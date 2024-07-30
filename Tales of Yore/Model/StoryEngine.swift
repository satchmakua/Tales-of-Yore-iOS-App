import Foundation

// MARK: - Story Node
struct StoryNode {
    var id: UUID = UUID()
    var storyText: String
    var options: [StoryOption] = []

    mutating func addOption(_ option: StoryOption) {
        options.append(option)
    }

    static func defaultStartNode() -> StoryNode {
        return StoryNode(storyText: "You are at the beginning of your adventure. What will you do first?", options: [])
    }

    static func findNode(by id: UUID, within nodes: [StoryNode]) -> StoryNode? {
        for node in nodes {
            if node.id == id {
                return node
            }
            for option in node.options {
                if let found = findNode(by: id, within: [option.successNode, option.failureNode]) {
                    return found
                }
            }
        }
        return nil
    }

    func resolveOption(for character: Character, chosenOption: StoryOption) -> StoryNode {
        let mirror = Mirror(reflecting: character.attributes)
        if let attributeValue = mirror.children.first(where: { $0.label == chosenOption.attributeRequired })?.value as? Int,
           attributeValue >= chosenOption.valueRequired {
            return chosenOption.successNode
        } else {
            return chosenOption.failureNode
        }
    }
}

// MARK: - Story Option
// MARK: - Story Option
struct StoryOption {
    var optionText: String
    var attributeRequired: String
    var valueRequired: Int
    var successNode: StoryNode
    var failureNode: StoryNode

    init(optionText: String, attributeRequired: String, valueRequired: Int, successNode: StoryNode, failureNode: StoryNode) {
        self.optionText = optionText
        self.attributeRequired = attributeRequired
        self.valueRequired = valueRequired
        self.successNode = successNode
        self.failureNode = failureNode
    }
}


// MARK: - Story Engine
class StoryEngine: ObservableObject {
    @Published var currentNode: StoryNode
    var allStoryNodes: [StoryNode] // Collection of all nodes

    init(startNode: StoryNode, allNodes: [StoryNode]) {
        self.currentNode = startNode
        self.allStoryNodes = allNodes // Initialize with all nodes
    }
    
    func goToNode(_ node: StoryNode) {
        if let foundNode = findNode(by: node.id, within: allStoryNodes) {
            DispatchQueue.main.async {
                self.currentNode = foundNode
            }
        }
    }

    func findNode(by id: UUID, within nodes: [StoryNode]) -> StoryNode? {
        for node in nodes {
            if node.id == id {
                return node
            }
            for option in node.options {
                if let found = findNode(by: id, within: [option.successNode, option.failureNode]) {
                    return found
                }
            }
        }
        return nil
    }

    func resolveOption(for character: Character, chosenOption: StoryOption) -> StoryNode {
        let mirror = Mirror(reflecting: character.attributes)
        if let attributeValue = mirror.children.first(where: { $0.label == chosenOption.attributeRequired })?.value as? Int,
           attributeValue >= chosenOption.valueRequired {
            return chosenOption.successNode
        } else {
            return chosenOption.failureNode
        }
    }
}
