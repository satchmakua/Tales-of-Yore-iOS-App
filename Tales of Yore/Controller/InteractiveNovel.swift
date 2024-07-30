import SwiftUI

// MARK: - Story View
struct StoryView: View {
    @EnvironmentObject var storyEnvironment: StoryEnvironment
    @ObservedObject var engine: StoryEngine
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text(engine.currentNode.storyText)
                .padding()

            ForEach(engine.currentNode.options.indices, id: \.self) { index in
                let option = engine.currentNode.options[index]
                Button(action: {
                    // Using resolveOption to determine the next node based on the character's attributes
                    let resultNode = engine.currentNode.resolveOption(for: storyEnvironment.currentCharacter!, chosenOption: option)
                    engine.goToNode(resultNode)
                }) {
                    Text(option.optionText)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            HStack {
                Button("Save Game") {
                    saveGame()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }

    private func saveGame() {
        GameSaveManager.shared.saveGame(nodeID: engine.currentNode.id)
    }
}

class StoryEnvironment: ObservableObject {
    var startNode: StoryNode
    var allNodes: [StoryNode]
    @Published var currentCharacter: Character?

    init(startNode: StoryNode, allNodes: [StoryNode], character: Character? = nil) {
        self.startNode = startNode
        self.allNodes = allNodes
        self.currentCharacter = character
    }
}

// MARK: - SwiftUI App
@main
struct InteractiveNovelApp: App {
    var body: some Scene {
        // Create an instance of DecisionTree to initialize all nodes properly
        let decisionTree = DecisionTree()
        
        // Use the nodes from the DecisionTree instance to set up the story environment
        let storyEnvironment = StoryEnvironment(startNode: decisionTree.startNode, allNodes: decisionTree.allNodes)

        return WindowGroup {
            ContentView()
                .environmentObject(storyEnvironment)
        }
    }
}
