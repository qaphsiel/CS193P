//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Cary on 2/22/13.
//  Copyright (c) 2013 Ratatosk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, strong) NSString *flipResult;
@property (nonatomic, assign) int numberOfCardsToMatch;

@end
