import Foundation
import CoreData

class UserPersistence {
	let coreDataManager: CoreDataManager
	
	init(coreDataManager: CoreDataManager) {
		self.coreDataManager = coreDataManager
	}
    
    
    func setUser(name: String, complete: @escaping (() -> Void)) {
        
        coreDataManager.persistentContainer.performBackgroundTask { (backgroundContext) in
            do  {
                let user: User
                if let existingUser = User.fetch(name: name){
                    user = existingUser
                } else {
                    user = User(context: backgroundContext)
                }
                try user.populate(name: name)
                
                try backgroundContext.save()
                complete()
                
            } catch let error as NSError {
                print(error)
            }
            complete()
            
        }
    }
    
    func deleteUser() {
        //need to have the object to delete it.
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        
        
        
        do {
            let results = try coreDataManager.persistentContainer.viewContext.fetch(fetch)
            if results.isEmpty {
                //nothing to delete
                print("Could not find that user to delete")
                return
            }
            //delete all users
            for result in results {
                coreDataManager.viewContext.delete(result)
            }
            
            
            try coreDataManager.viewContext.save()
            return
        } catch {
            //this is catching from two diffrent points in the above statement
            print("Failed to delete from Core data delete card: \(error)")
            return
            
        }
    }
    
    func getUser(context: NSManagedObjectContext? = nil) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results: [User]
            if let privateContext = context{
                
                results = try privateContext.fetch(request)
            } else{
                
                results = try coreDataManager.viewContext.fetch(request)
            }
            if results.count > 1{
                print("too many users")
                deleteUser()
                return nil
            }
            if results.isEmpty {
                print("no users found gettingUser")
                return nil
            }
            
            
            return results.first
        } catch {
            return nil
        }
    }
    
    func doesUserExist() -> Bool {
        //need to have the object to delete it.
        let fetch: NSFetchRequest<User> = User.fetchRequest()
       
        do {
            let results = try coreDataManager.persistentContainer.viewContext.fetch(fetch)
            if results.isEmpty {
                return false
            }
            if results.count > 1 {
                return false
            }
            return true
        } catch {
            print("Failed to fetch from Core data: \(error)")
            return false
            
        }
    }
    
    
}
