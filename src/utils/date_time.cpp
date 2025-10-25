#include <iostream>
#include <string>
#include <ctime>
#include <sstream>

using namespace std;

class LMDateTimeUtils
{
public:
    static string howLongAgo(unsigned long timestamp)
    {
        time_t now = time(nullptr);
        long diff = static_cast<long>(now - timestamp);

        if (diff < 0)
            return "in the future";

        int seconds = diff;
        int minutes = diff / 60;
        int hours = diff / 3600;
        int days = diff / 86400;
        int weeks = diff / (86400 * 7);
        int months = diff / (86400 * 30);
        int years = diff / (86400 * 365);

        ostringstream oss;

        if (seconds <= 15)
            return "just now";
        else if (seconds < 60)
            oss << seconds << (seconds == 1 ? " second ago" : " seconds ago");
        else if (minutes < 60)
            oss << minutes << (minutes == 1 ? " minute ago" : " minutes ago");
        else if (hours < 24)
            oss << hours << (hours == 1 ? " hour ago" : " hours ago");
        else if (days < 7)
            oss << days << (days == 1 ? " day ago" : " days ago");
        else if (weeks < 5)
            oss << weeks << (weeks == 1 ? " week ago" : " weeks ago");
        else if (months < 12)
            oss << months << (months == 1 ? " month ago" : " months ago");
        else
            oss << years << (years == 1 ? " year ago" : " years ago");

        return oss.str();
    }
};
