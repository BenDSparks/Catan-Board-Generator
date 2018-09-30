//
//  Hexagon.swift
//  FinalProject
//
//  Created by Ben Sparks on 11/27/17.
//  Copyright © 2017 UMSL. All rights reserved.
//

import UIKit



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
        self.width = frame.width
        self.height = frame.height
        
//        self.width = CGFloat(width)
//        self.height = CGFloat(height)
        
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
            case .brick?:
                UIColor(red: 156/255.0, green: 67/255.0, blue: 0/255.0, alpha: 1.0).setFill()
                path.fill()
            case .wood?:
                UIColor(red: 81/255.0, green: 125/255.0, blue: 25/255.0, alpha: 1.0).setFill()
                path.fill()
            case .sheep?:
                UIColor(red: 146/255.0, green: 229/255.0, blue: 47/255.0, alpha: 1.0).setFill()
                path.fill()
            case .wheat?:
                UIColor(red: 240/255.0, green: 173/255.0, blue: 0/255.0, alpha: 1.0).setFill()
                path.fill()
            case .ore?:
                UIColor(red: 116/255.0, green: 104/255.0, blue: 123/255.0, alpha: 1.0).setFill()
                path.fill()
            case .desert?:
                UIColor(red: 247/255.0, green: 205/255.0, blue: 117/255.0, alpha: 1.0).setFill()
                path.fill()
            default:
                break
        }
        
    }
    
    func setNumberToken(numberToken: Int) {
        

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: CGFloat(12), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor(red: 255/255.0, green: 227/255.0, blue: 159/255.0, alpha: 1.0).cgColor
        
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 0.5
        
        layer.addSublayer(shapeLayer)
        
        
        
        let numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 21))
        numberLabel.textColor = UIColor.black
        
        //set circle to be attached to left was and center y
        numberLabel.center.y = self.center.y
        numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        
        numberLabel.textAlignment = .center
        numberLabel.text = "\(numberToken)"
        addSubview(numberLabel)
    }
    
    func createHexagon(rect: CGRect, lineWidth: CGFloat, cornerRadius: CGFloat, rotationOffset: CGFloat = 0)
        -> UIBezierPath {
            let path = UIBezierPath()
            let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(6) // How much to turn at every
            
            let center = CGPoint(x: rect.origin.x + height / 2, y: rect.origin.y + height / 2)
            let radius = (height - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
            
            
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
