//
//  SearchObjectController.swift
//  PillPopr
//
//  Created by Joanna Pritt on 19/5/2022.
//

import Foundation
import UIKit
struct Result : Decodable {
    var results : [String]
    //var total : Int
}
class TableViewController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

class SearchObjectController : ObservableObject{
    static let shared = SearchObjectController()
    public init() {}
    
    
    func search(){
        guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json") else {return}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let results = try! JSONDecoder().decode(Result.self, from: data!)
            print(results)
        }
        .resume()
        }
        }
