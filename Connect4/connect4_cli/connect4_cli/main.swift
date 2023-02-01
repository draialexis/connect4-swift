import Foundation
import connect4_lib

var status: Bool

if var b = Board(withRows: 3, andWithCols: 3) {
    print(b)
    status = b.insertChip(from: 1, atCol: 1)
    print(b)
    status = b.insertChip(from: 2, atCol: 2)
    print(b)
    status = b.insertChip(from: 1, atCol: 1)
    print(b)
    status = b.insertChip(from: 2, atCol: 1)
    print(b)
    status = b.insertChip(from: 1, atCol: 1)
    print(b)
}

public func scan() -> Int {
    // board.dispokayBoard()
    // print("player \(rules.getNextPlayer()), choose a column between ")
    var res: Int? = nil
    while(res == nil) {
        let str = readLine()
        res = Int(str ?? "")
    }
    return res!
}
