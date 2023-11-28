//
//  ThirdQViewController.swift
//  Calmspace
//
//  Created by Admin on 26/11/2023.
//

import UIKit

class ThirdQViewController: UIViewController {

    @IBOutlet weak var q3: UITextField!
    
    @IBOutlet weak var q3B1: UIButton!
    
    @IBOutlet weak var q3B2: UIButton!
    
    @IBAction func q3B1Pressed(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", Yes"
            } else {
                
                DataHolder.selectedOption = "Yes"
            }
        performSegue(withIdentifier: "Q4", sender: self)
    }
    
    @IBAction func q3B2(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", No"
            } else {
                
                DataHolder.selectedOption = "No"
            }
        
        performSegue(withIdentifier: "Q4", sender: self)
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
