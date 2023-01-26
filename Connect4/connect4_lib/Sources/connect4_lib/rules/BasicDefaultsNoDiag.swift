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
        
        guard (
            minNbRows >= 3
            && minNbCols >= 3
            && maxNbRows >= minNbRows
            && maxNbCols >= minNbCols
            && nbChipsToAlign >= 2
            && nbChipsToAlign < minNbCols
            && nbChipsToAlign < minNbRows
        ) else { return nil }
        
        self.minNbRows = minNbRows
        self.maxNbRows = maxNbRows
        self.minNbCols = minNbCols
        self.maxNbCols = maxNbCols
        self.nbChipsToAlign = nbChipsToAlign
    }
    
    public func isGameOver(byPlayer playerId: Int, onGrid grid: [[Int?]])
    -> (isOver: Bool, hasWinner: Bool, victoryTiles: [(Int, Int)]?) {
        
        // first check if board is full
        var isFull = true
        for row in grid {
            for tile in row {
                if tile == nil {
                    isFull = false
                    break
                }
            }
        }
        
        var victoryTiles : [(Int, Int)] = Array(repeating: (0, 0), count: nbChipsToAlign)
        
        // assuming that the board is square, we could add a check for that in IRules if we want to leave it open for extension
        let nbCols = grid[0].count
        let nbRows = grid.count
        
        for i in 0..<nbRows {
            for j in 0..<nbCols {
                // check if there is room to the right
                if nbCols - j >= nbChipsToAlign && grid[i][j] != nil && grid[i][j] == playerId {
                    // check for victory
                    if checkAligned(byPlayer: playerId, onGrid: grid, fromRow: i, andCol: j, going: directions.right) == nbChipsToAlign {
                        for x in 0..<nbChipsToAlign {
                            // row i, origin is (i, j), goes to the right
                            victoryTiles[x] = (i, j + x)
                        }
                        return (isOver: true, hasWinner: true, victoryTiles)
                    }
                }
                // check if there is room lower down
                if nbRows - i >= nbChipsToAlign && grid[i][j] != nil && grid[i][j] == playerId {
                    // check for victory
                    if checkAligned(byPlayer: playerId, onGrid: grid, fromRow: i, andCol: j, going: directions.down) == nbChipsToAlign {
                        for x in 0..<nbChipsToAlign {
                            // column j, origin is (i, j), goes down
                            victoryTiles[x] = (i + x, j)
                        }
                        return (isOver: true, hasWinner: true, victoryTiles)
                    }
                }
            }
        }
        
        /*
        winner exists?
            return (true, true, tiles)
        else is full ?
            return (true, false, nil)
         else
            return (false, false, nil)
         */
        return (isFull, hasWinner: false, nil);
    }
        
    private func checkAligned(byPlayer playerId: Int,
                                   onGrid grid: [[Int?]],
                                   fromRow i: Int,
                                   andCol j: Int,
                                   going direction: directions) -> Int {
        if let tile = grid[i][j] {
            if tile == playerId {
                if direction == directions.right {
                    return 1 + checkAligned(byPlayer: playerId, onGrid: grid, fromRow: i, andCol: j + 1, going: direction)
                } else if direction == directions.down {
                    return 1 + checkAligned(byPlayer: playerId, onGrid: grid, fromRow: i + 1, andCol: j, going: direction)
                }
            }
        }
        return 0
    }
    
    private enum directions {
        case right
        case down
    }
}
