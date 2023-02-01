import Foundation
class Game {
    private let scanner: () -> Int
    private let displayBoard: () -> String
    private let board: Board
    private let rules: IRules
    private let player1: Player
    private let player2: Player
    
    init(withScanner scanner: @escaping () -> Int,
         withBoard board: Board,
         withRules rules: IRules,
         withPlayer1 player1: Player,
         withPlayer2 player2: Player) {
        self.scanner = scanner
        self.displayBoard = { () -> String in
            return board.description
        }
        // TODO check that board is valid using the rules
        self.board = board
        self.rules = rules
        self.player1 = player1
        self.player2 = player2
    }
    
    
}
