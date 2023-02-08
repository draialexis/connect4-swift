import XCTest
import connect4_lib

final class BotTest: XCTestCase {
    
    func testInit() throws {
        func expect(initBotWithId id: Int,
                    andName name: String,
                    shouldNotBeNil: Bool) {
            let bot = Bot(withId: id, withName: name)
            if !shouldNotBeNil {
                XCTAssertNil(bot)
                return
            }
            XCTAssertNotNil(bot)
            XCTAssertEqual(id, bot?.id)
            XCTAssertEqual(name, bot?.name)
        }
        
        expect(initBotWithId: 0, andName: "Bob", shouldNotBeNil: true)
        expect(initBotWithId: -1, andName: "Bob", shouldNotBeNil: false)
        expect(initBotWithId: 0, andName: "", shouldNotBeNil: false)
        expect(initBotWithId: 0, andName: "   ", shouldNotBeNil: false)
    }
    
    func testChooseColumn() throws {
        guard let board = Board(withGrid: [[1, nil, nil],
                                           [2, 2, nil],
                                           [1, 1, 2]]) else { XCTAssertFalse(true); return  }
        
        guard let rules = BasicDefaultsNoDiag(withMinNbRows: 3,
                                              withMaxNbRows: 5,
                                              withMinNbCols: 3,
                                              withMaxNbCols: 5,
                                              withNbChipsToAlign: 3) else { XCTAssertFalse(true); return  }
        
        for _ in 0..<100 {
            let choice = Bot(withId: 1, withName: "Clyde")?.chooseColumn(inBoard: board, withRules: rules)
            XCTAssertNotNil(choice)
            XCTAssertTrue(0 <= choice! && choice! < board.nbCols)
        }
    }
}
