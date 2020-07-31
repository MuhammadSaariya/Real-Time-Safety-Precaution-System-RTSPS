import datetime
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
# Create your views here.
from . import main
from firebase import firebase
from django import forms
from django.views.generic import View
import json
import firebase_admin
from firebase_admin import credentials, firestore
import random
import serial

cred = credentials.Certificate(
    "calc/precautionary-of-fire-system-firebase-adminsdk-ikj23-7a83f45714.json")
a = firebase_admin.initialize_app(cred)
firebase = firebase.FirebaseApplication(
    'https://rtsps2020.firebaseio.com/', None)

tmaxRange = []
tminRange = []
gmaxRange = []
gminRange = []
fminRange = []
fmaxRange = []
port = []
alert1 = ""
no = 0


def home(request):
    # Opening JSON file
    with open('templates/sensors.json') as json_file:
        data = json.load(json_file)
    tmaxRange.clear()
    tminRange.clear()
    gmaxRange.clear()
    gminRange.clear()
    fminRange.clear()
    fmaxRange.clear()
    port.clear()
    a = []
    if request.GET:
        try:
            if request.GET['1'] == 'on':
                tmaxRange.append(request.GET["maxRange1"])
                tminRange.append(request.GET["minRange1"])
            if request.GET['2'] == 'on':
                gmaxRange.append(request.GET["maxRange2"])
                gminRange.append(request.GET["minRange2"])

            if request.GET['3'] == 'on':
                fmaxRange.append(request.GET["maxRange3"])
                fminRange.append(request.GET["minRange3"])
            if request.GET['port']:
                port.append(request.GET["port"])

        except Exception as e:
            a.append('<center >     <h1>    plz select the ' + str(e) +
                     ' sensor</h1> <button><a class="btn" href="/">Go Back</a></button></center>')
            return HttpResponse(a)

    return render(request, 'home.html', {'file': data['sensor'], 'TMrange': tmaxRange, 'Trange': tminRange})


def Addsensor(request):
    if request.GET:
        print(request.GET["Naam"])
        print(request.GET["minRange"])
        print(request.GET["maxRange"])
    # read Data base

    # with open('templates\data.json', 'w') as outfile:
    #     json.dump(sensorData, outfile)

    return render(request, 'addSensor.html')


def get_data(request):
    data = {}
    if request.is_ajax():
        sensor_val = 0.3
        sensor_data = []
        now = datetime.datetime.now()
        ok_date = (str(now.strftime('%Y-%m-%d %H:%M:%S')))
        try:

            Day = (str(now.strftime('%d')))
            print(Day)
            Month = (str(now.strftime('%m')))
            print(Month)
            year = (str(now.strftime('%Y')))
            print(year)
            hr = (str(now.strftime('%H')))
            mint = (str(now.strftime('%M')))
            # sec = (str(now.strftime('%S')))

            sec = '42'

            # for random variable
            print(hr, mint)
            # tData = random.random()*150
            # gData = random.random()*600
            # fData = 0
            # print(year+'/'+Month + '/'+Day+'/'+hr+'/'+mint+'/'+sec)
            fMData = (firebase.get('FlameF/'+year+'/'+Month +
                                   '/'+Day+'/'+hr+'/'+mint, None))
            gMData = (firebase.get('GasF/CO/'+year+'/'+Month +
                                   '/'+Day+'/'+hr+'/'+mint, None))
            tMData = (firebase.get('DHT22F/Temperature/' +
                                   year+'/'+Month+'/'+Day+'/'+hr+'/'+mint, None))

            # print(fMData, gMData, tMData)
            f = list(fMData)
            g = list(gMData)
            t = list(tMData)
            print(f, g, t)

            fData = fMData[str(f[-1])]
            gData = gMData[str(g[-1])]
            tData = tMData[str(t[-1])]
            fData = int(fData)
            gData = float(gData[:-3])
            tData = float(tData[:-2])
            print(fData, gData, tData)

            # Direct port connection
            # sr = serial.Serial("COM9", int(port[0]))
            # st = list(str(sr.readline(), 'utf-8'))
            # sr.close()
            # sensor_val = str(''.join(st[:]))

            defuzz, alert, aggregated = main.Fuzzy(
                tData, gData, fData, int(tminRange[0])*1, int(tmaxRange[0])*1, int(gminRange[0])*1, int(gmaxRange[0])*1)

            if (defuzz):
                sensor_data.append(str(defuzz)+','+ok_date+','+alert)
            else:
                sensor_data.append(str(defuzz)+','+ok_date+','+alert)
        except Exception as x:
            pass
        data['result'] = sensor_data

    else:
        data['result'] = 'fail'

    return JsonResponse(data)
# [START custom_class_def]


def check(request):
    # c1 = request.GET('temp')
    # print("cdd")
    # get_custom_class()
    return render(request, 'chart.html')


def History(request):

    a = []
    date = []
    dFuzz = []
    fuz = []
    temp = []
    gas = []
    flam = []
    Date = '23/06/2020 20:45:34'
    tmaxRange = 80
    tminRange = -40
    gmaxRange = 10000
    gminRange = 0

    if request.GET:
        Date = request.GET["datetimepicker"]
        # print(Date)
        Day = Date[0:2]
        Month = Date[3:5]
        year = Date[6:10]
        hr = Date[11:13]
        # print(Day, Month, year, hr)
        t = firebase.get('DHT22F/Temperature/' +
                         year+'/'+Month+'/'+Day+'/'+hr, None)
        fData = firebase.get('FlameF/'+year+'/'+Month +
                             '/'+Day+'/'+hr, None)
        gData = firebase.get('GasF/CO/'+year+'/'+Month +
                             '/'+Day+'/'+hr, None)

        try:
            k = list(t)
            # print(k)
            # fList = list(fData)
            # gList = list(gData)
            count = 0
            stk = []
            for count in range(0, len(k)):
                if str(k[count]) == "None":
                    print(k[count], count)
                else:
                    stk.append(count)

                # Query

            for i in range(0, len(k)):
                pp = list(t[str(k[i])])
                for j in range(0, len(pp)):
                    temp.append(t[str(k[i])][str(pp[j])])

                    gas.append(gData[str(k[i])][str(pp[j])])
                    flam.append(fData[str(k[i])][str(pp[j])])

                    date.append(Day+'/'+Month+'/'+year +
                                ' '+hr+':'+str(i)+':'+str(pp[j]))

                    flameData = (fData[str(k[i])][str(pp[j])])
                    gasData = (gData[str(k[i])][str(pp[j])][:-3])
                    tempData = (t[str(k[i])][str(pp[j])][:-2])
                    defuzz, alert, aggregated = main.Fuzzy(
                        float(tempData), float(gasData), int(flameData), tminRange, tmaxRange, gminRange, gmaxRange)
                    dFuzz.append(defuzz)
                    fuz.append(alert)
        except Exception as e:
            a.append('<center >  <h1>error is  '+str(e)+' </h1>   <h1>    No Date of  ' + str(Date) +
                     ' </h1> <button><a class="btn" href="/History">Go Back</a></button></center>')
            return HttpResponse(a)

    return render(request, 'history.html', {'tem': temp, 'date': date, 'gas': gas, 'flame': flam, 'Defuzzy': dFuzz, 'Fuzzy': fuz})
