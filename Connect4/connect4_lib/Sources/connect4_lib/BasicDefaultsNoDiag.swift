import Foundation

public struct BasicDefaultsNoDiag : IRules {
    var minNbRows: Int
    
    var maxNbRows: Int
    
    var minNbCols: Int
    
    var maxNbCols: Int
    
    var nbChipsToAlign: Int
    
    func isGameOver(byPlayer playerId: Int, ontGrid grid: [[Int?]]) -> (isOver: Bool, hasWinner: Bool, victoryTiles: [(Int?, Int?)]) {
        
        var tiles : [(Int?, Int?)] = Array(repeating: (nil, nil), count: nbChipsToAlign)

        
        
        /*
         game over?
            winner exists?
                return (true, true, tiles)
            else
                return (true, false, tiles) (all tiles at nil)
        else
            return (false, false, tiles) (all tiles at nil)
         */
        
        return (isOver: false, hasWinner: false, victoryTiles: tiles);
    }
    
    init?(withMinNbRows minNbRows: Int = 0,
          withMaxNbRows maxNbRows: Int = 15,
          withMaxNbCols minNbCols: Int = 0,
          withMaxNbCols maxNbCols: Int = 15,
          withNbChipsToAlign nbChipsToAlign: Int = 4) {
        self.minNbRows = minNbRows
        self.maxNbRows = maxNbRows
        self.minNbCols = minNbCols
        self.maxNbCols = maxNbCols
        self.nbChipsToAlign = nbChipsToAlign
    }
    
    
}
