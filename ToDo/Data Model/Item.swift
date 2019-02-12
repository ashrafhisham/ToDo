//
//  Item.swift
//  ToDo
//
//  Created by ashraf on 1/15/19.
//  Copyright © 2019 ashraf hisham. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCatagory = LinkingObjects(fromType: Category.self, property: "items")
}
