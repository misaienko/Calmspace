//
//  FourthQViewController.swift
//  Calmspace
//
//  Created by Admin on 26/11/2023.
//

import UIKit

class FourthQViewController: UIViewController {

    @IBOutlet weak var q4: UITextField!
    
    @IBOutlet weak var q4B1: UIButton!
    
    @IBOutlet weak var q4B2: UIButton!
    
    @IBAction func q4B1Pressed(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", Yes"
            } else {
                
                DataHolder.selectedOption = "Yes"
            }
        
        performSegue(withIdentifier: "AdvicePractice", sender: self)
    }
    
    @IBAction func q4B2Pressed(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", No"
            } else {
                
                DataHolder.selectedOption = "No"
            }
        
        performSegue(withIdentifier: "AdvicePractice", sender: self)
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
