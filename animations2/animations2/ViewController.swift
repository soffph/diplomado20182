//
//  ViewController.swift
//  animations2
//
//  Created by d182_sofia_d on 18/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: self.view.frame)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.loadingView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tap)
    }
    @objc func onTap(){
        print("taping ... ")
       loadingView.animatePulse()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

