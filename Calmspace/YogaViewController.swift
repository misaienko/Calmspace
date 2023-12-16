//
//  YogaViewController.swift
//  Calmspace
//
//  Created by Admin on 06/12/2023.
//

import UIKit

class YogaViewController: UIViewController {

    @IBOutlet weak var yogaTable: UITableView!
    
    var yogaSections = ["Beginner & All Levels", "Medium & Advanced Levels"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yogaTable.dataSource = self
        yogaTable.delegate = self
        
        let verticalInset = (view.bounds.height - yogaTable.contentSize.height) * 0.70
                yogaTable.contentInset = UIEdgeInsets(top: verticalInset, left: 0, bottom: verticalInset, right: 0)
    }
}

extension YogaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yogaSections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaCell", for: indexPath) 
        let selectedYoga = yogaSections[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        if let customFont = UIFont(name: "AvenirNext-DemiBold", size: 18.0) {
            content.textProperties.font = customFont
        } else {
            content.textProperties.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        }
                content.textProperties.color = UIColor.white
                content.text = selectedYoga
                content.textProperties.alignment = .center
                cell.contentConfiguration = content

                return cell
            }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                var selectedArray: [PracticeLinks] = []

                switch indexPath.row {
                case 0:
                    selectedArray = practiceData.yogaBeginnerAllLevels.map {
                        return PracticeLinks(title: $0.title, youtubeLink: $0.link)
                    }
                case 1:
                    selectedArray = practiceData.yogaMediumAdvanceLevels.map {
                        return PracticeLinks(title: $0.title, youtubeLink: $0.link)
                    }
                default:
                        break
                        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
        detailsViewController.activitiesArray = selectedArray
        detailsViewController.practiceType = "Yoga"
        self.navigationController?.pushViewController(detailsViewController, animated: true)
     }
  }
    
}

