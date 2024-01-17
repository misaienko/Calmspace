//
//  FirstAskViewController.swift
//  Calmspace
//
//  Created by Admin on 11/12/2023.
//

import UIKit

class FirstAskViewController: UIViewController {
    
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var selectedOption: SelectedOption = SelectedOption(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: false)
        var questionIndex = 1
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
            setButtonFont(for: answerButton1)
            setButtonFont(for: answerButton2)
            setButtonFont(for: answerButton3)
        }
        
        func setButtonFont(for button: UIButton) {
            if let font = UIFont(name: "AvenirNext-DemiBold", size: 19) {
                button.titleLabel?.font = font
                print("Button font: \(button.titleLabel?.font ?? UIFont.systemFont(ofSize: 19))")
            } else {
                print("Font not available")
            }
        }
        
        func setButtonShadow(for button: UIButton) {
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 15
        }
        
        func updateUI() {
            print("Updating UI for questionIndex: \(questionIndex)")
            switch questionIndex {
            case 1:
                setupQuestion1UI()
            case 2:
                setupQuestion2UI()
            case 3:
                setupQuestion3UI()
            case 4:
                setupQuestion4UI()
            default:
                break
            }
            updateBackgroundImage()
        }
        
        func setupQuestion1UI() {
            questionText.text = "How are you feeling today?"
            answerButton1.setTitle("Good", for: .normal)
            answerButton2.setTitle("Okay", for: .normal)
            answerButton3.setTitle("Bad", for: .normal)
            backgroundImageView.image = UIImage(named: "image7")
        }

        func setupQuestion2UI() {
            questionText.text = "What is bothering you?"
            answerButton1.setTitle("Physically", for: .normal)
            answerButton2.setTitle("Mentally", for: .normal)
            answerButton3.setTitle("No", for: .normal)
            backgroundImageView.image = UIImage(named: "image6")
        }

        func setupQuestion3UI() {
            questionText.text = "Did you exercise today?"
            answerButton1.setTitle("Yes", for: .normal)
            answerButton2.setTitle("No", for: .normal)
            answerButton3?.isHidden = true
            backgroundImageView.image = UIImage(named: "image11")
        }

        func setupQuestion4UI() {
            questionText.text = "Did you spend time outside today?"
            answerButton1.setTitle("Yes", for: .normal)
            answerButton2.setTitle("No", for: .normal)
            answerButton3?.isHidden = true
            backgroundImageView.image = UIImage(named: "image8")
        }

        func updateBackgroundImage() {
            switch questionIndex {
            case 1:
                backgroundImageView.image = UIImage(named: "image7")
            case 2:
                backgroundImageView.image = UIImage(named: "image6")
            case 3:
                backgroundImageView.image = UIImage(named: "image11")
            case 4:
                backgroundImageView.image = UIImage(named: "image8")
            default:
                break
            }
        }

        @IBAction func answerButtonPressed(_ sender: UIButton) {
            print("Button \(sender.tag) pressed")
            switch questionIndex {
            case 1:
                handleAnswerButton1(tag: sender.tag)
            case 2:
                handleAnswerButton2(tag: sender.tag)
            case 3:
                handleAnswerButton3(tag: sender.tag)
            case 4:
                handleAnswerButton4(tag: sender.tag)
            default:
                break
            }
        }

        func handleAnswerButton1(tag: Int) {
            switch tag {
            case 1:
                selectedOption.feelingTodayLevel = .good
            case 2:
                selectedOption.feelingTodayLevel = .okay
            case 3:
                selectedOption.feelingTodayLevel = .bad
            default:
                break
            }
            handleQuestionCompletion()
        }

        func handleAnswerButton2(tag: Int) {
            switch tag {
            case 1:
                selectedOption.botheringReason = .physically
            case 2:
                selectedOption.botheringReason = .mentally
            case 3:
                selectedOption.botheringReason = nil
            default:
                break
            }
            handleQuestionCompletion()
        }

        func handleAnswerButton3(tag: Int) {
            selectedOption.hasExercised = (tag == 1)
            handleQuestionCompletion()
        }

        func handleAnswerButton4(tag: Int) {
            selectedOption.hasSpentTimeOutside = (tag == 1)
            handleQuestionCompletion()
        }

        func handleQuestionCompletion() {
            questionIndex += 1
            if questionIndex > 4 {
                performSegue(withIdentifier: "AdviceSegue", sender: self)
            } else {
                updateUI()
            }
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AdviceSegue", let destinationVC = segue.destination as? AdviceViewController {
                destinationVC.selectedOption = selectedOption
            }
        }
    }
