//
//  Todo+CoreDataProperties.swift
//  Todolist-MVVM
//
//  Created by Muhammad Ridho on 4/1/17.
//  Copyright © 2017 Foo Bar. All rights reserved.
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo");
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var todo: String?

}
