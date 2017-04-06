//
//  TodoDataProvider.swift
//  Todolist-MVVM
//
//  Created by Muhammad Ridho on 4/3/17.
//  Copyright © 2017 Foo Bar. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class TodoDataAccessProvider {
    
    private var todosFromCoreData = Variable<[Todo]>([])
    private var managedObjectContext : NSManagedObjectContext
    
    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        todosFromCoreData.value = [Todo]()
        managedObjectContext = delegate.persistentContainer.viewContext
        
        todosFromCoreData.value = fetchData()
    }
    
    // MARK: - fetching Todos from Core Data and update observable todos
    private func fetchData() -> [Todo] {
        let todoFetchRequest = Todo.todoFetchRequest()
        todoFetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(todoFetchRequest)
        } catch {
            return []
        }
        
    }
    
    // MARK: - return observable todo
    public func fetchObservableData() -> Observable<[Todo]> {
        todosFromCoreData.value = fetchData()
        return todosFromCoreData.asObservable()
    }
    
    // MARK: - add new todo from Core Data
    public func addTodo(withTodo todo: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: managedObjectContext) as! Todo
        
        newTodo.todo = todo
        newTodo.isCompleted = false
        
        do {
            try managedObjectContext.save()
            todosFromCoreData.value = fetchData()
        } catch {
            fatalError("error saving data")
        }
    }
    
    // MARK: - toggle selected todo's isCompleted value
    public func toggleTodoIsCompleted(withIndex index: Int) {
        todosFromCoreData.value[index].isCompleted = !todosFromCoreData.value[index].isCompleted
        
        do {
            try managedObjectContext.save()
            todosFromCoreData.value = fetchData()
        } catch {
            fatalError("error change data")
        }

    }
    
    // MARK: - remove specified todo from Core Data
    public func removeTodo(withIndex index: Int) {
        managedObjectContext.delete(todosFromCoreData.value[index])
        
        do {
            try managedObjectContext.save()
            todosFromCoreData.value = fetchData()
        } catch {
            fatalError("error delete data")
        }
    }
    
}
