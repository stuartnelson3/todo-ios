//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by Stuart Nelson on 7/29/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import "ToDoItem.h"
#import "ToDoListTableViewController.h"
#import "AddToDoItemViewController.h"

@interface ToDoListTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation ToDoListTableViewController

- (void)loadInitialData {
    NSDate *date = [NSDate date];
    ToDoItem *item1 = [[ToDoItem alloc] initWithText: @"Buy milk"];
    item1.dueDate = date;
    ToDoItem *item2 = [[ToDoItem alloc] initWithText: @"Learn German"];
    int daysToAdd = 1;
    item2.dueDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
    ToDoItem *item3 = [[ToDoItem alloc] initWithText: @"Become a mobile dev" ];
    daysToAdd = 4;
    item3.dueDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    [self.toDoItems addObject:item1];
    [self.toDoItems addObject:item2];
    [self.toDoItems addObject:item3];
}

- (IBAction)unwindTodoList:(UIStoryboardSegue*)seque {
    AddToDoItemViewController *source = [seque sourceViewController];
    ToDoItem *item = source.toDoItem;
    
    if (item == nil) {
        return;
    }
    
    [self.toDoItems addObject:item];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toDoItems = [[NSMutableArray alloc] init];
    
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.toDoItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];

    ToDoItem *item = [self.toDoItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.itemName;
    
    if (item.dueDate) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        NSString *dateString = [dateFormat stringFromDate:item.dueDate];
        
        NSDate *today = [NSDate date];
        
        // Find today's day of the month and the due day's day of the month. A to-do could be within
        // 24 hours of the due date, but still separated by calendar date.
        NSInteger todayDay = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:today] day];
        NSInteger itemDay = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:item.dueDate] day];

        NSTimeInterval seconds = [item.dueDate timeIntervalSinceDate: today];
        int days = (int)seconds / (60*60*24);
        
        if (days < 1 && (todayDay == itemDay)) {
            dateString = [dateString stringByAppendingString:@" (Due today)"];
        } else if (days < 2) {
            dateString = [dateString stringByAppendingString:@" (Due tomorrow)"];
        } else {
            NSString *daysLeft = [NSString stringWithFormat:@" (in %d days)", days];
            dateString = [dateString stringByAppendingString:daysLeft];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", item.itemName, dateString];
    }


    cell.accessoryType = UITableViewCellAccessoryNone;
    if (item.isCompleted) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.isCompleted = !tappedItem.isCompleted;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
