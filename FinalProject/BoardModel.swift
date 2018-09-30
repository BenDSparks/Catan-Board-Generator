
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
    var numberTokenOrder = [5,2,6,3,8,10,9,12,11,4,8,10,9,4,5,6,3,11]
    //for testing
    //var tileOrder =   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    var resourceOrder = [ResourceType]()
    
    let boardOffset = 2
    
    //set up first board when model is created
    init(session: ApplicationSession) {
        
        options = session.options
        
        shuffleBoard()
        
        //setBoard()
        
    }
    
    func getBoardData() -> BoardData {
        
       return BoardData(numberOrder: numberTokenOrder, resourceOrder: resourceOrder)
        
    }
    
    func shuffleBoard(){
        numberTokenOrder = [5,2,6,3,8,10,9,12,11,4,8,10,9,4,5,6,3,11]
        if options.randomNumbers {
            numberTokenOrder.shuffleThis()
        }
        
        resourceOrder = [.desert, .brick, .brick, .brick, .wood, .wood, .wood, .wood, .sheep, .sheep, .sheep, .sheep, .wheat, .wheat, .wheat, .wheat, .ore, .ore, .ore]
        if options.randomTiles {
            resourceOrder.shuffleThis()
        }
    }
    
    func newBoard(){
        shuffleBoard()
        //setBoard()
    }
    
}
