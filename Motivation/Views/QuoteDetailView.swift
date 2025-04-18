

import SwiftUI

struct QuoteDetailView: View {
    let quote: Quote
    @Bindable var favoritesManager: FavoritesManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("“\(quote.text)”")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            Text("- \(quote.author)")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()

            HStack {
                Button(action: {
                    favoritesManager.toggleFavorite(quote)
                }) {
                    Image(systemName: favoritesManager.isFavorite(quote) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.title)
                }

                ShareLink(item: "“\(quote.text)” — \(quote.author)") {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Quote")
    }
}

