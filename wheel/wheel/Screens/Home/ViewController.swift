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
    
    var vc: ListViewController?
    
    
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
        
        DispatchQueue.main.async { [weak self] in
            self?.vc = ListViewController(nibName: "ListViewController", bundle: nil)
        }
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
        
        
    }
    
    @IBAction func tapStart(_ sender: Any) {
        
        // Tạo một đối tượng CircleModel
        let total: Int = Int.random(in: 5...15)
        var models: [CircleModel] = []
        for i in 0...total {
            let circle = CircleModel()
            let randomID = Int.random(in: 100...1000)
            circle.content = UUID().uuidString
            
            models.append(circle)
        }
        
        viewModel.models = models
        
        
        
        
        // Nen den dan
        uvBlackCorver.alpha = 0.0
        uvBlackCorver.isHidden = false
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.uvBlackCorver.alpha = 1.0
        })
        // Xoa ket qua cu dang hien thi
        lblResult.text?.removeAll()
        lottieFirework.isHidden = true
        
        circleView.rotateView(view: circleView) { [weak self] id in
            // Xoa nen den
            self?.uvBlackCorver.isHidden = true
            guard let self = self, let id = id else { return }
            // Cap nhat ket qua
            self.viewModel.updateResult(id: id)
        }
    }
    
    @IBAction func tapBtnPlus(_ sender: Any) {

//        vc.modalTransitionStyle = .partialCurl
        if let vc = self.vc {
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalTransitionStyle = .flipHorizontal
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }

    }
    
    @IBAction func tapBtnEdit(_ sender: Any) {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        self.present(vc, animated: true)
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
