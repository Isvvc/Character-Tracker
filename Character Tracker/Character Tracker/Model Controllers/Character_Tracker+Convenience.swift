//
//  Character_Tracker+Convenience.swift
//  Character Tracker
//
//  Created by Isaac Lyons on 10/30/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import CoreData

extension Race {
    @discardableResult convenience init(name: String, game: Game, mod: Mod?, id: UUID = UUID(), context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.id = id
        self.game = [game]
        self.mod = mod
    }
}

extension Attribute {
    @discardableResult convenience init(name: String, game: Game, type: AttributeType, id: UUID = UUID(), mod: Mod?, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.id = id
        self.game = game
        self.type = type
        self.mod = mod
    }
}

extension Character {
    @discardableResult convenience init(name: String, race: Race, female: Bool, game: Game, id: UUID = UUID(), context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.race = race
        self.female = female
        self.game = game
        self.id = id
    }
}

extension CharacterAttribute {
    @discardableResult convenience init(character: Character, attribute: Attribute, priority: Int16, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.character = character
        self.attribute = attribute
        self.priority = priority
    }
}
