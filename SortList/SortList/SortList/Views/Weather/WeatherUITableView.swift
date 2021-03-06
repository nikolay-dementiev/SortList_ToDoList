//
//  WeatherUITableView.swift
//  SortList
//
//  Created by mc373 on 23.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class WeatherUITableView: UITableView, UITableViewDataSource, UITableViewDelegate {

	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
	// Drawing code
	}
	*/

	var weatherItems: [WeatherItem] = [] {
		didSet {
			self.reloadData()
		}
	}

	let defaultNameOfDictClassWeather = WeatherItem.elementDictOfClass
	let arrayOfNameOfDictClassWeather = [String](WeatherItem.elementDictOfClass.keys)

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		self.dataSource = self
		self.delegate = self
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayOfNameOfDictClassWeather.count
	}

	func tableView(tableView: UITableView,
	               cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		// swiftlint:disable:next line_length
		let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as? WeatherItemsTableViewCell

		return cell!
	}

	// MARK: UITableView delegate

	func tableView(tableView: UITableView,
	               willDisplayCell cell: UITableViewCell,
	                               forRowAtIndexPath indexPath: NSIndexPath) {

		let weatherItemCell = (cell as? WeatherItemsTableViewCell)!
		// swiftlint:disable:next line_length
		// let weatherItem = weatherItems[indexPath.row] // for case, where 1 cell = 1 record in CoreData, not our event!

		if let nameOfElWeather = arrayOfNameOfDictClassWeather[indexPath.row] as String! {
			if let valueOfElWeather = defaultNameOfDictClassWeather[nameOfElWeather] {

				if weatherItems.count > 0 {
					weatherItemCell.strctD = ElementDictStructure(name: nameOfElWeather,
					                                              description: valueOfElWeather)
					// swiftlint:disable:next line_length
					let weatherItem = weatherItems[0]// getting always first element in CoreData! There always only one elemement present
					weatherItemCell.weatherItem = weatherItem
				}
			}

		}
	}

}
