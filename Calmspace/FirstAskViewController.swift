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
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
                navigationItem.leftBarButtonItem = backButton
    }
    
    func updateUI() {
        
        print("Updating UI for questionIndex: \(questionIndex)")
        switch questionIndex {
        case 1:
            questionText.text = "How are you feeling today?"
            answerButton1.setTitle("Good", for: .normal)
            answerButton2.setTitle("Okay", for: .normal)
            answerButton3.setTitle("Bad", for: .normal)
            backgroundImageView.image = UIImage(named: "image7")
        case 2:
            questionText.text = "What is bothering you?"
            answerButton1.setTitle("Physically", for: .normal)
            answerButton2.setTitle("Mentally", for: .normal)
            answerButton3.setTitle("No", for: .normal)
            backgroundImageView.image = UIImage(named: "image6")
        default:
            break
        }
        
        updateBackgroundImage()
    }
    
    func updateBackgroundImage() {
            switch questionIndex {
            case 1:
                backgroundImageView.image = UIImage(named: "image7")
            case 2:
                backgroundImageView.image = UIImage(named: "image6")
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
               
               questionIndex += 1
               if questionIndex > 2 {
                   performSegue(withIdentifier: "SecondQuestionnaireSegue", sender: self)
               } else {
                   updateUI()
               }
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
               
               questionIndex += 1
               if questionIndex > 2 {
                   performSegue(withIdentifier: "SecondQuestionnaireSegue", sender: self)
               } else {
                   updateUI()
               }
           }
            
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "SecondQuestionnaireSegue" {
                    if let destinationVC = segue.destination as? SecondAskViewController {
                        destinationVC.selectedOption = selectedOption
                    }
                }
            }
    @objc func backPressed() {
            // Handle the back navigation item press
            // For example, navigate back to HomeViewController
            navigationController?.popToRootViewController(animated: true)
        }
    
    }

