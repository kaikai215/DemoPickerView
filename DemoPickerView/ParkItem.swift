//
//  ParkItem.swift
//  DemoPickerView
//
//  Created by Ryan on 2024/4/13.
//

import Foundation

struct ParkDate: Codable{
    let data: SearchPark
}


struct SearchPark: Codable{
    let park: [ParkItem]
}

struct ParkItem:Codable{
    let area: String
    let name: String
    let address: String
    let payex: String
    let tel: String
}

