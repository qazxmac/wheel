//
//  UIView+.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import UIKit

extension UIView {
    func rotateView(view: UIView, completion: ((_ tag: Int?) -> Void)?) {
        let targetAngle = CGFloat(arc4random_uniform(360)) * .pi / 180.0
        let numberOfRotations = CGFloat(arc4random())
        
        let totalAngle = numberOfRotations * CGFloat.pi * 2.0 + targetAngle
        
        let minDuration: TimeInterval = 3
        let maxDuration: TimeInterval = 10
        
        let durationRange = maxDuration - minDuration
        let randomDuration = TimeInterval(arc4random_uniform(UInt32(durationRange))) + minDuration
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = nil
        rotationAnimation.toValue = totalAngle
        rotationAnimation.duration = randomDuration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDuration - 1) {
            NotificationCenter.default.post(name: Notification.Name("ROTATE_ALMOST_DONE_1S"), object: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDuration - 3) {
            NotificationCenter.default.post(name: Notification.Name("ROTATE_ALMOST_DONE_3S"), object: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDuration) {
            let circleView = view as! CircleView
            let subviews = circleView.subviews
            
            var minYSubview: UIView?
            var minY: CGFloat = CGFloat.greatestFiniteMagnitude
            
            let center = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
            
            for subview in subviews {
                let rotatedPoint = subview.center.applying(CGAffineTransform(rotationAngle: totalAngle))
                let oy = rotatedPoint.y - center.y
                
                if oy < minY {
                    minY = oy
                    minYSubview = subview
                }
            }
            
            if let minYSubview = minYSubview {
                print("Subview with the smallest Oy value: \(minYSubview)")
                print("TAG: \(minYSubview.tag)")
                completion?(minYSubview.tag)
            }
            completion?(nil)
        }
    }
}
