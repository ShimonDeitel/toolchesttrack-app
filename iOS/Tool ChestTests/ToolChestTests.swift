import XCTest
@testable import ToolChest

@MainActor
final class ToolChestTests: XCTestCase {
    func testSeedDataLoadsBelowFreeLimit() {
        let store = Store()
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.items.count
        store.add(Tool(name: "Test Item", maker: "x", condition: "x", notes: "x"))
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testDeleteRemovesItem() {
        let store = Store()
        let item = Tool(name: "Deletable", maker: "x", condition: "x", notes: "x")
        store.add(item)
        store.delete(item)
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }

    func testCanAddMoreWhenBelowLimitAndNotPro() {
        let store = Store()
        store.isPro = false
        XCTAssertTrue(store.items.count < Store.freeLimit)
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreAtLimitWhenNotPro() {
        let store = Store()
        store.isPro = false
        while store.items.count < Store.freeLimit {
            store.add(Tool(name: "Filler", maker: "x", condition: "x", notes: "x"))
        }
        XCTAssertFalse(store.canAddMore)
    }

    func testCanAddMoreWhenProEvenAtLimit() {
        let store = Store()
        store.isPro = true
        while store.items.count < Store.freeLimit {
            store.add(Tool(name: "Filler", maker: "x", condition: "x", notes: "x"))
        }
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdateModifiesExistingItem() {
        let store = Store()
        var item = Tool(name: "Original", maker: "x", condition: "x", notes: "x")
        store.add(item)
        item.name = "Renamed"
        store.update(item)
        XCTAssertEqual(store.items.first(where: { $0.id == item.id })?.name, "Renamed")
    }
}
