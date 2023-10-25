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
        let url: URL
        
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case url = "URL"
        case description = "Description"
        }
    }
    
    struct YogaSession: Codable {
        let title, description: String
        let url: URL
        
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case url = "URL"
        case description = "Description"
        }
    }
    
class PracticeTableViewController: UITableViewController {
    
    var meditationSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation"]
    var yogaSections = ["Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]
    var showMeditationSections = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
    
    // MARK: - Table view data source
    
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
    
    /*  let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeCell", for: indexPath) as! PracticeTableViewCell
     
     cell.customLabel.text = practiceSections[indexPath.row]
     
     return cell
     }
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedArray: [PracticeDetail] = []
        
        switch indexPath.row {
        case 0:
            selectedArray = practiceData.morningMeditation.map {
                return PracticeDetail(title: $0.title, url: $0.url)
            }
        case 1:
            selectedArray = practiceData.dailyMeditation.map {
                return PracticeDetail(title: $0.title, url: $0.url)
            }
        case 2:
            selectedArray = practiceData.beforeSleepMeditation.map {
                return PracticeDetail(title: $0.title, url: $0.url)
            }
        case 3:
            selectedArray = practiceData.yogaBeginnerAllLevels.map {
                return PracticeDetail(title: $0.title, url: $0.url)
            }
        case 4:
            selectedArray = practiceData.yogaMediumAdvanceLevels.map {
                return PracticeDetail(title: $0.title, url: $0.url)
            }
        default:
            break
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
            detailsViewController.selectedArray = selectedArray
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    // override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {}
    // Now, you can pass selectedArray to DetailsTableViewController
    // and display the content.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MeditationSegue" {
            if let destinationVC = segue.destination as? PracticeTableViewController {
                destinationVC.showMeditationSections = true
            }
        } else if segue.identifier == "YogaSegue" {
            if let destinationVC = segue.destination as? PracticeTableViewController {
                destinationVC.showMeditationSections = false
            }
        }
    }
    
}
    // Configure the cell...
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.

    /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "ShowDetails" {
     if let destinationVC = segue.destination as? DetailsTableViewController,
     let selectedIndexPath = tableView.indexPathForSelectedRow {
     
     // Pass the selected array and its name to the details view controller
     let selectedArray = arrays[selectedIndexPath.row]
     destinationVC.selectedArray = selectedArray
     destinationVC.arrayName = arrayNames[selectedIndexPath.row]
     }
     }
     }
     */
    
    


