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
        
        setupMeditationTable()
        
        let topPadding: CGFloat = 100.0
        meditationTable.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
        meditationTable.rowHeight = 140.0
        self.view.accessibilityIdentifier = "MeditationViewController"
    }
    
    private func setupMeditationTable() {
        meditationTable.dataSource = self
        meditationTable.delegate = self
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
        let cell = configureMeditationCell(tableView, indexPath)
        cell.accessibilityIdentifier = "meditation_\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailsViewController(indexPath)
    }

    private func configureMeditationCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeditationCell", for: indexPath)
        let selectedMeditation = meditationSections[indexPath.row]
        var content = cell.defaultContentConfiguration()
        cell.selectionStyle = .none
        configureFont(in: &content)
        configureTextProperties(in: &content, with: selectedMeditation)
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
            selectedArray = mapPracticeLinks(practiceData.morningMeditation)
        case 1:
            selectedArray = mapPracticeLinks(practiceData.dailyMeditation)
        case 2:
            selectedArray = mapPracticeLinks(practiceData.beforeSleepMeditation)
        default:
            break
        }

        instantiateDetailsViewController(selectedArray)
    }

    private func mapPracticeLinks(_ meditationArray: [Meditation]) -> [PracticeLinks] {
        return meditationArray.map { PracticeLinks(title: $0.title, youtubeLink: $0.link) }
    }

    private func instantiateDetailsViewController(_ selectedArray: [PracticeLinks]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController {
            detailsViewController.activitiesArray = selectedArray
            detailsViewController.practiceType = practiceType
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
