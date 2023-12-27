//
//  AdviceViewController.swift
//  Calmspace
//
//  Created by Admin on 26/11/2023.
//

import UIKit
    
    struct SelectedOption: Equatable {
        enum FeelingTodayLevel {
            case good, okay, bad
        }

        enum BotheringReason {
            case physically, mentally
        }

        var feelingTodayLevel: FeelingTodayLevel
        var botheringReason: BotheringReason?
        var hasExercised: Bool
        var hasSpentTimeOutside: Bool
    }
    
class AdviceViewController: UIViewController {
    
    var selectedOption: SelectedOption?
    
    @IBOutlet weak var adviceText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AdviceViewController Loaded")
        
        displayAdvice()
        
        let forestGreenColor = UIColor(red: 34/255.0, green: 56/255.0, blue: 34/255.0, alpha: 1.0)

        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        backButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: forestGreenColor], for: .normal)

                navigationItem.leftBarButtonItem = backButton
    }
    
    func displayAdvice() {
        
        guard let selectedOption = self.selectedOption else {
            
            adviceText.text = "Invalid selection"
            
            return
        }
        
        switch selectedOption {
            
        case .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's do a short meditation!"
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Yoga Practice!"
        case .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga and Meditation!"
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Yoga Practice!"
        case .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Meditation! You will feel better!"
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
        case .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation outside!"
        case .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation and Yoga outside!"
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
        case .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation and Yoga outside!"
        case .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga Practice!"
        case .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's do a short meditation!"
        case .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Yoga Practice!"
        case .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga and Meditation!"
        case .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Yoga Practice!"
        case .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Meditation!"
        case .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
        case .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation outside!"
        case .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation and Yoga outside"
        case .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
        case .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation and Yoga outside!"
        case .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga Practice!"
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a long Meditation Session!"
        case .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Yoga Practice!"
        case .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga and Meditation!"
        case .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga Practice!"
        case .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a long Meditation Session!"
        case .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
        case .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation outside!"
        case .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation and Yoga outside!"
        case .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation and Yoga outside!"
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga and Meditation!"
            
        default:
                    adviceText.text = "No advice available for the selected option"
        }
    }
    
    @objc func backPressed() {
            // Handle the back navigation item press
            // For example, navigate back to HomeViewController
            navigationController?.popToRootViewController(animated: true)
        }
}
