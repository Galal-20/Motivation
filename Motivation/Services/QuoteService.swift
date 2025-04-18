import Foundation

@Observable
class QuoteService{
    func fetchQuote() async throws -> [Quote] {
        guard let url = URL(string: "https://zenquotes.io/api/quotes") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        var quotes = try JSONDecoder().decode([Quote].self, from: data)

        for index in quotes.indices {
            _ = quotes[index].author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "inspiration"
            if let imageURL = URL(string: "https://picsum.photos/seed/\(quotes[index].id)/400/300") {
                quotes[index].imageURL = imageURL
            }
        }

        return quotes
    }

    
   
    
    
}
