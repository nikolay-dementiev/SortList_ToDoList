//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate, DataEnteredDelegate, SelectedRowWhitIndexDelegate { //,UITableViewController

    var toDoItems: [ToDoItem] = []
    //var newItem: String = ""
    var recivedFromMainListValue: String = ""
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetailViewController" {
            let detailViewController = segue.destinationViewController as! DetailViewControllerProtocol
            detailViewController.detailDelegate = self
            
            // set a variable in the second view controller with the String to pass
            detailViewController.receivedString = recivedFromMainListValue
            
        }
        
    }
    
    func userDidEnterInformation(info: String) {
//        let item3_testSearch: ToDoItem = ToDoItem(item: info, checked: true)
//        let ddddd = toDoItems.indexOf{$0 === item3_testSearch}
        
//        var filteredItems = toDoItems.filter({(item : ToDoItem) -> Bool in
//            return item.lowercaseString.containsString(recivedFromMainListValue.lowercaseString)
//        })
        
        
        toDoItems.append(ToDoItem.init(item: info, checked: false))
    }
    
    
    func SetCurentItemTextLabel (item itemText: String) {
        recivedFromMainListValue = itemText
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true)
        let toDoItem2 = ToDoItem.init(item: "Value 2", checked: false)
        let toDoItem3 = ToDoItem.init(item: "Value 3", checked: true)
        
        toDoItems.append(toDoItem1)
        toDoItems.append(toDoItem2)
        toDoItems.append(toDoItem3)
        
        toDoListTableView.toDoListDelegate = self;
       
        toDoListTableView.SelectedRowDelegate = self
       // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        toDoListTableView.toDoItems = toDoItems
        toDoListTableView.reloadData()
        
    }
    
    //MARK: delegate Button Click
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?) {
        if (toDoItem != nil) {
            let myActionSheet = ButtonActionSheetCellItems(toDoItem?.item) as UIAlertController!
            self.presentViewController(myActionSheet, animated: true, completion: nil)
        }
    }

    
    @IBAction func editButtonTouched(sender: AnyObject) {
        toDoListTableView.setEditing(toDoListTableView.editing ? false : true, animated: true)
       //toDoListTableView.Mov

        
    }
    
    /*
    @IBAction func cancel(segue:UIStoryboardSegue) {
    
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
    let itemDetailVC = segue.sourceViewController as! DetailViewController
    newItem = itemDetailVC.labelText
    
    toDoItems.append(ToDoItem.init(item: newItem, checked: false))
    }
    */
    
}

