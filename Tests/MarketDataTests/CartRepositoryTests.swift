import XCTest
import Combine
@testable import MarketData

final class CartRepositoryTests: XCTestCase {

    private var sut: CartRepository!
    private var mockDataSource: MockCartLocalDataSource!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockDataSource = MockCartLocalDataSource()
        sut = CartRepository(localDataSource: mockDataSource)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        mockDataSource = nil
        sut = nil
        super.tearDown()
    }

    func test_saveCartItem_shouldCallLocalDataSource() {
        // GIVEN
        let expected = ProductCartDTO(id: "1", name: "Apple", quantity: 1, price: "10")
        let expectation = self.expectation(description: "Should save item")

        // WHEN
        sut.saveCartItem(expected)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            }, receiveValue: {
                // THEN
                XCTAssertTrue(self.mockDataSource.saveCalled)
                XCTAssertEqual(self.mockDataSource.lastSavedItem?.name, expected.name)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchCartItems_shouldReturnMockData() {
        // GIVEN
        let mockItem = ProductCartDTO(id: "1", name: "Apple", quantity: 1, price: "10")
        mockDataSource.stubbedItems = [mockItem]
        let expectation = self.expectation(description: "Should fetch items")

        // WHEN
        sut.fetchCartItems()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            }, receiveValue: { items in
                // THEN
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.name, "Apple")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
