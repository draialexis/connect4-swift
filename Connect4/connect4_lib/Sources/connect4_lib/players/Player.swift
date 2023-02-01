import Foundation

class Player {
    
    let id: Int
    
    init(withId id: Int){
        self.id = id
    }

    ///
    /// should be considered abstract and overridden by descendants
    internal func playBetween(min: Int, andMaxIncl maxIncl: Int) -> Int {
        return -1
    }
    
}

