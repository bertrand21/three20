/**
 * Copyright 2009 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// See: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/905-A-Unit-Test_Result_Macro_Reference/unit-test_results.html#//apple_ref/doc/uid/TP40007959-CH21-SW2
// for unit test macros.

#import "CoreGlobalTests.h"

#import "Three20/Three20.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation CoreGlobalTests


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)testSuccess {
  // This is just a test to ensure that you're building the unit tests properly.
  STAssertTrue(YES, @"Something is terribly, terribly wrong.");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Non Retaining Objects


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)testNonRetainingArray {
  NSMutableArray* array = TTCreateNonRetainingArray();
  id testObject = [[NSArray alloc] init];

  STAssertTrue([testObject retainCount] == 1, @"Improper initial retain count");

  [array addObject:testObject];
  STAssertTrue([testObject retainCount] == 1, @"Improper new retain count");

  TT_RELEASE_SAFELY(array);
  STAssertTrue([testObject retainCount] == 1, @"Improper retain count after release");

  TT_RELEASE_SAFELY(testObject);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)testNonRetainingDictionary {
  NSMutableDictionary* dictionary = TTCreateNonRetainingDictionary();
  id testObject = [[NSArray alloc] init];

  STAssertTrue([testObject retainCount] == 1, @"Improper initial retain count");

  [dictionary setObject:testObject forKey:@"obj"];
  STAssertTrue([testObject retainCount] == 1, @"Improper new retain count");

  TT_RELEASE_SAFELY(dictionary);
  STAssertTrue([testObject retainCount] == 1, @"Improper retain count after release");

  TT_RELEASE_SAFELY(testObject);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Empty Objects


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)testIsArrayWithItems {
  STAssertTrue(!TTIsArrayWithItems(nil), @"nil should not be an array with items.");

  NSMutableArray* array = [[NSMutableArray alloc] init];

  STAssertTrue(!TTIsArrayWithItems(array), @"This array should not have any items.");

  NSDictionary* dictionary = [[NSDictionary alloc] init];
  STAssertTrue(!TTIsArrayWithItems(dictionary), @"This is not an array.");

  [array addObject:dictionary];
  STAssertTrue(TTIsArrayWithItems(array), @"This array should have items.");

  TT_RELEASE_SAFELY(array);
  TT_RELEASE_SAFELY(dictionary);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)testIsEmptySet {
  STAssertTrue(!TTIsSetWithItems(nil), @"nil should not be a set with items.");

  NSMutableSet* set = [[NSMutableSet alloc] init];

  STAssertTrue(!TTIsSetWithItems(set), @"This set should not have any items.");

  NSDictionary* dictionary = [[NSDictionary alloc] init];
  STAssertTrue(!TTIsSetWithItems(dictionary), @"This is not an set.");

  [set addObject:dictionary];
  STAssertTrue(TTIsSetWithItems(set), @"This set should have items.");

  TT_RELEASE_SAFELY(set);
  TT_RELEASE_SAFELY(dictionary);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)testIsEmptyString {
  STAssertTrue(!TTIsStringWithAnyText(nil), @"nil should not be a string with any text.");

  NSString* string = [[NSString alloc] init];

  STAssertTrue(!TTIsStringWithAnyText(string), @"This should be an empty string.");

  NSDictionary* dictionary = [[NSDictionary alloc] init];
  STAssertTrue(!TTIsStringWithAnyText(dictionary), @"This is not a string.");

  STAssertTrue(!TTIsStringWithAnyText(@""), @"This should be an empty string.");
  STAssertTrue(TTIsStringWithAnyText(@"three20"), @"This should be a string with text.");

  TT_RELEASE_SAFELY(string);
  TT_RELEASE_SAFELY(dictionary);
}


@end