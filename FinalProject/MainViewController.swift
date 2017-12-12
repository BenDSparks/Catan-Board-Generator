import UIKit



class MainViewController: UIViewController {
	
	let session = ApplicationSession()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        
        
		if session.isUserLoggedIn {
            print("presenting options view controller")
			presentOptionsController()
		} else {
            print("presenting login controller")
			presentLoginController()
		}
        
        
	}
	
	func presentLoginController() {
        
		let loginStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        
		guard let loginVC = loginStoryboard.instantiateInitialViewController() as? LoginViewController else {
			print("Failed Login View Controller INIT")
			return
		}
        
		loginVC.delegate = self
		
        if let currentVC = childViewControllers.first, currentVC !== loginVC {
            transition(from: currentVC, to: loginVC, duration: 1.5, setup: {
                loginVC.view.alpha = 0.0
            }, animation: {
                loginVC.view.alpha = 1.0
                currentVC.view.alpha = 0.0
            })
        } else {
            addFullScreen(controller: loginVC, animationDuration: 0.5, setup: {
                loginVC.view.alpha = 0.0
            }, animation: {
                loginVC.view.alpha = 1.0
            })
        }
        
    }
	
    func presentOptionsController() {

        let optionsStoryboard = UIStoryboard(name: "Options", bundle: Bundle.main)

        let optionsVC: OptionsViewController = optionsStoryboard.instantiateViewController(withIdentifier: "Options") as! OptionsViewController
    
        optionsVC.session = session
        optionsVC.model = OptionsModel(session: session)
        optionsVC.delegate = self
        
        if let loginVC = childViewControllers.first as? LoginViewController {
            transition(from: loginVC, to: optionsVC, duration: 1.5, setup: {
                optionsVC.view.alpha = 0.0
            }, animation: {
                optionsVC.view.alpha = 1.0
                loginVC.view.alpha = 0.0
            })
        } else {
            addFullScreen(controller: optionsVC, animationDuration: 0.5, setup: {
                optionsVC.view.alpha = 0.0
            }, animation: {
                optionsVC.view.alpha = 1.0
            })
        }
    }
    
    func presentBoardController() {
        
        let boardStoryboard = UIStoryboard(name: "Board", bundle: Bundle.main)
        
        
        let boardVC: BoardViewController = boardStoryboard.instantiateViewController(withIdentifier: "BoardVC") as! BoardViewController
        
        
        
        boardVC.session = session
        boardVC.model = BoardModel(session: session)
        boardVC.delegate = self
        
        
        
        if let optionsVC = childViewControllers.first as? OptionsViewController {
            transition(from: optionsVC, to: boardVC, duration: 1.5, setup: {
                boardVC.view.alpha = 0.0
            }, animation: {
                boardVC.view.alpha = 1.0
                optionsVC.view.alpha = 0.0
            })
        } else {
            addFullScreen(controller: boardVC, animationDuration: 0.5, setup: {
                boardVC.view.alpha = 0.0
            }, animation: {
                boardVC.view.alpha = 1.0
            })
        }
        
    }
    
    
}




extension MainViewController: LoginViewControllerDelegate {
    func loginButtonPressed(name: String){
        
        session.attemptLogin(name: name) { success in
			if success {
                print("presenting options controller")
				self.presentOptionsController()
			}
            
            
		}
	}
	
	func usernameUpdated(to username: String?) {
		session.username = username
	}
	
}



extension MainViewController: OptionsViewControllerDelegate {
    
    func logout() {
        print("logout in main view controller")
        presentLoginController()
    }
    
    func generateBoard(){
        print("generate board in main view controller")
        presentBoardController()
    }
    
}

extension MainViewController: BoardViewControllerDelegate {
    
//    func logout() {
//        print("logout in main view controller")
//        presentLoginController()
//    }
//
//    func generateBoard(){
//        print("generate board in main view controller")
//    }
    
}
