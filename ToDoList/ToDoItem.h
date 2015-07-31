//
//  ToDoItem.h
//  ToDoList
//
//  Created by Stuart Nelson on 7/30/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject {
    NSDate *_completionDate;
}

@property NSString *itemName;
@property BOOL isCompleted;
@property (readonly) NSDate *creationDate;
@property NSDate *dueDate;

- (ToDoItem *)initWithText:(NSString *)text;
- (int)daysUntilDue;

@end
