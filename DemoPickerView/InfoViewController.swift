//
//  InfoViewController.swift
//  DemoPickerView
//
//  Created by Ryan on 2024/4/13.
//

import UIKit
import MapKit





class InfoViewController: UIViewController {

    var item: ParkItem?
    
    @IBOutlet weak var payexLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var telLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLabel()
        
    }
    
    func showLabel(){
        if let item {
            payexLabel.text = item.payex
            addressLabel.text =  "地址：" + item.address
            telLabel.text = "電話：" + item.tel
        }
    }
    
}
