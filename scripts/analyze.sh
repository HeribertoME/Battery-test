#!/usr/bin/env bash
STRICT_MODE_PARAM="$1"
STAGE_SUCCESS="$2"
TOTAL_ENERGY_CONSUMPTION="$3"

cd ${WORKSPACE}

echo "Pivot Param => $STAGE_SUCCESS"
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
  echo "OPTIMAL ENERGY UNSUCCESS WITHOUT STRICT MODE"
  exit 0
fi