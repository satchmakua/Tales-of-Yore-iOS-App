import Foundation

struct DecisionTree {
    // Define all nodes as properties to ensure proper initialization
    let startNode: StoryNode
    let decisionNodeLocked: StoryNode
    let noResponseNode: StoryNode
    let doorLockedNode: StoryNode
    let breakDoorNode: StoryNode
    let pickLockNode: StoryNode
    let spellOpenNode: StoryNode
    let pickLockFailedNode: StoryNode
    let spellOpenFailedNode: StoryNode
    let insideKeepNode: StoryNode
    let detailedInteriorNode: StoryNode
    let stairsNode: StoryNode
    let hallwayNode: StoryNode
    let cellarNode: StoryNode
    let allNodes: [StoryNode]

    init() {
        var start = StoryNode(storyText: "It's a dark and stormy night. As you approach an old run-down keep, you see a looming door.", options: [])
        var noResponse = StoryNode(storyText: "You knock on the door, but no one responds. The silence deepens the mystery of the old keep.", options: [])
        var doorLocked = StoryNode(storyText: "The door is locked. It seems you'll need to find another way in or overcome this obstacle.", options: [])
        
        var breakDoor = StoryNode(storyText: "With a forceful kick, the door gives way. You step inside the keep, ready to explore its secrets.", options: [])
        var pickLock = StoryNode(storyText: "You deftly pick the lock. As the latch clicks open, you slowly push the door, peering into the darkness.", options: [])
        var spellOpen = StoryNode(storyText: "Whispering 'Alohomora', the lock clicks and the door swings open magically, revealing the secrets hidden inside.", options: [])
        
        var pickLockFailed = StoryNode(storyText: "You fail to pick the lock.", options: [])
        var spellOpenFailed = StoryNode(storyText: "The spell fails to open the lock.", options: [])
        var breakDoorFailed = StoryNode(storyText: "You fail to break down the door.", options: [])

        var detailedInterior = StoryNode(storyText: "The keep's interior looms dark and mysterious, shadows flickering in the dim light. As you step inside, the air feels heavy with ancient secrets.", options: [])
        var stairs = StoryNode(storyText: "TBD", options: [])
        var hallway = StoryNode(storyText: "Under construction", options: [])
        var cellar = StoryNode(storyText: "Still rendering", options: [])

        // Linking Go Back options after all nodes are initialized
        noResponse.options.append(StoryOption(optionText: "Go Back", attributeRequired: "", valueRequired: 0, successNode: start, failureNode: start))
        doorLocked.options.append(StoryOption(optionText: "Go Back", attributeRequired: "", valueRequired: 0, successNode: start, failureNode: start))
        pickLockFailed.options.append(StoryOption(optionText: "Attempt Failed - Go Back", attributeRequired: "", valueRequired: 0, successNode: start, failureNode: start))
        spellOpenFailed.options.append(StoryOption(optionText: "Attempt Failed - Go Back", attributeRequired: "", valueRequired: 0, successNode: start, failureNode: start))
        breakDoorFailed.options.append(StoryOption(optionText: "Attempt Failed - Go Back", attributeRequired: "", valueRequired: 0, successNode: start, failureNode: start))


        // Adding exploration options to the detailed interior node
        detailedInterior.options.append(contentsOf: [
            StoryOption(optionText: "Walk up the stairs", attributeRequired: "", valueRequired: 0, successNode: stairs, failureNode: stairs),
            StoryOption(optionText: "Explore the hallway to the left", attributeRequired: "", valueRequired: 0, successNode: hallway, failureNode: hallway),
            StoryOption(optionText: "Explore the cellar to the right", attributeRequired: "", valueRequired: 0, successNode: cellar, failureNode: cellar)
        ])

        // Defining options for the decisionLocked node
        let decisionLocked = StoryNode(storyText: "The door is locked. What do you do?", options: [
            StoryOption(optionText: "Break the door down", attributeRequired: "strength", valueRequired: 6, successNode: breakDoor, failureNode: doorLocked),
            StoryOption(optionText: "Pick the lock", attributeRequired: "agility", valueRequired: 6, successNode: pickLock, failureNode: pickLockFailed),
            StoryOption(optionText: "Use 'Alohomora' spell", attributeRequired: "intelligence", valueRequired: 6, successNode: spellOpen, failureNode: spellOpenFailed)
        ])

        // Completing the initial options for the start node
        start.options = [
            StoryOption(optionText: "Knock on the door", attributeRequired: "", valueRequired: 0, successNode: noResponse, failureNode: noResponse),
            StoryOption(optionText: "Try to open the door", attributeRequired: "", valueRequired: 0, successNode: decisionLocked, failureNode: decisionLocked)
        ]

        // Assigning the initialized nodes to properties
        self.startNode = start
        self.decisionNodeLocked = decisionLocked
        self.noResponseNode = noResponse
        self.doorLockedNode = doorLocked
        self.breakDoorNode = breakDoor
        self.pickLockNode = pickLock
        self.spellOpenNode = spellOpen
        self.pickLockFailedNode = pickLockFailed
        self.spellOpenFailedNode = spellOpenFailed
        self.insideKeepNode = breakDoor 
        self.detailedInteriorNode = detailedInterior
        self.stairsNode = stairs
        self.hallwayNode = hallway
        self.cellarNode = cellar
        self.allNodes = [start, decisionLocked, noResponse, doorLocked, breakDoor, pickLock, spellOpen, pickLockFailed, spellOpenFailed, detailedInterior, stairs, hallway, cellar]
    }
}
