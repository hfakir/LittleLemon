//
//  DishesModel.swift
//  LittleLemon
//
//  Created by hicham fakir on 3/11/2026.
//

import Foundation
import Combine
import CoreData

@MainActor
class DishesModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    
    func reload(_ coreDataContext: NSManagedObjectContext) async {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Dish.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? coreDataContext.execute(deleteRequest)
        
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/littleLemonSimpleMenu.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fullMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
            self.menuItems = fullMenu.menu
            
            for item in menuItems {
                let dish = Dish(context: coreDataContext)
                dish.name = item.title
                dish.price = item.price
                dish.dishDescription = item.description
                dish.image = item.image
            }
            try coreDataContext.save()
        } catch {
            print("Error: \(error)")
        }
    }
}
