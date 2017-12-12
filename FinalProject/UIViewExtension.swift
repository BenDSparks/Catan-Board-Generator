import UIKit

extension UIView {
	func drawUnderline(withWidth width: CGFloat, opacity: Float, color strokeColor: UIColor = UIColor.black) {
		layer.masksToBounds = false
		let lineLayer = CAShapeLayer()
		let linePath = CGMutablePath()
		linePath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
		linePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
		lineLayer.path = linePath
		lineLayer.fillColor = nil
		lineLayer.opacity = opacity
		lineLayer.strokeColor = strokeColor.cgColor
		lineLayer.lineWidth = width
		layer.addSublayer(lineLayer)
	}
	
	func pinFullScreen(to superView: UIView) {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor).isActive = true
		self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor).isActive = true
		self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
		self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}
