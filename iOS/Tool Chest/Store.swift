import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Tool] = []
    @Published var isPro: Bool = false

    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("toolchesttrack_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Tool) {
        items.append(item)
        save()
    }

    func update(_ item: Tool) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Tool) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Tool].self, from: data) {
            items = decoded
        } else {
            items = [
        Tool(name: "No. 4 Smoothing Plane", maker: "Stanley", condition: "Excellent", notes: "Sole lapped flat"),
        Tool(name: "Dovetail Saw", maker: "Disston", condition: "Good", notes: "Sharpened 2023"),
        Tool(name: "Claw Hammer", maker: "Estwing", condition: "Mint", notes: "Leather grip"),
        Tool(name: "Chisel Set", maker: "Marples", condition: "Good", notes: "Boxwood handles"),
        Tool(name: "Brace Drill", maker: "Millers Falls", condition: "Fair", notes: "Needs chuck cleaning")
            ]
            save()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
