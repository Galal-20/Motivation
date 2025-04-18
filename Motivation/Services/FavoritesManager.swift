import Foundation

@Observable
class FavoritesManager {
    private let favoritesKey = "favoriteQuotes"
    var favoriteQuotes: Set<Quote> = []

    init() {
        loadFavorites()
    }

    func toggleFavorite(_ quote: Quote) {
        if favoriteQuotes.contains(quote) {
            favoriteQuotes.remove(quote)
        } else {
            favoriteQuotes.insert(quote)
        }
        saveFavorites()
    }

    func isFavorite(_ quote: Quote) -> Bool {
        favoriteQuotes.contains(quote)
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let savedQuotes = try? JSONDecoder().decode(Set<Quote>.self, from: data) {
            favoriteQuotes = savedQuotes
        }
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteQuotes) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
