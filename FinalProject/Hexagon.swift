//
//  Hexagon.swift
//  FinalProject
//
//  Created by Ben Sparks on 11/27/17.
//  Copyright © 2017 UMSL. All rights reserved.
//

import UIKit

enum ResourceType {
    case brick
    case wood
    case sheep
    case wheat
    case ore
    case desert
}

class Hexagon: UIView {
    
    var resourceType: ResourceType!
    var numberToken = 2
    var width: Int!
    var height: Int!
    

    var path: UIBezierPath!
    
    
    init(frame: CGRect, resourceType: ResourceType, numberToken: Int){
        super.init(frame: frame)
        
        self.resourceType = resourceType
        self.numberToken = numberToken
        
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let path = createHexagon(rect: rect, lineWidth: 2, cornerRadius: 0, rotationOffset: CGFloat(.pi / 2.0))

        setResourceType(path: path)
        
        //trim view
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        
        
    }
    
    func setResourceType(path: UIBezierPath){
        
        switch resourceType {
        case .brick:
            UIColor(red: 156.0/255.0, green: 67.0/255.0, blue: 0.0/255.0, alpha: 1.0).setFill()
            path.fill()
            
           break
        case .wood:
            UIColor(red: 81/255.0, green: 125/255.0, blue: 25/255.0, alpha: 1.0).setFill()
            path.fill()
            break
        case .sheep:
            UIColor(red: 156.0/255.0, green: 67.0/255.0, blue: 0.0/255.0, alpha: 1.0).setFill()
            path.fill()
            break
        case .wheat:
            UIColor(red: 156.0/255.0, green: 67.0/255.0, blue: 0.0/255.0, alpha: 1.0).setFill()
            path.fill()
            break
        case .ore:
            UIColor(red: 156.0/255.0, green: 67.0/255.0, blue: 0.0/255.0, alpha: 1.0).setFill()
            path.fill()
            break
        case .desert:
            UIColor(red: 156.0/255.0, green: 67.0/255.0, blue: 0.0/255.0, alpha: 1.0).setFill()
            path.fill()
            break
        default:
            break
        }
            
        
        
        
    }
    
    
  
//    func createRectangle() {
//        // Initialize the path.
//        path = UIBezierPath()
//
//        // Specify the point that the path should start get drawn.
//        path.move(to: CGPoint(x: 0.0, y: 0.0))
//
//        // Create a line between the starting point and the bottom-left side of the view.
//        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
//
//        // Create the bottom line (bottom-left to bottom-right).
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
//
//        // Create the vertical line from the bottom-right to the top-right side.
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
//
//        // Close the path. This will create the last line automatically.
//        path.close()
//    }
    
    func createHexagon(rect: CGRect, lineWidth: CGFloat, cornerRadius: CGFloat, rotationOffset: CGFloat = 0)
        -> UIBezierPath {
            let path = UIBezierPath()
            let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(6) // How much to turn at every corner
            //let offset: CGFloat = cornerRadius * tan(theta / 2)     // Offset from which to start rounding corners
            let width = min(rect.size.width, rect.size.height)        // Width of the square
            let center = CGPoint(x: rect.origin.x + width / 2, y: rect.origin.y + width / 2)
            
            // Radius of the circle that encircles the polygon
            // Notice that the radius is adjusted for the corners, that way the largest outer
            // dimension of the resulting shape is always exactly the width - linewidth
            let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
            
            // Start drawing at a point, which by default is at the right hand edge
            // but can be offset
            var angle = CGFloat(rotationOffset)
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle),y: center.y + (radius - cornerRadius) * sin(angle))
            path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
            
            //for each side
            for _ in 0 ..< 6 {
                angle += theta
                
                let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
                let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
                let start = CGPoint(x:corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
                let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
                
                path.addLine(to: start)
                //path.addQuadCurve(to: end, controlPoint: tip)
            }
            
            path.close()
            
            // Move the path to the correct origins
            let bounds = path.bounds
            let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0,
                                              y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
            path.apply(transform)
            
            return path
    }
    
}
