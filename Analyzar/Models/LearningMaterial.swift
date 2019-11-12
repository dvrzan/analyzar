//
//  LearningMaterial.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-17.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

struct LearningMaterial: Decodable {
    let title: String
    let category: Category
    let description: String
    
    enum Category: Decodable {
        case all
        case basics
        case part1
        case part2
        case part3
        case part4
    }
}

extension LearningMaterial.Category: CaseIterable {}

extension LearningMaterial.Category: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "All": self = .all
        case "Basics": self = .basics
        case "Part 1": self = .part1
        case "Part 2": self = .part2
        case "Part 3": self = .part3
        case "Part 4": self = .part4
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .all: return "All"
        case .basics: return "Basics"
        case .part1: return "Part 1"
        case .part2: return "Part 2"
        case .part3: return "Part 3"
        case .part4: return "Part 4"
        }
    }
}

extension LearningMaterial {
    static func learningMaterials() -> [LearningMaterial] {
        guard
            let url = Bundle.main.url(forResource: "learn", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([LearningMaterial].self, from: data)
        } catch {
            return []
        }
    }
}
