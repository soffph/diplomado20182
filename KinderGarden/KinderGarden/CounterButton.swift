//
//  CounterButton.swift
//  KinderGarden
//
//  Created by d182_sofia_d on 16/06/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
@IBDesignable
class CounterButton: UIButton {

    private var halfWidth : CGFloat{
        return bounds.width/2
    }
    private var halfHeight: CGFloat{
        return bounds.height/2
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        #colorLiteral(red: 0.4196078431, green: 0.8352941176, blue: 0.6666666667, alpha: 1).setFill()
        path.fill()
        
        let plusWidth:CGFloat = min(bounds.width, bounds.height) * 0.6
        let halfPlusWidth:CGFloat = plusWidth / 4
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = 3.0
        
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth, y: halfHeight))
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth, y: halfHeight))
        
        plusPath.move(to: CGPoint(x: halfWidth , y: halfHeight - halfPlusWidth))
        plusPath.addLine(to: CGPoint(x: halfWidth, y: halfHeight + halfPlusWidth))
        
        UIColor.white.setStroke()
        plusPath.stroke()
    }
 

}
