import SwiftUI

enum Theme {
    static let accent = Color(red: 0.4235, green: 0.5569, blue: 0.6784)
    static let background = Color(red: 0.0627, green: 0.0784, blue: 0.0941)
    static let card = Color(red: 0.1020, green: 0.1255, blue: 0.1529)
    static let textPrimary = Color(red: 0.9176, green: 0.9373, blue: 0.9529)
    static let textMuted = Color(red: 0.6235, green: 0.7059, blue: 0.7765)

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let labelFont = Font.system(.caption, design: .rounded).weight(.semibold)
}
