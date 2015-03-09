//
//  BSGPUImageDemoViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 24/01/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSGPUImageDemoViewController.h"
#import "GPUImage.h"

@interface BSGPUImageDemoViewController ()

@end

@implementation BSGPUImageDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc]
                                        initWithSessionPreset:AVCaptureSessionPreset640x480
                                        cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    GPUImageLevelsFilter *filter = [[GPUImageLevelsFilter alloc] init];
    [filter setRedMin:0.299 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [filter setGreenMin:0.587 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [filter setBlueMin:0.114 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [videoCamera addTarget:filter];
    
    GPUImageView *filteredVideoView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [filter addTarget:filteredVideoView];
    [self.view addSubview:filteredVideoView];
    
    [videoCamera startCameraCapture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
