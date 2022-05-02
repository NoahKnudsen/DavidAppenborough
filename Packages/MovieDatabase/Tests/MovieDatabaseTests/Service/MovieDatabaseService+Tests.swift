import XCTest
import Foundational
@testable import MovieDatabase

final class MovieDatabaseService_Tests: XCTestCase {
    
    var session: URLSessionMock!
    var service: MovieDatabaseService!
    
    override func setUp() async throws {
        session = URLSessionMock()
        service = MovieDatabaseService(
            session: session,
            defaults: UserDefaults(suiteName: UUID().uuidString)!
        )
    }
    
    func test_calls_person_endpoint_and_returns_Person_model() async throws {
        
        let expectedResult = Person.TestData.sirDavid
        let expectation = expectation(description: "request made")
        
        session.handler = { request in
            XCTAssertEqual(request.url, try! Endpoint.person(id: 1).url())
            expectation.fulfill()
            return (try! expectedResult.json(), URLResponse(), nil)
        }
        
        for try await result in service.people.fetch(1) {
            XCTAssertEqual(result, expectedResult.person)
        }
        
        await waitForExpectations(timeout: 0.1)
    }
    
    func test_calls_credits_endpoint_and_returns_Credits_model() async throws {
        
        let expectedResult = Credits.TestData.sirDavid
        let expectation = expectation(description: "request made")
        
        session.handler = { request in
            XCTAssertEqual(request.url, try! Endpoint.credits(of: 2).url())
            expectation.fulfill()
            return (try! expectedResult.json(), URLResponse(), nil)
        }
        
        for try await result in service.credits.fetch(2) {
            XCTAssertEqual(result, expectedResult.credits)
        }
        
        await waitForExpectations(timeout: 0.1)
    }
    
    func test_calls_show_endpoints_and_returns_TVShow_model() async throws {
        
        let expectedResult = TVShow.TestData.trialsOfLife
        let creditLinkEndpointCalled = expectation(description: "credit link requested")
        let showsEndpointCalled = expectation(description: "show requested")
        
        let creditLinkId = "abc"
        let showId = 123
        
        session.handler = { request in
            switch request.url {
            case try! Endpoint.creditMediaLink(id: creditLinkId).url():
                
                creditLinkEndpointCalled.fulfill()
                let link = Credit.MediaLink(
                    id: creditLinkId,
                    media:.init(id: showId),
                    type: .tv
                )
                let data = try! JSONEncoder().encode(link)
                return (data, URLResponse(), nil)
                
            case try! Endpoint.tvShow(id: showId).url():
                
                showsEndpointCalled.fulfill()
                return (try! expectedResult.json(), URLResponse(), nil)
                
            default:
                return (
                    nil,
                    URLResponse(),
                    String.Error("Unexpected endpoint called \(request.url?.absoluteString ?? "nil")")
                )
            }
        }
        
        for try await result in service.shows.fetch(creditLinkId) {
            XCTAssertEqual(result, expectedResult.show)
        }
        
        await waitForExpectations(timeout: 0.1)
    }
}

fileprivate class URLSessionMock: URLSession {
    
    var handler: (URLRequest) -> (Data?, URLResponse?, Error?) = { _ in
        (nil, nil, String.Error("URLSessionMock handler not implemented"))
    }
    
    // Note: MovieDatabaseService uses the async method `data(for: URLRequest)`
    // which seems to be an async wrapper around the following `dataTask` version.
    // We cannot override the async version directly.
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSessionDataTaskMock {
            let (data, response, error) = self.handler(request)
            completionHandler(data, response, error)
        }
        
    }
}

fileprivate class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

