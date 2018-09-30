import CoreData


extension User {
    
    func populate(name: String) throws {
        self.name = name
    }
    
    static func fetch(name: String) -> User? {
        
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        
    
        fetch.predicate = NSPredicate(format: "name = [cd] %@", name)
        
        do{
            let results = try fetch.execute()
            if results.count > 1{
                print("multiple of the same loginId in the database")
                return nil
            }
            if results.isEmpty {
                print("name does not exist in the database")
                return nil
            }
            return results.first
            
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    
    
    
    
}
