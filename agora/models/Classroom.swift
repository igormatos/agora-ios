//
//  Room.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

struct Classroom: Codable {
    var name: String
    var code: String
    var authorId: String
    var author: String
    var theme: String
    var texts: [String:Text]
    var users: [String:CustomUser]
    var highlightedText: Highlighted?
    var stage: Int
    
    init(name: String, authorId: String, author: String, theme: String) {
        self.name = name
        self.code =  NanoID.new(alphabet: .uppercasedLatinLetters, size: 5)
        self.authorId = authorId
        self.author = author
        self.theme = theme
        self.texts = [:]
        self.users = [:]
        self.stage = 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        authorId = try container.decode(String.self, forKey: .authorId)
        author = try container.decode(String.self, forKey: .author)
        theme = try container.decode(String.self, forKey: .theme)
        stage = try container.decode(Int.self, forKey: .stage)
        
        do {
            texts = try container.decode([String:Text].self, forKey: .texts)
        } catch {
            texts = [:]
        }
        
        do {
            users = try container.decode([String:CustomUser].self, forKey: .users)
        } catch {
            users = [:]
        }
        
        do {
        highlightedText = try container.decode(Highlighted.self, forKey: .highlightedText)
        } catch {
            
        }
        
        
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case code
        case authorId
        case author
        case theme
        case stage
        case texts
        case users
        case highlightedText
        
    }
    
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
    var id: String
    var author: String
    var authorId: String
    var body: String
    var theme: String
    var highlightedTexts: [String:Highlighted]
    
    init (author: String, authorId: String, body: String, theme: String) {
        self.id = NanoID.new(alphabet: .uppercasedLatinLetters, size: 5)
        self.author = author
        self.authorId = authorId
        self.body = body
        self.theme = theme
        self.highlightedTexts = [:]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        authorId = try container.decode(String.self, forKey: .authorId)
        body = try container.decode(String.self, forKey: .body)
        theme = try container.decode(String.self, forKey: .theme)
        
        do {
            try highlightedTexts = try container.decode([String:Highlighted].self, forKey: .highlightedTexts)
        } catch {
            highlightedTexts = [:]
        }
    
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case authorId
        case body
        case theme
        
        case highlightedTexts
    }
}

struct Highlighted: Codable {
    var id: String
    var text: String // "Muito importante analisarmos que..."
    var color: String // #cccccc
    
    init (text: String, color: String) {
        self.id = NanoID.new(alphabet: .uppercasedLatinLetters, size: 5)
        self.text = text
        self.color = color
    }
    
}

struct CustomUser: Codable {
    var name: String
    var id: String
    
    init(firebaseUser: User) {
        self.name = firebaseUser.displayName!
        self.id = firebaseUser.uid
    }
}
