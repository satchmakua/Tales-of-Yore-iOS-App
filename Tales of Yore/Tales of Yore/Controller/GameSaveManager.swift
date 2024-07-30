import Foundation

class GameSaveManager {
    static let shared = GameSaveManager()
    private init() {}

    func saveGame(nodeID: UUID) {
        UserDefaults.standard.set(nodeID.uuidString, forKey: "currentNodeID")
    }

    func loadGame() -> UUID? {
        guard let nodeIDString = UserDefaults.standard.string(forKey: "currentNodeID"),
              let nodeID = UUID(uuidString: nodeIDString) else {
            return nil
        }
        return nodeID
    }
}
