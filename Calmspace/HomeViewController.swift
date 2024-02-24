//
//  HomeViewController.swift
//  Calmspace
//
//  Created by Admin on 25/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var suggestActivity: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestActivity.layer.shadowColor = UIColor.black.cgColor
        suggestActivity.layer.shadowOffset = CGSize(width: 0, height: 2)
        suggestActivity.layer.shadowOpacity = 0.5
        suggestActivity.layer.shadowRadius = 15
        suggestActivity.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        suggestActivity.accessibilityIdentifier = "suggestActivity"
    }
    
    @IBAction func suggestActivityPressed(_ sender: Any) {
        performSegue(withIdentifier: "Questions", sender: self)
    }
    
    @objc func buttonPressed() {
        suggestActivity.layer.shadowOpacity = 0.8
    }
}
