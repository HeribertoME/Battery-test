#!/usr/bin/env bash
STRICT_MODE_PARAM="$1"
PIVOT_PARAM="$2"
STAGE_SUCCESS="$3"
TOTAL_ENERGY_CONSUMPTION="$4"

cd ${WORKSPACE}

echo "Pivot Param => $PIVOT_PARAM"
echo "Total de gasto energetico => $TOTAL_ENERGY_CONSUMPTION"

if [ "$STRICT_MODE_PARAM" = "true" ] && [ "$STAGE_SUCCESS" = "1" ]; then
  echo "**********************************************************"
  echo "*                                                        *"
  echo "* ✅Consumo energético dentro del valor de referencia ✅ *"
  echo "*                  Ejecución  exitosa                    *"
  echo "*                                                        *"
  echo "**********************************************************"
  echo
  exit 0
fi

if [ "$STRICT_MODE_PARAM" = "true" ] && [ "$STAGE_SUCCESS" = "0" ]; then
    echo "**********************************************************"
    echo "*                                                        *"
    echo "* ⛔ Consumo energetico superó el valor de referencia ⛔ *"
    echo "*                  Ejecucion no exitosa                  *"
    echo "*                El pipeline se ha detenido              *"
    echo "*                                                        *"
    echo "**********************************************************"
    echo
  exit 1
fi

if [ "$STRICT_MODE_PARAM" = "false" ] && [ "$STAGE_SUCCESS" = "1" ]; then
  echo "**********************************************************"
  echo "*                                                        *"
  echo "* ✅Consumo energético dentro del valor de referencia ✅ *"
  echo "*                   Ejecución  exitosa                   *"
  echo "*                                                        *"
  echo "**********************************************************"
  echo
  exit 0
fi

if [ "$STRICT_MODE_PARAM" = "false" ] && [ "$STAGE_SUCCESS" = "0" ]; then
      echo "**********************************************************"
      echo "*                                                        *"
      echo "* ⚠️ Consumo energetico superó el valor de referencia ⚠️ *"
      echo "*                  Ejecución exitosa                     *"
      echo "*                                                        *"
      echo "**********************************************************"
      echo
  exit 0
fi