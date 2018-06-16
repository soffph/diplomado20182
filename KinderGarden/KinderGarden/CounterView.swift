//
//  CounterView.swift
//  KinderGarden
//
//  Created by d182_sofia_d on 16/06/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
@IBDesignable
class CounterView: UIView {
    private struct Constants{
        static let numberOfGlasses = 8
        
    }
    @IBInspectable var counter : Int = 5{
        didSet{
            if counter <= Constants.numberOfGlasses{
                setNeedsDisplay()
            }
        }
    }
    //@IBInspectable var counterColor : UIColor = UIColor.orange
    override func draw(_ rect: CGRect) {
       let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = max(bounds.width, bounds.height)
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - 86/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = 86
        #colorLiteral(red: 0.7818874717, green: 0.7445468307, blue: 1, alpha: 1).setStroke()
        path.stroke()
        
        let angleDifference : CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width / 2 - 4, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        
        outlinePath.addArc(withCenter: center, radius: bounds.width/2 - 86 + 4, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        #colorLiteral(red: 0.9362677932, green: 0.815276444, blue: 0.9910152555, alpha: 1).setStroke()
        outlinePath.lineWidth = 8
        outlinePath.stroke()
        
    }
    

}
