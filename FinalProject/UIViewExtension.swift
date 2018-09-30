import UIKit

extension UIView {
	
	
	func pinFullScreen(to superView: UIView) {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor).isActive = true
		self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor).isActive = true
		self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
		self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
    

    func rotate360Degrees(duration: CFTimeInterval = 1.0) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat( .pi * 2.0)
        rotateAnimation.duration = duration
        

        self.layer.add(rotateAnimation, forKey: nil)
        
    }
    
}
