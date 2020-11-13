//
//  GuidesTest.swift
//  modes-mobile-iosUITests
//
//  Created by Joseph Sortino on 11/1/20.
//

import XCTest

class GuidesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let app = XCUIApplication()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        app.tabBars["Tab Bar"].buttons["MilLife Guides"].tap()
        print(app.debugDescription)



        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testGuidesCategoriesCount() throws{
        
        //Check to see if there are at least 13 guide categories shown
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssert(count >= 13)
    }
    
    
    
    func testGuidesViewAll() throws{
        
        //Check to see if there are at least 21 individual guides shown
        let app = XCUIApplication()
        app.buttons["viewAll"].tap()
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssert(count >= 21)
        
    }
    
    
    func testGuidesContent() throws{
        
        //Check to see if there are at least 21 individual guides shown
        let app = XCUIApplication()
        app.buttons["viewAll"].tap()
        
        let detailTitle = app.staticTexts["detailTitle"]
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        XCTAssertEqual("Commissary & Exchanges", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()
        XCTAssertEqual("Connected and Strong During Deployment", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 2).tap()
        XCTAssertEqual("Education & Employment for Spouses", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        XCTAssertEqual("Families With Special Needs", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 4).tap()
        XCTAssertEqual("Fun and Fitness", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 5).tap()
        XCTAssertEqual("MilLife Learning & the MWR Digital Library", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 6).tap()
        XCTAssertEqual("Moving in the Military", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 7).tap()
        XCTAssertEqual("Navigating MilLife in the National Guard", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 8).tap()
        XCTAssertEqual("Navigating the Impact of COVID-19 on MilLife", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 9).tap()
        XCTAssertEqual("Non-medical Counseling", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()

        app.tables.element(boundBy: 0).cells.element(boundBy: 10).tap()
        XCTAssertEqual("OCONUS Moves", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 11).tap()
        XCTAssertEqual("Parenting & Child Care", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 12).tap()
        XCTAssertEqual("Personal Finance", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 13).tap()
        XCTAssertEqual("Preventing Abuse & Neglect", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 14).tap()
        XCTAssertEqual("Resources for a Smooth Transition", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 15).tap()
        XCTAssertEqual("Specialty Consultations", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 16).tap()
        XCTAssertEqual("Strengthening Relationships", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 17).tap()
        XCTAssertEqual("Support After Loss", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 18).tap()
        XCTAssertEqual("Survivor Finances & Legal", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 19).tap()
        XCTAssertEqual("Taking Advantage of Exclusive Offers", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 20).tap()
        XCTAssertEqual("Tickets, Tours & Travel", detailTitle.label)
        XCUIApplication().scrollViews.otherElements.buttons["Back"].tap()
    
    }
    
    
    
    func testRandomGuidesArticle() throws{
        
    
        let app = XCUIApplication()
        for _ in 1...10 {
        let guideNumber = Int.random(in: 0...20)
        let articleNumber = Int.random(in: 0...3)
        app.buttons["viewAll"].tap()
        let detailTitle = app.staticTexts["detailTitle"]
        app.tables.element(boundBy: 0).cells.element(boundBy: guideNumber).tap()
        app.tables.element(boundBy: 1).cells.element(boundBy: articleNumber).tap()
        let about = app.staticTexts["About Us"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: about, handler: nil)
        waitForExpectations(timeout: 7, handler: nil)
        XCTAssert(about.exists)
        XCTAssert(app.staticTexts["Connect with us"].exists)
        app.buttons["Back"].tap()
        app.scrollViews.otherElements.buttons["Back"].tap()
        }
        
    }
    
    /*
    
        func testGuidesList() throws {
            let app = XCUIApplication()
            app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
            
            let app = app2
            app.tabBars["Tab Bar"].buttons["MilLife Guides"].tap()
            
            let app2 = app
            app2/*@START_MENU_TOKEN@*/.staticTexts["View All"]/*[[".buttons[\"viewAll\"].staticTexts[\"View All\"]",".staticTexts[\"View All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app2/*@START_MENU_TOKEN@*/.tables.staticTexts["Commissary & Exchanges"]/*[[".otherElements[\"tableview\"].tables",".cells.staticTexts[\"Commissary & Exchanges\"]",".staticTexts[\"Commissary & Exchanges\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
            app.scrollViews.otherElements.staticTexts["The perks of shopping at a commissary or military exchange go far beyond tax-free shopping and discounted goods and services. Military OneSource highlights the many other benefits and perks, like scholastic rewards for military kids, employment advantages, content prizes and online shopping."].swipeUp()
            app2.scrollViews.otherElements.tables/*@START_MENU_TOKEN@*/.staticTexts["Commissary On-Site Sales"]/*[[".cells.staticTexts[\"Commissary On-Site Sales\"]",".staticTexts[\"Commissary On-Site Sales\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.buttons["Back"].tap()
            
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

 */


}

