import CoreData


struct OptionsData {
    let randomNumbers: Bool
    let randomTiles: Bool
}

extension Options {
    
    
    func populate(optionsData: OptionsData){
        self.randomNumbers = optionsData.randomNumbers
        self.randomTiles = optionsData.randomTiles
    }
    
    static func fetch() -> Options? {

        let fetch: NSFetchRequest<Options> = Options.fetchRequest()



        do{
            let results = try fetch.execute()
            if results.count > 1{
                print("multiple options in the database")
                return nil
            }
            if results.isEmpty {
                print("no options in the database")
                return nil
            }
            return results.first

        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    
    
    
    
}
