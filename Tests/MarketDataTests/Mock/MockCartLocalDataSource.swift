import Foundation
import Combine
@testable import MarketData

final class MockCartLocalDataSource: ICartLocalDataSource {

    var saveCalled = false
    var lastSavedItem: ProductCartDTO?
    var stubbedItems: [ProductCartDTO] = []

    func saveCartItem(_ item: ProductCartDTO) -> AnyPublisher<Void, Error> {
        saveCalled = true
        lastSavedItem = item
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error> {
        return Just(stubbedItems)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
