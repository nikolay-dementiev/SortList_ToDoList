//
//  ToDoCollectionView.swift
//  SortList
//
//  Created by mc373 on 07.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoListCollectionViewDelegate {
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel)
    func setCurentItemTextLabel (item: ToDoItem)
}

class ToDoCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate,ToDoItemCollectionViewCellDelegate{

    var toDoItems: [ToDoItem] = [] {
        didSet {
            self.reloadData()
        }
    }
    var toDoListDelegate: ToDoListCollectionViewDelegate?
    var updateListWithAnimation:Bool = true
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //first Nib: Cell like Collection
        let nib1 = UINib(nibName: "ToDoItemCollectionViewCell", bundle: nil)
        self.registerNib(nib1, forCellWithReuseIdentifier: ProductsGridFlowLayout.iDOfInstanse)
//        self.backgroundColor = UIColor.brownColor() //TEST !!!!

        //second Nib: Cell like Cell
        let nib2 = UINib(nibName: "ToDoItemCollectionViewCellLikeCell", bundle: nil)
        self.registerNib(nib2, forCellWithReuseIdentifier: ProductsListFlowLayout.iDOfInstanse)
        
        self.dataSource = self
        self.delegate   = self
    }

    
    //MARK: UICollectionViewDataSource func
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoItems.count
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cellIstanceName = getCellIstanceNameFromCollectionViewLayout(collectionView)
        
        let cell = self.dequeueReusableCellWithReuseIdentifier(cellIstanceName, forIndexPath: indexPath) as? ToDoItemCollectionViewCell
        
        cell?.delegate = self
        
        return cell!
    }
    
    func getCellIstanceNameFromCollectionViewLayout(collectionView:UICollectionView)  -> String {
        var cellIstanceName:String = ""
        
        if let tempCellIstanceName:String = collectionView.collectionViewLayout.iDOfInstanse {
            cellIstanceName = tempCellIstanceName
        } else {
            cellIstanceName = ""
        }
        
        return cellIstanceName
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let toDoItemCell = cell as! ToDoItemCollectionViewCell
        let toDoItem = toDoItems[indexPath.row]
        
        toDoItemCell.toDoItemElem = toDoItem
        
        if updateListWithAnimation {
            //CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformWave, andDuration: 1)
            CellAnimator.animateCell(cell)
            
//            //Disable animation
//            if indexPath.row == toDoItems.count-1 {
//                updateListWithAnimation = false
//            }
        }

    }
    
    //MARK: ToDoItemCollectionViewCellDelegate functions
    func didTouchMoreButton(cell: UICollectionViewCell?) {
        if (cell != nil) {
            let toDoItem       = (cell as! ToDoItemCollectionViewCell).toDoItemElem
            let itemLabelView  = (cell as! ToDoItemCollectionViewCell).itemLabelView as UILabel
            
            toDoListDelegate?.didTouchMoreButtonForController(item: toDoItem, itemLabel: itemLabelView)
        }
    }
}
