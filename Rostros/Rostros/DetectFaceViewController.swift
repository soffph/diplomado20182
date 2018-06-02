//
//  DetectFaceViewController.swift
//  Rostros
//
//  Created by d182_sofia_d on 02/06/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
import Vision
import ImageIO

class DetectFaceViewController: UIViewController {
    var selectedImage : UIImage!
    
    let faceImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "alien")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    let resultsLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont(name: "Arial", size: 30)
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        faceImage.image = selectedImage
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let ciImage = selectedImage.cgImage else{
            print("No se pudo crear el CIImage")
            return
        }
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(selectedImage.imageOrientation.rawValue))
        let faceRequest = VNDetectFaceRectanglesRequest(completionHandler: handleFaces)
        
        let hanlder = VNImageRequestHandler(cgImage: ciImage, orientation: orientation!)
        DispatchQueue.global(qos: .userInteractive).async {
            do{
                try hanlder.perform([faceRequest])
            }catch{
                print("Error al manejar la peticion",error)
            }
        }
        
    }
    
    func setupLayout(){
        view.addSubview(faceImage)
        view.addSubview(resultsLabel)
        
        faceImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faceImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        faceImage.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        faceImage.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        resultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultsLabel.topAnchor.constraint(equalTo: faceImage.bottomAnchor,constant: 20).isActive = true
        resultsLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-100).isActive = true
        resultsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
  //lo que le acaba de regresear dada la foto detectada y devuelve los resultados como observaciones de rostros pero no me da mas info pero con el dispatch que me des mas observaciones de las imagenes acabes de detectar
    func handleFaces(request: VNRequest, error: Error?){
        guard let observations = request.results as? [VNFaceObservation] else{
            print("no se pudo hacer la solicitud")
            return
        }
        DispatchQueue.main.async {
            self.handleFaces(observations:observations)
        }
    }
    func handleFaces(observations: [VNFaceObservation]){
        resultsLabel.text = "Se detectaron \(observations.count) rostros"
        for face in observations{
            let box1 = face.boundingBox
            let box2 = faceImage.bounds
            let w = box1.size.width * box2.width
            let h = box1.size.height * box2.height
            
            let x = box1.origin.x * box2.width
            let y = abs((box1.origin.y * box2.height) - box2.height) - h
            
            let subview = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
            subview.layer.borderColor = UIColor.red.cgColor
            subview.layer.borderWidth = 3.0
            faceImage.addSubview(subview)
        }
    }

}
