#!/usr/bin/env bash
STRICT_MODE_PARAM="$1"
PIVOT_PARAM="$2"
STAGE_SUCCESS="$3"
TOTAL_ENERGY_CONSUMPTION="$4"

IS_OPTIMAL="0"

cd ${WORKSPACE}

if [ $(bc <<< "$TOTAL_ENERGY_CONSUMPTION <= $PIVOT_PARAM") -eq 1 ];then
  set IS_OPTIMAL = "1"
else
  set IS_OPTIMAL = "0"
fi

echo "Total de gasto energetico => $TOTAL_ENERGY_CONSUMPTION"

if [ "$STRICT_MODE_PARAM" = "true" ] && [ "$IS_OPTIMAL" = "1" ]; then
  echo "OPTIMAL ENERGY SUCCESS WITH STRICT MODE"
  exit 0
fi

if [ "$STRICT_MODE_PARAM" = "true" ] && [ "$IS_OPTIMAL" == "0" ]; then
  echo "OPTIMAL ENERGY UNSUCCESS WITH STRICT MODE"
  exit 1
fi

if [ "$STRICT_MODE_PARAM" = "false" ] && [ "$IS_OPTIMAL" = "1" ]; then
  echo "OPTIMAL ENERGY SUCCESS WITHOUT STRICT MODE"
  exit 0
fi

if [ "$STRICT_MODE_PARAM" = "false" ] && [ "$IS_OPTIMAL" = "0" ]; then
  echo "OPTIMAL ENERGY SUCCESS WITHOUT STRICT MODE"
  exit 0
fi