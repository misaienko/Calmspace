//
//  YogaViewController.swift
//  Calmspace
//
//  Created by Admin on 06/12/2023.
//

import UIKit

class YogaViewController: UIViewController {
    
    @IBOutlet weak var yogaTable: UITableView!
    
    var yogaSections = ["Yoga: Beginner & All Levels", "Yoga: Medium & Advance Levels"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupYogaTable()
        
        let topPadding: CGFloat = 150.0
        yogaTable.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
        yogaTable.rowHeight = 140.0
        self.view.accessibilityIdentifier = "YogaViewController"
    }
    
    private func setupYogaTable() {
        yogaTable.dataSource = self
        yogaTable.delegate = self
        
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
        let cell = configureYogaCell(tableView, indexPath)
        cell.accessibilityIdentifier = "yoga_\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailsViewController(indexPath)
    }
    
    private func configureYogaCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaCell", for: indexPath)
        let selectedYoga = yogaSections[indexPath.row]
        var content = cell.defaultContentConfiguration()
        cell.selectionStyle = .none
        configureFont(in: &content)
        configureTextProperties(in: &content, with: selectedYoga)
        cell.contentConfiguration = content
        
        return cell
    }
    
    private func configureFont(in content: inout UIListContentConfiguration) {
        if let customFont = UIFont(name: "AvenirNext-DemiBold", size: 22.0) {
            content.textProperties.font = customFont
        } else {
            content.textProperties.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        }
    }
    
    private func configureTextProperties(in content: inout UIListContentConfiguration, with text: String) {
        content.textProperties.color = UIColor.white
        content.text = text
        content.textProperties.alignment = .center
    }
    
    private func navigateToDetailsViewController(_ indexPath: IndexPath) {
        var selectedArray: [PracticeLinks] = []
        
        switch indexPath.row {
        case 0:
            selectedArray = mapPracticeLinks(practiceData.yogaBeginnerAllLevels)
        case 1:
            selectedArray = mapPracticeLinks(practiceData.yogaMediumAdvanceLevels)
        default:
            break
        }
        
        showDetailsViewController(selectedArray)
    }
    
    private func mapPracticeLinks(_ yogaArray: [YogaSession]) -> [PracticeLinks] {
        return yogaArray.map { PracticeLinks(title: $0.title, youtubeLink: $0.link) }
    }
    
    private func showDetailsViewController(_ selectedArray: [PracticeLinks]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
            detailsViewController.activitiesArray = selectedArray
            detailsViewController.practiceType = "Yoga"
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}



