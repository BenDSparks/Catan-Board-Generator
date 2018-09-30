import Foundation


extension MutableCollection where Index == Int {
//    testing
    mutating func shuffleThis() {
        if count < 2 {
            return
        }
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}
