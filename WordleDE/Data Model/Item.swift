//
//  Item.swift
//  WordleDE
//
//  Created by MacBook on 22/06/2019.
//  Copyright © 2019 MatMacBook. All rights reserved.
//

import Foundation

// we need to write Encodable since it means that our word/item can encode itself to plist or json
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
