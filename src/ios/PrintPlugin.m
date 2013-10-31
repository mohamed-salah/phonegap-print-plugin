//
//  PrintPlugin.m
//  Print Plugin
//
//  Created by Ian Tipton (github.com/itip) on 02/07/2011.
//  Copyright 2011 Ian Tipton. All rights reserved.
//  MIT licensed
//

#import "PrintPlugin.h"

@interface PrintPlugin (Private)
-(void) doPrint;
-(void) callbackWithFuntion:(NSString *)function withData:(NSString *)value;
- (BOOL) isPrintServiceAvailable;
@end

@implementation PrintPlugin

@synthesize successCallback, failCallback, printHTML, dialogTopPos, dialogLeftPos;

/*
 Is printing available. Callback returns true/false if printing is available/unavailable.
 */
 - (void) isPrintingAvailable:(CDVInvokedUrlCommand*)command{
    NSUInteger argc = [command.arguments count];
    
    if (argc < 1) {
        return;
    }
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:([self isPrintServiceAvailable] ? YES : NO)];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) print:(CDVInvokedUrlCommand*)command{
    NSUInteger argc = [command.arguments count];
    NSLog(@"Array contents: %@", command.arguments);
    if (argc < 1) {
        return;
    }
    self.printHTML = [command.arguments objectAtIndex:0];
    
    if (![self isPrintServiceAvailable]){
        [self callbackWithFuntion:self.failCallback withData: @"{success: false, available: false}"];
        
        return;
    }
    
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    
    if (!controller){
        return;
    }
    
    if ([UIPrintInteractionController isPrintingAvailable]){
        //Set the priner settings
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        if(argc >= 2 && (BOOL)[command.arguments objectAtIndex:1]) {
            printInfo.orientation = UIPrintInfoOrientationLandscape;
        }
        controller.printInfo = printInfo;
        controller.showsPageRange = YES;
        
        
        //Set the base URL to be the www directory.
        NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"www" ofType:nil ];
        NSURL *baseURL = [NSURL fileURLWithPath:dbFilePath];
        
        //Load page into a webview and use its formatter to print the page
        UIWebView *webViewPrint = [[UIWebView alloc] init];
        [webViewPrint loadHTMLString:printHTML baseURL:baseURL];
        
        //Get formatter for web (note: margin not required - done in web page)
        UIViewPrintFormatter *viewFormatter = [webViewPrint viewPrintFormatter];
        if(argc >= 3) {
            viewFormatter.maximumContentWidth = [[command.arguments objectAtIndex:2] intValue];
        }
        if(argc >= 4) {
            viewFormatter.maximumContentHeight = [[command.arguments objectAtIndex:3] intValue];
        }
        NSError *error = nil;
        controller.printFormatter = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:self.printHTML];
        if (error) {
            NSLog(@"Error while creating the print formatter:\n%@", error);
            NSLog(@"%@", dbFilePath);
        }
        controller.showsPageRange = YES;
        
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            CDVPluginResult* pluginResult = nil;
            if (!completed || error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"{success: false, available: true, error: \"%@\"}", error.localizedDescription]];
            }
            else{
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"{success: true}"];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        };
        
        /*
         If iPad, and if button offsets passed, then show dilalog 
         from offset
         */
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad &&
            dialogTopPos != 0 && dialogLeftPos != 0) {
            [controller presentFromRect:CGRectMake(self.dialogLeftPos, self.dialogTopPos, 0, 0) inView:self.webView animated:YES completionHandler:completionHandler];
    } else {
        [controller presentAnimated:YES completionHandler:completionHandler];
    }
}

}

-(BOOL) isPrintServiceAvailable{
    
    Class myClass = NSClassFromString(@"UIPrintInteractionController");
    if (myClass) {
        UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
        return (controller != nil) && [UIPrintInteractionController isPrintingAvailable];
    }
    
    
    return NO;
}

@end
