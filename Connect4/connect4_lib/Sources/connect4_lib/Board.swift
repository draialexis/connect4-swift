import Foundation

//TODO implement Equatable?
public struct Board : CustomStringConvertible {
    
    public let nbRows: Int
    public let nbCols: Int
    
    
    /// Watch your indices --  in a empty 3x3 grid, if you insert a chip at column 0, it will fall down to grid[2][0]
    ///    0 1 2
    /// 0     -  -  -
    /// 1     -  -  -
    /// 2     x  -  -
    ///
    public var grid : [[Int?]] { _grid }
    var _nbFree: Int
    var _grid: [[Int?]]
    
    public init?(withRows nbRows: Int = 6, andWithCols nbCols: Int = 7) {
        guard(nbRows >= 3 && nbCols >= 3) else { return nil }
        self.nbRows = nbRows
        self.nbCols = nbCols
        self._nbFree = nbRows * nbCols
        self._grid = Array(repeating: Array(repeating: nil, count: nbCols), count: nbRows)
    }
    
    public init?(withGrid grid: [[Int?]]) {
        guard(grid.count >= 3
              && grid[0].count >= 3
              && grid.allSatisfy{ $0.count == grid[0].count }) else { return nil }
        self.nbRows = grid.count
        self.nbCols = grid[0].count
        self._grid = grid
        var nbFree = self.nbRows * self.nbCols
        for row in grid {
            for tile in row {
                if tile != nil {
                    nbFree -= 1
                    if (tile != 1 && tile != 2) {
                        return nil
                    }
                }
            }
        }
        self._nbFree = nbFree
    }
    
    func isWithinBounds(_ row: Int, and col: Int) -> Bool {
        return 0 <= row && row < nbRows
            && 0 <= col && col < nbCols
    }
    
    static let descriptionMapper : [Int? : String] = [nil : "-", 1 : "X", 2: "O"]
    
    public var description: String {
        var string = String()
        for row in _grid {
            for tile in row {
                string.append("\(String(describing: Board.descriptionMapper[tile] ?? "@"))")
            }
            string.append("\n")
        }
        string.append("\n")
        return string
    }

    mutating func insertChip(from playerId: Int, atRow row: Int, atCol col: Int) -> Bool {
        guard(isWithinBounds(row, and: col)) else { return false }
        guard((_grid[row][col] == nil)) else { return false }
        
        _grid[row][col] = playerId
        _nbFree -= 1
        return true
    }

    public mutating func insertChip(from playerId: Int, atCol col: Int) -> Bool {
        guard(0 <= col && col < nbCols) else { return false }
        guard(!isFull()) else { return false }

        if _grid[0][col] != nil { return false }
                
        for i in stride(from: nbRows - 1, through: 0, by: -1) {
            if _grid[i][col] == nil {
                return insertChip(from: playerId, atRow: i, atCol: col)
            }
        }

        return false
    }

    mutating func removeChip(fromRow row: Int, fromCol col: Int) {
        assert(isWithinBounds(row, and: col))
        _grid[row][col] = nil
        _nbFree += 1
    }

    public func isFull() -> Bool {
        return _nbFree <= 0
    }

}

