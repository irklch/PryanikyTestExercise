//
//  DataTableView.swift
//  PryanikyTest
//
//  Created by Ирина Кольчугина on 05.03.2021.
//

import UIKit

class DataTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadResponseData() {[weak self] _ in
            self?.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResponseJson.shared.view.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataItemsCell", for: indexPath) as! DataItemsCell
        
        cell.nameLable.text = ResponseJson.shared.view[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsInfo",
           let indexPath = tableView.indexPathForSelectedRow {
            for count in (0..<DataJson.shared.count) {
                if ResponseJson.shared.view[indexPath.row] == DataJson.shared[count].name {
                    dataIndex = count
                }
            }
        }
    }

}
