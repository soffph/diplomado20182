//
//  ViewController.swift
//  animanic
//
//  Created by d182_sofia_d on 12/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var actionX: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        actionX.bounds = CGRect(x: actionX.center.x, y: actionX.center.y , width: actionX.bounds.width / 10.0, height: actionX.bounds.height)
    }

    @IBAction func onTapActionBtn(_ sender: Any) {
        print("tapping...")
            //        UIView.animate(withDuration: 0.7, animations: {
            //self.actionX.transform = CGAffineTransform(rotationAngle: CGFloat(1.5*Float.pi))
            //            self.actionX.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            //            self.actionX.transform = CGAffineTransform(scaleX: self.actionX.bounds.width * 3.0, y: 3.0)
            //            self.actionX.transform = CGAffineTransform(translationX: 5, y: 0)
            //            self.actionX.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
            //        }) { (success) in
            //            guard success else {return}
            //            UIView.animate(withDuration: 0.7, animations: {
            //                self.actionX.transform = CGAffineTransform.identity
            //                self.actionX.backgroundColor = #colorLiteral(red: 1, green: 0.8225150704, blue: 0, alpha: 1)
            //            }, completion: nil)
            //
            //        }
        
        
        
//        let anima = CAKeyframeAnimation(keyPath: "backgroundColor")
//        let times : [NSNumber] = [0.0, 0.25, 0.5, 0.75, 1.0]
//        anima.keyTimes = times
        //        anima.values = [#colorLiteral(red: 1, green: 0.2376380265, blue: 0.3687204123, alpha: 1).cgColor,
        //                        #colorLiteral(red: 0.1697468162, green: 0.5359709859, blue: 1, alpha: 1).cgColor,
        //                        #colorLiteral(red: 0.9981825948, green: 1, blue: 0, alpha: 1).cgColor,
        //                        #colorLiteral(red: 0, green: 0.7842388153, blue: 0.553284049, alpha: 1).cgColor
        //        ]
//        anima.duration = 0.5
//        anima.repeatCount = Float.infinity
        //anima.autoreverses = true
        //anima.timingFunctions = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //self.actionX.layer.add(anima, forKey: "backgroundColorBlink")
        // self.view.layer.add(anima, forKey: "backgroundColorBlink")
        
//        let anima = CASpringAnimation(keyPath: "transform.scale.x")
//        anima.fromValue = 1
//
//        anima.toValue = 2
//        anima.damping = 4
//        anima.duration = 2
    
        
        let revert = CABasicAnimation(keyPath: "transform.scale.x")
        revert.fromValue = 2
        revert.toValue = 1
        revert.duration = 1
         revert.timeOffset = 2
        revert.repeatCount = Float.infinity
        
//        let group = CAAnimationGroup()
//        group.animations = [revert, anima]
//        group.duration = 2
//        self.actionX.layer.add(group, forKey: "spring and reverse")
        //anima.autoreverses = true
    
        self.actionX.layer.add(revert, forKey: "backgroundColorBlink")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

