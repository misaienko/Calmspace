//
//  SecondQViewController.swift
//  Calmspace
//
//  Created by Admin on 26/11/2023.
//

import UIKit

class SecondQViewController: UIViewController {

    @IBOutlet weak var q2: UITextField!
    
    @IBOutlet weak var q2B1: UIButton!
    
    @IBOutlet weak var q2B2: UIButton!
    
    @IBOutlet weak var q2B3: UIButton!
    
    @IBAction func q2B1Pressed(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", No"
            } else {
               
                DataHolder.selectedOption = "No"
            }
        
        performSegue(withIdentifier: "Q3", sender: self)
    }
    
    @IBAction func q2B2Pressed(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", Physically"
            } else {
                
                DataHolder.selectedOption = "Physically"
            }
        
        performSegue(withIdentifier: "Q3", sender: self)
    }
    
    @IBAction func q3B3Pressed(_ sender: Any) {
        
        if let unwrappedOption = DataHolder.selectedOption {
                DataHolder.selectedOption = unwrappedOption + ", Mentally"
            } else {
               
                DataHolder.selectedOption = "Mentally"
            }
        
        performSegue(withIdentifier: "Q3", sender: self)
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
