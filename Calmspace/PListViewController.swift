//
//  PListViewController.swift
//  Calmspace
//
//  Created by Admin on 21/10/2023.
//

import UIKit
import Foundation

class PListViewController: UIViewController{
    
    var showMeditationSections = true
    
    @IBOutlet weak var meditationButton: UIButton!
    
    @IBOutlet weak var yogaButton: UIButton!
    
    @IBOutlet weak var natureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print("View Did Load")
        
    }
    
    @IBAction func meditationButtonPressed(_ sender: Any) {
        showMeditationSections = true
        print("Meditation button pressed. Setting showMeditationSections to true.")
        performSegue(withIdentifier: "PracticeSegue", sender: self)
            }

    @IBAction func yogaButtonPressed(_ sender: Any) {
        showMeditationSections = false
        print("Yoga button pressed. Setting showMeditationSections to false.")
        performSegue(withIdentifier: "PracticeSegue", sender: self)
            }
    
    @IBAction func natureButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "NatureSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing for segue. Sending showMeditationSections:", showMeditationSections)
            if let practiceTableVC = segue.destination as? PracticeTableViewController {
                practiceTableVC.showMeditationSections = self.showMeditationSections
            }
        }
}
