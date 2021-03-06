import UIKit



class MainViewController: UIViewController {
	
	let session = ApplicationSession()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        
        print("checking if user is loged in")
        
		if session.isUserLoggedIn {
            print("presenting options view controller")
            //just for testing
            presentBoardController()
			//presentOptionsController()
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
		
        if let currentVC = children.first, currentVC !== loginVC {
            print("currenVC != loginVC")
            transition(from: currentVC, to: loginVC, duration: 1.5, setup: {
                loginVC.view.alpha = 0.0
            }, animation: {
                loginVC.view.alpha = 1.0
                currentVC.view.alpha = 0.0
            })
        } else {
            print("currentVC == loginVC")
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
        
        if let loginVC = children.first as? LoginViewController {
            print("login to options")
            transition(from: loginVC, to: optionsVC, duration: 1.5, setup: {
                optionsVC.view.alpha = 0.0
            }, animation: {
                optionsVC.view.alpha = 1.0
                loginVC.view.alpha = 0.0
            })
        }
        else if let boardVC = children.first as? BoardViewController {
            print("board to options")
            transition(from: boardVC, to: optionsVC, duration: 1.5, setup: {
                optionsVC.view.alpha = 0.0
            }, animation: {
                optionsVC.view.alpha = 1.0
                boardVC.view.alpha = 0.0
            })
        }
        else {
            
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
        
        
        
        if let optionsVC = children.first as? OptionsViewController {
            print("transitioning from optionsVC to boardVC")
            transition(from: optionsVC, to: boardVC, duration: 1.5, setup: {
                boardVC.view.alpha = 0.0
            }, animation: {
                boardVC.view.alpha = 1.0
                optionsVC.view.alpha = 0.0
            })
        }
        else if let boardCollectionVC = children.first as? BoardCollectionViewController {
            transition(from: boardCollectionVC, to: boardVC, duration: 1.5, setup: {
                boardVC.view.alpha = 0.0
            }, animation: {
                boardVC.view.alpha = 1.0
                boardCollectionVC.view.alpha = 0.0
            })
        }
        else {
                addFullScreen(controller: boardVC, animationDuration: 0.5, setup: {
                boardVC.view.alpha = 0.0
            }, animation: {
                boardVC.view.alpha = 1.0
            })
        }
        
    }
    
    func presentBoardCollectionController() {
        let boardStoryboard = UIStoryboard(name: "BoardCollection", bundle: Bundle.main)
        
        
        let boardCollectionVC: BoardCollectionViewController = boardStoryboard.instantiateViewController(withIdentifier: "BoardCollectionVC") as! BoardCollectionViewController
        
        
        
        boardCollectionVC.session = session
        boardCollectionVC.model = BoardModel(session: session)
        boardCollectionVC.delegate = self
        
        
        
        if let boardVC = children.first as? BoardViewController {
            print("transitioning from boardVC to boardCollectionVC")
            transition(from: boardVC, to: boardCollectionVC, duration: 1.5, setup: {
                boardCollectionVC.view.alpha = 0.0
            }, animation: {
                boardCollectionVC.view.alpha = 1.0
                boardVC.view.alpha = 0.0
            })
        }
        else {
            addFullScreen(controller: boardCollectionVC, animationDuration: 0.5, setup: {
                boardCollectionVC.view.alpha = 0.0
            }, animation: {
                boardCollectionVC.view.alpha = 1.0
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
        print("generate board from options in main")
        presentBoardController()
    }
    
}

extension MainViewController: BoardViewControllerDelegate {
    
    func goToOptions() {
        print("presenting options controller")
        presentOptionsController()
    }
    
    func goToBoardCollection(){
        print("presenting board collection controller")
        presentBoardCollectionController()
    }

}

extension MainViewController: BoardCollectionViewControllerDelegate {
    

    func goToBoardCreation(){
        print("presenting board view controller from collection")
        presentBoardController()
    }
    
    
}
