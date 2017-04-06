import UIKit
import RxSwift
import RxCocoa

class TodoListViewController: UIViewController {

    @IBOutlet weak var todoListTableView: UITableView!
    
    var todoListViewModel = TodoListViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        populateTodoListTableView()
        setupTodoListTableViewCellWhenTapped()
        setupTodoListTableViewCellWhenDeleted()
    }
    
    // MARK: - perform a binding from observableTodo from ViewModel to todoListTableView
    private func populateTodoListTableView() {
        var observableTodos = todoListViewModel.getTodos().asObservable()
        
        observableTodos.bindTo(todoListTableView.rx.items(cellIdentifier: "todoCellIdentifier", cellType: UITableViewCell.self)) { (row, element, cell) in
            
            cell.textLabel?.text = element.todo
            
            if element.isCompleted {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        }
        .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - subscribe to todoListTableView when item has been selected, then toggle todo to persistent storage via viewmodel
    private func setupTodoListTableViewCellWhenTapped() {
        todoListTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.todoListTableView.deselectRow(at: indexPath, animated: false)
                self.todoListViewModel.toggleTodoIsCompleted(withIndex: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - subscribe to todoListTableView when item has been deleted, then remove todo to persistent storage via viewmodel
    private func setupTodoListTableViewCellWhenDeleted() {
        todoListTableView.rx.itemDeleted
            .subscribe(onNext : { indexPath in
                self.todoListViewModel.removeTodo(withIndex: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }

    // MARK: - event handling when add button tapped, and add todo to persistent storage via viewmodel
    @IBAction func buttonAddTodoTapped(_ sender: UIBarButtonItem) {
        let addTodoAlert = UIAlertController(title: "Add Todo", message: "Enter your string", preferredStyle: .alert)
        
        addTodoAlert.addTextField(configurationHandler: nil)
        addTodoAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { al in
            let todoString = addTodoAlert.textFields![0].text
            if !(todoString!.isEmpty) {
                self.todoListViewModel.addTodo(withTodo: todoString!)
            }
        }))
        
        addTodoAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(addTodoAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
