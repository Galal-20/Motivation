import SwiftUI

struct DailyQuoteSection: View {
    let quote: Quote?
    @Bindable var favoritesManager: FavoritesManager

    var body: some View {
        if let quote = quote {
            ZStack(alignment: .bottomLeading) {
                if let imageURL = quote.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                        case .failure:
                            Image("image")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .cornerRadius(12)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("“\(quote.text)”")
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(3)

                    Text("- \(quote.author)")
                        .font(.subheadline)
                        .foregroundColor(.white)

                    Button(action: {
                        favoritesManager.toggleFavorite(quote)
                    }) {
                        Image(systemName: favoritesManager.isFavorite(quote) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                                   startPoint: .bottom,
                                   endPoint: .top)
                )
                .cornerRadius(12)
            }
            .frame(height: 250)
            .padding(.horizontal)
        }
    }
}
