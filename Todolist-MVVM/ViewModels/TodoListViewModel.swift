import Foundation
import RxSwift
import CoreData

class TodoListViewModel {
    
    private var todos = Variable<[Todo]>([])
    private var delegate = UIApplication.shared.delegate as! AppDelegate
    private var todosFetchedFromCoreData = [Todo]()
    
    init() {
        fetchTodosAndUpdateObservableTodos()
    }
    
    public func getTodos() -> Variable<[Todo]> {
        return todos
    }
    
    // MARK: - fetching Todos from Core Data and update observable todos
    private func fetchTodosAndUpdateObservableTodos() {
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        let todoFetchRequest = Todo.todoFetchRequest()
        todoFetchRequest.returnsObjectsAsFaults = false
    
        do {
            todos.value = try managedObjectContext.fetch(todoFetchRequest) 
            
            print(todos.value)
        } catch {
            fatalError("error fetch data")
        }
    }
    
    // MARK: - add new todo from Core Data
    public func addTodo(withTodo todo: String) {
        let managedObjectContext = delegate.persistentContainer.viewContext
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: managedObjectContext) as! Todo
        
        newTodo.todo = todo
        newTodo.isCompleted = false
        
        do {
            try managedObjectContext.save()
            fetchTodosAndUpdateObservableTodos()
        } catch {
            fatalError("error saving data")
        }
    }
    
    // MARK: - toggle selected todo's isCompleted value
    public func toggleTodoIsCompleted(withId id: Int) {
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        todos.value[id].isCompleted = !todos.value[id].isCompleted
        
        do {
            try managedObjectContext.save()
            fetchTodosAndUpdateObservableTodos()
        } catch {
            fatalError("error change data")
        }
    }
    
    // MARK: - remove specified todo from Core Data
    public func removeTodo(withId id: Int) {
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        managedObjectContext.delete(todos.value[id])
        
        do {
            try managedObjectContext.save()
            fetchTodosAndUpdateObservableTodos()
        } catch {
            fatalError("error delete data")
        }
    }
    
}
