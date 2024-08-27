//
//  CoreDataManager.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 27/08/2024.
//

import CoreData

final  class CoreDataManager {

    static let shared = CoreDataManager()

    var allUsers: [User]?

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AllUsers")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error: \(error.userInfo)")
            } else {
                print("Container is ok")
            }
        }
        return container
    }()

    private lazy var objectContext: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    private func saveData() {
        if objectContext.hasChanges {
            do {
                try objectContext.save()
            } catch {
                objectContext.rollback()
                let savingError = error as NSError
                fatalError("Error: \(savingError.userInfo)")
            }
        }
    }

    func fetchAllUsers() -> [User] {
        let fetchRequest: NSFetchRequest = User.fetchRequest()
        do {
            let users = try objectContext.fetch(fetchRequest)
            return users
        } catch {
            print("Fetching failed: \(error.localizedDescription)")
            return []
        }
    }

    func addUser(name: String, dateOfBirth: String?, gender: String?) {
        let newUser = User(context: objectContext)
        newUser.name = name
        newUser.dateOfBirth = dateOfBirth
        newUser.gender = gender
        saveData()
//        do {
//            try objectContext.save()
//        } catch {
//            objectContext.rollback()
//            print("Adding new user error: \(error.localizedDescription)")
//        }
        allUsers = fetchAllUsers()
    }

    func deleteUser(user: User) {
        objectContext.delete(user)
        saveData()
//        do {
//            try objectContext.save()
//        } catch {
//            objectContext.rollback()
//            print("Deleting user error: \(error.localizedDescription)")
//        }
        allUsers = fetchAllUsers()
    }
}

