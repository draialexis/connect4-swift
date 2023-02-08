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
print("nothing yet")
if let rules = BasicDefaultsNoDiag() {
    print("rules")

    if let board = Board() {
        print("board")

        if let human = Human(withId: 1,
                          withName: "Geraldine Humanman",
                          usingScanner: scan) {
            print("human")

            if let bot = Bot(withId: 2,
                              withName: "Botty McBotFace") {
                print("bot")

                if let game = Game(withScanner : scan,
                                   withBoard: board,
                                   withRules: rules,
                                   withPlayer1: human,
                                   withPlayer2: bot) {
                    print("game")

                    status = game.isOver
                    print(game.displayBoard()) // 1st turn
                    while(!(status.isOver)) {
                        if game.play() {
                            print(game.displayBoard())
                            status = game.isOver
                        }
                    }
                    
                    print(game.gameOverString)
                    
                }
            }
        }
    }
}

