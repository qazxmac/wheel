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
    @IBOutlet weak var lottieThunder: LottieAnimationView!
    @IBOutlet weak var lblList: UILabel!
    
    var vcListViewController: ListViewController?
    
    
    var vm: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.delegate = self
        vm.loadData()
        lottieCatScratch.loopMode = .playOnce
        lottieFirework.loopMode = .loop
        lottieThunder.loopMode = .playOnce
        
        // Đăng ký nhận thông báo
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification3s), name: Notification.Name("ROTATE_ALMOST_DONE_3S"), object: nil)
        // Đăng ký nhận thông báo
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification1s), name: Notification.Name("ROTATE_ALMOST_DONE_1S"), object: nil)
        // Đăng ký nhận thông báo
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationReloadHome), name: Notification.Name("RELOAD_HOME"), object: nil)
        
        DispatchQueue.main.async { [weak self] in
            self?.vcListViewController = ListViewController(nibName: "ListViewController", bundle: nil)
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
    
    @objc func handleNotificationReloadHome() {
        vm.loadData()
    }
 
    
    @IBAction func tapSelect(_ sender: Any) {
        if let vc = self.vcListViewController {
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalTransitionStyle = .flipHorizontal
            nav.modalPresentationStyle = .overFullScreen
            self.present(nav, animated: true)
        }
    }
    
    @IBAction func tapStart(_ sender: Any) {
        
        // Nen den dan
        uvBlackCorver.alpha = 0.0
        uvBlackCorver.isHidden = false
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.uvBlackCorver.alpha = 1.0
        })
        lottieThunder.isHidden = false
        lottieThunder.play { [weak self] completed in
            self?.lottieThunder.isHidden = true
        }
        // Xoa ket qua cu dang hien thi
        lblResult.text?.removeAll()
        lottieFirework.isHidden = true
        
        circleView.rotateView(view: circleView) { [weak self] id in
            // Xoa nen den
            self?.uvBlackCorver.isHidden = true
            guard let self = self, let id = id else { return }
            // Cap nhat ket qua
            self.vm.updateResult(id: id)
        }
    }
    
    @IBAction func tapBtnPlus(_ sender: Any) {
        let vc = DetailViewController()
        vc.vm.parentItem = CircleModel()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func tapBtnEdit(_ sender: Any) {
        guard let parentItem = vm.selectedItem else { return }
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.vm.parentItem = parentItem
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}




extension ViewController: HomeViewModelDelegate {
    func didSetModels() {
        circleView.dataSource = vm.models
        lottieFirework.isHidden = true
        lblList.text = vm.selectedItem?.content
    }
    
    func didSetResult() {
        print("=========== \(vm.result)")
        
        lottieCatScratch.isHidden = true
        if let ressult = vm.result {
            lblResult.text = ressult.content
            lottieFirework.isHidden = false
            lottieFirework.play()
        } else {
            lblResult.text?.removeAll()
        }
    }
}
