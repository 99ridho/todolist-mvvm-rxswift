import Foundation
import RxSwift
import CoreData

class TodoListViewModel {
    
    private var todos = Variable<[Todo]>([])
    private var delegate = UIApplication.shared.delegate as! AppDelegate
    private var todosFetchedFromCoreData = [Todo]()
    
    init() {
        fetchDataAndUpdateDataToObservableTodos()
    }
    
    public func getTodos() -> Variable<[Todo]> {
        return todos
    }
    
    private func fetchDataAndUpdateDataToObservableTodos() {
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        let todoFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        todoFetchRequest.returnsObjectsAsFaults = false
    
        do {
            todosFetchedFromCoreData = try managedObjectContext.fetch(todoFetchRequest) as! [Todo]
            
            todos.value = todosFetchedFromCoreData
            
            print(todos.value)
        } catch {
            fatalError("error fetch data")
        }
    }
    
    public func addTodo(withTodo todo: String) {
        let managedObjectContext = delegate.persistentContainer.viewContext
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: managedObjectContext) as! Todo
        
        newTodo.todo = todo
        newTodo.isCompleted = false
        
        do {
            try managedObjectContext.save()
            fetchDataAndUpdateDataToObservableTodos()
        } catch {
            fatalError("error saving data")
        }
    }
    
    public func toggleTodoIsCompleted(withId id: Int) {
        let managedObjectContext = delegate.persistentContainer.viewContext
        todosFetchedFromCoreData[id].isCompleted = !todosFetchedFromCoreData[id].isCompleted
        
        do {
            try managedObjectContext.save()
            fetchDataAndUpdateDataToObservableTodos()
        } catch {
            fatalError("error change data")
        }
    }
    
    // TODO : remove data
    
}
