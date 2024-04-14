//
//  ParkingLotsTableViewController.swift
//  DemoPickerView
//
//  Created by Ryan on 2024/4/13.
//

import UIKit

class ParkingLotsTableViewController: UITableViewController {
    
    var items = [ParkItem] ()
    var selectedDistrict: String? // 接收所選的行政區
    var parkingLots = [String]() // 存儲停車場名稱


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchItems()
        
    }
    
    //抓資料
    func fetchItems(){
        guard let selectedDistrict = selectedDistrict else { return }
        let urlStr = "https://tcgbusfs.blob.core.windows.net/blobtcmsv/TCMSV_alldesc.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let searchResponse = try decoder.decode(ParkDate.self, from: data)
                        self.items = searchResponse.data.park
                        self.parkingLots = self.items.filter({ parkItem in
                            return parkItem.area == selectedDistrict
                        }).map({ parkItem in
                            return parkItem.name
                        })
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }catch{
                        //show error
                    }
                }else {
                    //show error
                }
            }.resume()
        }
    }

    @IBSegueAction func showInfo(_ coder: NSCoder) -> InfoViewController? {
        if let row = tableView.indexPathForSelectedRow?.row {
        let controller = InfoViewController(coder: coder)
            controller?.item = items[row]
            return controller
        }else{
            return nil
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parkingLots.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkTableViewCell", for: indexPath) as! ParkTableViewCell

        cell.parkNameLabel.text = parkingLots[indexPath.row]

        
        return cell
    }

}
