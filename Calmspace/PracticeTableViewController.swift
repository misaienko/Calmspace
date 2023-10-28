//
//  PracticeTableViewController.swift
//  Calmspace
//
//  Created by Admin on 09/10/2023.
//

import UIKit
import Foundation
    
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

class PracticeTableViewController: UITableViewController {
    
    var meditationSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation"]
    var yogaSections = ["Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]
    var showMeditationSections = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("PracticeTableViewController - View Did Load")
        
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
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showMeditationSections {
            
            print("Returning \(meditationSections.count) rows for Meditation sections")
            return meditationSections.count
            
        } else {
            
            print("Returning \(yogaSections.count) rows for Yoga sections")
            return yogaSections.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeCell", for: indexPath) as! PracticeTableViewCell
        if showMeditationSections {
            print("Setting cell for Meditation section")
            
            cell.customLabel.text = meditationSections[indexPath.row]
            
        } else {
            print("Setting cell for Yoga section")
            cell.customLabel.text = yogaSections[indexPath.row]
            
        }
        return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedArray: [PracticeDetail] = []
        
        if showMeditationSections {
                switch indexPath.row {
                case 0:
                    selectedArray = practiceData.morningMeditation.map {
                        return PracticeDetail(title: $0.title, url: $0.link)
                    }
                case 1:
                    selectedArray = practiceData.dailyMeditation.map {
                        return PracticeDetail(title: $0.title, url: $0.link)
                    }
                case 2:
                    selectedArray = practiceData.beforeSleepMeditation.map {
                        return PracticeDetail(title: $0.title, url: $0.link)
                    }
                default:
                    break
                }
        } else {
                switch indexPath.row {
                case 0:
                    selectedArray = practiceData.yogaBeginnerAllLevels.map {
                        return PracticeDetail(title: $0.title, url: $0.link)
                    }
                case 1:
                    selectedArray = practiceData.yogaMediumAdvanceLevels.map {
                        return PracticeDetail(title: $0.title, url: $0.link)
                    }
                default:
                    break
                }
            }
        
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
            detailsViewController.selectedArray = selectedArray
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}
   
    
    
    


