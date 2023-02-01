import Foundation

class Bot: Player {
    override func playBetween(min: Int, andMaxIncl maxIncl: Int) -> Int {
        return Int.random(in: min..<maxIncl + 1)
    }
}
