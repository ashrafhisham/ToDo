//
//  Catagory.swift
//  ToDo
//
//  Created by ashraf on 1/15/19.
//  Copyright © 2019 ashraf hisham. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
    
}
