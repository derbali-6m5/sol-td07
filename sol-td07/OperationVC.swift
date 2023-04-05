//
//  OperationVC.swift
//  sol-td07
//
//  Created by admin on 2023-04-05.
//

import UIKit

class OperationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var compte:Compte?
    
    @IBOutlet weak var lblTypeCompte: UILabel!
    @IBOutlet weak var lblSoldeCompte: UILabel!
    @IBOutlet weak var pickerOperation: UIPickerView!
    @IBOutlet weak var txtMontant: UITextField!
    var dataOperation = ["Retrait", "Depot"]
    var operationSelectionnee = "Retrait"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerOperation.delegate = self
        self.pickerOperation.dataSource = self
        
        lblTypeCompte.text = "\(lblTypeCompte.text!) \(compte!.type)"
        lblSoldeCompte.text = "\(lblSoldeCompte.text!) \(String(format: "%.2f", compte!.solde)) $"
        
    }
    
    //4 operations nécessaires pour le pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataOperation.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataOperation[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.operationSelectionnee = self.dataOperation[row]
        print(operationSelectionnee)
    }
    
    @IBAction func validerOperation(_ sender: Any) {
        var montant  = Float(txtMontant.text!)
        if operationSelectionnee == "Retrait"{
            montant = montant! * -1
        }
        
        self.compte?.solde = self.compte!.solde + montant!
        CompteRestAPI().updateCompte(idCompte: (compte?.id)!, compte: compte!)
//        let alert = UIAlertController(title: "Confirmation", message: "Mise à jour effectuée", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .cancel)
//        alert.addAction(okAction)
//        present(alert, animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "retourComptesSegue"{
            let destination = segue.destination as? ComptesTVC
            destination?.clientId = self.compte?.clientId
        }
    }
    */

}
