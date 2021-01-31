//
//  User.swift
//  podometer
//
//  Created by Mohamed dennoun on 25/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import CoreData

class User: NSManagedObject {
    
    static var all: [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return users
    }
    
    static func updateOne(user: User) {
            let u: User!
            let results = User.all

            if results.count == 0 {
               // here you are inserting
                u = User(context: AppDelegate.viewContext)
            } else {
               // here you are updating
               u = results.first
            }
            u.pseudo = user.pseudo
            u.age = user.age
            u.height = user.height
            u.weight = user.weight
            
            try? AppDelegate.viewContext.save()
            
        }
}
