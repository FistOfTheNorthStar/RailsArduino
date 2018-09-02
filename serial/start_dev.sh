#!/bin/sh
crontab -r
whenever --update-crontab --set environment='development'
