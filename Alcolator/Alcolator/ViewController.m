//
//  ViewController.m
//  Alcolator
//
//  Created by Christopher Allen on 9/9/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString * enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
//    NSLog(@"slider value changed to %f", sender.value);
//    WORK HERE.  Objective: show slider value in navbar, eg 'Whiskey (12 shots)', or 'Wine (1 glass)'
    
//    repeating code you have in the button not great here.
//    is float to int equality done like this, 1.2 == 1?  if so I don't need the range.
//    could do the glass v glasses AND shot v shots all here, but to mimic the button I'll try overriding in the whiskey .m file, even if it's not DRY

    if (!self.originalNavTitle) {
        self.originalNavTitle = self.navigationItem.title;
    }
    
    NSString *glassOrGlasses;
    if (sender.value < 1.5) {
        glassOrGlasses = @"glass";
    } else {
        glassOrGlasses = @"glasses";
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ (%.0f %@)", self.originalNavTitle, sender.value, glassOrGlasses];
    
    [self.beerPercentTextField resignFirstResponder];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    // calculate how much alcohol in beers
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;

    // calculate equivalent amount of wine
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide to use "beer/beers" and "glass/glasses"
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text and display to label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}


@end
