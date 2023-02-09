import Foundation
public class Game {
    private let scanner: () -> Int
    private var board: Board
    private let rules: IRules
    private let player1: Player
    private let player2: Player
    
    public init?(withScanner scanner: @escaping () -> Int,
         withBoard board: Board,
         withRules rules: IRules,
         withPlayer1 player1: Player,
         withPlayer2 player2: Player) {
        self.scanner = scanner
        guard(rules.isValid(board)) else { return nil }
        self.board = board
        self.rules = rules
        self.player1 = player1
        self.player2 = player2
    }
    
    public var isOver: Bool {
        return rules.isGameOver(byPlayer: getCurrentPlayerId(),
                                onGrid: board.grid).isOver
    }
    
    public var boardString: String {
        return board.description
    }
    
    public var gameOverString: String {
        var string = "Game over"
        
        let gameOverResult = rules.isGameOver(byPlayer: getCurrentPlayerId(),
                                              onGrid: board.grid).result
        if case .won(let playerId, let victoryTiles) = gameOverResult {
            string.append("\nPlayer \(playerId) won!\n")
            string.append(board.displayVictory(fromTiles: victoryTiles))
        }
        return string
    }
    
    public func play() -> Bool {

        let currentPlayer = {
            if(rules.getNextPlayer(fromGrid: board.grid,
                                   withPlayer1Id: player1.id,
                                   withPlayer2Id: player2.id) == player1.id) {
                return player1
            } else {
                return player2
            }
        }()
        
        if let chosenCol = currentPlayer.chooseColumn(inBoard: board,
                                                      withRules: rules) {
            return board.insertChip(from: currentPlayer.id, atCol: chosenCol)
        }
        return false
    }
    
    private func getCurrentPlayerId() -> Int {
        if(rules.getNextPlayer(fromGrid: board.grid,
                               withPlayer1Id: player1.id,
                               withPlayer2Id: player2.id) == player1.id) {
            return player2.id
        } else {
            return player1.id
        }
    }
}
