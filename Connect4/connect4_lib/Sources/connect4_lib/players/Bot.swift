import Foundation

public class Bot: Player {
    
    // NICE TO HAVE (on a future, smarter bot for example)
    // "board est passé par copie, donc constant et immuable
    // var b = board nous donne une copie modifiable, avec laquelle le bot peut faire des essais"

    public override init?(withId id: Int,
                          withName name: String) {
        super.init(withId: id, withName: name)
    }
    
    public override func chooseColumn(inBoard board: Board,
                                      withRules rules: IRules)
    -> Int? {
        print("(\(id)°w°)")
        return Int.random(in: 0..<board.nbCols)
    }
}
