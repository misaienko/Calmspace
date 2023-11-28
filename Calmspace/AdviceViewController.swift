//
//  AdviceViewController.swift
//  Calmspace
//
//  Created by Admin on 26/11/2023.
//

import UIKit

class AdviceViewController: UIViewController {
    
    var selectedOption: String?
    
    @IBOutlet weak var adviceText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AdviceViewController Loaded")
        
        displayAdvice()
    }
    
    func displayAdvice() {
        guard let selectedOption = self.selectedOption else {
            adviceText.text = "Invalid selection"
            return
        }
        
        switch selectedOption {
            case "Good, No, Yes, Yes":
                adviceText.text = "That's great! Let's do a short meditation!"
            case "Good, Physically, No, Yes":
                adviceText.text = "Let's have a Yoga Practice!"
            case "Good, Mentally, No, Yes":
                adviceText.text = "Let's have a quick Yoga and Meditation!"
            case "Good, Physically, Yes, Yes":
                adviceText.text = "Let's have a Yoga Practice!"
            case "Good, Mentally, Yes, Yes":
                adviceText.text = "Let's have a Meditation! You will feel better!"
            case "Good, Physically, Yes, No":
                adviceText.text = "Let's have a quick Yoga outside!"
            case "Good, Mentally, Yes, No":
                adviceText.text = "Let's have a Meditation outside!"
            case "Good, Mentally, No, No":
                adviceText.text = "Let's have a Meditation and Yoga outside!"
            case "Good, Physically, No, No":
                adviceText.text = "Let's have a quick Yoga outside!"
            case "Good, No, No, No":
                adviceText.text = "Let's have a Meditation and Yoga outside!"
            case "Good, No, No, Yes":
                adviceText.text = "Let's have a quick Yoga Practice!"
            case "Okay, No, Yes, Yes":
                adviceText.text = "That's great! Let's do a short meditation!"
            case "Okay, Physically, No, Yes":
                adviceText.text = "Let's have a Yoga Practice!"
            case "Okay, Mentally, No, Yes":
                adviceText.text = "Let's have a quick Yoga and Meditation!"
            case "Okay, Physically, Yes, Yes":
                adviceText.text = "Let's have a Yoga Practice!"
            case "Okay, Mentally, Yes, Yes":
                adviceText.text = "Let's have a Meditation!"
            case "Okay, Physically, Yes, No":
                adviceText.text = "Let's have a quick Yoga outside!"
            case "Okay, Mentally, Yes, No":
                adviceText.text = "Let's have a Meditation outside!"
            case "Okay, Mentally, No, No":
                adviceText.text = "Let's have a Meditation and Yoga outside!"
            case "Okay, Physically, No, No":
                adviceText.text = "Let's have a quick Yoga outside!"
            case "Okay, No, No, No":
                adviceText.text = "Let's have a Meditation and Yoga outside!"
            case "Okay, No, No, Yes":
                adviceText.text = "Let's have a quick Yoga Practice!"
            case "Bad, No, Yes, Yes":
                adviceText.text = "Let's have a quick Yoga and Meditation!"
            case "Bad, Physically, No, Yes":
                adviceText.text = "Let's have a Yoga Practice!"
            case "Bad, Mentally, No, Yes":
                adviceText.text = "Let's have a quick Yoga and Meditation!"
            case "Bad, Physically, Yes, Yes":
                adviceText.text = "Let's have a quick Yoga Practice!"
            case "Bad, Mentally, Yes, Yes":
                adviceText.text = "Let's have a long Meditation Session!"
            case "Bad, Physically, Yes, No":
                adviceText.text = "Let's have a quick Yoga outside!"
            case "Bad, Mentally, Yes, No":
                adviceText.text = "Let's have a Meditation outside!"
            case "Bad, Mentally, No, No":
                adviceText.text = "Let's have a Meditation and Yoga outside!"
            case "Bad, Physically, No, No":
                adviceText.text = "Let's have a quick Yoga outside!"
            case "Bad, No, No, No":
                adviceText.text = "Let's have a Meditation and Yoga outside!"
            case "Bad, No, No, Yes":
                adviceText.text = "Let's have a quick Yoga and Meditation!"
            default:
                adviceText.text = "No advice available for the selected option"
            }
        }
}
