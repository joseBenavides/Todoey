//
//  Item.swift
//  Todoey
//
//  Created by Jose on 6/6/18.
//  Copyright © 2018 Benavides, Jose. All rights reserved.
//

import Foundation

//adding the codable type allows the Method to be saved and loaded locally
class Item : Codable{
    var title : String = ""
    var done : Bool = false
}
