import XCTest
import connect4_lib

final class GameTest: XCTestCase {
    
    func scan() -> Int {
        return 0
    }
    
    func testPlay() throws {
        
        let rules = BasicDefaultsNoDiag()
        
        func expect(withGrid orig: [[Int?]],
                    choice1: @escaping () -> Int,
                    choice2: @escaping () -> Int,
                    shouldWork: Bool) {
            let p1 = Human(withId: 1, withName: "bot1", usingScanner: choice1)
            let p2 = Human(withId: 2, withName: "bot2", usingScanner: choice2)
            let board = Board(withGrid: orig)
            let game = Game(withScanner: scan, withBoard: board!, withRules: rules!, withPlayer1: p1!, withPlayer2: p2!)

            XCTAssertEqual(shouldWork, game!.play())
        }
        
        expect(withGrid: [[nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil]], choice1: { return 0 }, choice2: scan, shouldWork: true)
        
        expect(withGrid: [[nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [ 1 , nil, nil, nil, nil, nil, nil]], choice1: scan, choice2: { return 3 }, shouldWork: true)

        expect(withGrid: [[nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [ 1 , nil, nil,  2 , nil, nil, nil]], choice1: { return -1 }, choice2: scan, shouldWork: false)
        
        expect(withGrid: [[nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [ 1 , nil, nil,  2 , nil, nil, nil]], choice1: { return 0 }, choice2: scan, shouldWork: true)
        
        expect(withGrid: [[nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [ 1 , nil, nil, nil, nil, nil, nil],
                          [ 1 , nil, nil,  2 , nil, nil, nil]], choice1: scan, choice2: { return 7 }, shouldWork: false)    }
}
