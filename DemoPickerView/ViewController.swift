//
//  ViewController.swift
//  DemoPickerView
//
//  Created by Ryan on 2024/4/12.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var items = [ParkItem] ()
    var taipeiDistricts = [String]() // 用於儲存台北市的行政區
    var selectedDistrict: String? //用於儲存所選的行政區


    @IBOutlet weak var areaPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        fetchItems()
    }
    
    //抓資料
    func fetchItems(){
        let urlStr = "https://tcgbusfs.blob.core.windows.net/blobtcmsv/TCMSV_alldesc.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let searchResponse = try decoder.decode(ParkDate.self, from: data)
                        self.items = searchResponse.data.park
                        
                        // 在成功解析 JSON 後，更新 Set 中的行政區資料
                        var uniqueDistricts = Set<String>()
                        for item in self.items {
                            uniqueDistricts.insert(item.area)
                        }
                        // 將 Set 轉換為陣列，並按照字母順序排序
                        self.taipeiDistricts =  Array(uniqueDistricts).sorted()
                        
                        DispatchQueue.main.async {
                            self.areaPickerView.reloadAllComponents()
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

    @IBSegueAction func showResult(_ coder: NSCoder) -> ParkingLotsTableViewController? {
        let controller = ParkingLotsTableViewController(coder: coder)
        // 傳遞所選的行政區到下一個畫面
            let selectedRow = areaPickerView.selectedRow(inComponent: 0)
            if selectedRow != -1 {
                selectedDistrict = taipeiDistricts[selectedRow]
                controller?.selectedDistrict = selectedDistrict
            }
        return controller
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 只有一個欄位
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taipeiDistricts.count // 行數應該等於項目的數量
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taipeiDistricts[row]  //提供每一行的資料
    }
    
}

