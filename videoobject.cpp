#include "videoobject.h"
#include <QDebug>

using namespace std;

VideoObject::VideoObject(QObject *parent) : QObject(parent)
{

}

VideoObject::VideoObject(string _filePath){
    // this function should be called everytime new file is chosen in ui
    /// hopefully lmao
    video = cv::VideoCapture(_filePath);
    width = video.get(cv::CAP_PROP_FRAME_WIDTH);
    height = video.get(cv::CAP_PROP_FRAME_HEIGHT);
    fps = video.get(cv::CAP_PROP_FPS);
    videoType = video.get(cv::CAP_PROP_FORMAT);
    totalFrames = video.get(cv::CAP_PROP_FRAME_COUNT);
}

void VideoObject::getCopyPixelSTI(bool col = true){
    video.set(cv::CAP_PROP_POS_FRAMES, 0);
    cv::Mat hist;
    if(col)
        hist = cv::Mat(width, totalFrames, videoType); // rows = same as og frame # of rows
    else
        hist = cv::Mat(width, totalFrames, videoType);// rows = same as og frame # of cols

    cv::Mat temp(hist.rows,  hist.cols, hist.type());
    for(int i = 0; i < totalFrames; i++){ // loop through the frams
        // go through frame by frame and copy over to thing
        video >> temp;
        for(int j = 0; hist.rows; j++){
            if(col){
                hist.at<cv::Vec3b>(j,i) = temp.at<cv::Vec3b>(j, width/2);
            } else{
                // copy the middle row
                hist.at<cv::Vec3b>(j,i) = temp.at<cv::Vec3b>(totalFrames/2, j);
            }
        }
    }

    // have histogram
    // push to to histogram memory
    sti.push_back(hist);

    // push back empty threshold cuz copy by pixel and not historgram
    thresholds.push_back(cv::Mat(height, totalFrames, 0, cv::Scalar(0,0,0)));

    // push back sti info
    STI_data info;
    info.type = videoType;
    info.width = hist.cols;
    info.height = hist.rows;
    info.threshold = false;
    info.analysis_method = col? 0 : 1;
    stiData.push_back(info);
}
