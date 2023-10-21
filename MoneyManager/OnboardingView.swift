//
//  ProfileView.swift
//  MoneyManager
//
//  Created by Maciej Rak on 13/10/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("createdProfile") var createdProfile: Bool = false
    @AppStorage("name") var userName: String?
    @AppStorage("budget") var userBudget: Int?

    
    @State var onboardingState: Int = 0
    
    @State var name: String = ""
    @State var budget: String = ""
    
    @State var buttonText: String = ""
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    var body: some View {
        ZStack{
            
            switch onboardingState{
            case 0:
                welcomeSection
                    .transition(transition)
            case 1:
                addNameSection
                    .transition(transition)
            case 2:
                addBudgetSection
                    .transition(transition)
            default:
                RoundedRectangle(cornerRadius: 10)
            }
            
            VStack{
                Spacer()
                bottomButton
            }
            .padding()
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
}

#Preview {
    ZStack{
        BackgroundView()
        OnboardingView()
    }
}

//MARK: COMPONENTS

extension OnboardingView{
    private var bottomButton: some View{
        Text(getButtonText())
            .font(.headline)
            .foregroundStyle(Color(#colorLiteral(red: 0.1803921569, green: 0.768627451, blue: 0.7137254902, alpha: 1)))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .animation(nil, value: UUID())
            .onTapGesture {
                nextOnboardingView()
            }
    }
    
    private var welcomeSection: some View{
        VStack(spacing: 40){
            Spacer()
            Image(systemName: "chart.pie.fill")
                .resizable()
                .scaledToFit()
                .frame(
                    width: UIScreen.main.bounds.width/4
                )
                .foregroundColor(.white)
                .shadow(radius: 5)
            Text("Manage your budget")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundStyle(.white)
                    , alignment: .bottom
                )
            Text("Managing your finances has never been easier! Take control of your money, set goals, and achieve financial success.")
                .fontWeight(.medium)
                .foregroundColor(.white)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addNameSection: some View{
        VStack(spacing: 40){
            Spacer()
            VStack{
                Text("What's your name?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                TextField("Your name here...", text: $name)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 2)
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addBudgetSection: some View{
        VStack(spacing: 40){
            Spacer()
            VStack{
                Text("What's your budget?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                TextField("Your budget here...", text: $budget)
                    .keyboardType(.decimalPad)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 2)
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 20)
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

extension OnboardingView{
    private func nextOnboardingView(){
        
        switch onboardingState{
        case 0:
            onboardingState += 1
        case 1:
            buttonText = "Next"
            if name.count < 3{
                showAlert(title: "Your name must be at least 3 characters long!")
                return
            }
            onboardingState += 1
        case 2:
            if Int(budget) ?? 0 < 1 {
                showAlert(title: "Your budget is too low!")
                return
            }else{
                signUp()
                return
            }
        default:
            break
        }
    }
    
    private func showAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
    
    private func getButtonText() -> String{
        var returnText: String = ""
        
        switch onboardingState{
        case 0:
            returnText =  "Create Profile"
        case 1:
            returnText = "Next"
        case 2:
            returnText = "Finish"
        default:
            break
        }
        
        return returnText
    }
    
    private func signUp(){
        print("signup")
        userName = name
        userBudget = Int(budget)
        withAnimation(.spring()){
            createdProfile = true
        }
    }
}
