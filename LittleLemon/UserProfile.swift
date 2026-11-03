//
//  UserProfile.swift
//  LittleLemon
//
//  Created by hicham fakir on 3/11/2026.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @AppStorage("kIsLoggedIn") var isLoggedIn = true
    
    @State var firstName = UserDefaults.standard.string(forKey: "firstKey") ?? "Tilly"
    @State var lastName = UserDefaults.standard.string(forKey: "lastKeyState") ?? "Doe"
    @State var email = UserDefaults.standard.string(forKey: "emailKey") ?? "tillydoe@example.com"
    @State var phoneNumber = UserDefaults.standard.string(forKey: "phoneKey") ?? "(217) 555-0113"
    
    @State var orderStatuses = true
    @State var passwordChanges = true
    @State var specialOffers = true
    @State var newsletter = true

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Header
                HStack {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                    
                    Spacer()
                    
                    Image("Profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Personal information")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    
                    Text("Avatar")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 20) {
                        Image("Profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Button("Change") {
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Remove") {
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 73/255, green: 94/255, blue: 87/255), lineWidth: 1)
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("First name").font(.caption).foregroundColor(.gray)
                        TextField("First name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Last name").font(.caption).foregroundColor(.gray)
                        TextField("Last name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Email").font(.caption).foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Phone number").font(.caption).foregroundColor(.gray)
                        TextField("Phone number", text: $phoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Text("Email notifications")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .padding(.top, 5)
                    
                    Toggle("Order statuses", isOn: $orderStatuses)
                    Toggle("Password changes", isOn: $passwordChanges)
                    Toggle("Special offers", isOn: $specialOffers)
                    Toggle("Newsletter", isOn: $newsletter)
                    
                    Button("Log out") {
                        UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                        UserDefaults.standard.removeObject(forKey: "firstKey")
                        UserDefaults.standard.removeObject(forKey: "emailKey")
                        isLoggedIn = false
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 244/255, green: 206/255, blue: 20/255))
                    .cornerRadius(8)
                    .padding(.top, 10)
                    
                    HStack(spacing: 15) {
                        Button("Discard changes") {
                            firstName = UserDefaults.standard.string(forKey: "firstKey") ?? ""
                            email = UserDefaults.standard.string(forKey: "emailKey") ?? ""
                        }
                        .font(.subheadline)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 73/255, green: 94/255, blue: 87/255), lineWidth: 1)
                        )
                        
                        Button("Save changes") {
                            UserDefaults.standard.set(firstName, forKey: "firstKey")
                            UserDefaults.standard.set(email, forKey: "emailKey")
                            presentation.wrappedValue.dismiss()
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
}
