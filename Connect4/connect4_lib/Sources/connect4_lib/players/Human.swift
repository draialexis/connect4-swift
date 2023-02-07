import Foundation
class Human: Player {
    
    private let scanner: () -> Int?
    
    init(withId id: Int,
         withName name: String,
         usingScanner scanner: @escaping () -> Int?) {
        self.scanner = scanner
        super.init(withId: id, withName: name)
    }

    override func chooseColumn(inBoard board: Board,
                               withRules rules: IRules)
    -> Int? {
        return scanner()
    }
}
