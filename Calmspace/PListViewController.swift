//
//  PListViewController.swift
//  Calmspace
//
//  Created by Admin on 21/10/2023.
//

import UIKit
import Foundation

class PListViewController: UIViewController{
    
    @IBOutlet weak var meditationButton: UIButton!
    
    @IBOutlet weak var yogaButton: UIButton!
    
    var meditationTable: UITableView?
    var yogaTable: UITableView?
    
    @IBAction func meditationPressed(_ sender: Any) {
        print("Meditation button pressed")
        performSegue(withIdentifier: "PracticeSegue", sender: "Meditation")
    }
    
    @IBAction func yogaPressed(_ sender: Any) {
        print("Yoga button pressed")
        performSegue(withIdentifier: "PracticeSegue", sender: "Yoga")
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PracticeSegue" {
            if let practiceViewController = segue.destination as? PracticeViewController, let practiceType = sender as? String {
                practiceViewController.practiceType = practiceType
            }
        }
    }
    
}
