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
    var numberToken: Int?
    var height: CGFloat!
    var width: CGFloat!
    

    var path: UIBezierPath!
    
    
    init(frame: CGRect, resourceType: ResourceType, numberToken: Int?, width: Double, height: Double){
        super.init(frame: frame)
        
        self.resourceType = resourceType
        self.numberToken = numberToken
        self.width = CGFloat(width)
        self.height = CGFloat(height)
        
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        
        //let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let path = createHexagon(rect: rect, lineWidth: 2, cornerRadius: 0, rotationOffset: CGFloat(.pi / 2.0))

        setResourceType(path: path)
        if resourceType != ResourceType.desert {
            setNumberToken(numberToken: numberToken!)
        }
        
        //trim view
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        
        
    }
    
    func setResourceType(path: UIBezierPath){
        
        switch resourceType {
        case .brick:
            UIColor(red: 156/255.0, green: 67/255.0, blue: 0/255.0, alpha: 1.0).setFill()
            path.fill()
        case .wood:
            UIColor(red: 81/255.0, green: 125/255.0, blue: 25/255.0, alpha: 1.0).setFill()
            path.fill()
        case .sheep:
            UIColor(red: 146/255.0, green: 229/255.0, blue: 47/255.0, alpha: 1.0).setFill()
            path.fill()
        case .wheat:
            UIColor(red: 240/255.0, green: 173/255.0, blue: 0/255.0, alpha: 1.0).setFill()
            path.fill()
        case .ore:
            UIColor(red: 116/255.0, green: 104/255.0, blue: 123/255.0, alpha: 1.0).setFill()
            path.fill()
        case .desert:
            UIColor(red: 247/255.0, green: 205/255.0, blue: 117/255.0, alpha: 1.0).setFill()
            path.fill()
        default:
            break
        }
        
    }
    
    func setNumberToken(numberToken: Int) {
        
        
        
        
        let numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 21))
        numberLabel.textColor = UIColor.black
        //numberLabel.center = CGPoint(x: self.width/2, y: height/2)
        
        //set test to be attached to left was and center y
        numberLabel.center.y = self.center.y
        numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        
        numberLabel.textAlignment = .center
        numberLabel.text = "\(numberToken)"
        addSubview(numberLabel)
    }
    
    func createHexagon(rect: CGRect, lineWidth: CGFloat, cornerRadius: CGFloat, rotationOffset: CGFloat = 0)
        -> UIBezierPath {
            let path = UIBezierPath()
            let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(6) // How much to turn at every corner
            //let offset: CGFloat = cornerRadius * tan(theta / 2)     // Offset from which to start rounding corners
            
            let center = CGPoint(x: rect.origin.x + height / 2, y: rect.origin.y + height / 2)
            
            // Radius of the circle that encircles the polygon
            // Notice that the radius is adjusted for the corners, that way the largest outer
            // dimension of the resulting shape is always exactly the height - linewidth
            let radius = (height - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
            
            // Start drawing at a point, which by default is at the right hand edge
            // but can be offset
            var angle = CGFloat(rotationOffset)
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle),y: center.y + (radius - cornerRadius) * sin(angle))
            path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
            
            //for each side
            for _ in 0 ..< 6 {
                angle += theta
                
                let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
                //let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
                let start = CGPoint(x:corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
                //let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
                
                path.addLine(to: start)
                //path.addQuadCurve(to: end, controlPoint: tip)
            }
            
            path.close()
            
            // Move the path to the correct origins
            let bounds = path.bounds
            let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0, y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
            path.apply(transform)
            
            return path
    }
    
}
