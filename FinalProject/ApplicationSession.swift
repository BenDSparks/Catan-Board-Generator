import Foundation

class ApplicationSession {
	
	let userPersistence: UserPersistence
	let optionsPersistence: OptionsPersistence
    
    var user: User!
    var options: Options!
	
	private var _username: String?
    
	var username: String? {
		get { return _username }
		set {
			if !isUserLoggedIn { _username = newValue }
		}
	}
	
	init() {
		let coreDataManager = CoreDataManager()
		self.userPersistence = UserPersistence(coreDataManager: coreDataManager)
		self.optionsPersistence = OptionsPersistence(coreDataManager: coreDataManager)
        self.getUserFromCoreData()
        self.getOptionsFromCoreData()
	}
	
	private var _isUserLoggedIn: Bool = false
    
	var isUserLoggedIn: Bool {
        return _isUserLoggedIn
	}
    

    
    func getUserFromCoreData(){
        if let userFromCoreData = userPersistence.getUser() {
            user = userFromCoreData
            _isUserLoggedIn = true
        }
        else{
            _isUserLoggedIn = false
        }
    }
    
    func getOptionsFromCoreData(){
        if let optionsFromCoreData = optionsPersistence.getOptions() {
            options = optionsFromCoreData
        }
    }
	
    func attemptLogin(name: String, _ complete: (Bool) -> Void) {
        
        print("Name Entered: \(name)")
        
        let semaphore = DispatchSemaphore(value: 0)
        userPersistence.setUser(name: name) {
            semaphore.signal()
        }
        if semaphore.wait(timeout: .now() + 3) == .timedOut {
            print("semaphore timeout after setUser call in attemptLogin")
        }
        user = userPersistence.getUser()
        
        _username = name

		_isUserLoggedIn = true
        
		complete(isUserLoggedIn)
	}
    
    
}
