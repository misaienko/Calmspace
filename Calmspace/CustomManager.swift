//
//  CustomManager.swift
//  Calmspace
//
//  Created by Admin on 16/10/2023.
//

import Foundation

// MARK: - Practice
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


// MARK: - Meditation
struct Meditation: Codable {
    let title, url, description: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case url = "URL"
        case description = "Description"
    }
}

// MARK: - YogaSessionItem
struct YogaSession: Codable {
    let title, url, description: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case url = "URL"
        case description = "Description"
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Could not find \(file) in the project!")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not find \(file) in the project!")
        }

        let decoder = JSONDecoder()

        do {
            let loadedData = try decoder.decode(T.self, from: data)
            return loadedData
        } catch {
            print("Error decoding \(file):", error)
            fatalError("Could not decode \(file) in the project!")
        }
    }
}

