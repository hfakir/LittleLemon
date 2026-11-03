//
//  Home.swift
//  LittleLemon
//
//  Created by hicham fakir on 3/11/2026.
//

import SwiftUI
import CoreData

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var dishesModel = DishesModel()
    @State var searchText = ""
    @State var selectedCategory = "all"
    @State private var navigateToProfile = false

    @FetchRequest(
        entity: Dish.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
    ) var dishes: FetchedResults<Dish>

    let defaultMenuItems: [LocalMenuItem] = [
        LocalMenuItem(title: "Greek Salad", description: "The famous greek salad of crispy lettuce, peppers, olives and our Chicago...", price: "12.99", imageName: "Greek salad"),
        LocalMenuItem(title: "Bruschetta", description: "Our Bruschetta is made from grilled bread that has been smeared with garlic...", price: "7.99", imageName: "Bruschetta"),
        LocalMenuItem(title: "Grilled Fish", description: "Barbequed catch of the day, with red onion, crisp capers, chive creme fraiche.", price: "20.00", imageName: "Grilled fish"),
        LocalMenuItem(title: "Pasta", description: "Penne with fried aubergines, tomato sauce, fresh chilli, garlic, basil & salted...", price: "18.99", imageName: "Pasta"),
        LocalMenuItem(title: "Lemon Dessert", description: "Light and fluffy traditional homemade Italian Lemon and ricotta cake", price: "6.99", imageName: "Lemon dessert")
    ]

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
                    
                    Button(action: {
                        navigateToProfile = true
                    }) {
                        Image("Profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Little Lemon")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
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
                            .frame(width: 110, height: 120)
                            .cornerRadius(12)
                            .clipped()
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                        
                        TextField("Search menu...", text: $searchText)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ORDER FOR DELIVERY!")
                        .font(.headline)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            CategoryButton(title: "Starters", selectedCategory: $selectedCategory)
                            CategoryButton(title: "Mains", selectedCategory: $selectedCategory)
                            CategoryButton(title: "Desserts", selectedCategory: $selectedCategory)
                            CategoryButton(title: "Drinks", selectedCategory: $selectedCategory)
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider().padding(.top, 8)
                
                List {
                    if !dishes.isEmpty {
                        ForEach(dishes.filter { dish in
                            searchText.isEmpty || (dish.name?.localizedCaseInsensitiveContains(searchText) ?? false)
                        }) { dish in
                            MenuRowView(
                                title: dish.name ?? "",
                                description: dish.dishDescription ?? "",
                                price: dish.price ?? "0.00",
                                imageName: getImageName(for: dish.name ?? "")
                            )
                        }
                    } else {
                        ForEach(defaultMenuItems.filter { item in
                            searchText.isEmpty || item.title.localizedCaseInsensitiveContains(searchText)
                        }) { item in
                            MenuRowView(
                                title: item.title,
                                description: item.description,
                                price: item.price,
                                imageName: item.imageName
                            )
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationDestination(isPresented: $navigateToProfile) {
                UserProfile()
            }
            .navigationBarBackButtonHidden(true)
            .task {
                await dishesModel.reload(viewContext)
            }
        }
    }
    
    func getImageName(for dishName: String) -> String {
        let name = dishName.lowercased()
        if name.contains("greek") { return "Greek salad" }
        if name.contains("bruschetta") { return "Bruschetta" }
        if name.contains("fish") { return "Grilled fish" }
        if name.contains("pasta") { return "Pasta" }
        if name.contains("dessert") || name.contains("lemon") { return "Lemon dessert" }
        return "Logo"
    }
}

struct LocalMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let price: String
    let imageName: String
}

struct MenuRowView: View {
    let title: String
    let description: String
    let price: String
    let imageName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                Text("$\(price)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
            }
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .cornerRadius(8)
                .clipped()
        }
        .padding(.vertical, 4)
    }
}

struct CategoryButton: View {
    let title: String
    @Binding var selectedCategory: String
    
    var body: some View {
        Button(action: {
            selectedCategory = title.lowercased()
        }) {
            Text(title)
                .font(.subheadline)
                .bold()
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                .cornerRadius(12)
        }
    }
}
