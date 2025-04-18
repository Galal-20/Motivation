import SwiftUI

struct QuoteListSection: View {
    let quotes: [Quote]
    @Bindable var favoritesManager: FavoritesManager

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(quotes, id: \.id) { quote in
                NavigationLink(value: quote) {
                    ZStack(alignment: .bottomLeading) {
                        if let imageURL = quote.imageURL {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 180)
                                        .frame(maxWidth: .infinity)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                case .failure:
                                    Image("image")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .frame(maxWidth: .infinity)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .cornerRadius(10)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("“\(quote.text)”")
                                .font(.headline)
                                .foregroundColor(.white)
                                .lineLimit(2)

                            Text("- \(quote.author)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                           startPoint: .bottom,
                                           endPoint: .top)
                        )
                        .cornerRadius(10)
                    }
                    .frame(height: 180)
                    .padding(.horizontal)
                }
            }
        }
    }
}
