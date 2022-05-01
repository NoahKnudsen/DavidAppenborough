//
//  Created by Noah Knudsen on 01/05/2022.
//

public extension Sequence {
    
    func unique<T: Hashable>(by: (Element) -> T) -> [Iterator.Element] {
        var seen: Set<T> = []
        let o = filter { seen.insert(by($0)).inserted }
        return o
    }
}
