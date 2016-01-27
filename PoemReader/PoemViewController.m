//
//  PoemViewController.m
//  PoemReader
//
//  Created by DuongNArtist on 1/27/16.
//  Copyright © 2016 DuongNArtist. All rights reserved.
//

#import "PoemViewController.h"
#import "PoemObject.h"
#import "PoemContentViewController.h"

@interface PoemViewController () {
    NSMutableArray<PoemObject *> *poemList;
}
@end

@implementation PoemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    poemList = [[NSMutableArray<PoemObject *> alloc] init];
    [self loadPoemData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [poemList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"PoemItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [poemList objectAtIndex:indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemContentViewController *contentVC = [[PoemContentViewController alloc]initWithNibName:@"PoemContentViewController" bundle:nil];
    PoemObject *poemObject = [poemList objectAtIndex:indexPath.row];
    contentVC.poemObject = poemObject;
    [self.navigationController pushViewController:contentVC animated:YES];
}

-(void) loadPoemData {
    NSString* name = @"poems";
    NSString* path = [[NSBundle mainBundle]
                          pathForResource:name ofType:@"txt"];
    NSString* content =
    [NSString stringWithContentsOfFile:path
                              encoding:NSUTF8StringEncoding error:nil];
    NSArray* lines =
    [content componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    NSCharacterSet *lowercase = [NSCharacterSet lowercaseLetterCharacterSet];
    NSCharacterSet *punctuation = [NSCharacterSet punctuationCharacterSet];
    NSMutableArray *indexes = [[NSMutableArray alloc]init];
    for (int index = 0; index < [lines count]; index++) {
        NSString *line = [lines objectAtIndex:index];
        NSScanner *scanner = [NSScanner scannerWithString:line];
        BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
        BOOL titleRule0 = [line rangeOfCharacterFromSet:lowercase].location == NSNotFound;
        BOOL titleRule1 = [line rangeOfCharacterFromSet:punctuation].location == NSNotFound;
        BOOL titleRule2 = !isNumeric;
        BOOL titleRule3 = [[line stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0;
        if (titleRule0 && titleRule1 && titleRule2 && titleRule3) {
            [indexes addObject:[NSNumber numberWithInt:index]];
            PoemObject *poem = [[PoemObject alloc] init];
            poem.title = line;
            [poemList addObject:poem];
        }
    }
    [indexes addObject:[NSNumber numberWithInt:[lines count]]];
    for (int index = 0; index < [indexes count] - 1; index++) {
        PoemObject *poem = [poemList objectAtIndex:index];
        NSMutableString *body = [[NSMutableString alloc]init];
        int start = [[indexes objectAtIndex:index] integerValue] + 1;
        int end = [[indexes objectAtIndex:index + 1]integerValue];
        for (int i = start; i < end; i++) {
            [body appendString:[lines objectAtIndex:i]];
            [body appendString:@"\n"];
        }
        poem.body = body;
    }
    [self.tblPoemList reloadData];
    self.title = [NSString stringWithFormat:@"Danh sách thơ (%d bài)", [poemList count]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
