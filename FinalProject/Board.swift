import Foundation

enum ResourceType {
    case brick
    case wood
    case sheep
    case wheat
    case ore
    case desert
}

struct BoardData {
    let numberOrder: [Int]
    let resourceOrder: [ResourceType]
}
