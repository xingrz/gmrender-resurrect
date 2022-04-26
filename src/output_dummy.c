#include "output_module.h"
#include "output_dummy.h"

#include <stdio.h>

static void output_dummy_set_uri(const char *uri,
                                 output_update_meta_cb_t meta_cb)
{
    printf("output_dummy_set_uri: %s\n", uri);
}

static int output_dummy_play(output_transition_cb_t callback)
{
    return 0;
}

static int output_dummy_stop(void)
{
    return 0;
}

static int output_dummy_pause(void)
{
    return 0;
}

static int output_dummy_seek(gint64 position_nanos)
{
    return 0;
}

struct output_module dummy_output = {
    .shortname = "dummy",
    .description = "Dummy output",
    .set_uri = output_dummy_set_uri,
    .play = output_dummy_play,
    .stop = output_dummy_stop,
    .pause = output_dummy_pause,
    .seek = output_dummy_seek,
};
