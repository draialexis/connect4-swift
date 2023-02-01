import Foundation

class Bot: Player {
    
    // TODO implement
    // board est passé par copie, donc constant et immuable (?)
    // var b = board nous donne une copie modifiable, avec laquele le bot peut faire des essais
    
    override func chooseColumn(inBoard board: Board, withRules rules: IRules) -> Int? {
        return Int.random(in: 0..<board.nbCols)
    }
}
