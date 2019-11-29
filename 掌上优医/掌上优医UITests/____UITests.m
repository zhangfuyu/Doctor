//___FILEHEADER___

#import <XCTest/XCTest.h>

@interface ___FILEBASENAMEASIDENTIFIER___ : XCTestCase

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app.tabBars.buttons[@"病友圈"] tap];
//    
//    XCUIElementQuery *tablesQuery = app.tables.cells.tables;
//    [[[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"咯巨魔王头陀"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] swipeUp];
//    [[[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"商城运行后台"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] swipeUp];
//    [app.navigationBars[@"帖子详情"].buttons[@"ic zhaoyisheng back"] tap];
//    [[[[tablesQuery.cells containingType:XCUIElementTypeButton identifier:@"6"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] swipeUp];
//    
//    XCUIElement *button = [[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"文文静静大家舍不得你等你方便"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
//    [button swipeRight];
//    [button swipeUp];
//    [[[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"怎样减肥？"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] swipeRight];
//    [[[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"哈哈"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] swipeRight];
//    
//    XCUIElement *button2 = [[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"再次测试"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
//    [button2 swipeRight];
//    [button2 swipeDown];

    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
