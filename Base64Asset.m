//
//  RCTBase64Asset.m
//  Devine
//
//  Created by David on 12/3/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "Base64Asset.h"

@implementation Base64Asset

// Expose this module to the React Native bridge
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(read:(NSString *)uri callback:(RCTResponseSenderBlock)callback)
{
  // Create NSURL from uri
  NSURL *url = [[NSURL alloc] initWithString:uri];

  // Create an ALAssetsLibrary instance. This provides access to the
  // videos and photos that are under the control of the Photos application.
  ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

  // Using the ALAssetsLibrary instance and our NSURL object open the image.
  [library assetForURL:url resultBlock:^(ALAsset *asset) {
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    
    Byte *buffer = (Byte*)malloc(rep.size);
    
    NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
    
    NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
    
    // Convert to base64 encoded string
    NSString *base64Encoded = [data base64EncodedStringWithOptions:0];
    
    callback(@[base64Encoded]);
  } failureBlock:^(NSError *error) {
    NSLog(@"Failed to base64 encode file %@", error);
  }];
}

@end