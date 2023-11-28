//
//  DetailsTableViewController.swift
//  Calmspace
//
//  Created by Admin on 12/10/2023.
//

import UIKit

struct PracticeDetail {
    let title: String
    let youtubeLink: URL
}

class DetailsTableViewController: UITableViewController {
    
    var selectedArray: [PracticeDetail] = []
    var practiceType: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
        cell.detailsLabel.text = selectedArray[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DetailsViewController - didSelectRowAt")
                if let displayViewController = storyboard?.instantiateViewController(withIdentifier: "DisplayViewController") as? DisplayViewController {
                    let selectedMeditation = selectedArray[indexPath.row]
                    displayViewController.link = selectedMeditation.youtubeLink
                    navigationController?.pushViewController(displayViewController, animated: true)
                }
            }
        }
  
 
