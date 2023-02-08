import Foundation

public class Player {
    
    public private(set) var id: Int
    public private(set) var name: String
    
    init?(withId id: Int,
          withName name: String){
        self.id = id
        self.name = name
    }
    
    /// should be considered abstract and overridden by descendants
    public func chooseColumn(inBoard board: Board,
                             withRules rules: IRules)
    -> Int? {
        return nil
    }
    
}
