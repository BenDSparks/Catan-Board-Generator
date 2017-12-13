struct TileData {
    var xIndex: Int
    var yIndex: Int
    var resourceType: ResourceType
    var tileNumberToken: Int?
    
}
//board coords
//        (0,-2)(1,-2)(2,-2)
//     (-1,-1)(0,-1)(1,-1)(2,-1)
//    (-2,0)(0,-1)(0,0)(1,0)(2,0)
//     (-2,1)(-1,1)(0,1)(1,1)
//        (-2,2)(-1,2)(0,2)

import Foundation

class BoardModel{
    
    let options: Options
    
    //order A-R on number tokens
    var tileOrder = [5,2,6,3,8,10,9,12,11,4,8,10,9,4,5,6,3,11]
    //var tileOrder =   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    var tileDeck = [ResourceType]()
    
    let boardOffset = 2
    
    var tileData: [[TileData?]] = [[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil]]
    
    
    //set up first board when model is created
    init(session: ApplicationSession) {
        
        options = session.options
        
        shuffleBoard()
        
        setBoard()
        
        
        
        
    }
    
    func shuffleBoard(){
        tileOrder = [5,2,6,3,8,10,9,12,11,4,8,10,9,4,5,6,3,11]
        if options.randomNumbers {
            tileOrder.shuffle()
        }
        
        tileDeck = [.desert, .brick, .brick, .brick, .wood, .wood, .wood, .wood, .sheep, .sheep, .sheep, .sheep, .wheat, .wheat, .wheat, .wheat, .ore, .ore, .ore]
        if options.randomTiles {
            tileDeck.shuffle()
        }
        
        
    }
    
    func newBoard(){
        shuffleBoard()
        setBoard()
    }
    
    func setBoard(){
        var tileDeckIndex = 0
        var tileOrderIndex = 0
        
        for i in -2...2 {
            
            for j in -2...2 {
                //if not the empty tiles in the grid
                //empty tiles indexes  (-2,-2) (-1,-2) (-2,-1) (2,1) (1,2) (2,2)
                if (i == -2 && j == -2) || (i == -1 && j == -2) || (i == -2 && j == -1) || (i == 2 && j == 1) || (i == 1 && j == 2) || (i == 2 && j == 2) {
                    //DO NOTHING
                    //print("Tile at (\(i),\(j)) is water")
                }
                else{
                    if tileDeck[tileDeckIndex] != .desert {
                        
                        //print("Tile at (\(i),\(j)) is assigned \(tileDeck[tileDeckIndex]) resource type with token number \(tileOrder[tileOrderIndex]).")
                        
                        let td = TileData(xIndex: i, yIndex: j, resourceType: tileDeck[tileDeckIndex], tileNumberToken: tileOrder[tileOrderIndex])
                        
                        tileData[i+boardOffset][j+boardOffset] = td
                        
                        tileOrderIndex += 1
                        
                    }
                    else{
                        
                        //print("Tile at (\(i),\(j)) is assigned \(tileDeck[tileDeckIndex]) resource type.")
                        
                        let td = TileData(xIndex: i, yIndex: j, resourceType: tileDeck[tileDeckIndex], tileNumberToken: nil)
                        
                        tileData[i+boardOffset][j+boardOffset] = td
                    }
                    
                    tileDeckIndex += 1
                }
            }
            
        }
    }
    
}
