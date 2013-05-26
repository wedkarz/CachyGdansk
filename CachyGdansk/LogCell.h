//
//  LogCell.h
//  CachyGdansk
//
//  Created by Artur Rybak on 5/19/13.
//  Copyright (c) 2013 Kainos Software Polska. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foundImage;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@end
