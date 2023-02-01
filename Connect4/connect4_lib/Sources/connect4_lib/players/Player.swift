import Foundation

class Player {
    
    private let id: Int
    private let name: String
    
    init(withId id: Int, withName name: String){
        self.id = id
        self.name = name
    }
    
    /// should be considered abstract and overridden by descendants
    func chooseColumn(inBoard board: Board, withRules rules: IRules) -> Int? {
        return nil
    }
    
}
