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
        
    print("View Did Load")
        
    }
    
    @IBAction func meditationButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "MeditationSegue", sender: self)
    }

    @IBAction func yogaButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "YogaSegue", sender: self)
    }
    
    /*   @IBAction func meditationButtonPressed(_ sender: UIButton) {
        print("Meditation button pressed")
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PracticeTableViewController") as! PracticeTableViewController
           destinationVC.showMeditationSections = true
           navigationController?.pushViewController(destinationVC, animated: true)
       }
     
         @IBAction func yogaButtonPressed(_ sender: UIButton) {
        print("Yoga button pressed")
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PracticeTableViewController") as! PracticeTableViewController
            destinationVC.showMeditationSections = false
            navigationController?.pushViewController(destinationVC, animated: true)
        }
   
    */

    @IBAction func natureButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "NatureSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
