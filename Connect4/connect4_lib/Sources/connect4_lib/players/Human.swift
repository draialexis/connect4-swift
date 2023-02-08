import Foundation
public class Human: Player {
    
    private let scanner: () -> Int?
    
    public init?(withId id: Int,
         withName name: String,
         usingScanner scanner: @escaping () -> Int?) {
        self.scanner = scanner
        super.init(withId: id, withName: name)
    }

    public override func chooseColumn(inBoard board: Board, withRules rules: IRules) -> Int? { return scanner() }
}
