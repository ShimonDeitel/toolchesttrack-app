import Foundation

struct Tool: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var maker: String
    var condition: String
    var notes: String
    var dateAdded: Date = Date()
}
