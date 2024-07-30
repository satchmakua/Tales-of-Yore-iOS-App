import SwiftUI

struct LoadGameView: View {
    @EnvironmentObject var storyEnvironment: StoryEnvironment

    var body: some View {
        NavigationView {
            List {
                if let loadedEngine = loadSavedGame() {
                    NavigationLink("Load Saved Game", destination: StoryView(engine: loadedEngine))
                } else {
                    Text("No saved games available")
                }
            }
            .navigationBarTitle("Load Game")
        }
    }

    private func loadSavedGame() -> StoryEngine? {
        guard let savedNodeID = GameSaveManager.shared.loadGame(),
              let startNode = StoryNode.findNode(by: savedNodeID, within: storyEnvironment.allNodes) else {
            return nil
        }
        return StoryEngine(startNode: startNode, allNodes: storyEnvironment.allNodes)
    }
}

