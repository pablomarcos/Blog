//
//  Mascota.m
//  SearchBar
//
//  Created by Pablo on 13/03/14.
//  Copyright (c) 2014 Pablo Marcos. All rights reserved.
//

#import "Mascota.h"

@implementation Mascota

-(id) init
{
    if (self = [super init])
    {
        //constructor code
        _nombre = [[NSString alloc] init];
        _especie = [[NSString alloc] init];
    }
    return self;
}

@end
