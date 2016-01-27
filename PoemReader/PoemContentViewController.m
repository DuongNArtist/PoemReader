//
//  PoemContentViewController.m
//  PoemReader
//
//  Created by DuongNArtist on 1/28/16.
//  Copyright © 2016 DuongNArtist. All rights reserved.
//

#import "PoemContentViewController.h"

@interface PoemContentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtBody;

@end

@implementation PoemContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.poemObject.title;
    self.txtBody.text = self.poemObject.body;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
