//
//  ViewController.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var uvBlackCorver: UIView!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lottieCatScratch: LottieAnimationView!
    @IBOutlet weak var lottieFirework: LottieAnimationView!
    
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        lottieCatScratch.loopMode = .playOnce
        lottieFirework.loopMode = .loop
        
        // Đăng ký nhận thông báo
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification3s), name: Notification.Name("ROTATE_ALMOST_DONE_3S"), object: nil)
        // Đăng ký nhận thông báo
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification1s), name: Notification.Name("ROTATE_ALMOST_DONE_1S"), object: nil)
    }

    // Xử lý thông báo
    @objc func handleNotification1s() {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.uvBlackCorver.alpha = 0.0
        })
    }
    
    @objc func handleNotification3s() {
        lottieCatScratch.isHidden = false
        lottieCatScratch.play()
    }
 
    
    @IBAction func tapSelect(_ sender: Any) {
        viewModel.models = [
            CircleModel(id: Int.random(in: 100...1000), content: "My y"),
            CircleModel(id: Int.random(in: 100...1000), content: "Vit quay"),
            CircleModel(id: Int.random(in: 100...1000), content: "Com chien duong chau"),
            CircleModel(id: Int.random(in: 100...1000), content: "Banh canh"),
            CircleModel(id: Int.random(in: 100...1000), content: "Hu tieu"),
            CircleModel(id: Int.random(in: 100...1000), content: "Com tam"),
            CircleModel(id: Int.random(in: 100...1000), content: "Banh uot"),
            CircleModel(id: Int.random(in: 100...1000), content: "Banh hoi heo quay"),
            CircleModel(id: Int.random(in: 100...1000), content: "Pizza"),
            CircleModel(id: Int.random(in: 100...1000), content: "Mi vit tiem"),
            CircleModel(id: Int.random(in: 100...1000), content: "Bun rieu"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Banh canh cha ca"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Chao long"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Mi xao gion"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Bun thai"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Banh xeo"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Goi cuon"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Nhin doi"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Hadilao"),
//            CircleModel(id: Int.random(in: 100...1000), content: "Bo kho"),
        ]
        
    }
    
    @IBAction func tapStart(_ sender: Any) {
        // Nen den dan
        uvBlackCorver.isHidden = false
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.uvBlackCorver.alpha = 1.0
        })
        // Xoa ket qua cu dang hien thi
        lblResult.text?.removeAll()
        lottieFirework.isHidden = true
        
        circleView.rotateView(view: circleView) { [weak self] tag in
            // Xoa nen den
            self?.uvBlackCorver.isHidden = true
            guard let self = self, let tag = tag else { return }
            // Cap nhat ket qua
            self.viewModel.updateResult(id: tag)
        }
    }
    
}




extension ViewController: HomeViewModelDelegate {
    func didSetModels() {
        circleView.dataSource = viewModel.models
    }
    
    func didSetResult() {
        print("=========== \(viewModel.result)")
        
        lottieCatScratch.isHidden = true
        if let ressult = viewModel.result {
            lblResult.text = ressult.content
            lottieFirework.isHidden = false
            lottieFirework.play()
        } else {
            lblResult.text?.removeAll()
        }
    }
}
