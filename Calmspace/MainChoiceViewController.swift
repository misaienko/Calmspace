//
//  PListViewController.swift
//  Calmspace
//
//  Created by Admin on 21/10/2023.
//

import UIKit
    
    var practiceSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation", "Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]

    var practiceData: Practice!
    
    struct Practice: Codable {
        let dailyMeditation: [Meditation]
        let yogaBeginnerAllLevels: [YogaSession]
        let yogaMediumAdvanceLevels: [YogaSession]
        let morningMeditation: [Meditation]
        let beforeSleepMeditation: [Meditation]
        
    enum CodingKeys: String, CodingKey {
        case dailyMeditation = "Daily Meditation"
        case yogaBeginnerAllLevels = "Yoga: Beginner & All Levels"
        case yogaMediumAdvanceLevels = "Yoga: Medium & Advance Levels"
        case morningMeditation = "Morning Meditation"
        case beforeSleepMeditation = "Before Sleep Meditation"
        }
    }

   struct Meditation: Codable {
        let title, description: String
        let link: URL
    
   enum CodingKeys: String, CodingKey {
        case title = "Title"
        case link = "URL"
        case description = "Description"
    }
}

   struct YogaSession: Codable {
        let title, description: String
        let link: URL
    
   enum CodingKeys: String, CodingKey {
        case title = "Title"
        case link = "URL"
       case description = "Description"
    }
}

class MainChoiceViewController: UIViewController{
    
    var meditationSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation"]
    var yogaSections = ["Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MainChoiceViewController - View Did Load")
        
        guard let url = Bundle.main.url(forResource: "Practice", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load Practice.json")
            
        }
        
        let decoder = JSONDecoder()
        do {
            practiceData = try decoder.decode(Practice.self, from: data)
        } catch {
            fatalError("Failed to decode Practice.json: \(error)")
        }
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))

        
                navigationItem.leftBarButtonItem = backButton
    }
    
    
    @IBOutlet weak var meditationButton: UIButton!
    
    @IBOutlet weak var yogaButton: UIButton!
    
    var meditationTable: UITableView?
    var yogaTable: UITableView?
    
    @IBAction func meditationPressed(_ sender: Any) {
        print("Meditation button pressed")
        performSegue(withIdentifier: "MeditationSegue", sender: "Meditation")
    }
    
    @IBAction func yogaPressed(_ sender: Any) {
        print("Yoga button pressed")
        performSegue(withIdentifier: "YogaSegue", sender: "Yoga")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MeditationSegue" {
            if let meditationViewController = segue.destination as? MeditationViewController {
                meditationViewController.meditationSections = meditationSections
            }
        } else if segue.identifier == "YogaSegue" {
            if let yogaViewController = segue.destination as? YogaViewController {
                yogaViewController.yogaSections = yogaSections
            }
        }
    }
    
    @objc func backPressed() {
           // Handle the back navigation item press
           // For example, navigate back to HomeViewController
           navigationController?.popToRootViewController(animated: true)
       }
}
