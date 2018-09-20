//
//  image_filteres.cpp
//  CameraSample
//
//  Created by Naoyoshi Aikawa on 2018/09/20.
//  Copyright © 2018年 Naoyoshi Aikawa. All rights reserved.
//

#include "image_filteres.hpp"
#include <opencv2/opencv.hpp>
#include <vector>

using namespace std;

namespace filter {

cv::Mat saturation(const cv::Mat& img) {
    cv::Mat hsv;
    cv::cvtColor(img, hsv, CV_BGR2HSV);
    vector<cv::Mat> panes;
    split(hsv, panes);  // split to H, S, V
    return panes[1];
}

cv::Mat canny(const cv::Mat& img) {
    cv::Mat edge;
    cv::Canny(img, edge, 5, 50);
    return edge;
}

}
