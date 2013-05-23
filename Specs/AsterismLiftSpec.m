//
//  AsterismLiftSpec.m
//  Asterism
//
//  Created by Robert Böhnke on 5/23/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "LiftTestClassA.h"
#import "LiftTestClassB.h"

#import "AsterismLift.h"

SpecBegin(AsterismLift)

describe(@"lift_noargs", ^{
    it(@"should return a block that takes one arguments", ^{
        id (^block)(id) = lift_noargs(description);

        expect(block).notTo.beNil();
    });
});

describe(@"lift", ^{
    it(@"should return a block that takes one argument more than selector components are passed to it", ^{
        id (^block)(id, id) = lift(stringByAppendingString:);

        expect(block).notTo.beNil();
    });
});

describe(@"Calling a block", ^{
    describe(@"without additional arguments", ^{
        id (^block)(id) = lift_noargs(uppercaseString);

        it(@"should invoke the selector on the object", ^{
            expect(block(@"foo")).to.equal(@"FOO");
        });
    });

    describe(@"with additional arguments", ^{
        it(@"should use pass all additional arguments to the method", ^{
             id (^block)(id, id) = lift(stringByAppendingString:);

            expect(block(@"foo", @"bar")).to.equal(@"foobar");
        });

        it(@"should automatically unbox NSValue arguments", ^{
            id (^block)(id, id) = lift(substringToIndex:);

            expect(block(@"abcdef", @3)).to.equal(@"abc");
        });
    });

    it(@"should automatically box return values", ^{
        id (^block)(id, id) = lift(rangeOfString:);

        NSValue *result = block(@"abcdef", @"bcd");

        NSRange range = [result rangeValue];

        expect(range.location).to.equal(1);
        expect(range.length).to.equal(3);
    });

    it(@"should raise an exception if the object does not implement the method", ^{
        id (^block)(id) = lift_noargs(uppercaseString);

        expect(^{
            block(@1);
        }).to.raise(NSInternalInconsistencyException);
    });

    describe(@"on objects with diffent method signatures for the selector", ^{
        it(@"should work", ^{
            id a = [[LiftTestClassA alloc] init];
            id b = [[LiftTestClassB alloc] init];

            id (^block)(id, id) = lift(test:);

            expect(block(a, @2)).to.equal(@-2);
            expect(block(b, @2)).to.equal(@"success");
        });
    });
});

SpecEnd
