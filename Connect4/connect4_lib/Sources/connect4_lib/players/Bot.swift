import Foundation

public class Bot: Player {
    
    // TODO implement
    // board est passé par copie, donc constant et immuable (?)
    // var b = board nous donne une copie modifiable, avec laquele le bot peut faire des essais

    public override init?(withId id: Int,
         withName name: String) {
        super.init(withId: id, withName: name)
    }
    
    public override func chooseColumn(inBoard board: Board, withRules rules: IRules) -> Int? {
        return Int.random(in: 0..<board.nbCols)
    }
}
