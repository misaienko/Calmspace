//
//  PracticeTableViewController.swift
//  Calmspace
//
//  Created by Admin on 09/10/2023.
//

import UIKit
import Foundation

class PracticeTableViewController: UITableViewController {
    
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
        let title, url, description: String
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case url = "URL"
            case description = "Description"
        }
    }
    
    struct YogaSession: Codable {
        let title, url, description: String
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case url = "URL"
            case description = "Description"
        }
    }
    
    
    
    ///      var selectedArray: [String] = []
    
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
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //  print("Number of sections called")
        
        return 1
    }
    
    //Return Array Names
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    //      print("Number of rows in section \(section) called")
    
    
    
    // #warning Incomplete implementation, return the number of rows
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PracticeTableViewCell
        
        cell.customLabel.text = practiceSections[indexPath.row]
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedArray: [String] = []
        
        switch indexPath.row {
        case 0:
            selectedArray = practiceData.dailyMeditation.map { $0.title }
        case 1:
            selectedArray = practiceData.yogaBeginnerAllLevels.map { $0.title }
        case 2:
            selectedArray = practiceData.yogaMediumAdvanceLevels.map { $0.title }
        case 3:
            selectedArray = practiceData.morningMeditation.map { $0.title }
        case 4:
            selectedArray = practiceData.beforeSleepMeditation.map { $0.title }
        default:
            break
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
            detailsViewController.selectedArray = selectedArray
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}

    
 //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    
    
    // Now, you can pass selectedArray to DetailsTableViewController
    // and display the content.
      
     
     
     
     
     
     
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
             
        
    
    
    
    //   let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsTableViewController") as! DetailsTableViewController
    //            detailsVC.details = values
    //            navigationController?.pushViewController(detailsVC, animated: true)
    
    
    
    
    
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
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

    
              
