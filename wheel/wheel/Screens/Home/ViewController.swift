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
            CircleModel(id: Int.random(in: 100...1000), content: "Part 1"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 2"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 3"),
            CircleModel(id: Int.random(in: 100...1000), content: "Thanh cong chua"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 5"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 6"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 7"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 8"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 9"),
            CircleModel(id: Int.random(in: 100...1000), content: "Part 10"),
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
