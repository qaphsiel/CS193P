//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Cary on 2/14/13.
//  Copyright (c) 2013 Ratatosk. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;

@end

	
@implementation CardGameViewController


- (IBAction)dealButton:(id)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
//    self.scoreLabel.text = @"Score: 0";
//    self.lastMoveLabel.text = @"Last move: <none>";
    self.flipCount = 0;
    [self updateUI];
}


-(CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}


- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"%d flips", self.flipCount];
}


- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}


-(void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.4 : 1.0;
        if (!card.isFaceUp)
        {
            [cardButton setBackgroundImage:cardBackImage forState:UIControlStateNormal];
        }
        else
        {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }

    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
    [self.lastMoveLabel setText:[NSString stringWithFormat:@"Last move: %@", self.game.flipResult ? self.game.flipResult : @"<none>"]];
}

// /////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
