import Foundation

protocol IRules {
    var minNbRows: Int { get }
    var maxNbRows: Int { get }
    var minNbCols: Int { get }
    var maxNbCols: Int { get }
    var nbChipsToAlign: Int { get }
    func isGameOver(byPlayer playerId: Int, onGrid grid: [[Int?]]) -> (isOver: Bool, hasWinner: Bool, victoryTiles: [(Int, Int)]?)
}
