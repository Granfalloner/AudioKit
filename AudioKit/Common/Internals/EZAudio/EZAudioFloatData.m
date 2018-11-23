//
//  EZAudioFloatData.m
//  EZAudio
//
//  Created by Syed Haris Ali, revision history on Githbub.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "EZAudioFloatData.h"
#import "EZAudioUtilities.h"

//------------------------------------------------------------------------------
#pragma mark - EZAudioFloatData
//------------------------------------------------------------------------------

@interface EZAudioFloatData ()
@property (nonatomic, assign, readwrite) int    numberOfChannels;
@property (nonatomic, assign, readwrite) float  **buffers;
@property (nonatomic, assign, readwrite) UInt32 bufferSize;
@property (nonatomic, assign, readwrite) BOOL freeWhenDone;
@end

//------------------------------------------------------------------------------

@implementation EZAudioFloatData

//------------------------------------------------------------------------------

- (void)dealloc
{
    if (self.freeWhenDone) {
        [EZAudioUtilities freeFloatBuffers:self.buffers
                          numberOfChannels:self.numberOfChannels];
    }
}

//------------------------------------------------------------------------------

+ (instancetype)dataWithNumberOfChannels:(int)numberOfChannels
                                 buffers:(float **)buffers
                              bufferSize:(UInt32)bufferSize
{
    return [self dataWithNumberOfChannels:numberOfChannels
                                  buffers:buffers
                               bufferSize:bufferSize
                                     copy:YES
                             freeWhenDone:YES];
}

+ (instancetype)dataWithNumberOfChannels:(int)numberOfChannels
                                 buffers:(float **)buffers
                              bufferSize:(UInt32)bufferSize
                                    copy:(BOOL)copy
                            freeWhenDone:(BOOL)freeWhenDone
{
    return [[self alloc] initWithNumberOfChannels:numberOfChannels
                                          buffers:buffers
                                       bufferSize:bufferSize
                                             copy:copy
                                     freeWhenDone:freeWhenDone];
}

- (instancetype)initWithNumberOfChannels:(int)numberOfChannels
                                 buffers:(float **)buffers
                              bufferSize:(UInt32)bufferSize
                                    copy:(BOOL)copy
                            freeWhenDone:(BOOL)freeWhenDone;
{
    if (self = [super init])
    {
        float **buffersCopy = buffers;
        if (copy)
        {
            size_t size = sizeof(float) * bufferSize;
            buffersCopy = [EZAudioUtilities floatBuffersWithNumberOfFrames:bufferSize
                                                          numberOfChannels:numberOfChannels];
            for (int i = 0; i < numberOfChannels; i++)
            {
                memcpy(buffersCopy[i], buffers[i], size);
            }
        }

        self.numberOfChannels = numberOfChannels;
        self.buffers = buffersCopy;
        self.bufferSize = bufferSize;
        self.freeWhenDone = freeWhenDone;
    }
    return self;
}

//------------------------------------------------------------------------------

- (float *)bufferForChannel:(int)channel
{
    float *buffer = NULL;
    if (channel < self.numberOfChannels)
    {
        buffer = self.buffers[channel];
    }
    return buffer;
}

//------------------------------------------------------------------------------

@end
