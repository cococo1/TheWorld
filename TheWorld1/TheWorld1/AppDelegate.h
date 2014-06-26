//
//  AppDelegate.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/25/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

//Resolve time freezing
//Make actions separated by domain... or may be not?
//Scroll programmatically & zoom programmatically to your country - or other
//First think about objects, then group them into classes;
//Make the hierarchy of CONCEPTS, not OBJECTS;
//The classifying criterias shouldn't be too specific or too general;
//When there are some properties which describe big differences, define two classes;
//If a class has just one descendant, it's nonsense;
//The class is a data type which is defined by it's interface;
//Object's interface lies in its methods, not data, thus begin the design process by thinking about what a system component must do, not how it represents the data;
//Reuse is achieved through composition;
