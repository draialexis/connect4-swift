import Foundation

public struct Board : CustomStringConvertible {
    
    public let nbRows: Int
    public let nbCols: Int
    private var nbFree: Int
    private var grid: [[Int?]]
    
    public init?(withRows nbRows: Int = 6, andWithCols nbCols: Int = 7) {
        guard(nbRows > 0 && nbCols > 0) else { return nil }
        self.nbRows = nbRows
        self.nbCols = nbCols
        self.nbFree = nbRows * nbCols
        self.grid = Array(repeating: Array(repeating: nil, count: nbCols), count: nbRows)
    }
    
    public init?(withGrid grid: [[Int?]]) {
        guard(grid.allSatisfy{ $0.count == grid[0].count }) else { return nil }
        self.nbRows = grid.count
        self.nbCols = grid[0].count
        self.nbFree = nbRows * nbCols
        self.grid = grid
    }

    private func isWithinBounds(_ row: Int, and col: Int) -> Bool {
        return 0 <= row && row < nbRows
            && 0 <= col && col < nbCols
    }
    
    public var description: String {
        var string = String()
        for row in grid {
            for tile in row {
                string.append(" ")
                switch(tile) {
                case 1: string.append("O")
                case 2: string.append("X")
                default: string.append("_")
                }
            }
            string.append("\n")
        }
        string.append("\n")
        return string
    }

    private mutating func insertChip(from playerId: Int, atRow row: Int, atCol col: Int) -> Bool {
        guard(isWithinBounds(row, and: col)) else { return false }
        guard((playerId == 1 || playerId == 2)) else { return false }
        guard(!isFull()) else { return false }
        guard((grid[row][col] == nil)) else { return false }
        
        grid[row][col] = playerId
        nbFree -= 1
        return true
    }

    public mutating func insertChip(from playerId: Int, atCol col: Int) -> Bool {
        guard(0 < col && col <= nbCols) else { return false }

        if grid[0][col] != nil { return false }
                
        for i in stride(from: nbRows - 1, through: 0, by: -1) {
            if grid[i][col] == nil {
                return insertChip(from: playerId, atRow: i, atCol: col)
            }
        }

        return false
    }

    private mutating func removeChip(fromRow row: Int, fromCol col: Int) {
        assert(isWithinBounds(row, and: col))
        grid[row][col] = nil
        nbFree += 1
    }

    public func isFull() -> Bool {
        return nbFree <= 0
    }
}

