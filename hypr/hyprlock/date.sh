#!/usr/bin/env bash
# Prints today's date in English.
weekday=$(date +%A)
day=$(date +%-d)
month=$(date +%B)
echo "$weekday, $month $day"
