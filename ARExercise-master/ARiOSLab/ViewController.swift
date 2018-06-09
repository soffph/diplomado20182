//
//  ViewController.swift
//  ARiOSLab
//
//  Created by Luis Ezcurdia on 6/8/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createPlane(anchor: ARPlaneAnchor) -> SCNNode {
        let node = SCNNode()
        node.geometry = SCNPlane(width: CGFloat(anchor.extent.x),
                                 height: CGFloat(anchor.extent.z))
        node.eulerAngles.x = -.pi / 2
        node.opacity = 0.25
        
        return node
    }
    
    func createEarth(anchor: ARPlaneAnchor) -> SCNNode{
        let node = SCNScene(named: "art.scnassets/solar.scn")!.rootNode.childNodes.first!
        
//        node.geometry = SCNSphere(radius: 5)
//        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth-difusse.jpg")
//        node.geometry?.firstMaterial?.specular.contents = UIImage(named: "earth-specular.jpg")
//        node.geometry?.firstMaterial?.isDoubleSided = true
        return node
    }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = createPlane(anchor: planeAnchor)
        node.addChildNode(plane)
        
        let earth = createEarth(anchor: planeAnchor)
        node.addChildNode(earth)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        for node in node.childNodes {
            node.position = SCNVector3(planeAnchor.center.x
                
                
                , 0, planeAnchor.center.z)
            if let plane = node.geometry as? SCNPlane {
                plane.width = CGFloat(planeAnchor.extent.x)
                plane.height = CGFloat(planeAnchor.extent.z)
            }
        }
    }
    var ht: ARHitTestResult!
    
    @IBAction func onScreenTap(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: sceneView)
        guard let hitResult = sceneView.hitTest(location,
        types: .existingPlaneUsingExtent).first else {return}
        print("Hit resulta at : \(hitResult)")
        ht = hitResult
        
        if let ray = createRay(anchor: (hitResult.anchor as? ARPlaneAnchor)!){
            sceneView.scene.rootNode.addChildNode(ray)
        }
    }
    
    func createRay(anchor: ARPlaneAnchor)->SCNNode?{
        guard let currentFrame = sceneView.session.currentFrame
            else{return nil}
        let framePos = currentFrame.camera.transform.columns.3
        let node = SCNNode()
        //let position = SCNVector3(anchor.center)
        
        node.name = "ray[\(UUID().uuidString)]"
        
        //node.position = SCNVector3(framePos.x,framePos.y,framePos.z)
        
        //node.position = SCNVector3(framePos.x,framePos.y,framePos.z/2)
        //node.rotation = SCNVector4(framePos.x,framePos.y,framePos.z/2,3)
        node.eulerAngles.x = currentFrame.camera.eulerAngles.x
        node.eulerAngles.y = currentFrame.camera.eulerAngles.y
        node.eulerAngles.z = currentFrame.camera.eulerAngles.z
        
        //node.position = positionForm(transform: currentFrame.camera.transform)
        
        node.geometry = SCNCylinder(radius: 0.005, height: 0.7)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor(cgColor: #colorLiteral(red: 0.8875563741, green: 0.6283646822, blue: 1, alpha: 1))
        
        return node
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
