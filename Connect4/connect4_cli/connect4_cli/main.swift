import Foundation
import connect4_lib

//var status: Bool
//
//if var b = Board(withRows: 3, andWithCols: 3) {
//    print(b)
//    status = b.insertChip(from: 1, atCol: 1)
//    print(b)
//    status = b.insertChip(from: 2, atCol: 2)
//    print(b)
//    status = b.insertChip(from: 1, atCol: 1)
//    print(b)
//    status = b.insertChip(from: 2, atCol: 1)
//    print(b)
//    status = b.insertChip(from: 1, atCol: 1)
//    print(b)
//}

public func scan() -> Int {
    // print(game.board)
    // print("player \(game.getNextPlayer()), choose a column between ")
    var res: Int? = nil
    while(res == nil) {
        let str = readLine()
        res = Int(str ?? "")
    }
    return res!
}

let chosenCol: Int?
var turn = 0
var wasPlayed = true
if let rules = BasicDefaultsNoDiag(withMinNbRows: 3, withMaxNbRows: 5, withMinNbCols: 3, withMaxNbCols: 5, withNbChipsToAlign: 3) {
    if var board = Board(withRows: 3, andWithCols: 3) {
        if let me = Human(withId: 1, withName: "Alexis", usingScanner: scan) {
            if let them = Bot(withId: 2, withName: "Botty McBotFace") {
                if wasPlayed {
                    turn += 1
                }
                
                //while(!(game.isOver())
                while(true) {
                    switch (turn % 2) {
                    case 1:
                        print("turn \(turn)\n>")
                        if let chosenCol = me.chooseColumn(inBoard: board, withRules: rules) {
                            wasPlayed = board.insertChip(from: me.id, atCol: chosenCol)
                        }
                        print(board)

                        break
                    case 0:
                        print("turn \(turn)")
                        if let chosenCol = them.chooseColumn(inBoard: board, withRules: rules) {
                            wasPlayed = board.insertChip(from: them.id, atCol: chosenCol)
                        }
                        print(board)
                        
                        break
                    default:
                        wasPlayed = false
                    }
                }
            }
        }
    }
}

