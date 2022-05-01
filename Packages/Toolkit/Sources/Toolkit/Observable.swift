//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI

@dynamicMemberLookup
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
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T? {
        value?[keyPath: keyPath]
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

public extension Observable {
    
    /// Provide content, placeholder, and error views for the Obeservable's state
    @ViewBuilder
    func view<Placeholder, Error, Content>(
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder error: (Swift.Error) -> Error,
        @ViewBuilder content: (Value) -> Content
    ) -> some View
    where Placeholder: View, Error: View, Content: View
    {
        switch state {
        case .noValue: placeholder()
        case .error(let e): error(e)
        case .value(let v): content(v)
        }
    }
    
    /// Provide a content view for the value state of the observable, and
    /// Empty views for when theres no value or an error
    @ViewBuilder
    func view<Content>(
        @ViewBuilder _ content: (Value) -> Content
    ) -> some View
    where Content: View
    {
        view(
            placeholder: { EmptyView() },
            error: { _ in EmptyView() },
            content: content
        )
    }
}
