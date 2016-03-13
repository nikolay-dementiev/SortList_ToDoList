//
//  ButtonActionSheetCellController.swift
//  SortList
//
//  Created by mc373 on 05.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoItemActionSheetControlDelegate: class {
    func didChangeAction()
}

class ToDoItemActionSheetControl : UIAlertController {

    weak var delegate: ToDoItemActionSheetControlDelegate?
    
    var toDoItem: ToDoItem = ToDoItem.insertNewObjectIntoContext(CoreDataManager.sharedInstance.managedObjectContext) as! ToDoItem {
        didSet {
            initButtons()
        }
    }
    
    internal func initButtons() {
        let itemChecked = toDoItem.checked as! Bool
        
        let buttonArchive = UIAlertAction(title: "Archive", style: UIAlertActionStyle.Default) {
            (ACTION) in
            print("Archive button tapped")
        }
        let buttonDelete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) {
            (ACTION) in
            print("Delete button tapped")
        }
        
        let titleChekenUnCheked: String = (itemChecked ? "Un check" : "Check")
        let buttonCheck = UIAlertAction (title: titleChekenUnCheked, style: UIAlertActionStyle.Default) {
            (ACTION) in
            print("\(titleChekenUnCheked) button tapped")
            //        ButtonPressedDelegate?.CheckButtonFromActionSheetCellItemsPressed()

            self.toDoItem.checked = !itemChecked
            self.delegate?.didChangeAction()
        }
        
        let buttonAllItems = UIAlertAction (title: "All items", style: UIAlertActionStyle.Default) {
            (ACTION) in
            print("All items button tapped")
        }
        let buttonRemind = UIAlertAction (title: "Remind", style: UIAlertActionStyle.Default) {
            (ACTION) in
            print("All items button tapped")
            
        }
        let buttonBlock = UIAlertAction (title: "Block", style: UIAlertActionStyle.Default) {
            (ACTION) in
            print("Block button tapped")
        }
        let buttonCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            (ACTION) in
            print("Cancel button tapped")
        }
        
        self.addAction(buttonArchive)
        self.addAction(buttonDelete)
        self.addAction(buttonCheck)
        self.addAction(buttonAllItems)
        self.addAction(buttonRemind)
        self.addAction(buttonBlock)
        self.addAction(buttonCancel)
    }
}