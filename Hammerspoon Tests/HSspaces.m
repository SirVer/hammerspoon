//
//  HSspaces.m
//  Hammerspoon
//

#import "HSTestCase.h"

@interface HSspaces : HSTestCase

@end

@implementation HSspaces

- (void)setUp {
    [super setUpWithRequire:@"test_spaces"];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMissionControlGroupInDock {
    RUN_LUA_TEST()
}

- (void)testMissionControlGroupInWindowManager {
    RUN_LUA_TEST()
}

- (void)testMissionControlGroupNotPopulated {
    RUN_LUA_TEST()
}

- (void)testMissionControlGroupClosed {
    RUN_LUA_TEST()
}

@end
