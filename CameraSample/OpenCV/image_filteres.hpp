//
//  image_filteres.hpp
//  CameraSample
//
//  Created by Naoyoshi Aikawa on 2018/09/20.
//  Copyright © 2018年 Naoyoshi Aikawa. All rights reserved.
//

#ifndef image_filteres_hpp
#define image_filteres_hpp

#include <opencv2/core.hpp>

namespace filter {
    cv::Mat saturation(const cv::Mat& img);
    cv::Mat canny(const cv::Mat& img);
}

#endif /* image_filteres_hpp */
