//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by Xue Yu on 5/15/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import "BNRWebViewController.h"

@interface BNRWebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic,strong) UIBarButtonItem *forwardButton;
@property (nonatomic, strong) UIBarButtonItem *backButton;

@end

@implementation BNRWebViewController

- (void) loadView
{
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    
    self.webView.delegate = self;
    self.view = self.webView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.toolBar = [[UIToolbar alloc] init];
    
    float width = [[UIScreen mainScreen]bounds].size.width;
    float height = [[UIScreen mainScreen]bounds].size.height;
    
    self.toolBar.frame = CGRectMake(0, height - 44, width, 44);
    
    self.forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"Forward" style:UIBarButtonItemStylePlain target:self action:@selector(goForward:)];
    self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];

    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    self.toolBar.items = @[self.backButton, flexSpace, self.forwardButton];
    
    [self updateBarButtons];
    [self.view addSubview:self.toolBar];
}

- (IBAction)goForward:(id)sender
{
    [self.webView goForward];
}

-(IBAction)goBack:(id)sender
{
    [self.webView goBack];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self updateBarButtons];
}

- (void) updateBarButtons
{
    self.forwardButton.enabled = self.webView.canGoForward;
    self.backButton.enabled = self.webView.canGoBack;
    
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        // here we need to convert, because at that time maybe only self.view is created
        [(UIWebView *)self.view loadRequest:req];
    }
}
@end




