//
//  User.swift
//  podometer
//
//  Created by Mohamed dennoun on 25/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import CoreData

class User: NSManagedObject {
    
    static func new(named pseudo: String, age: Int32, height: Double, weight: Double) -> User {
        
        let u = User(context: AppDelegate.viewContext)
        u.pseudo = pseudo
        u.age = age
        u.height = height
        u.weight = weight
        return u
    }
    
    static var all: [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return users
    }
    
    static func saveOne(user: User) {
        let u = User(context: AppDelegate.viewContext)
        u.pseudo = user.pseudo
        u.age = user.age
        u.height = user.height
        u.weight = user.weight
        u.curlevel = 0
        u.curxp = 0
        u.curimc = 0
        u.total_step = 0
        u.total_distance = 0
        try? AppDelegate.viewContext.save()
        
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
    
    static func updateTotalStep(nbStep: Int) {
            let u: User!
            let results = User.all

            if results.count == 0 {
               // here you are inserting
                u = User(context: AppDelegate.viewContext)
            } else {
               // here you are updating
               u = results.first
            }
            u.total_step = Int64(nbStep)
            try? AppDelegate.viewContext.save()
            
        }
    
    static func updateTotalDistance(nbDistence: Int) {
            let u: User!
            let results = User.all

            if results.count == 0 {
               // here you are inserting
                u = User(context: AppDelegate.viewContext)
            } else {
               // here you are updating
               u = results.first
            }
            u.total_distance = Int64(nbDistence)
            
            try? AppDelegate.viewContext.save()
            
        }
    
    static func updateLevel(level: Int) {
        let u: User!
        let results = User.all

        if results.count == 0 {
           // here you are inserting
            u = User(context: AppDelegate.viewContext)
        } else {
           // here you are updating
           u = results.first
        }
        u.curlevel = Int64(level)
        
        try? AppDelegate.viewContext.save()
        
    }
}
