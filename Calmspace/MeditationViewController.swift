//
//  PracticeViewController.swift
//  Calmspace
//
//  Created by Admin on 18/11/2023.
//
import UIKit

class MeditationViewController: UIViewController {
    
    var practiceType: String?    
    var meditationSections = ["Morning Meditation", "Daily Meditation", "Before Sleep Meditation"]
    
    @IBOutlet weak var meditationTable: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        meditationTable.dataSource = self
        meditationTable.delegate = self
        
        let verticalInset = (view.bounds.height - meditationTable.contentSize.height) * 0.70
                meditationTable.contentInset = UIEdgeInsets(top: verticalInset, left: 0, bottom: verticalInset, right: 0)
        
        let forestGreenColor = UIColor(red: 34/255.0, green: 56/255.0, blue: 34/255.0, alpha: 1.0)
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        backButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: forestGreenColor], for: .normal)
        
                navigationItem.leftBarButtonItem = backButton
    }
}
extension MeditationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meditationSections.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeditationCell", for: indexPath)
            let selectedMeditation = meditationSections[indexPath.row]
            var content = cell.defaultContentConfiguration()
            
            if let customFont = UIFont(name: "AvenirNext-DemiBold", size: 22.0) {
                content.textProperties.font = customFont
            } else {
                content.textProperties.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
            }
            
            content.textProperties.color = UIColor.white
            content.text = selectedMeditation
            content.textProperties.alignment = .center
            cell.contentConfiguration = content

                    return cell
                }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       var selectedArray: [PracticeLinks] = []
       
        switch indexPath.row {
                case 0:
                    selectedArray = practiceData.morningMeditation.map {
                        return PracticeLinks(title: $0.title, youtubeLink: $0.link)
                    }
                case 1:
                    selectedArray = practiceData.dailyMeditation.map {
                        return PracticeLinks(title: $0.title, youtubeLink: $0.link)
                    }
                case 2:
                    selectedArray = practiceData.beforeSleepMeditation.map {
                        return PracticeLinks(title: $0.title, youtubeLink: $0.link)
                    }
                default:
                    break
                }
       
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
           detailsViewController.activitiesArray = selectedArray
           detailsViewController.practiceType = practiceType
           self.navigationController?.pushViewController(detailsViewController, animated: true)
       }
   }
    @objc func backPressed() {
            // Handle the back navigation item press
            // For example, navigate back to HomeViewController
            navigationController?.popToRootViewController(animated: true)
        }
}
