import XCTest
import connect4_lib

final class HumanTest: XCTestCase {
    
    func scan() -> Int {
        return 0
    }
    
    func testInit() throws {
        func expect(initHumanWithId id: Int,
                    andName name: String,
                    andScanner scanner: @escaping () -> Int,
                    shouldNotBeNil: Bool) {
            let human = Human(withId: id, withName: name, usingScanner: scanner)
            if !shouldNotBeNil {
                XCTAssertNil(human)
                return
            }
            XCTAssertNotNil(human)
            XCTAssertEqual(id, human?.id)
            XCTAssertEqual(name, human?.name)
        }
        
        expect(initHumanWithId: 0, andName: "Bob", andScanner: scan, shouldNotBeNil: true)
        expect(initHumanWithId: -1, andName: "Bob", andScanner: scan, shouldNotBeNil: false)
        expect(initHumanWithId: 0, andName: "", andScanner: scan, shouldNotBeNil: false)
        expect(initHumanWithId: 0, andName: "   ", andScanner: scan, shouldNotBeNil: false)
    }
    
    //not testing for pebcak
}
