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
    
    func isValid(_ board: Board)
    -> Bool
    
    func getNextPlayer(fromGrid grid: [[Int?]], withPlayer1Id p1id: Int, withPlayer2Id p2id: Int)
    -> Int
}

private func == (lhs:(Int, Int), rhs:(Int, Int)) -> Bool
{
   return (lhs.0 == rhs.0) && (lhs.1 == rhs.1)
}


public enum Result : Equatable {
    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.notOver, .notOver):
            return true
        case (.deadlocked, .deadlocked) :
            return true
        case let (.won(lPlayerId, lVictoryTiles), .won(rPlayerId, rVictoryTiles)) :
            if lPlayerId != rPlayerId {
                return false
            }
            for n in 0..<lVictoryTiles.count{
                if(lVictoryTiles[n].0 != rVictoryTiles[n].0
                   || lVictoryTiles[n].1 != rVictoryTiles[n].1) {
                    return false
                }
            }
            return true
        default:
            return false
        }
    }
    
    case notOver
    case deadlocked
    
    // playerId, victoryTiles
    case won(Int, [(Int, Int)])
    
}


