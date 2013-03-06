//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Cary on 2/22/13.
//  Copyright (c) 2013 Ratatosk. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@end


@implementation CardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@synthesize numberOfCardsToMatch;

-(int)numberOfCardsToMatch
{
    if (!numberOfCardsToMatch)
        numberOfCardsToMatch = 2;
    return numberOfCardsToMatch;
}


-(void)setNumberOfCardsToMatch:(int)noctm
{
    if (noctm > 1 && noctm < 5)
    {
        numberOfCardsToMatch = noctm;
    }

}


-(NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (!card)
            {
                self = nil;
            }
            else
            {
                self.cards[i] = card;
            }
        }	
    }
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index
{
    if (index < self.cards.count)
    {
        return self.cards[index];
    }
    return nil;
}


-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsToMatch = [[NSMutableArray alloc] init];
    NSString *cardsToMatchContents = [[NSMutableString alloc] init];
    self.flipResult = [NSString stringWithFormat:@"Flipped up %@.", card.contents];
    int matchScore = 0;
    if (!card.isUnplayable)
    {	
        if (!card.isFaceUp) {
            self.score -= FLIP_COST;
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [cardsToMatch addObject:otherCard];
                    if (cardsToMatchContents.length)
                    {
                        cardsToMatchContents = [[NSString alloc] initWithFormat:@"%@,%@", cardsToMatchContents, otherCard.contents];
                    }
                    else
                    {
                        cardsToMatchContents = otherCard.contents;
                    }
                }
            }
            NSLog(@"%d == %d", cardsToMatch.count, self.numberOfCardsToMatch-1);

            if (cardsToMatch.count >= self.numberOfCardsToMatch - 1)
            {
                matchScore = [card match:cardsToMatch];
 
            
                if (matchScore)
                {
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in cardsToMatch)
                    {
                        otherCard.unplayable = YES;
                        //cardsToMatchList = [NSString a]
                    }
                    
                    self.flipResult = [NSString stringWithFormat:@"Matched %@ with [%@] for %d points.", card.contents, cardsToMatchContents, matchScore * MATCH_BONUS];
                    
                }
                else if (cardsToMatch.count)
                {
                    self.score -= MISMATCH_PENALTY;
                    self.flipResult = [NSString stringWithFormat:@"%@ didn't match [%@] for penalty of %d.", card.contents, cardsToMatchContents, MISMATCH_PENALTY];
                }
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
