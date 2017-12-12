//
//  Board.swift
//  FinalProject
//
//  Created by Ben Sparks on 11/27/17.
//  Copyright © 2017 UMSL. All rights reserved.
//

struct BoardData {
    var resourceType: ResourceType
    var tileNumberToken: Int
}
    //board coords
//        (0,-2)(1,-2)(2,-2)
//     (-1,-1)(0,-1)(1,-1)(2,-1)
//    (-2,0)(0,-1)(0,0)(1,0)(2,0)
//     (-2,1)(-1,1)(0,1)(1,1)
//        (-2,2)(-1,2)(0,2)

import Foundation

class Board {
    
    let options: Options
    
    //order A-R on number tokens
    //var tileOrder = [5,2,6,3,8,10,9,12,11,4,8,10,9,4,5,6,3,11]
    var tileOrder =   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    var tileDeck = [ResourceType]()
    
    let boardOffset = 2
    var boardData = [[BoardData]]()
    
   
    
    init(options passedOptions: Options) {
        tileDeck = [.brick, .brick, .brick, .wood, .wood, .wood, .wood, .sheep, .sheep, .sheep, .sheep, .desert]
        options = passedOptions
        
        if options.randomTiles {
            tileDeck.shuffle()
        }
        
        if options.randomNumbers {
            tileOrder.shuffle()
        }
        
        var tileDeckIndex = 0
        var tileOrderIndex = 0
        
        for i in -2...2 {
            
            for j in -2...2 {
                //if not the desert tile
                if tileDeck[tileDeckIndex] != .desert {
                        //if not the empty tiles in the grid
                        //empty tiles indexes  (-2,-2) (-1,-2) (-2,-1) (2,1) (1,2) (2,2)
                    if i != -2 && j != -2 || i != -1 && j != -2 || i != -2 && j != -1 || i != 2 && j != 1 || i != 1 && j != 2 || i != 2 && j != 2 {
                        //set board data
                        boardData[i+boardOffset][j+boardOffset] = BoardData(resourceType: tileDeck[tileDeckIndex], tileNumberToken: tileOrder[tileOrderIndex])
                        tileDeckIndex += 1
                        tileOrderIndex += 1
                    }
                    
                    
                }
                
                
            }
            
        }
        
        
    }
    
}
