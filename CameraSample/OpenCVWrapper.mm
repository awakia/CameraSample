//
//  OpenCVWrapper.m
//  CameraSample
//
//  Created by Naoyoshi Aikawa on 2018/09/12.
//  Copyright © 2018年 Naoyoshi Aikawa. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

#import "OpenCVWrapper.h"
#import "image_filteres.hpp"

@implementation OpenCVWrapper

+(UIImage *)Saturation:(UIImage *)image{
    cv::Mat mat;
    UIImageToMat(image, mat);
    return MatToUIImage(filter::saturation(mat));
}

@end
