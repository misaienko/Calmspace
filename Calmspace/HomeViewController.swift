//
//  HomeViewController.swift
//  Calmspace
//
//  Created by Admin on 25/11/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var suggestActivity: UIButton!
    
    @IBAction func suggestActivityPressed(_ sender: Any) {
        
    performSegue(withIdentifier: "Q1", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
}
