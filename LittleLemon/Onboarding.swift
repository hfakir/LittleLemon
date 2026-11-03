//
//  Onboarding.swift
//  LittleLemon
//
//  Created by hicham fakir on 3/11/2026.
//

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var email = ""
    @State var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    Spacer()
                }
                .padding(.vertical, 10)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Little Lemon")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Chicago")
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Image("Hero image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 120)
                            .cornerRadius(12)
                            .clipped()
                    }
                }
                .padding()
                .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Name *")
                            .font(.headline)
                            .foregroundColor(.gray)
                        TextField("Name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Email *")
                            .font(.headline)
                            .foregroundColor(.gray)
                        TextField("Username@example.com", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        if !firstName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: "firstKey")
                            UserDefaults.standard.set(email, forKey: "emailKey")
                            UserDefaults.standard.set(true, forKey: "kIsLoggedIn")
                            isLoggedIn = true
                        }
                    }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 244/255, green: 206/255, blue: 20/255))
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
        }
    }
}
