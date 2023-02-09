import Foundation

public struct BasicDefaultsNoDiag : IRules {
    public let minNbRows: Int
    public let maxNbRows: Int
    public let minNbCols: Int
    public let maxNbCols: Int
    public let nbChipsToAlign: Int
    
    public init?(withMinNbRows minNbRows: Int = 5,
          withMaxNbRows maxNbRows: Int = 15,
          withMinNbCols minNbCols: Int = 5,
          withMaxNbCols maxNbCols: Int = 15,
          withNbChipsToAlign nbChipsToAlign: Int = 4) {

        self.minNbRows = minNbRows
        self.maxNbRows = maxNbRows
        self.minNbCols = minNbCols
        self.maxNbCols = maxNbCols
        self.nbChipsToAlign = nbChipsToAlign
        
        guard (minNbRows >= 3
               && minNbCols >= 3
               && maxNbRows >= minNbRows
               && maxNbCols >= minNbCols
               && nbChipsToAlign >= 2
               && nbChipsToAlign <= minNbCols
               && nbChipsToAlign <= minNbRows) else { return nil }
        }
    
    public func isValid(_ board: Board)
    -> Bool {
        return board.nbRows >= minNbRows
        && board.nbRows <= maxNbRows
        && board.nbCols >= minNbCols
        && board.nbCols <= maxNbCols
    }
    
    public func getNextPlayer(fromGrid grid: [[Int?]], withPlayer1Id p1id: Int, withPlayer2Id p2id: Int)
    -> Int {
        // player 1 will always start
        let playerCounters = grid
            .flatMap { $0 }
            .compactMap { $0 }
            .reduce([p1id: 0, p2id: 0]) { (inCounters, tile) in
                var counters = inCounters
                counters[tile, default: 0] += 1
                return counters
            }
        
        
        return playerCounters[p1id] ?? 0 <= playerCounters[p2id] ?? 0
                ? p1id
                : p2id
    }
    
    private func isFull(_ grid: [[Int?]]) -> Bool {
        for row in grid {
            for tile in row {
                if tile == nil {
                    return false
                }
            }
        }
        return true
    }
    
    private func checkVictory(byPlayer playerId: Int,
                              onGrid grid: [[Int?]],
                              fromRow: Int,
                              fromCol: Int,
                              going direction: Direction,
                              victoryTiles: inout [(Int, Int)]) -> Bool {
        let amountAligned = checkAligned(byPlayer: playerId,
                                         onGrid: grid,
                                         fromRow: fromRow,
                                         fromCol: fromCol,
                                         going: direction)
        if amountAligned >= nbChipsToAlign {
            for x in 0..<nbChipsToAlign {
                if direction == .right {
                    victoryTiles[x] = (fromRow, fromCol + x)
                } else if direction == .down {
                    victoryTiles[x] = (fromRow + x, fromCol)
                }
            }
            return true
        }
        return false
    }
                              
    public func isGameOver(byPlayer playerId: Int, onGrid grid: [[Int?]])
    -> (isOver: Bool, result: Result) {
        
        // first check if board is full
        let isFull = isFull(grid)
        
        var victoryTiles : [(Int, Int)] = Array(repeating: (0, 0), count: nbChipsToAlign)
        
        // assuming that the board is square -- we could add a check for that in IRules if we wanted to leave that open for extension
        let nbRows = grid.count
        let nbCols = grid[0].count
        
        for i in 0..<nbRows {
            for j in 0..<nbCols {
                if let tile = grid[i][j], (nbCols - j) >= nbChipsToAlign && tile == playerId && checkVictory(byPlayer: playerId,
                                                                                                             onGrid: grid,
                                                                                                             fromRow: i,
                                                                                                             fromCol: j,
                                                                                                             going: .right,
                                                                                                             victoryTiles: &victoryTiles) {
                    return (isOver: true, Result.won(playerId, victoryTiles))
                }
                if let tile = grid[i][j], (nbRows - i) >= nbChipsToAlign && tile == playerId && checkVictory(byPlayer: playerId,
                                                                                                             onGrid: grid,
                                                                                                             fromRow: i,
                                                                                                             fromCol: j,
                                                                                                             going: .down,
                                                                                                             victoryTiles: &victoryTiles) {
                    return (isOver: true, Result.won(playerId, victoryTiles))
                }
            }
        }
        return (isOver: isFull,
                isFull ? Result.deadlocked : Result.notOver);
    }
        
    private func checkAligned(byPlayer playerId: Int,
                              onGrid grid: [[Int?]],
                              fromRow i: Int,
                              fromCol j: Int,
                              going direction: Direction) -> Int {
        let iMax = grid.count - 1
        let jMax = grid[0].count - 1
        
        if let tile = grid[i][j], tile == playerId {
            if direction == .right {
                if j == jMax {
                    return 1
                }
                return 1 + checkAligned(byPlayer: playerId,
                                        onGrid: grid,
                                        fromRow: i,
                                        fromCol: j + 1,
                                        going: direction)
                    
            } else if direction == .down {
                if i == iMax {
                    return 1
                }
                return 1 + checkAligned(byPlayer: playerId,
                                        onGrid: grid,
                                        fromRow: i + 1,
                                        fromCol: j,
                                        going: direction)
            }
        }
        return 0
    }
    
    private enum Direction {
        case right
        case down
    }
}
