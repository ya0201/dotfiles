#!/usr/bin/env bash

# usage: search-and-set-prop [include word for device search] [exclude word for device search] [inc word for prop search] [exc word for prop search] [value]
function search-and-set-prop () {
  local SEARCHED_DEVICE_ID_LIST=$(xinput list | grep -i "$1" | grep -iv "$2" | sed -e "s/.*[<space><tab>]*id=\([0-9]*\).*/\1/")
  if [[ $? -ne 0 || -z $SEARCHED_DEVICE_ID_LIST ]]; then
    echo 'Error: Could not detect device. Do nothing.'
    exit 1
  elif [[ $(echo $SEARCHED_DEVICE_ID_LIST | wc -l) -gt 1 ]]; then
    echo "Error: Could not determine device uniquely by query ($1 -$2). Do nothing."
    exit 1
  fi
  local DEV_ID=$SEARCHED_DEVICE_ID_LIST
  echo "Detected device id for query ($1 -$2): $DEV_ID"

  local SEARCHED_PROP_ID=$(xinput list-props $DEV_ID | grep -i "$3" | grep -iv "$4" | sed -e "s/.*(\([0-9]*\)).*/\1/")
  if [[ $? -ne 0 || -z $SEARCHED_PROP_ID ]]; then
    echo 'Error: Could not get prop id of the device. Do nothing.'
    exit 1
  elif [[ $(echo $SEARCHED_PROP_ID | wc -l) -gt 1 ]]; then
    echo "Error: Could not determine prop uniquely by query ($3 -$4). Do nothing."
    exit 1
  fi
  local PROP_ID=$SEARCHED_PROP_ID
  echo "Detected prop id of device($DEV_ID) for query ($3 -$4): $PROP_ID"

  echo "Enable Prop($PROP_ID)(query: $3 -$4) for device($DEV_ID)(query: $1 -$2)"
  xinput set-prop $DEV_ID $PROP_ID $5
  if [[ $? ]]; then
    echo 'done.'
  else
    echo "Error: Could not run set-prop for prop($PROP_ID) of device($DEV_ID). Something went wrong."
  fi
}

ENABLE=1
search-and-set-prop 'touchpad' 'null' 'natural scrolling enabled' 'default' $ENABLE
search-and-set-prop 'touchpad' 'null' 'tapping enabled' 'default' $ENABLE

# TOUCHPAD_DEVICE_ID=$(xinput list | grep -i 'touchpad' | sed -e "s/.*[<space><tab>]*id=\([0-9]*\).*/\1/")
# if [[ $? -ne 0 || -z $TOUCHPAD_DEVICE_ID ]]; then
#   echo 'Error: Could not detect touchpad device. Do nothing.'
#   exit 1
# fi
# echo "Detected Touchpad device id: $TOUCHPAD_DEVICE_ID"

# NATURAL_SCROLLING_OPTION_ID=$(xinput list-props $TOUCHPAD_DEVICE_ID | grep -i 'natural scrolling enabled' | grep -iv 'default' | sed -e "s/.*(\([0-9]*\)).*/\1/")
# if [[ $? -ne 0 || -z $NATURAL_SCROLLING_OPTION_ID ]]; then
#   echo 'Error: Could not get natural scrolling option id of the touchpad device. Do nothing.'
#   exit 1
# fi
# echo "Detected natural scrolling option id of the touchpad device: $NATURAL_SCROLLING_OPTION_ID"

# echo "Enable Natural Scrolling Option($NATURAL_SCROLLING_OPTION_ID) for Touchpad Device($TOUCHPAD_DEVICE_ID)"
# xinput set-prop $TOUCHPAD_DEVICE_ID $NATURAL_SCROLLING_OPTION_ID $ENABLE
# if [[ $? ]]; then
#   echo 'done.'
# else
#   echo "Error: Could not run set-prop for prop($NATURAL_SCROLLING_OPTION_ID) of device($TOUCHPAD_DEVICE_ID). Something went wrong."
# fi
