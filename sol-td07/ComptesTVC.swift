//
//  ComptesTVC.swift
//  sol-td07
//
//  Created by admin on 2023-04-05.
//


import UIKit

protocol WhenComptesReady{
    func loadData(comptes:[Compte])
}

class ComptesTVC: UITableViewController , WhenComptesReady{

    var comptes:[Compte] = []
    var clientId:String?
    var compteRestAPI: CompteRestAPI?

    override func viewDidLoad() {
        super.viewDidLoad()
        //compteRestAPI = CompteRestAPI()
        //compteRestAPI?.whenComptesReady = self
        //compteRestAPI?.getByClient(clientId: self.clientId!)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        compteRestAPI = CompteRestAPI()
        compteRestAPI?.whenComptesReady = self
        compteRestAPI?.getByClient(clientId: self.clientId!)
    }
    
    func loadData(comptes: [Compte]) {
        DispatchQueue.main.async {
            self.comptes = comptes
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comptes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "compteCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.comptes[indexPath.row].type
        cell.detailTextLabel?.text = "\(String(format: "%.2f", self.comptes[indexPath.row].solde)) $"
        
        return cell
    }
    
    
    @IBAction func ajouterCompte(_ sender: Any) {
        let alert = UIAlertController(title: "Ajout d'un compte", message: "", preferredStyle: .alert)
        //champs
        alert.addTextField{(textfield) in
            textfield.placeholder = "Type"
            textfield.textColor = UIColor.purple
        }
        
        alert.addTextField{(textfield) in
            textfield.placeholder = "Solde"
            textfield.textColor = UIColor.purple
        }
        
        //actions
        let saveAction = UIAlertAction(title: "Ajouter", style: .default, handler: {_ in
            if let type = alert.textFields?[0 ].text, let solde = Float(alert.textFields?[1].text ?? "0") {
                //ajout avec appel du servicePOST
                let compte = Compte(id: nil, type: type, solde: solde, clientId: self.clientId!)
                self.compteRestAPI?.addCompte(compte: compte)
                
                //mise à jour de l'affichage tableView
                self.comptes.append(compte)
                self.tableView.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: {_ in
            
        })
        
        //ajouter les actions à l'alerte
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //presenter l'alerte
        present(alert, animated: true)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "operationSegue"{
            let cell = sender as! UITableViewCell
            let index = tableView.indexPath(for: cell)!.row
            let destination = segue.destination as? OperationVC
            destination?.compte = self.comptes[index]
        }
    }
    

}
