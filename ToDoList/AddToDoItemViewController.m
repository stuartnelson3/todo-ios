//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by Stuart Nelson on 7/29/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import "AddToDoItemViewController.h"

@interface AddToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *dueDate;
@property (weak, nonatomic) NSDate *actualDueDate;

@end

@implementation AddToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *today = [NSDate date];
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setMinimumDate:today];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // Toolbar displaying "done" above UIDatePicker.
    UIToolbar *doneBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [doneBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                target:nil
                                action:nil];
    [doneBar setItems: [NSArray arrayWithObjects:spacer2, [[UIBarButtonItem alloc]
                                                           initWithTitle:@"Done"
                                                           style:UIBarButtonItemStyleDone
                                                           target:self.dueDate
                                                           action:@selector(resignFirstResponder)], nil] animated:YES];
    
    [self.dueDate setInputAccessoryView:doneBar];
    
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dueDate setInputView:datePicker];
    
    // Set initial selection to tomorrow.
    datePicker.date = [today dateByAddingTimeInterval:60*60*24];
    [self dateTextField:nil];
    
    // Do any additional setup after loading the view.
}

-(void) dateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)self.dueDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    self.actualDueDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:self.actualDueDate];
    self.dueDate.text = dateString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton || self.textField.text.length == 0) {
        return;
    }
    
    self.toDoItem = [[ToDoItem alloc] initWithText:self.textField.text];
    if (self.dueDate.text.length > 0) {
        self.toDoItem.dueDate = self.actualDueDate;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
