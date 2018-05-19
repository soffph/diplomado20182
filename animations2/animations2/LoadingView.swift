//
//  LoadingView.swift
//  animations2
//
//  Created by d182_sofia_d on 18/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import Foundation
import UIKit
import UIKit

class LoadingView: UIView, CAAnimationDelegate {
    lazy var circle: CAShapeLayer = {
        let layer = circleShape(at: self.center, fillColor: UIColor(named: "c3")!, strokeColor: .clear)
        return layer
    }()
    
    lazy var pulseLayer: CAShapeLayer = {
        let layer = circleShape(at: self.center, fillColor: UIColor(named: "c1")!, strokeColor: .clear)
        return layer
    }()
    lazy var strokeLayer: CAShapeLayer = {
        let layer = circleShape(at: self.center, fillColor: .clear, strokeColor:UIColor(named: "c2")! ,radius: 130)
        layer.transform = CATransform3DMakeRotation(-CGFloat.pi/2.0, 0, 0, 1)
        return layer
    }()
    lazy var pulseAnimation: CAAnimationGroup = {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.8
        scaleAnimation.toValue = 2.0
        
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let pulseAnimation = CAAnimationGroup()
        pulseAnimation.animations = [scaleAnimation, opacityAnimation]
        pulseAnimation.duration = 1
        pulseAnimation.repeatCount = Float.infinity
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return pulseAnimation
    }()
    let progressAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        //animation.delegate = self
        return animation
    }()
    let progressAnimationFinish: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        return animation
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }
    
    func setupLayers() {
        backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        self.layer.addSublayer(pulseLayer)
        self.layer.addSublayer(strokeLayer)
        self.layer.addSublayer(circle)
        
        pulseLayer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    
    private func circleShape(at center: CGPoint,
                             fillColor: UIColor,
                             strokeColor: UIColor,
                             radius: CGFloat = 120,
                             strokeWidth: CGFloat = 20) -> CAShapeLayer {
        let shape = CAShapeLayer()
        let circle = UIBezierPath(arcCenter: .zero,
                                  radius: radius,
                                  startAngle: 0,
                                  endAngle: 2*CGFloat.pi,
                                  clockwise: true)
        shape.path = circle.cgPath
        shape.fillColor = fillColor.cgColor
        shape.strokeColor = strokeColor.cgColor
        shape.lineWidth = strokeWidth
        shape.lineCap = kCALineCapRound
        shape.position = center
        return shape
    }
    func  animatePulse()  {
        progressAnimation.delegate = self
         strokeLayer.isHidden = false
        self.strokeLayer.add(self.progressAnimation, forKey: "progressBarAnimation")
        //strokeLayer.removeFromSuperlayer()
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        strokeLayer.isHidden = true
    }
}
