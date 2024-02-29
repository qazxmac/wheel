//
//  ViewController.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circleView: CircleView!
    
    @IBOutlet weak var btnStart: UIButton!
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

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
            CircleModel(id: Int.random(in: 100...1000), content: "Banh canh cha ca"),
            CircleModel(id: Int.random(in: 100...1000), content: "Chao long"),
            CircleModel(id: Int.random(in: 100...1000), content: "Mi xao gion"),
            CircleModel(id: Int.random(in: 100...1000), content: "Bun thai"),
            CircleModel(id: Int.random(in: 100...1000), content: "Banh xeo"),
            CircleModel(id: Int.random(in: 100...1000), content: "Goi cuon"),
            CircleModel(id: Int.random(in: 100...1000), content: "Nhin doi"),
            CircleModel(id: Int.random(in: 100...1000), content: "Hadilao"),
            CircleModel(id: Int.random(in: 100...1000), content: "Bo kho"),
        ]
    }
    
    @IBAction func tapStart(_ sender: Any) {
        circleView.rotateView(view: circleView) { [weak self] tag in
            guard let self = self, let tag = tag else { return }
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
    }
}
