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

var status: (isOver: Bool, result: Result)
if let rules = BasicDefaultsNoDiag() {

    if let board = Board() {

        if let p1 = Human(withId: 1,
                          withName: "Geraldine Humanman",
                          usingScanner: scan) {

            if let p2 = Bot(withId: 2,
                              withName: "Botty McBotFace") {

                if let game = Game(withScanner : scan,
                                   withBoard: board,
                                   withRules: rules,
                                   withPlayer1: p1,
                                   withPlayer2: p2) {

                    print(game.boardString) // 1st turn
                    while(!(game.isOver)) {
                        if game.play() {
                            print(game.boardString)
                        }
                    }
                    print(game.gameOverString)
                }
            }
        }
    }
}

