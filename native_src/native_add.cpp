// #include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

struct Coordinate
{
    double latitude;
    double longitude;
};

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
struct Coordinate *create_coordinate(double latitude, double longitude)
{
    struct Coordinate *coordinate = (struct Coordinate *)malloc(sizeof(struct Coordinate));
    coordinate->latitude = latitude;
    coordinate->longitude = longitude;
    return coordinate;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t sum_of_elements(int32_t arr[], int32_t size)
{
    int32_t result = 0;
    for (int i = 0; i < size; i++) {
        result += arr[i];
    }
    return result;
}

