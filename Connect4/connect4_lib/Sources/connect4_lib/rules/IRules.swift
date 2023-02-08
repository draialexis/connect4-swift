import Foundation

public protocol IRules {
    var minNbRows: Int { get }
    var maxNbRows: Int { get }
    var minNbCols: Int { get }
    var maxNbCols: Int { get }
    var nbChipsToAlign: Int { get }
    
    func isGameOver(byPlayer playerId: Int,
                    onGrid grid: [[Int?]])
    -> (isOver: Bool, result: Result)
    
    func isValid(withMinNbRows: Int,
                 withMaxNbRows: Int,
                 withMinNbCols: Int,
                 withMaxNbCols: Int,
                 withNbChipsToAlign: Int)
    -> Bool
    
    func getNextPlayer(fromGrid grid: [[Int?]], withPlayer1Id p1id: Int, withPlayer2Id p2id: Int)
    -> Int
}

public enum Result : Equatable {
    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch lhs {
        case .notOver :
            
            switch rhs {
            case .notOver : return true
            default : return false
            }
            
        case .deadlocked :
            
            switch rhs {
            case .deadlocked : return true
            default : return false
            }
            
        case .won(let lPlayerId, let lVictoryTiles) :
            
            switch rhs {
            case .won(let rPlayerId, let rVictoryTiles) :
                if (lPlayerId != rPlayerId) {
                    return false
                }
                
                for n in 0..<lVictoryTiles.count {
                    if (lVictoryTiles[n].0 != rVictoryTiles[n].0
                        || lVictoryTiles[n].1 != rVictoryTiles[n].1) {
                        return false
                    }
                }
                
                return true
                
            default : return false
                
            }
        }
    }
    
    case notOver
    case deadlocked
    
    // playerId, victoryTiles
    case won(Int, [(Int, Int)])
    
}
