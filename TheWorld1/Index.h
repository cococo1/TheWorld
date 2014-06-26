//
//  Index.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/26/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//
//This is a country characteristics

#import <Foundation/Foundation.h>

#define VALUE_MAX 141 
#define INITIAL_VALUE 70

@interface Index : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic) double importance;
@property (nonatomic) double value;
//TO DO HERE: instead of NSArray make a dictionary.
@property (nonatomic, strong) NSMutableDictionary *subindices;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, getter = isPositive) BOOL positive;


-(void) orderSimilarRanks;



-(id) initWithName:(NSString*)name
        importance:(double) importance
      initialValue:(double) value;

@end
