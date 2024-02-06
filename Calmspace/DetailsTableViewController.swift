//
//  DetailsTableViewController.swift
//  Calmspace
//
//  Created by Admin on 12/10/2023.
//

import UIKit

struct PracticeLinks {
    let title: String
    let youtubeLink: URL
}

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet var detailsTable: UITableView!
    
    var activitiesArray: [PracticeLinks] = []
    var practiceType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTable.rowHeight = 60.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        let selectedMeditation = activitiesArray[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        cell.selectionStyle = .none
        
        if let customFont = UIFont(name: "AvenirNext-DemiBold", size: 19.0) {
            content.textProperties.font = customFont
        } else {
            content.textProperties.font = UIFont.systemFont(ofSize: 19.0, weight: .bold)
        }
        
        content.textProperties.color = UIColor.white
        content.text = selectedMeditation.title
        content.textProperties.alignment = .center
        cell.contentConfiguration = content
        cell.accessibilityIdentifier = "optionCell_\(indexPath.row)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(#function)")
        if let displayViewController = storyboard?.instantiateViewController(withIdentifier: "DisplayViewController") as? DisplayViewController {
            let selectedMeditation = activitiesArray[indexPath.row]
            displayViewController.link = selectedMeditation.youtubeLink
            navigationController?.pushViewController(displayViewController, animated: true)
        }
    }
}

 
