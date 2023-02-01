import Foundation

public protocol IRules {
    var minNbRows: Int { get }
    var maxNbRows: Int { get }
    var minNbCols: Int { get }
    var maxNbCols: Int { get }
    var nbChipsToAlign: Int { get }
    func isGameOver(byPlayer playerId: Int, onGrid grid: [[Int?]]) -> (isOver: Bool, result: Result)
    // TODO plug in the EnumResult
    // and
    // isGameOver(c) -> (Bool, EnumResult)
    // getNextPlayer(c) -> Int
    // isValid(c) -> Bool
    
}

public enum Result {
    case notOver
    case deadlocked
    
    // playerId, victoryTiles
    case won(Int, [(Int, Int)]?)
    
}
