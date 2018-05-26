//
//  TableViewController.swift
//  TableTest
//
//  Created by d182_sofia_d on 26/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var alumnos = ["sofia", "jorge", "sergio", "el traidor", "tavo"]
    
    var lastDeleted : String = ""
    var indice : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alumnos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = alumnos[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fetchAction = UIContextualAction(style: .normal, title: "recupera") {(action, sourceView, completionHandler) in
            self.alumnos.append(self.lastDeleted)
            self.tableView.reloadData()
            //self.tableView.insertRows(at: [self.indice!], with: .fade)
            //self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [fetchAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "die☠️") {(action, sourceView, completionHandler) in
            self.lastDeleted = self.alumnos[indexPath.row]
            self.alumnos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let shareAction = UIContextualAction(style: .normal, title: "Compartir") { (action, sourceView, completionHandler) in
            let letrerito = "Compartiendo al alumno: " + self.alumnos[indexPath.row]
            let activityController = UIActivityViewController(activityItems: [letrerito], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            completionHandler(true)
            
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.737254902, blue: 0.6901960784, alpha: 1)
        deleteAction.image = UIImage(named: "image2")
        shareAction.backgroundColor = #colorLiteral(red: 0.9113846421, green: 0.7986511588, blue: 0.7775793672, alpha: 1)
        shareAction.image = UIImage(named: "image")
        //swipeConfiguration = uis
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        return swipeConfiguration
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return.none
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedAlumno = self.alumnos[sourceIndexPath.row]
        self.alumnos.remove(at: sourceIndexPath.row)
        self.alumnos.insert(movedAlumno, at: destinationIndexPath.row)
        tableView.reloadData()
        
        //self.alumnos.remove(at: sourceIndexPath.row)
        
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let rowData = self.alumnos[indexPath.row]
        return rowData.hasPrefix("s")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Marcado Alumnos", message: "Desea marcarlos?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "ok", style: .default) { (action) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
           
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationAR = 90 * CGFloat(M_PI / 180.0)
        let rotationTransform = CATransform3DMakeRotation(rotationAR, 0, 0, 1)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
//     Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            alumnos.remove(at: indexPath.row)
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
