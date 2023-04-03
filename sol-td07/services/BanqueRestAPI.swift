//
//  BanqueRestAPI.swift
//  sol-td07
//
//  Created by admin on 2023-03-24.
//

import Foundation
class BanqueRestAPI {
    
    var whenBanqueReady : WhenBanquesReady?
    
    let sesstion = URLSession.shared
    let url = URL(string: "https://derbali-36d8.restdb.io/rest/banques")
    
    func getAll() {
        var request = URLRequest(url: url!)
        request.addValue("232ec52be6fc72935ea68431ecf658ba36b5a", forHTTPHeaderField: "x-apikey")
        let task = sesstion.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder  = JSONDecoder()
                    let banques:[Banque] = try decoder.decode([Banque].self, from: data!)
                    self.whenBanqueReady?.loadData(data: banques)
                    
                    /*for b in banques {
                        print("\(b.id) \(b.nom) \(b.ville)")
                    }*/
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
}
