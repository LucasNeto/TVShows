//
//  TVShowListPresenterTests.swift
//  TVShowsTests
//
//  Created by Lucas  N Santana on 03/07/23.
//

import XCTest
@testable import TVShows

final class TVShowListPresenterTests: XCTestCase {

    var sut: TVShowListPresenter!
    var spy: TVShowListViewControllerSpy!
    
    override func setUpWithError() throws {
        spy = TVShowListViewControllerSpy()
        sut = TVShowListPresenter(viewController: spy)
    }

    override func tearDownWithError() throws {
        spy = nil
        sut = nil
    }
    
    func testPresentList() {
        //given
        let shows = TVShowListPresenterMock.shows
        let expectation = self.expectation(description: "execute in the main thread")

        //when
        sut.present(shows: shows)
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        //then
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(spy.displayedShows, "Display show method should be called")
    }
    
}

class TVShowListViewControllerSpy: TVShowListViewController {
    var displayedShows = false
    
    override func displayShows(shows: [Show]) {
        displayedShows = true
    }
}


struct TVShowListPresenterMock {
    static let shows = [Show(id: 1, url: nil, name: "name", schedule: Schedule(time: "10:00", days: ["Monday"]), image: Images(medium: nil, original: nil), summary: "summary", genres: nil)]
}
