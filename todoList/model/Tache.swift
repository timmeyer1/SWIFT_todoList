import Foundation

struct Tache: Identifiable, Codable {
    let id = UUID()
    var titre: String
    var estFaite: Bool
}
