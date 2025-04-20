import SwiftUI

struct HomeView: View {
    @State private var viewModel = QuoteViewModel()
    @State private var favoritesManager = FavoritesManager()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            
            // daily quote tab
            NavigationStack {
                GeometryReader { geometry in
                    ZStack {
                        // Background image
                        if let imageURL = viewModel.dailyQuote?.imageURL {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .empty:
                                    Color.blue.opacity(0.1)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .blur(radius: 20)
                                        .overlay(Color.blue.opacity(0.3))
                                        .ignoresSafeArea()
                                case .failure:
                                    Color.blue.opacity(0.3)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Color.blue.opacity(0.3)
                                .ignoresSafeArea()
                        }
                        // Center the DailyQuoteSection
                        if viewModel.isLoading {
                            DailyQuoteShimmerPlaceholder()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.trailing, 430)
                        } else {
                            DailyQuoteSection(
                                quote: viewModel.dailyQuote,
                                favoritesManager: favoritesManager,
                                maxWidth: geometry.size.width,
                                maxHeight: geometry.size.height
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.trailing, 430)
                        }

                    }
                    
                    
                }
                .navigationTitle("Daily Quote")
                .task {await viewModel.loadQuotes()}
            }
            .tabItem {
                Label("Daily", systemImage: "sun.max.fill")
            }
            .tag(0)

            // quotes list tab
            NavigationStack {
                ScrollView {
                    if viewModel.isLoading {
                        DailyQuoteShimmerPlaceholder()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else if let error = viewModel.errorMessage {
                        ErrorSection(error: error) {
                            Task { await viewModel.loadQuotes() }
                        }
                    } else {
                        QuoteListSection(quotes: viewModel.quotes, favoritesManager: favoritesManager)
                    }
                }
                .navigationTitle("Quotes")
                .navigationDestination(for: Quote.self) { quote in
                    QuoteDetailView(quote: quote, favoritesManager: favoritesManager)
                }
                .task {
                    await viewModel.loadQuotes()
                }
            }
            .tabItem {
                Label("Quotes", systemImage: "quote.bubble.fill")
            }
            .tag(1)

            // favorites Tab
            NavigationStack {
                FavoritesView(favoritesManager: favoritesManager)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            .tag(2)
        }
    }
}




//                ScrollView {
//                    DailyQuoteSection(quote: viewModel.dailyQuote, favoritesManager: favoritesManager)
//                        .padding(.top)
//                }
//                .navigationTitle("Daily Quote")
////                .toolbar {
////                    ToolbarItem(placement: .navigationBarTrailing) {
////                        NavigationLink(destination: FavoritesView(favoritesManager: favoritesManager)) {
////                            Image(systemName: "heart.fill")
////                                .foregroundColor(.red)
////                        }
////                    }
////                }
//                .task {
//                    await viewModel.loadQuotes()
//                }
//            }
//            .tabItem {
//                Label("Daily", systemImage: "sun.max.fill")
//            }
//            .tag(0)
