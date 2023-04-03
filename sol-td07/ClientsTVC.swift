//
//  ClientsTVC.swift
//  sol-td07
//
//  Created by admin on 2023-03-31.
//

import UIKit

protocol WhenClientsReady{
    func loadData(clients:[Client])
    func updateIsDone(client:Client, index:Int)
}


class ClientsTVC: UITableViewController, WhenClientsReady {
    
    var banque: Banque?
    var clients: [Client] = []
    var clientRestAPI: ClientRestAPI?
    override func viewDidLoad() {
        super.viewDidLoad()
        clientRestAPI = ClientRestAPI()
        clientRestAPI?.whenClientsReady = self
        clientRestAPI?.getByBanque(banqueId: banque!.id)
    }
    
    func loadData(clients: [Client]) {
        DispatchQueue.main.async {
            self.clients = clients
            self.tableView.reloadData()
        }
    }
    func updateIsDone(client: Client, index: Int) {
        DispatchQueue.main.async {
            //mise à jour de l'affichage tableView
            self.clients[index].nom = client.nom
            self.clients[index].telephone  = client.telephone
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func ajouterClient(_ sender: Any) {
        let alert = UIAlertController(title: "Ajout d'un client", message: "", preferredStyle: .alert)
        //champs
        alert.addTextField{(textfield) in
            textfield.placeholder = "Nom"
            textfield.textColor = UIColor.purple
        }
        
        alert.addTextField{(textfield) in
            textfield.placeholder = "Telephone"
            textfield.textColor = UIColor.purple
        }
        
        //actions
        let saveAction = UIAlertAction(title: "Ajouter", style: .default, handler: {_ in
            if let nom = alert.textFields?[0].text, let telephone = alert.textFields?[1].text {
                //ajout avec appel du service POST
                let client = Client(id: nil, nom: nom, telephone: telephone, banqueId: self.banque!.id)
                self.clientRestAPI?.addClient(client: client)
                
                //mise à jour de l'affichage tableView
                self.clients.append(client)
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
    

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Supprimer", handler: {(action, view, handler)  in
            let idClient = self.clients[indexPath.row].id
            //suppression avec l'appel du service DELETE
            self.clientRestAPI?.deleteClient(idClient: idClient!)
            //suppression de l'affichage dans tableView
            self.clients.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        })
        
        let edit = UIContextualAction(style: .normal, title: "Éditer", handler: {(action, view, handler)  in
            let idClient = self.clients[indexPath.row].id
            let oldNom = self.clients[indexPath.row].nom
            let oldTelephone = self.clients[indexPath.row].telephone
//
            let alert = UIAlertController(title: "Mise à jour d'un client", message: "", preferredStyle: .alert)
            //champs
            alert.addTextField{(textfield) in
                textfield.text = oldNom
                textfield.textColor = UIColor.purple
            }
            
            alert.addTextField{(textfield) in
                textfield.text = oldTelephone
                textfield.textColor = UIColor.purple
            }
            
            //actions
            let saveAction = UIAlertAction(title: "Éditer", style: .default, handler: {_ in
                if let nom = alert.textFields?[0].text, let telephone = alert.textFields?[1].text {
                    //appele du service PUT
                    let client = Client(id: nil, nom: nom, telephone: telephone, banqueId: self.banque!.id)
                    self.clientRestAPI?.updateClient(idClient: idClient!, client: client, index: indexPath.row)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: {_ in
                
            })
            
            //ajouter les actions à l'alerte
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            //presenter l'alerte
            self.present(alert, animated: true)
        })
        edit.backgroundColor = UIColor.systemBlue
        
        let actions = UISwipeActionsConfiguration(actions: [delete, edit])
        return actions
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.clients[indexPath.row].nom
        cell.detailTextLabel?.text = self.clients[indexPath.row].telephone

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
