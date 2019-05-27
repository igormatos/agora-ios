//
//  Room.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import Foundation
import UIKit

struct Classroom: Codable {
    var name: String
    var code: String
    var authorId: String
    var author: String
    var theme: String
    var texts: [Text]
    var users: [String: Phase] // [userId: Phase]
    var canJoin: Bool? = true
}

enum Phase: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }

    enum CodingError: Error {
        case unknownValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .justJoined
        case 1:
            self = .writing
        case 2:
            self = .mayGrade
        case 3:
            self = .grading
        case 4:
            self = .debate
        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .justJoined:
            try container.encode(0, forKey: .rawValue)
        case .writing:
            try container.encode(1, forKey: .rawValue)
        case .mayGrade:
            try container.encode(2, forKey: .rawValue)
        case .grading:
            try container.encode(2, forKey: .rawValue)
        case .debate:
            try container.encode(2, forKey: .rawValue)
        }
    }
    
    case justJoined, writing, mayGrade, grading, debate
}


struct Text: Codable {
    var author: String
    var authorId: String
    var body: String
    var theme: String
    var highlightedTexts: [Highlighted]
}

struct Highlighted: Codable {
    var text: String
    var color: String
}
