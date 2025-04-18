import SwiftUI

struct HomeView: View {
    @State private var viewModel = QuoteViewModel()
    @State private var favoritesManager = FavoritesManager()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            
            // daily Qquote Tab
            NavigationStack {
                ScrollView {
                    DailyQuoteSection(quote: viewModel.dailyQuote, favoritesManager: favoritesManager)
                        .padding(.top)
                }
                .navigationTitle("Daily Quote")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        NavigationLink(destination: FavoritesView(favoritesManager: favoritesManager)) {
//                            Image(systemName: "heart.fill")
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
                .task {
                    await viewModel.loadQuotes()
                }
            }
            .tabItem {
                Label("Daily", systemImage: "sun.max.fill")
            }
            .tag(0)

            // quotes list tab
            NavigationStack {
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
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

            // favorites tab
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
