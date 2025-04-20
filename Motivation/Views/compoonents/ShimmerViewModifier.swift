//
//  ShimmerViewModifier.swift
//  Motivation
//
//  Created by Dr.Galal Ahmed  on 20/04/2025.
//

import SwiftUI

struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.4), .clear]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .rotationEffect(.degrees(30))
                    .offset(x: phase * 350, y: 0)
                    .blendMode(.plusLighter)
            )
            .mask(content)
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(Shimmer())
    }
}
