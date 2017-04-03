import Foundation
import RxSwift
import CoreData

struct TodoListViewModel {
    
    private var todos = Variable<[Todo]>([])
    private var todoDataAccessProvider = TodoDataAccessProvider()
    private var disposeBag = DisposeBag()
    
    init() {
        fetchTodosAndUpdateObservableTodos()
    }
    
    public func getTodos() -> Variable<[Todo]> {
        return todos
    }
    
    // MARK: - fetching Todos from Core Data and update observable todos
    private func fetchTodosAndUpdateObservableTodos() {
        todoDataAccessProvider.fetchObservableData()
            .map({ $0 })
            .subscribe(onNext : { (todos) in
                self.todos.value = todos
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - add new todo from Core Data
    public func addTodo(withTodo todo: String) {
        todoDataAccessProvider.addTodo(withTodo: todo)
    }
    
    // MARK: - toggle selected todo's isCompleted value
    public func toggleTodoIsCompleted(withIndex index: Int) {
        todoDataAccessProvider.toggleTodoIsCompleted(withIndex: index)
    }
    
    // MARK: - remove specified todo from Core Data
    public func removeTodo(withIndex index: Int) {
        todoDataAccessProvider.removeTodo(withIndex: index)
    }
    
}
