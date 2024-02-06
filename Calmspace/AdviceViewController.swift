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
    @IBOutlet weak var commandButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAdvice()
        
        commandButton.layer.shadowColor = UIColor.black.cgColor
        commandButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        commandButton.layer.shadowOpacity = 0.5
        commandButton.layer.shadowRadius = 15
        
        commandButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func displayAdvice() {
        guard let selectedOption = self.selectedOption else {
            adviceText.text = "Invalid selection"
            return
        }
        
        switch selectedOption {
        case .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a short Meditation!"
            
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Yoga Practice!"
            
        case .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Meditation outside!"
            
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a quick Yoga outside!"
            
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false):
            adviceText.text = "Let's have a Meditation & Yoga outside!"
            
        case .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga Practice!"
            
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a quick Yoga & Meditation!"
            
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            adviceText.text = "Let's have a Meditation!"
            
        default:
            adviceText.text = "No advice available for the selected option"
        }
    }
    
    @objc func buttonPressed() {
        commandButton.layer.shadowOpacity = 0.8
    }
}
