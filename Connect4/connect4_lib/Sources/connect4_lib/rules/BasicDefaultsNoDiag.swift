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
            && nbChipsToAlign <= minNbCols
            && nbChipsToAlign <= minNbRows
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
        
        // assuming that the board is square -- we could add a check for that in IRules if we wanted to leave that open for extension
        let nbRows = grid.count
        let nbCols = grid[0].count
        
        for i in 0..<nbRows {
            for j in 0..<nbCols {
                // check if there is room to the right
                if (nbCols - j) >= nbChipsToAlign && grid[i][j] != nil && grid[i][j] == playerId {
                    
                    // check for victory
                    let amountAligned = checkAligned(byPlayer: playerId,
                                                     onGrid: grid,
                                                     fromRow: i,
                                                     upToRow: (nbRows - 1),
                                                     andCol: j,
                                                     upToCol: (nbCols - 1),
                                                     going: directions.right)
                    
                    //print("player \(String(describing: Board.descriptionMapper[playerId])) aligned \(amountAligned) horizontally:")
                    if amountAligned >= nbChipsToAlign {
                        
                        for x in 0..<nbChipsToAlign {
                            
                            // row i, origin is (i, j), goes to the right
                            victoryTiles[x] = (i, j + x)
                        }
                        return (isOver: true, hasWinner: true, victoryTiles)
                    }
                }
                
                // check if there is room lower down
                if (nbRows - i) >= nbChipsToAlign && grid[i][j] != nil && grid[i][j] == playerId {
                    
                    // check for victory
                    let amountAligned = checkAligned(byPlayer: playerId,
                                                     onGrid: grid,
                                                     fromRow: i,
                                                     upToRow: (nbRows - 1),
                                                     andCol: j,
                                                     upToCol: (nbCols - 1),
                                                     going: directions.down)
                    
                    //print("player \(String(describing: Board.descriptionMapper[playerId])) aligned \(amountAligned) vertically:")
                    if amountAligned >= nbChipsToAlign {
                        
                        for x in 0..<nbChipsToAlign {
                            
                            // column j, origin is (i, j), goes down
                            victoryTiles[x] = (i + x, j)
                        }
                        return (isOver: true, hasWinner: true, victoryTiles)
                    }
                }
            }
        }

        return (isFull, hasWinner: false, nil);
    }
        
    private func checkAligned(byPlayer playerId: Int,
                                   onGrid grid: [[Int?]],
                                   fromRow i: Int,
                                   upToRow iMax: Int,
                                   andCol j: Int,
                                   upToCol jMax: Int,
                                   going direction: directions) -> Int {
        if let tile = grid[i][j] {
            if tile == playerId {
                if direction == directions.right {
                    if j == jMax { return 1 }
                    return 1 + checkAligned(byPlayer: playerId,
                                            onGrid: grid,
                                            fromRow: i,
                                            upToRow: iMax,
                                            andCol: j + 1,
                                            upToCol: jMax,
                                            going: direction)
                    
                } else if direction == directions.down {
                    if i == iMax { return 1 }
                    return 1 + checkAligned(byPlayer: playerId,
                                            onGrid: grid,
                                            fromRow: i + 1,
                                            upToRow: iMax,
                                            andCol: j,
                                            upToCol: jMax,
                                            going: direction)
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
