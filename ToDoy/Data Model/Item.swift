//
//  Item.swift
//  ToDoy
//
//  Created by CA@CA on 2019-01-02.
//  Copyright © 2019 Red Nova Engine. All rights reserved.
//

import Foundation

class Item: Codable {  // Encodable, Decodable
    // 注意，要让 Codable，必须所有数据都是缺省格式(String, Float, Bool, Int, etc.)，不能是自建格式
    var title : String = ""
    var done : Bool = false
}
