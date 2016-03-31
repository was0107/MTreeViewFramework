//
//  TestTreeViewUITests.m
//  TestTreeViewUITests
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import <XCTest/XCTest.h>



@interface TestTreeViewUITests : XCTestCase
@property (nonatomic , strong) XCUIApplication *app ;
@end

@implementation TestTreeViewUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTest {
    
//    XCUIElementQuery *tablesQuery = self.app.tables;
//
//    [tablesQuery.staticTexts[@"自测项目"] tap];
//    
//    [[tablesQuery childrenMatchingType:XCUIElementTypeStaticText][@"0级类目：0"] tap];
//    
//    [[tablesQuery childrenMatchingType:XCUIElementTypeStaticText][@" 0级类目：1"] tap];
//    
//    [[tablesQuery childrenMatchingType:XCUIElementTypeStaticText][@" 0级类目：2"] tap];
//    
//    [[tablesQuery childrenMatchingType:XCUIElementTypeStaticText][@" 0级类目：0"] tap];
//    
//    [[tablesQuery childrenMatchingType:XCUIElementTypeStaticText][@" 1级类目：2"] tap];
//    
//    [[tablesQuery childrenMatchingType:XCUIElementTypeStaticText][@" 1级类目：7"] tap];

}

@end
