//
//  CallingUITests.swift
//  CallingUITests
//
//  Created by Xuan Yin on 1/29/18.
//  Copyright © 2018 Shawn. All rights reserved.
//

import XCTest

class CallingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
//        let app = XCUIApplication()
//        app.buttons["Make a phone call"].tap()
//
//        let closeButton = app.buttons["close"]
//        closeButton.tap()
//
//        let clearTextSearchField = app.searchFields.containing(.button, identifier:"Clear text").element
//        clearTextSearchField.tap()
//        clearTextSearchField.typeText("hil")
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hilton Garden Inn Cupertino"]/*[[".cells.staticTexts[\"Hilton Garden Inn Cupertino\"]",".staticTexts[\"Hilton Garden Inn Cupertino\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        closeButton.tap()
        
        let app = XCUIApplication()
        app.otherElements.containing(.table, identifier:"Empty list").children(matching: .other).element.children(matching: .searchField).element.tap()
        let clearTextSearchField = app.searchFields.element
        clearTextSearchField.tap()
        clearTextSearchField.typeText("hil")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hilton Garden Inn Cupertino"]/*[[".cells.staticTexts[\"Hilton Garden Inn Cupertino\"]",".staticTexts[\"Hilton Garden Inn Cupertino\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Make a phone call"].tap()
        let closeButton = app.buttons["close"]
        closeButton.tap()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
