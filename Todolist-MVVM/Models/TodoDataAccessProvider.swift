//
//  TodoDataProvider.swift
//  Todolist-MVVM
//
//  Created by Muhammad Ridho on 4/3/17.
//  Copyright © 2017 Foo Bar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TodoDataAccessProvider {
    
    private var todosFromCoreData : [Todo]
    private var managedObjectContext : NSManagedObjectContext
    
    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        todosFromCoreData = [Todo]()
        managedObjectContext = delegate.persistentContainer.viewContext
        
        todosFromCoreData = fetchData()
    }
    
    public func fetchData() -> [Todo] {
        let todoFetchRequest = Todo.todoFetchRequest()
        todoFetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(todoFetchRequest)
        } catch {
            return []
        }
        
    }
    
    public func addTodo(withTodo todo: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: managedObjectContext) as! Todo
        
        newTodo.todo = todo
        newTodo.isCompleted = false
        
        do {
            try managedObjectContext.save()
            todosFromCoreData = fetchData()
        } catch {
            fatalError("error saving data")
        }
    }
    
    public func toggleTodoIsCompleted(withIndex index: Int) {
        todosFromCoreData[index].isCompleted = !todosFromCoreData[index].isCompleted
        
        do {
            try managedObjectContext.save()
            todosFromCoreData = fetchData()
        } catch {
            fatalError("error change data")
        }

    }
    
    public func removeTodo(withIndex index: Int) {
        managedObjectContext.delete(todosFromCoreData[index])
        
        do {
            try managedObjectContext.save()
            todosFromCoreData = fetchData()
        } catch {
            fatalError("error delete data")
        }
    }
    
}
