import SwiftUI


struct DailyQuoteSection: View {
    let quote: Quote?
    @Bindable var favoritesManager: FavoritesManager
    let maxWidth: CGFloat
    let maxHeight: CGFloat

    var body: some View {
        if let quote = quote {
            ZStack(alignment: .bottomLeading) {
                // Background image
                if let imageURL = quote.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image("image")
                                .resizable()
                                .scaledToFill()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Gradient and text
                VStack(alignment: .leading, spacing: 8) {
                    Text("“\(quote.text)”")
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(3)

                    Text("- \(quote.author)")
                        .font(.subheadline)
                        .foregroundColor(.white)

                    HStack {
                        Button(action: {
                            favoritesManager.toggleFavorite(quote)
                        }) {
                            Image(systemName: favoritesManager.isFavorite(quote) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        Spacer()
                        ShareLink(item: "“\(quote.text)” — \(quote.author)") {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                                   startPoint: .bottom,
                                   endPoint: .top)
                )
            }
            .frame(width: maxWidth * 0.9, height: maxHeight * 0.4)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .clipped()
            .shadow(radius: 8)
            .background(Color.clear)
        }
    }

}




struct DailyQuoteShimmerPlaceholder: View {
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 200, height: 24)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 300, height: 18)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 18)
                .shimmer()
        }
        .padding()
    }
}

//struct DailyQuoteSection: View {
//    let quote: Quote?
//    @Bindable var favoritesManager: FavoritesManager
//
//    var body: some View {
//        if let quote = quote {
//            ZStack(alignment: .bottomLeading) {
//                if let imageURL = quote.imageURL {
//                    AsyncImage(url: imageURL) { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView()
//                                .frame(height: 300)
//                                .frame(maxWidth: .infinity)
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .scaledToFill()
//                                .frame(height: 300)
//                                .frame(maxWidth: .infinity)
//                        case .failure:
//                            Image("image")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(height: 300)
//                                .frame(maxWidth: .infinity)
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
//                    .cornerRadius(12)
//                    //.padding()
//                }
//
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("“\(quote.text)”")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .lineLimit(3)
//
//                    Text("- \(quote.author)")
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                    
//                    HStack{
//                        Button(action: {
//                            favoritesManager.toggleFavorite(quote)
//                        }) {
//                            Image(systemName: favoritesManager.isFavorite(quote) ? "heart.fill" : "heart")
//                                .foregroundColor(.red)
//                        }
//                        Spacer()
//                        ShareLink(item: "“\(quote.text)” — \(quote.author)") {
//                            Label("",systemImage: "square.and.arrow.up")
//                                .padding(.leading)
//                                .cornerRadius(10)
//                                .foregroundColor(.red)
//                        }
//                    }
//
//                    
//                }
//                .padding()
//                .background(
//                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
//                                   startPoint: .bottom,
//                                   endPoint: .top)
//                )
//                .cornerRadius(12)
//            }
//            .frame(height: 250)
//            .padding(.horizontal)
//            //.padding()
//        }
//    }
//}
