//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI

public class Observable<Value>: ObservableObject {
    
    @Published public var state: State<Value> = .noValue
 
    public init(_ stream: AsyncThrowingStream<Value, Error>) {
        Task {
            await subscribe(to: stream)
        }
    }
    
    @MainActor private func subscribe(to stream: AsyncThrowingStream<Value, Error>) async {
        do {
            for try await value in stream {
                self.state = .value(value)
            }
        } catch {
            self.state = .error(error)
        }
    }
}

public extension Observable {
    
    enum State<Value> {
        case noValue
        case value(Value)
        case error(Error)
    }
    
    var value: Value? { state.value }
}

public extension Observable.State {
    
    var value: Value? {
        switch self {
        case .value(let o): return o
        default: return nil
        }
    }
}
