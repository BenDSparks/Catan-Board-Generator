import Foundation
import CoreData

class OptionsPersistence {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    

    func setOptions(optionsData: OptionsData, complete: @escaping (() -> Void)) {
        
        coreDataManager.persistentContainer.performBackgroundTask { (backgroundContext) in
            do  {
                let options: Options
                if let existingOptions = Options.fetch(){
                    options = existingOptions
                } else {
                    options = Options(context: backgroundContext)
                }
                options.populate(optionsData: optionsData)
                
                try backgroundContext.save()
                
                complete()
                
            } catch let error as NSError {
                print(error)
            }
            complete()
            
        }
    }
    
    func deleteOptions() {
        //need to have the object to delete it.
        let fetch: NSFetchRequest<Options> = Options.fetchRequest()
        
        
        
        do {
            let results = try coreDataManager.persistentContainer.viewContext.fetch(fetch)
            if results.isEmpty {
                //nothing to delete
                print("Could not find any options")
                return
            }
            //delete all options, should only ever be one anyway
            for result in results {
                coreDataManager.viewContext.delete(result)
            }
            
            
            try coreDataManager.viewContext.save()
            return
        } catch {
            //this is catching from two diffrent points in the above statement
            print("Failed to delete options from Core data: \(error)")
            return
            
        }
    }
    
    func getOptions(context: NSManagedObjectContext? = nil) -> Options? {
        let fetch: NSFetchRequest<Options> = Options.fetchRequest()
        
        
        do {
            let results: [Options]
            if let privateContext = context{
                results = try privateContext.fetch(fetch)
            } else{
                results = try coreDataManager.viewContext.fetch(fetch)
            }
            
            
            
            if results.count > 1 {
                self.deleteOptions()
            }
            if results.isEmpty{
                return nil
            }
            
            return results.first
        } catch {
            return nil
        }
    }
    
    
    
    
    func doesOptionsExist() -> Bool {
        //need to have the object to delete it.
        let fetch: NSFetchRequest<Options> = Options.fetchRequest()
        
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

