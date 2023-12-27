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
    
    var activitiesArray: [PracticeLinks] = []
    var practiceType: String?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Your existing code
            // Add a custom back button action
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        backButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
            navigationItem.leftBarButtonItem = backButton
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
            
        if let customFont = UIFont(name: "AvenirNext-DemiBold", size: 18.0) {
                content.textProperties.font = customFont
            } else {
                // Provide a default font or handle the failure case
                content.textProperties.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
            }
            
            content.textProperties.color = UIColor.white
            content.text = selectedMeditation.title
            content.textProperties.alignment = .center
            cell.contentConfiguration = content
            
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
    @objc func backPressed() {
        // Handle the back navigation item press
        // For example, navigate back to HomeViewController
        navigationController?.popToRootViewController(animated: true)
    }
        }
  
 
