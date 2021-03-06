//
//  HttpRequestWork.swift
//  SortList
//
//  Created by mc373 on 18.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit


class  HttpRequestWork {

	static func connectToWS(cityName: String? = "Kathmandu",
	                        // swiftlint:disable:next line_length
	                        callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {


		let urlPath     = getUrlPathUsingParametrs(cityName)
		let cortegeSR   = getSessionAndtRequestFromPath (urlPath)
		let session     = cortegeSR.session
		let request     = cortegeSR.request

		let task = session.dataTaskWithRequest(request) { data, response, error in
			callBack?(data: data, response: response, error: error)
		}
		//NSNotificationCenter.defaultCenter().postNotificationName(
		//						"updateWeatherTableFromAnotherModule",
		//						object: nil)
		task.resume()
	}

	private static func getUrlPathUsingParametrs (cityName: String?) -> String {
		let cityNameParam: String = cityName ?? ""
		// swiftlint:disable line_length
		let urlPath: String = GeneralPurposeParametres.weatherUrlString.replace(GeneralPurposeParametres.symbolOfCityNameForUrlString,
		                                                                        withString:"\(cityNameParam)")

		return urlPath
	}

	// swiftlint:disable:next line_length
	private static func getSessionAndtRequestFromPath (urlPath: String) -> (session: NSURLSession, request: NSURLRequest) {
		let url: NSURL = NSURL(string: urlPath)!
		let request: NSURLRequest = NSURLRequest(URL: url)
		let session = NSURLSession.sharedSession()

		return (session, request)
	}

}
