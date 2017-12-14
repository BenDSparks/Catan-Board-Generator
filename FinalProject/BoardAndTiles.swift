import Foundation

struct TileData {
    var xIndex: Int
    var yIndex: Int
    var resourceType: ResourceType
    var tileNumberToken: Int?
}

struct BoardData {
    let numberOrder: [Int]
    let resourceOrder: [ResourceType]
}
