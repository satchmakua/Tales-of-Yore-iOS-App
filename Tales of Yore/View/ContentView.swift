import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: CharacterCreationView()) {
                    Text("New Game")
                }
                .buttonStyle(MainMenuButtonStyle())
                
                NavigationLink(destination: LoadGameView()) {
                    Text("Load Game")
                }
                .buttonStyle(MainMenuButtonStyle())
                
                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                }
                .buttonStyle(MainMenuButtonStyle())
                
                NavigationLink(destination: StoryView(engine: StoryEngine(startNode: loadGame(), allNodes: allStoryNodes))) {
                    Text("Continue")
                }
                .buttonStyle(MainMenuButtonStyle())

                Button("Quit") {
                    exit(0)
                }
                .buttonStyle(MainMenuButtonStyle())
            }
            .navigationBarHidden(true)
        }
    }
}

struct MainMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let allStoryNodes: [StoryNode] = []

func loadGame() -> StoryNode {
    if let characterData = UserDefaults.standard.data(forKey: "savedCharacter"),
       let savedCharacter = try? JSONDecoder().decode(Character.self, from: characterData),
       let savedNodeID = savedCharacter.currentNodeID {
        if let startNode = findNode(by: savedNodeID, within: allStoryNodes) {
            return startNode
        }
    }
    return StoryNode.defaultStartNode()
}

// Helper function to find a node by UUID
func findNode(by id: UUID, within nodes: [StoryNode]) -> StoryNode? {
    for node in nodes {
        if node.id == id {
            return node
        }
        for option in node.options {
            // Check both the successNode and failureNode for each option
            if let found = findNode(by: id, within: [option.successNode, option.failureNode]) {
                return found
            }
        }
    }
    return nil
}

