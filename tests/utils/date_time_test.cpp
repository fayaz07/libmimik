#include <gtest/gtest.h>
#include "utils/date_time.h"
#include <ctime>

TEST(LMDateTimeUtilsTest, JustNowRange) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 0), "just now");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 5), "just now");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 15), "just now");
}

TEST(LMDateTimeUtilsTest, SecondsAgoRange) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 16), "16 seconds ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 45), "45 seconds ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 59), "59 seconds ago");
}

TEST(LMDateTimeUtilsTest, MinutesAgo) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 60), "1 minute ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 5 * 60), "5 minutes ago");
}

TEST(LMDateTimeUtilsTest, HoursAgo) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 3600), "1 hour ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 3 * 3600), "3 hours ago");
}

TEST(LMDateTimeUtilsTest, DaysAgo) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 86400), "1 day ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 6 * 86400), "6 days ago");
}

TEST(LMDateTimeUtilsTest, WeeksAgo) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 7 * 86400), "1 week ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 3 * 7 * 86400), "3 weeks ago");
}

TEST(LMDateTimeUtilsTest, MonthsAgo) {
    time_t now = time(nullptr);
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 30 * 86400), "1 month ago");
    EXPECT_EQ(LMDateTimeUtils::howLongAgo(now - 3 * 30 * 86400), "3 months ago");
}
