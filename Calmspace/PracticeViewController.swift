//
//  PracticeViewController.swift
//  Calmspace
//
//  Created by Admin on 18/11/2023.
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

    class PracticeViewController: UIViewController {
    
    var meditationSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation"]
    var yogaSections = ["Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]
    var selectedTable: UITableView?
    var practiceType: String?

    @IBOutlet weak var meditationTable: UITableView!
    
    @IBOutlet weak var yogaTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PracticeViewController - View Did Load")
        
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
 
           meditationTable.dataSource = self
           meditationTable.delegate = self
           yogaTable.dataSource = self
           yogaTable.delegate = self
        
        if let type = practiceType {
                switch type {
                case "Meditation":
                    enableTable(meditationTable)
                    disableTable(yogaTable)
                case "Yoga":
                    enableTable(yogaTable)
                    disableTable(meditationTable)
                default:
                    break
                }
            }
       }

}
    private func enableTable(_ tableView: UITableView) {
    tableView.isHidden = false
    tableView.isUserInteractionEnabled = true
}

    private func disableTable(_ tableView: UITableView) {
    tableView.isHidden = true
    tableView.isUserInteractionEnabled = false
}

    extension PracticeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
    return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView === meditationTable {
            return meditationSections.count
            
        } else {
            
            print("Returning \(yogaSections.count) rows for Yoga sections")
            return yogaSections.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == meditationTable {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MeditationCell", for: indexPath) as! MeditationCell
                cell.customLabel.text = meditationSections[indexPath.row]
                return cell
            
            } else if tableView == yogaTable {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "YogaCell", for: indexPath) as! YogaCell
                cell.customLabel2.text = yogaSections[indexPath.row]
                return cell
            }
            return UITableViewCell()
        }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       var selectedArray: [PracticeDetail] = []
       
        if tableView == meditationTable {
                switch indexPath.row {
                    case 0:
                        selectedArray = practiceData.morningMeditation.map {
                            return PracticeDetail(title: $0.title, youtubeLink: $0.link)
                        }
                    case 1:
                        selectedArray = practiceData.dailyMeditation.map {
                            return PracticeDetail(title: $0.title, youtubeLink: $0.link)
                        }
                    case 2:
                        selectedArray = practiceData.beforeSleepMeditation.map {
                            return PracticeDetail(title: $0.title, youtubeLink: $0.link)
                        }
                    default:
                        break
                }
        } else if tableView == yogaTable {
                switch indexPath.row {
                    // Adjust cases for yoga sections
                    case 0:
                        selectedArray = practiceData.yogaBeginnerAllLevels.map {
                            return PracticeDetail(title: $0.title, youtubeLink: $0.link)
                        }
                    case 1:
                        selectedArray = practiceData.yogaMediumAdvanceLevels.map {
                            return PracticeDetail(title: $0.title, youtubeLink: $0.link)
                        }
                    default:
                        break
                }
            }
       
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
           detailsViewController.selectedArray = selectedArray
           detailsViewController.practiceType = practiceType
           self.navigationController?.pushViewController(detailsViewController, animated: true)
       }
   }
}
