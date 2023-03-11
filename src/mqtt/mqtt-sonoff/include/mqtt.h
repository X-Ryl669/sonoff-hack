/*
 * Copyright (c) 2023 roleo.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef MQTT_H
#define MQTT_H

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <mosquitto.h>

#define EMPTY_TOPIC         ""

#define IR_AUTO_FILE             "/tmp/manualControl_autoIR"
#define IR_DARK_FILE             "/tmp/manualControl_darkIR"
#define IR_BRIGHT_FILE           "/tmp/manualControl_brightIR"

typedef struct
{
    char       *client_id;
    char       *user;
    char       *password;
    char        host[128];
    int         port;
    int         keepalive;
    char        bind_address[32];
    int         qos;
    int         retain_birth_will;
    int         retain_motion;
    int         retain_motion_image;
    int         ipcsys_db;

    char       *mqtt_prefix;
    char       *mqtt_prefix_cmnd;
    char       *topic_birth_will;
    char       *birth_msg;
    char       *will_msg;
} mqtt_conf_t;

typedef struct
{
    char* topic;
    char* msg;
    int len;
} mqtt_msg_t;

int init_mqtt(void);
void stop_mqtt(void);

void mqtt_loop(void);

void mqtt_init_conf(mqtt_conf_t *conf);
void mqtt_set_conf(mqtt_conf_t *conf);
void mqtt_check_connection();
int mqtt_send_message(mqtt_msg_t *msg, int retain);

int mqtt_connect();

#endif // MQTT_H
