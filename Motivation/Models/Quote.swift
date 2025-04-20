import Foundation

struct Quote: Identifiable, Codable, Hashable {
    let q: String
    let a: String
    var id: String { q + a }
    var text: String { q }
    var author: String { a }
    var imageURL: URL?
}




