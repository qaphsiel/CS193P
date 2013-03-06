//
//  PlayingCard.h
//  Matchismo
//
//  Created by Cary on 2/14/13.
//  Copyright (c) 2013 Ratatosk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end

