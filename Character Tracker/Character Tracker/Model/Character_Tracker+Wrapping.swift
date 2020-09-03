//
//  Character_Tracker+Wrapping.swift
//  Character Tracker
//
//  Created by Isaac Lyons on 7/27/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import CoreData

extension NSManagedObject {
    var idString: String? {
        guard let idObject = self.value(forKey: "id") else { return nil }
        
        if let idString = idObject as? String {
            return idString
        } else if let uuid = idObject as? UUID {
            return uuid.uuidString
        }
        
        return nil
    }
}

extension Mod: Identifiable {
    var wrappedName: String {
        get { self.name ?? "" }
        set { self.name = newValue }
    }
}

extension Module: Identifiable {}

extension CharacterModule: Identifiable {}

extension Ingredient: Identifiable {}

extension Character {
    var wrappedName: String {
        get { self.name ?? "" }
        set { self.name = newValue }
    }
}

extension Race: Identifiable {
    var gamesList: String? {
        guard let gameNames = games?.compactMap({ ($0 as? Game)?.name }) else { return nil }
        return gameNames.joined(separator: ", ")
    }
}
