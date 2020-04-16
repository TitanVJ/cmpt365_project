#ifndef VIDEOOBJECT_H
#define VIDEOOBJECT_H

#include <QObject>
#include <QImage>
#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <math.h>

// histogram information struct
typedef struct {
    int width; // # of frames
    int height; // depends on analysis method
    int type; // cv img type
    int analysis_method;
    bool threshold;
    // something to hold the characteristics
    // maybe include the processing time here instead
    /// of right panel (if video player is working on other thd)
} STI_data;

class VideoObject : public QObject
{
    Q_OBJECT
private:
    const std::string methods[4] = {"Copy Pixel - Col", "Copy Pixel - Row",
                                "Histogram Diff - Col", "Histogram Diff - Row"};
    int width;
    int height;
    int videoType; // frame type, like the img
    double fps;
    int totalFrames;
    cv::VideoCapture video;
//    cv::Mat hist;
//    Hist_info info;

    // app memory
    std::vector<cv::Mat> sti;
    std::vector<cv::Mat> thresholds;
    std::vector<QImage> qsti;
    std::vector<QImage> q_thresholds;
    std::vector<STI_data> stiData;

    // main processing methods
    cv::Mat getFrame();
    cv::Mat getChromacity(cv::Mat);
    void makeThreashold(cv::Mat);
    QImage mat2qimg(cv::Mat);

public:
    explicit VideoObject(QObject *parent = nullptr);
    // add setters and getters and main funcs for the buttons to call
    VideoObject(std::string);

    // Main analyis method calls
    void getCopyPixelSTI(bool);
    void getHistDiffSTI(bool);
    void save(std::string);

signals:

};

#endif // VIDEOOBJECT_H
