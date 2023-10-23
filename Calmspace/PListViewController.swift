//
//  PListViewController.swift
//  Calmspace
//
//  Created by Admin on 21/10/2023.
//

import UIKit

class PListViewController: UIViewController {
    
    @IBOutlet weak var meditationButton: UIButton!
    
    @IBOutlet weak var yogaButton: UIButton!
    
    @IBOutlet weak var natureButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func meditationButtonPressed(_ sender: UIButton) {
   //  performSegue(withIdentifier: "MeditationSegue", sender: self)
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PracticeTableViewController") as? PracticeTableViewController {
                destinationVC.meditationSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation"]
                navigationController?.pushViewController(destinationVC, animated: true)
            }
    }

    @IBAction func yogaButtonPressed(_ sender: UIButton) {
   // performSegue(withIdentifier: "YogaSegue", sender: self)
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PracticeTableViewController") as? PracticeTableViewController {
            destinationVC.yogaSections = ["Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]
                navigationController?.pushViewController(destinationVC, animated: true)
            }
    }

    @IBAction func natureButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "NatureSegue", sender: self)
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
     
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
  

}
