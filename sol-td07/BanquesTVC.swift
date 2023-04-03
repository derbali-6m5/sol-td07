//
//  BanquesTVC.swift
//  sol-td07
//
//  Created by admin on 2023-03-24.
//

import UIKit

//design pattern Observer
protocol WhenBanquesReady{
    func loadData(data:[Banque])
}


class BanquesTVC: UITableViewController, WhenBanquesReady {
    var banques:[Banque] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let banquesRestApi = BanqueRestAPI()
        banquesRestApi.whenBanqueReady = self
        banquesRestApi.getAll()
    }
    
    func loadData(data: [Banque]) {
        DispatchQueue.main.async {
            self.banques = data
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
        return self.banques.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "banqueCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.banques[indexPath.row].nom
        cell.detailTextLabel?.text = self.banques[indexPath.row].ville

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "clientsParBanqueSegue"{
            let cell = sender as! UITableViewCell
            let index = tableView.indexPath(for: cell)!.row
            let destination = segue.destination as? ClientsTVC
            destination?.banque = self.banques[index]
        }
    }
    

}
