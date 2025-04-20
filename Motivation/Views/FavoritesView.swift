import SwiftUI

struct FavoritesView: View {
    @Bindable var favoritesManager: FavoritesManager

    var body: some View {
        List {
            if favoritesManager.favoriteQuotes.isEmpty {
                Text("No favorites yet.")
                    .foregroundColor(.gray)
            } else {
                ForEach(Array(favoritesManager.favoriteQuotes), id: \.id) { quote in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("“\(quote.text)”")
                            .font(.headline)
                        Text("- \(quote.author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Favorites")
    }
}
