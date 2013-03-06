//
//  PlayingCard.m
//  Matchismo
//
//  Created by Cary on 2/14/13.
//  Copyright (c) 2013 Ratatosk. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@property (nonatomic, strong) NSArray *suitMatchScores;
@property (nonatomic, strong) NSArray *rankMatchScores;

@end

@implementation PlayingCard

@synthesize  suit = _suit;
//@synthesize  contents = _contents;

// Override Card match


-(NSArray *)suitMatchScores
{
    return @[[NSNumber numberWithInt:0],
             [NSNumber numberWithInt:1],
             [NSNumber numberWithInt:4]];
}

-(NSArray *)rankMatchScores
{
    return @[[NSNumber numberWithInt:0],
             [NSNumber numberWithInt:4],
             [NSNumber numberWithInt:100]];
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSLog(@"score %d", score);
    NSLog(@"Checking for matches against %@...", self.contents);
    if (otherCards.count > 0	 && otherCards.count <= self.suitMatchScores.count)
    {
        int suitMatches = 0;
        int rankMatches = 0;
        for (PlayingCard *ocard in otherCards)
        {
            NSLog(@"checking %@", ocard.contents);
            suitMatches += [ocard.suit isEqualToString:self.suit] ? 1 : 0;
            rankMatches += ocard.rank == self.rank ? 1 : 0;
            NSLog(@"suitMatches %d, rankMatches %d", suitMatches, rankMatches);
        }
        if (suitMatches == otherCards.count)
        {
            NSLog(@"sMS object at index %d is %@", suitMatches, [self.suitMatchScores objectAtIndex:rankMatches]);
            score = [[self.suitMatchScores objectAtIndex:suitMatches] intValue];
        }
        else if (rankMatches == otherCards.count)
        {
            NSLog(@"rMS object at index %d is %@", rankMatches, [self.rankMatchScores objectAtIndex:rankMatches]);
            score = [[self.rankMatchScores objectAtIndex:rankMatches] intValue];
        }
        NSLog(@"score %d", score);
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
             @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank] && rank > 0)
    {
        _rank = rank;
    }
}


@end
