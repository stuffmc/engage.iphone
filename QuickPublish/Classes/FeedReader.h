/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 Copyright (c) 2010, Janrain, Inc.
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
 * Redistributions in binary form must reproduce the above copyright notice, 
   this list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution. 
 * Neither the name of the Janrain, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.
 
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 
 File:	 FeedReader.h 
 Author: Lilli Szafranski - lilli@janrain.com, lillialexis@gmail.com
 Date:	 Tuesday, August 24, 2010
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JREngage.h"
#import "FeedReaderDetail.h"
#import "Strings.h"

@class FeedReaderDetail;
@interface StoryImage : NSObject <JRConnectionManagerDelegate>
{
    NSString *alt;		/* Specifies an alternate text for an image (e.g., x) */
	NSString *src;		/* (URL) Specifies the URL of an image (e.g., x) */
	CGFloat *height;	/* p(ixels) pecifies the height of an image (e.g., x) */
	CGFloat *width;		/* (pixels) Specifies the width of an image (e.g., x) */
    
    UIImage *image;
    
    BOOL downloadFailed;    
}
@property (readonly) NSString *alt;
@property (readonly) NSString *src;
@property (readonly) CGFloat  *height;
@property (readonly) CGFloat  *width;
@property (readonly) UIImage  *image;
@property (readonly) BOOL downloadFailed;

- (id)initWithSrc:(NSString*)_src;
@end

@class Feed;
@interface Story : NSObject
{   
	NSString *title;		/* The title of the item. (e.g., Venice Film Festival Tries to Quit Sinking) */
	NSString *link;         /* The URL of the item. (e.g., http://nytimes.com/2004/12/07FEST.html) */
	NSString *description;	/* The item synopsis. (e.g., Some of the most heated chatter at the Venice Film Festival this week was about the way that the arrival of the stars at the Palazzo del Cinema was being staged.) */
	NSString *author;		/* Email address of the author of the item. (e.g., oprah\@oxygen.net) */
	NSString *pubDate;		/* Indicates when the item was published. (e.g., Sun, 19 May 2002 15:21:36 GMT) */

    NSString *plainText;
	
    NSMutableArray *storyImages;
    
    Feed *feed;
}

@property (readonly) NSString *title;
@property (readonly) NSString *link;
@property (readonly) NSString *description;
@property (readonly) NSString *author;
@property (readonly) NSString *pubDate;
@property (readonly) NSString *plainText;
@property (readonly) NSMutableArray *storyImages;
@property (readonly) Feed *feed;
@end

@interface Feed : NSObject
{
    NSString *url;

 	NSString *title;            /* The name of the channel. It's how people refer to your service. If you have an HTML website that contains the same information as your RSS file, the title of your channel should be the same as the title of your website. (e.g., GoUpstate.com News Headlines) */
	NSString *link;             /* The URL to the HTML website corresponding to the channel. (e.g., http://www.goupstate.com/) */

    NSMutableArray *stories;
}

@property (readonly) NSString *title;
@property (readonly) NSString *link;
@property (readonly) NSMutableArray *stories;
@end

@interface FeedReader : NSObject <JREngageDelegate>
{    
    Feed *feed;
    Story *selectedStory;
    
    JREngage *jrEngage;
    
    FeedReaderDetail *feedReaderDetail;
}

@property (retain)   FeedReaderDetail *feedReaderDetail;
@property (readonly) NSMutableArray *allStories;
@property (retain)   Story *selectedStory;
@property (readonly) JREngage *jrEngage;

+ (FeedReader*)feedReader;
@end
