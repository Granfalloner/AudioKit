//
//  OCSGuiro.m
//  Objective-C Sound
//
//  Created by Aurelius Prochazka on 10/28/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//
//  Implementation of Csound's guiro:
//  http://www.csounds.com/manual/html/guiro.html
//

#import "OCSGuiro.h"

@interface OCSGuiro () {
    OCSConstant *idettack;
    OCSControl *kamp;
    OCSConstant *inum;
    OCSConstant *imaxshake;
    OCSConstant *ifreq;
}
@end

@implementation OCSGuiro

- (id)initWithDuration:(OCSConstant *)duration
             amplitude:(OCSControl *)amplitude
{
    self = [super initWithString:[self operationName]];
    if (self) {
        idettack = duration;
        kamp = amplitude;
        
        inum = ocsp(128);
        imaxshake = ocsp(0);
        ifreq = ocsp(2500);
        
        
    }
    return self;
}


- (void)setCount:(OCSConstant *)count {
	inum = count;
}

- (void)setEnergyReturn:(OCSConstant *)energyReturn {
	imaxshake = energyReturn;
}

- (void)setMainResonantFrequency:(OCSConstant *)mainResonantFrequency {
	ifreq = mainResonantFrequency;
}

- (NSString *)stringForCSD {
    return [NSString stringWithFormat:
            @"%@ guiro %@, %@, %@, %@, %@",
            self, kamp, idettack, inum, idamp, imaxshake, ifreq, ifreq1];
}

@end