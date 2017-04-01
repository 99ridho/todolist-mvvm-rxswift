//
//  TodoListViewModelTests.swift
//  Todolist-MVVM
//
//  Created by Muhammad Ridho on 4/1/17.
//  Copyright © 2017 Foo Bar. All rights reserved.
//

import XCTest
@testable import Todolist_MVVM

class TodoListViewModelTests: XCTestCase {
    
    var vm: TodoListViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        vm = TodoListViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        vm = nil
    }
    
    func testAddTwoTodos() {
        let oldCount = vm.getTodos().value.count
        
        vm.addTodo(withTodo: "test")
        vm.addTodo(withTodo: "test123")
        
        print("TODOS : ", vm.getTodos().value)
        XCTAssert(vm.getTodos().value.count == oldCount + 2)
    }
//
    
    func testToggleTodo() {
        let isCompleted = vm.getTodos().value[0].isCompleted
        vm.toggleTodoIsCompleted(withId: 0)
        XCTAssert(vm.getTodos().value[0].isCompleted == !isCompleted)
    }
    
    func testPrintTodos() {
        print("TODOS : ", vm.getTodos().value)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
