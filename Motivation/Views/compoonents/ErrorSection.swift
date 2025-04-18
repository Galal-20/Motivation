import SwiftUI

struct ErrorSection: View {
    let error: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text(error)
                .foregroundColor(.red)
            Button("Try again", action: retryAction)
                .padding(.top)
        }
    }
}
