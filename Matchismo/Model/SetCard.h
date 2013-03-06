//
//  SetCard.h
//  Matchismo
//
//  Created by Cary on 3/6/13.
//  Copyright (c) 2013 Ratatosk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSInteger number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSNumber *shading;

+(NSArray *)validShadings;
+(NSUInteger)maxNumber;
+(NSArray *)validColors;
+(NSArray *)validSymbols;

@end
