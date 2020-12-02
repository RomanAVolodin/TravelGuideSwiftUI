//
//  TileModifier.swift
//  Travel
//
//  Created by Roman Vol on 08.11.2020.
//

import SwiftUI

extension View {
    func asTile() -> some View {
        modifier(TileModifier())
    }
}

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(5.0)
            .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 2, x: 0, y: 2)
    }
}
