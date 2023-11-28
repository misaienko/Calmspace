//
//  FirstQViewController.swift
//  Calmspace
//
//  Created by Admin on 26/11/2023.
//

import UIKit

class FirstQViewController: UIViewController {

    @IBOutlet weak var q1: UITextField!
    
    @IBOutlet weak var q1B1: UIButton!
    
    @IBOutlet weak var q1B2: UIButton!
    
    @IBOutlet weak var q1B3: UIButton!
    
    @IBAction func q1B1Pressed(_ sender: Any) {
        
        DataHolder.selectedOption = "Good"
        
        performSegue(withIdentifier: "Q2", sender: self)
    }
    
    @IBAction func q1B2Pressed(_ sender: Any) {
        
        DataHolder.selectedOption = "Okay"
        
        performSegue(withIdentifier: "Q2", sender: self)
    }
    
    @IBAction func q1B3Pressed(_ sender: Any) {
        
        DataHolder.selectedOption = "Bad"
        
        performSegue(withIdentifier: "Q2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdvicePractice" {
            if let destinationVC = segue.destination as? AdviceViewController {
                destinationVC.selectedOption = DataHolder.selectedOption
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
