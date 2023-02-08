import Foundation
import connect4_lib

public func scan() -> Int {
    print("choose a column in [ 0 ; MAX [ \n>: ")
    var res: Int? = nil
    while(res == nil) {
        let str = readLine()
        res = Int(str ?? "")
    }
    return res!
}

var chosenCol: Int?
var wasPlayed = false
var status: (isOver: Bool, result: Result) = (false, .notOver)
var currentId: Int
var currentPlayer: Player
let p1id = 1, p2id = 2
let p1name = "Alice", p2name = "Bob the bot"

if let rules = BasicDefaultsNoDiag(withMinNbRows: 3,
                                   withMaxNbRows: 5,
                                   withMinNbCols: 3,
                                   withMaxNbCols: 5,
                                   withNbChipsToAlign: 3) {
    
    if var board = Board(withRows: 3,
                         andWithCols: 3) {
        
        if let me = Human(withId: p1id,
                          withName: p1name,
                          usingScanner: scan) {
            
            if let them = Bot(withId: p2id,
                              withName: p2name) {
                
                print(board) // 1st turn
                while(!(status.isOver)) {
                    
                    currentId = rules.getNextPlayer(fromGrid: board.grid,
                                                    withPlayer1Id: p1id,
                                                    withPlayer2Id: p2id)
                    currentPlayer = {
                        if(me.id == currentId) { return me }
                        else { return them }
                    }()
                    if let chosenCol = currentPlayer.chooseColumn(inBoard: board,
                                                                  withRules: rules) {
                        if(board.insertChip(from: currentId,
                                            atCol: chosenCol)) {
                            print(board)
                            status = rules.isGameOver(byPlayer: currentId,
                                                      onGrid: board.grid)
                        }
                    }
                }
                
                print("Game over")
                switch(status.result) {
                case .won(let playerId, let victoryTiles):
                    print("Player \(playerId) won!")
                    print(board.displayVictory(fromTiles: victoryTiles))
                default: break; // nothing
                }
            }
            
        }
    }
}

