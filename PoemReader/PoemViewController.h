//
//  PoemViewController.h
//  PoemReader
//
//  Created by DuongNArtist on 1/27/16.
//  Copyright © 2016 DuongNArtist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoemViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblPoemList;

@end
