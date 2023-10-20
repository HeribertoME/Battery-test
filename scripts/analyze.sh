#!/usr/bin/env bash
STRICT_MODE_PARAM="$1"
PIVOT_PARAM="$2"
STAGE_SUCCESS="$3"
TOTAL_ENERGY_CONSUMPTION="$4"

IS_OPTIMAL="false"

cd ${WORKSPACE}

if [ $(bc <<< "$TOTAL_ENERGY_CONSUMPTION <= $PIVOT_PARAM") -eq 1 ];then
  set IS_OPTIMAL = "true"
else
  set IS_OPTIMAL = "false"
fi

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