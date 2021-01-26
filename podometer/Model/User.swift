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
    
    
}
