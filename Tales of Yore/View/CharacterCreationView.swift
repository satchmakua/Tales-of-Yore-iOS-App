import SwiftUI

struct CharacterCreationView: View {
    @State private var characterName: String = ""
    @State private var selectedClass: CharacterClass = .warrior
    @State private var attributes = Attributes(strength: 0, intelligence: 0, agility: 0)
    @State private var totalPoints = 15  // Total points available for distribution
    @State private var portraitURL: URL?
    @State private var shouldNavigateToGame = false

    @EnvironmentObject var storyEnvironment: StoryEnvironment

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Character Info")) {
                    TextField("Character Name", text: $characterName)
                    Picker("Class", selection: $selectedClass) {
                        ForEach(CharacterClass.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                }
                
                Section(header: Text("Attributes")) {
                    Stepper("Strength: \(attributes.strength)", onIncrement: {
                        incrementAttribute(&attributes.strength)
                    }, onDecrement: {
                        decrementAttribute(&attributes.strength)
                    })
                    Stepper("Intelligence: \(attributes.intelligence)", onIncrement: {
                        incrementAttribute(&attributes.intelligence)
                    }, onDecrement: {
                        decrementAttribute(&attributes.intelligence)
                    })
                    Stepper("Agility: \(attributes.agility)", onIncrement: {
                        incrementAttribute(&attributes.agility)
                    }, onDecrement: {
                        decrementAttribute(&attributes.agility)
                    })
                    Text("Total Points Remaining: \(totalPoints)")
                }
                
                Section {
                    Button("Save Character") {
                        saveCharacter()
                    }
                }
                
                NavigationLink(
                    "",
                    destination: StoryView(engine: StoryEngine(startNode: storyEnvironment.startNode, allNodes: storyEnvironment.allNodes)),
                    isActive: $shouldNavigateToGame
                )
            }
            .navigationTitle("Create Character")
        }
    }

    private func incrementAttribute(_ attribute: inout Int) {
        if totalPoints > 0 && attribute < 10 {
            attribute += 1
            totalPoints -= 1
        }
    }

    private func decrementAttribute(_ attribute: inout Int) {
        if attribute > 0 {
            attribute -= 1
            totalPoints += 1
        }
    }
    
    private func saveCharacter() {
        let newCharacter = Character(name: characterName, characterClass: selectedClass, attributes: attributes, portraitURL: portraitURL)
        storyEnvironment.currentCharacter = newCharacter  // Update the current character in the environment
        if let characterData = try? JSONEncoder().encode(newCharacter) {
            UserDefaults.standard.set(characterData, forKey: "savedCharacter")
            self.shouldNavigateToGame = true  // Triggers navigation to game view
        }
    }
}

struct CharacterCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCreationView().environmentObject(StoryEnvironment(startNode: StoryNode.defaultStartNode(), allNodes: []))
    }
}
