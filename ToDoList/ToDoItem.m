//
//  ToDoItem.m
//  ToDoList
//
//  Created by Stuart Nelson on 7/30/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import "ToDoItem.h"

@interface ToDoItem ()

@property (nonatomic) NSDate *creationDate;

@end

@implementation ToDoItem

- (ToDoItem *)initWithText:(NSString *)text {
    self.itemName = text;
    self.isCompleted = NO;
    self.creationDate = [NSDate date];
    return self;
}

@end
