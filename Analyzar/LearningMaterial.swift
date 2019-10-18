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
        case vision
        case text
        case speech
    }
}

extension LearningMaterial.Category: CaseIterable {}

extension LearningMaterial.Category: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "All": self = .all
        case "Vision": self = .vision
        case "Text": self = .text
        case "Speech": self = .speech
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .all: return "All"
        case .vision: return "Vision"
        case .text: return "Text"
        case .speech: return "Speech"
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
