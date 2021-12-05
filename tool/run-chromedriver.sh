#!/bin/sh

chromedriver="Google Chrome"

if flutter devices | grep "$chromedriver";
  then
    cmd="chromedriver --port=4444"
    $cmd &
fi