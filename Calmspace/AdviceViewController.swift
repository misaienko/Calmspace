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
        commandButton.accessibilityIdentifier = "commandButton"
    }
    
    func displayAdvice() {
        guard let selectedOption = self.selectedOption else {
            adviceText.text = "Invalid selection"
            return
        }
        
        let (modifiers, activities) = Advice.makeAdvice(selectedOption)
        
        var adviceMessage = ""
        for activity in activities {
            switch activity {
            case .none:
                adviceMessage += "No advice available"
            case .yoga:
                adviceMessage += "Yoga Practice"
            case .meditation:
                adviceMessage += "Meditation"
            default:
                fatalError("Unhandled activity: \(activity)")
            }
        }
        
        switch (modifiers, activities) {
        case ([.short], [.meditation]):
            adviceMessage = "Let's have a short Meditation!"
        case (nil, [.yoga]):
            adviceMessage = "Let's have a Yoga Practice!"
        case ([.outside], [.meditation]):
            adviceMessage = "Let's have a Meditation outside!"
        case ([.short, .outside], [.yoga]):
            adviceMessage = "Let's have a quick Yoga outside!"
        case ([.outside], [.meditation, .yoga]):
            adviceMessage = "Let's have a Meditation & Yoga outside!"
        case ([.short], [.yoga]):
            adviceMessage = "Let's have a quick Yoga Practice!"
        case ([.short], [.yoga, .meditation]):
            adviceMessage = "Let's have a quick Yoga & Meditation!"
        case (nil, [.meditation]):
            adviceMessage = "Let's have a Meditation!"
        case (nil, [.none]):
            adviceMessage = "No advice available for the selected option"
        default:
            break
        }
        
        adviceText.text = adviceMessage
    }
    
    
    @objc func buttonPressed() {
        commandButton.layer.shadowOpacity = 0.8
    }
}

struct Advice {
    
    struct Modifier: OptionSet {
        let rawValue: Int
        
        static let short: Self = .init(rawValue: 1 << 0)
        static let outside: Self = .init(rawValue: 1 << 1)
    }
    
    struct Activity: OptionSet {
        let rawValue: Int
        
        static let none: Self = .init(rawValue: 1 << 0)
        static let yoga: Self = .init(rawValue: 1 << 1)
        static let meditation: Self = .init(rawValue: 1 << 2)
    }
    
    static func makeAdvice(_ selection: SelectedOption) -> ([Modifier]?, [Activity]) {
        
        switch selection {
            
        case .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            return ([.short], [.meditation])
            
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true):
            return (nil, [.yoga])
            
        case .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            return ([.outside], [.meditation])
            
        case .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false):
            return ([.short, .outside], [.yoga])
            
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false):
            return ([.outside], [.meditation, .yoga])
            
        case .init(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true):
            return ([.short], [.yoga])
            
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true):
            return ([.short], [.yoga, .meditation])
            
        case .init(feelingTodayLevel: .bad, botheringReason: nil, hasExercised: true, hasSpentTimeOutside: true),
                .init(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true):
            return (nil, [.meditation])
            
        default:
            return (nil, [.none])
        }
    }
}
