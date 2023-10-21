//
//  ContentView.swift
//  MoneyManager
//
//  Created by Maciej Rak on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("createdProfile") var createdProfile: Bool = false
    
    var body: some View {
        ZStack{
            BackgroundView()
            
            if createdProfile{
                Text("Created")
            }else{
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
}
