//
//  BackgroundView.swift
//  MoneyManager
//
//  Created by Maciej Rak on 13/10/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        RadialGradient(
            colors: [Color(#colorLiteral(red: 0.7960784314, green: 0.9529411765, blue: 0.9411764706, alpha: 1)), Color(#colorLiteral(red: 0.1803921569, green: 0.768627451, blue: 0.7137254902, alpha: 1))],
            center: .topLeading,
            startRadius: 20,
            endRadius: UIScreen.main.bounds.height
        )
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
