import Foundation

enum CharacterClass: String, CaseIterable, Codable {
    case warrior = "Warrior"
    case mage = "Mage"
    case rogue = "Rogue"
}

struct Attributes: Codable {
    var strength: Int
    var intelligence: Int
    var agility: Int
}

struct Character: Codable {
    var name: String
    var characterClass: CharacterClass
    var attributes: Attributes
    var alignment: Int = 0 
    var portraitURL: URL?
    var currentNodeID: UUID?
}
