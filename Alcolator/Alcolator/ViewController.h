//
//  ViewController.h
//  Alcolator
//
//  Created by Christopher Allen on 9/9/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong, nonatomic) NSString *originalNavTitle;

- (void)buttonPressed:(UIButton *)sender;
- (void)sliderValueDidChange:(UISlider *)sender;

@end

