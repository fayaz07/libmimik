#ifndef DATE_TIME_H
#define DATE_TIME_H

#include <string>

class LMDateTimeUtils {
public:
    /**
     * @brief Returns a human-readable string describing how long ago
     *        the given UNIX timestamp occurred.
     *
     * Rules:
     *  - 0–15 seconds → "just now"
     *  - 16–59 seconds → "X seconds ago"
     *  - 1–59 minutes → "X minutes ago"
     *  - 1–23 hours → "X hours ago"
     *  - 1–6 days → "X days ago"
     *  - 1–4 weeks → "X weeks ago"
     *  - 1–11 months → "X months ago"
     *  - 1+ years → "X years ago"
     *  - Future timestamps → "in the future"
     *
     * @param timestamp UNIX timestamp (seconds since epoch)
     * @return std::string Formatted "time ago" message
     */
    static std::string howLongAgo(unsigned long timestamp);
};

#endif
