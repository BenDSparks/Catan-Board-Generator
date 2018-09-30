
import UIKit

extension UIViewController {
	
	func transition(from current: UIViewController, to replacing: UIViewController, duration: TimeInterval, setup: () -> Void, animation: @escaping () -> Void, completion: (() -> Void)? = nil) {
		current.willMove(toParent: nil)
		addFullScreen(controller: replacing, animationDuration: duration, setup: setup, animation: animation) {
			current.view.removeFromSuperview()
			current.removeFromParent()
			completion?()
		}
	}
	
	
	func addFullScreen(controller: UIViewController, animationDuration duration: TimeInterval, setup: () -> Void, animation: @escaping () -> Void, completion: (() -> Void)? = nil) {
		controller.willMove(toParent: self)
		addChild(controller)
		
		view.insertSubview(controller.view, at: 1)
		controller.view.pinFullScreen(to: view)
		setup()
		UIView.animate(withDuration: duration, animations: animation, completion: { complete in
			controller.didMove(toParent: self)
			completion?()
		})
	}
}
