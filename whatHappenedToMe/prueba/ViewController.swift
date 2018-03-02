//
//  ViewController.swift
//  prueba
//
//  Created by markmota on 2/24/18.
//  Copyright © 2018 markmota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //conexión de elementos de la vista con el controlador
    @IBOutlet weak var aoutletButton: UIButton!
    @IBOutlet weak var outletText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //El nombre del elemento boton se modifica: "Touch me!"
        aoutletButton.setTitle("Touch me!", for: .normal)
        
    }
    //conexión del controlador con la vista (accion que realiza el boton)
    @IBAction func actionoutletButton(_ sender: Any) {
        //el elemento outletText recibe la cadena y la muestra en la vista
        outletText.text = "You are a genius "
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

