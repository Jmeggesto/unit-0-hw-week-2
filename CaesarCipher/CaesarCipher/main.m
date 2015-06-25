//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject

- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;
- (BOOL)isCodedString:(NSString *)string1 equalToOtherCodedString:(NSString *)string2;

@end


@implementation CaesarCipher

- (BOOL)isCodedString:(NSString *)string1 equalToOtherCodedString:(NSString *)string2 {
    
    for (int i = 1; i <= 25; i ++) {
        for (int j = 1; j <= 25; j ++) {
            if ([[self decode:string1 offset:i]isEqualToString:[self decode:string2 offset:j]]) {
                return YES;
            }
        }
    }
    return 0;
}
- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);

        result[i] = allchars[new_idx];
    }

    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CaesarCipher *myCipher = [[CaesarCipher alloc]init];
        NSString *myTest1 = [myCipher encode:@"natalia" offset:5];
        NSString *myTest2 = [myCipher encode:@"nataliy" offset:12];
        NSLog(@"%d", [myCipher isCodedString:myTest1 equalToOtherCodedString:myTest2]);
        
        
    }
    return 0;
}
