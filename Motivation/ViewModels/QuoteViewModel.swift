import Foundation

@Observable
class QuoteViewModel {
    var quotes: [Quote] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var dailyQuote: Quote?

    private let service = QuoteService()

    @MainActor
    func loadQuotes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let fetchedQuotes = try await service.fetchQuote()
            self.quotes = fetchedQuotes
            self.dailyQuote = fetchedQuotes.randomElement()
        } catch {
            self.errorMessage = "Error to fetch data : \(error.localizedDescription)"
        }
    }
}
