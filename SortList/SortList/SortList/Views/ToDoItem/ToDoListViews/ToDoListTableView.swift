//
//  ToDoListTableView.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoListTableViewDelegate {
	func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel)
	func setCurentItemTextLabel (item: ToDoItem)
}


class ToDoListTableView: UITableView, UITableViewDataSource,
UITableViewDelegate, ToDoItemTableViewCellDelegate {

	var toDoItems: [ToDoItem] = [] {
		didSet {
			self.reloadData()
		}
	}

	var updateListWithAnimation: Bool = false

	var toDoListDelegate: ToDoListTableViewDelegate?

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		self.registerClass(ToDoItemTableViewCell.self, forCellReuseIdentifier: "cell")

		self.dataSource = self
		self.delegate = self
	}


	// MARK: UITableView datasource

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return toDoItems.count
	}

	func tableView(tableView: UITableView,
	               cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// swiftlint:disable:next line_length
		var cell = self.dequeueReusableCellWithIdentifier("ToDoItemTableViewCell") as? ToDoItemTableViewCell

		if cell == nil {
			// Load the nib and assign an owner
			let topLevelObjects = NSBundle.mainBundle().loadNibNamed("ToDoItemTableViewCell",
			                                                         owner: self,
			                                                         options: nil)
			cell = topLevelObjects.first as? ToDoItemTableViewCell
		}

		cell?.delegate = self
		return cell!
	}

	//MARK: controll buttton
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	func tableView(tableView: UITableView,
	               commitEditingStyle editingStyle: UITableViewCellEditingStyle,
	                                  forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// Delete the row from the data source
			CoreDataUtil.deleteObject(ToDoItem.getEntityNameOfObject(), object: toDoItems[indexPath.row])
			toDoItems.removeAtIndex(indexPath.row)// relod data was writed in "didset" of this item var

			//tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class,
			//insert it into the array, and add a new row to the table view
		}
	}


	//MARK: moveRow
	// Override to support rearranging the table view.
	func tableView(tableView: UITableView,
	               moveRowAtIndexPath fromIndexPath: NSIndexPath,
	                                  toIndexPath: NSIndexPath) {
		// swiftlint:disable line_length
		//       let itemToMove = toDoItems[fromIndexPath.row]
		//        toDoItems.removeAtIndex(fromIndexPath.row)
		//        toDoItems.insert(itemToMove, atIndex: toIndexPath.row)

		//        let orderedSet: NSMutableOrderedSet = (routineToReorder?.mutableOrderedSetValueForKey("yourKeyValue"))!
		//
		//        orderedSet.exchangeObjectAtIndex(fromIndexPath.row, withObjectAtIndex: toIndexPath.row)
		//        CoreDataUtil.saveContext("ToDoItem")

		//!!!!  NEED to rewrite! see there: http://lattejed.com/a-simple-todo-app-in-swift
		// swiftlint:enable line_length
	}



	// Override to support conditional rearranging of the table view.
	func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the item to be re-orderable.
		return true
	}



	// MARK: UITableView delegate

	func tableView(tableView: UITableView,
	               willDisplayCell cell: UITableViewCell,
	                               forRowAtIndexPath indexPath: NSIndexPath) {
		// todo: check on version if not iOS7 then return
		if cell.respondsToSelector(Selector("setSeparatorInset:")) {
			cell.separatorInset = UIEdgeInsetsZero
		}

		if cell.respondsToSelector(Selector("setLayoutMargins:")) {
			cell.layoutMargins = UIEdgeInsetsZero
		}

		if cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")) {
			cell.preservesSuperviewLayoutMargins = false
		}

		let toDoItemCell = (cell as? ToDoItemTableViewCell)!
		let toDoItem = toDoItems[indexPath.row]

		//        toDoItemCell.itemLabelView.text = toDoItem.item
		toDoItemCell.toDoItemElem = toDoItem

		if updateListWithAnimation {
			//CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformWave, andDuration: 1)
			CellAnimator.animateCell(cell)

			//Disable animation
			if indexPath.row == toDoItems.count-1 {
				updateListWithAnimation = false
			}
		}
	}


	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let valueitemText = String(toDoItems[indexPath.row].item)
		print("selected row: \(indexPath.row), value: \(valueitemText)")

		//SelectedRowDelegate?.SetCurentItemTextLabel(item: valueitemText)
		toDoListDelegate?.setCurentItemTextLabel(toDoItems[indexPath.row] as ToDoItem)
	}

	// MARK: UITableViewCell delegate

	func didTouchMoreButton(cell: UITableViewCell?) {
		if cell != nil {
			let toDoItem       = (cell as? ToDoItemTableViewCell)!.toDoItemElem
			let itemLabelView  = (cell as? ToDoItemTableViewCell)!.itemLabelView as UILabel

			toDoListDelegate?.didTouchMoreButtonForController(item: toDoItem, itemLabel: itemLabelView)
		}
	}
}
