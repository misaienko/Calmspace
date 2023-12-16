//
//  SecondAskViewController.swift
//  Calmspace
//
//  Created by Admin on 11/12/2023.
//

import UIKit

class SecondAskViewController: UIViewController {

    @IBOutlet weak var questionLabel: UITextField!
    
    @IBOutlet weak var responseButton1: UIButton!
    
    @IBOutlet weak var responseButton2: UIButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var selectedOption: SelectedOption!

        var questionIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        
        switch questionIndex {
                case 3:
                    updateUIForQuestion3()
                case 4:
                    updateUIForQuestion4()
                default:
                    break
            }
        }
    
    func updateUIForQuestion3() {
            questionLabel.text = "Did you exercise today?"
            responseButton1.setTitle("Yes", for: .normal)
            responseButton2.setTitle("No", for: .normal)
            backgroundImageView.image = UIImage(named: "image8")
        }

        func updateUIForQuestion4() {
            questionLabel.text = "Did you spend time outside today?"
            responseButton1.setTitle("Yes", for: .normal)
            responseButton2.setTitle("No", for: .normal)
            backgroundImageView.image = UIImage(named: "image4")
        }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        switch questionIndex {
                case 3:
                    handleAnswerButton3(tag: sender.tag)
                case 4:
                    handleAnswerButton4(tag: sender.tag)
                default:
                    break
                }
            }

        func handleAnswerButton3(tag: Int) {
                switch tag {
                case 1:
                    selectedOption.hasExercised = true
                case 2:
                    selectedOption.hasExercised = false
                default:
                    break
                }
                
                questionIndex += 1
                if questionIndex > 4 {
                    performSegue(withIdentifier: "ShowAdviceSegue", sender: self)
                } else {
                    updateUI()
                }
            }

        func handleAnswerButton4(tag: Int) {
                switch tag {
                case 1:
                    selectedOption.hasSpentTimeOutside = true
                case 2:
                    selectedOption.hasSpentTimeOutside = false
                default:
                    break
                }

                questionIndex += 1
                if questionIndex > 4 {
                    performSegue(withIdentifier: "AdviceSegue", sender: self)
                } else {
                    updateUI()
                }
            }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AdviceSegue" {
                if let destinationVC = segue.destination as? AdviceViewController {
                    destinationVC.selectedOption = selectedOption
                }
            }
        }
    }

