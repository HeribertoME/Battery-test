#!/usr/bin/env bash
STRICT_MODE_PARAM="$1"
PIVOT_PARAM="$2"
STAGE_SUCCESS="$3"
TOTAL_ENERGY_CONSUMPTION="$4"

cd ${WORKSPACE}

#filename='batterystats.txt'
#n=1

# while read line; do

#     if [[ $line == *"Estimated power use"* ]]; then
#         echo -e "\033[34mLine No. $n : $line\033[0m"
#     fi

#     if [[ $line == *"Total cpu time"* ]]; then
#         echo -e "\033[34mLine No. $n : $line\033[0m"
#     fi

#     if [[ $line == *"Proc"* ]]; then
#         echo -e "\033[34mLine No. $n : $line\033[0m"
#     fi

#     n=$((n+1))

# done < "$filename"

echo "Total de gasto energetico => $TOTAL_ENERGY_CONSUMPTION"

if [ "$STRICT_MODE_PARAM" = "true" ] && [ "$STAGE_SUCCESS" = "1" ]; then
  echo "OPTIMAL ENERGY SUCCESS WITH STRICT MODE"
  exit 0
fi

if [ "$STRICT_MODE_PARAM" = "true" ] && [ "$STAGE_SUCCESS" == "0" ]; then
  echo "OPTIMAL ENERGY UNSUCCESS WITH STRICT MODE"
  exit 1
fi

if [ "$STRICT_MODE_PARAM" = "false" ] && [ "$STAGE_SUCCESS" = "1" ]; then
  echo "OPTIMAL ENERGY SUCCESS WITHOUT STRICT MODE"
  exit 0
fi

if [ "$STRICT_MODE_PARAM" = "false" ] && [ "$STAGE_SUCCESS" = "0" ]; then
  echo "OPTIMAL ENERGY SUCCESS WITHOUT STRICT MODE"
  exit 0
fi