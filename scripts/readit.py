import re
import subprocess
import sys
#from tabulate import tabulate

WORKSPACE= sys.argv[1]
OS_TYPE_PARAM=sys.argv[2]
TEST_TYPE_PARAM=sys.argv[3]
TEST_TIME_PARAM=sys.argv[4]
STRICT_MODE_PARAM=sys.argv[5]
PIVOT_PARAM=sys.argv[6]
PACKAGE_ID_PARAM= sys.argv[7]
STAGE_SUCCESS=0
TOTAL_ENERGY_CONSUMPTION=0

sCapacity = 'Capacity'
sUID = 'Uid'
uIdTotal = 0.0
uIdNamesList = []
uIdValuesList = []
doc= open("results.txt","w+")
fileName= 'batterystats.txt'

def checkIsTypePhysical():
    with open(fileName) as file:
        while True:
            line = file.readline()
            if not line:
                return False

            if sUID.lower() in line.lower() and ("fg" in line or "bg" in line):#Physic
                return True

    return False

def getIdPackage():
    indexId = 0
    temporal= []
    with open(fileName) as file:
        n= 0
        while True:
            line = file.readline()

            if not line:
                break
            if "  " in line and "   " not in line:
                arrT = line.rstrip().replace(':','').replace('  ','')
                n+=1
                temporal.append(arrT)
                if arrT == "1000":
                    indexId = n

    return temporal[indexId]

def getEnergyStats():
    with open(fileName) as file:
        while True:
            line = file.readline()
            if not line:
                break
            #Obtener Capacidades
            if sCapacity in line:
                capData = re.split(",|:",line)
                lineCap1 = "Capacidad de batería "+ capData[1].strip().lstrip()+ " mAh\r\n"
                lineCap2 = "Batería drenada por procesos "+ capData[3].strip().lstrip()+ " mAh\r\n\r\n"
                doc.writelines([lineCap1,lineCap2])

            #Obtener Energia usada
            if "uid "+appID in line.lower():
                line = line.strip()
                indexChilds = line.index('(')
                mainData = re.split(' ',line[0:indexChilds].strip())
                #add params and values to array
                for i in range(1,len(mainData)):
                    if ":" in mainData[i] :
                        uIdNamesList.append(mainData[i])

                    else:
                        uIdValuesList.append(mainData[i])

                #manage data child
                if isPhysical == True:
                    childData = line[indexChilds+1: len(line)-1 ]
                    cildrenArr = re.split('=',childData)
                    uIdNamesList.append(cildrenArr[0].strip())

                    for i in range(1,len(cildrenArr)-1):
                        segment= cildrenArr[i].strip()
                        cutSegment= re.split(' ',segment)
                        nextValue = cutSegment[len(cutSegment)-1]
                        indexSegment = segment.index(nextValue)
                        firstName = segment[0:indexSegment]
                        uIdValuesList.append(firstName)
                        uIdNamesList.append(nextValue)

                    uIdValuesList.append(cildrenArr[len(cildrenArr)-1])
                else:
                    cildrenArr = re.split('[(]|[)]',line)

                    for i in range(1,len(cildrenArr)-1):
                        segment= cildrenArr[i].strip()
                        if '=' in segment:
                            cutSegment= re.split(' |=',segment)
                        elif ':' in segment:
                            cutSegment= re.split(':',segment)

                        for i in range(0,len(cutSegment)):
                            modulo = i % 2
                            if modulo == 0:
                                uIdNamesList.append(cutSegment[i])
                            else:
                                uIdValuesList.append(cutSegment[i])

def getCPUStats():
    #Obtener Uso de CPU
    with open(fileName) as file:
        lines = file.readlines()
    
    cpuRow = ""
    n = 0
    for line in lines:
        if PACKAGE_ID_PARAM in line:
            cpuRow = lines[n+1].strip()
        n+=1
    
    
    arrData = re.split(':|[+]|;',cpuRow)

    for i in  range(1,len(arrData)):
        value = re.split(' ',arrData[i])
        uIdValuesList.append(value[1])
    
    uIdNamesList.append("CPU: Tiempo de usuario")
    uIdNamesList.append("CPU: Tiempo del sistema")
    uIdNamesList.append("CPU: Tiempo del primer plano")

try:
    isPhysical= checkIsTypePhysical()
    appID= getIdPackage()
    getEnergyStats() 
    getCPUStats()


    i = 0
    while i <= len(uIdNamesList) - 1:
        #row = [str(uIdNamesList[i]),str(uIdValuesList[i])]
        #tableNames.append(row)
        createLine = "  - ",str(uIdNamesList[i]), " ", str(uIdValuesList[i]), " \r\n"
        doc.writelines(createLine)
        i += 1

    doc.close()
    #tabFull = tabulate(tableNames,["Campos","Valor"])
    #doc.writelines(tabFull)

    if uIdValuesList[0]:
        STAGE_SUCCESS=1
        TOTAL_ENERGY_CONSUMPTION= uIdValuesList[0]

    if TOTAL_ENERGY_CONSUMPTION <= PIVOT_PARAM:
        STAGE_SUCCESS=1
    else:
        STAGE_SUCCESS=0
except:
      STAGE_SUCCESS=0

try:
    subprocess.run(["sh", WORKSPACE+'/scripts/analyze.sh',
                    str(STRICT_MODE_PARAM),
                    str(PIVOT_PARAM),
                    str(STAGE_SUCCESS),
                    str(TOTAL_ENERGY_CONSUMPTION)])
except:
    print("Exception on code")

