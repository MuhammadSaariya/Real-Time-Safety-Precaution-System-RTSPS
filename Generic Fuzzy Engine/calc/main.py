from django.shortcuts import render
import skfuzzy as fuzz
import numpy as np

import xlsxwriter


def Fuzzy(tData, gData, fData, minRange, maxRange, gminRange, gmaxRange):

    # Zero[0%]
    # Low[0-20%]
    # Mediem[20-60%]
    # High[60-100%]
    alert = ""
    x_temp = np.arange(minRange, maxRange+1, 1)
    Total = np.abs(minRange)+np.abs(maxRange)
    print(Total)
    percent = 25 * Total / (100)
    print(percent)
    vlowM = percent + minRange
    print(vlowM)
    lowM = percent + vlowM
    print(lowM)
    midM = percent+lowM
    print(midM)

    highM = percent+midM
    print(highM)
    temp_vlo = fuzz.trimf(x_temp, [minRange, minRange, vlowM+.1])
    # Visualize these universes and membership functions
    temp_lo = fuzz.trimf(x_temp, [vlowM-(np.abs(vlowM)/2), vlowM, lowM+.1])
    # fig, (ax0, ax1, ax2) = plt.subplots(nrows=3, figsize=(8, 9))
    temp_md = fuzz.trimf(x_temp, [lowM - (np.abs(vlowM)/2), lowM, midM+.1])
    temp_hi = fuzz.trimf(x_temp, [midM-(np.abs(vlowM)/2), midM, highM+.1])  #
    temp_vhi = fuzz.trimf(
        x_temp, [highM-(np.abs(vlowM)/2), maxRange+1, maxRange+1])
    temp_level_vlo = fuzz.interp_membership(x_temp, temp_vlo, tData)
    # ax0.plot(x_temp, temp_vlo, 'p', linewidth=1.5, label='very low range')
    temp_level_lo = fuzz.interp_membership(x_temp, temp_lo, tData)
    temp_level_md = fuzz.interp_membership(x_temp, temp_md,
                                           tData)  # ax0.plot(x_temp, temp_md, 'g', linewidth=1.5, label='Medium range')
    temp_level_hi = fuzz.interp_membership(x_temp, temp_hi,
                                           tData)  # ax0.plot(x_temp, temp_hi, 'r', linewidth=1.5, label='High range')
    temp_level_vhi = fuzz.interp_membership(x_temp, temp_vhi, tData)
    x_Gas = np.arange(gminRange, gmaxRange+1, 1)

    gTotal = np.abs(gminRange) + np.abs(gmaxRange)
    percent = 20 * gTotal / (100)
    vlowM = percent + gminRange

    lowM = percent + vlowM
    midM = percent+lowM
    highM = percent+midM
    Gas_vlo = fuzz.trimf(x_Gas, [gminRange, gminRange, vlowM+.1])
    Gas_lo = fuzz.trimf(x_Gas, [vlowM-(vlowM/3), vlowM, lowM+.1])
    Gas_md = fuzz.trimf(x_Gas, [lowM-(vlowM/3), lowM, midM+.1])
    Gas_hi = fuzz.trimf(x_Gas, [midM-(vlowM/3), midM, highM+.1])
    Gas_vhi = fuzz.trimf(x_Gas, [highM-(vlowM/3), gmaxRange+1, gmaxRange+1])
    gas_level_vlo = fuzz.interp_membership(x_Gas, Gas_vlo, gData)
    gas_level_lo = fuzz.interp_membership(x_Gas, Gas_lo, gData)
    gas_level_md = fuzz.interp_membership(x_Gas, Gas_md, gData)
    gas_level_hi = fuzz.interp_membership(x_Gas, Gas_hi, gData)
    gas_level_vhi = fuzz.interp_membership(x_Gas, Gas_vhi, gData)

    Flame_level_lo = 0
    Flame_level_hi = 0
    if fData:
        Flame_level_hi = 1
    else:
        Flame_level_lo = 1

    x_fire = np.arange(0, 101, 1)
    fire_vlo = fuzz.trimf(x_fire, [0, 0, 12])
    fire_lo = fuzz.trimf(x_fire, [11, 30, 40])
    fire_md = fuzz.trimf(x_fire, [39, 50, 65])
    fire_hi = fuzz.trimf(x_fire, [64, 75, 85])
    fire_vhi = fuzz.trimf(x_fire, [84, 101, 101])
    # for || or condition use fmax and for and use fmin
    fire0 = np.zeros_like(x_fire)
    # Fuzzy Rules for temparature and gas sensors
    # Rule 1:  If temparature sensor value is <=40 and Gas sensor detect <=20ppm then Fire chances are zero[0 %]
    # Rule 2:  If temparature sensor value is >40 and <70 and Gas sensor detect <=20ppm then Fire chances are Low[20%]    # Equation  is   (  temp_level_lo || temp_level_md)&(gas level_lo) => fire lo
    fire_activation_vlo = np.zeros_like(fire_vlo)
    fire_activation_lo = np.zeros_like(fire_lo)
    fire_activation_md = np.zeros_like(fire_md)
    fire_activation_hi = np.zeros_like(fire_hi)
    fire_activation_vhi = np.zeros_like(fire_vhi)
    if Flame_level_lo:
        if gas_level_vlo:

            if temp_level_vlo:
                Act = np.fmin(temp_level_vlo, gas_level_vlo)  # &
                fire_activation_vlo = np.fmin(Act, fire_vlo)  # &
                alert = 'Normal situation'
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_vlo)  # &
                fire_activation_vlo = np.fmin(Act, fire_vlo)  # &
                alert = 'Normal situation'

            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_vlo)  # &
                fire_activation_vlo = np.fmin(Act, fire_lo)  # &
                alert = 'Normal situation'
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_vlo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_vlo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
        if gas_level_lo:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_lo)  # &
                fire_activation_vlo = np.fmin(Act, fire_vlo)  # &
                alert = 'Normal situation'
         #       print("If gas level is lo with vlow twmp",fire_activation_vlo)
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_lo)  # &
                fire_activation_lo = np.fmin(Act, fire_lo)  # &
                alert = 'Normal situation'
        #        print("If gas level is lo with low twmp", fire_activation_lo)
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_lo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
       #         print("If gas level is lo with md temp", fire_activation_md)
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_lo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
                # print("If gas level is lo with hi twmp", fire_activation_md)
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_lo)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
               # print("If gas level is lo with vhi twmp", fire_activation_hi)
        if gas_level_md:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_md)  # &
                fire_activation_lo = np.fmin(Act, fire_lo)  # &
                alert = 'Normal situation'
              #  print("If gas level is md with vlow twmp",fire_activation_lo)
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_md)  # &
                fire_activation_lo = np.fmin(Act, fire_lo)  # &
                alert = 'Normal situation'
             #   print("If gas level is md with low twmp", fire_activation_lo)
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_md)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
            #    print("If gas level is md with md temp", fire_activation_md)
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_md)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
           #     print("If gas level is md with hi twmp", fire_activation_hi)
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_md)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
          #      print("If gas level is md with vhi twmp", fire_activation_hi)
        if gas_level_hi:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_hi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Normal situation'
         #       print("If gas level is hi with vlow twmp",fire_activation_md)
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_hi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
        #        print("If gas level is hi with low twmp", fire_activation_md)
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_hi)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
       #         print("If gas level is hi with md temp", fire_activation_hi)
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_hi)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
      #          print("If gas level is hi with hi twmp", fire_activation_hi)
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_hi)  # &
                fire_activation_vhi = np.fmin(Act, fire_vhi)  # &
                alert = 'Extreme bad'
               # print("If gas level is hi with vhi twmp", fire_activation_vhi)
        if gas_level_vhi:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_vhi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Normal situation'
              #  print("If gas level is vhi with vlow twmp",fire_activation_md)
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_vhi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
             #   print("If gas level is vhi with low twmp", fire_activation_md)
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_vhi)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
            #    print("If gas level is vhi with md temp", fire_activation_hi)
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_vhi)  # &
                fire_activation_vhi = np.fmin(Act, fire_vhi)  # &
                alert = 'Extreme bad'
           #     print("If gas level is vhi with hi twmp", fire_activation_vhi)
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_vhi)  # &
                fire_activation_vhi = np.fmin(Act, fire_vhi)  # &
                alert = 'Extreme bad'
          #      print("If gas level is vhi with vhi twmp", fire_activation_vhi)
    if Flame_level_hi:
        if gas_level_vlo:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_vlo)  # &
                fire_activation_vlo = np.fmin(Act, fire_vlo)  # &
                alert = 'Not Normal situation'
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_vlo)  # &
                fire_activation_vlo = np.fmin(Act, fire_vlo)  # &
                alert = 'Not Normal situation'
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_vlo)  # &
                fire_activation_vlo = np.fmin(Act, fire_lo)  # &
                alert = 'Not Normal situation'
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_vlo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_vlo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
        if gas_level_lo:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_lo)  # &
                fire_activation_vlo = np.fmin(Act, fire_vlo)  # &
                alert = 'Not Normal situation'
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_lo)  # &
                fire_activation_lo = np.fmin(Act, fire_lo)  # &
                alert = 'Not Normal situation'
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_lo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_lo)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_lo)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
         #       print("If gas level is lo with vhi twmp", fire_activation_hi)
        if gas_level_md:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_md)  # &
                fire_activation_lo = np.fmin(Act, fire_lo)  # &
                alert = 'Not Normal situation'
                # print("If gas level is md with vlow twmp",fire_activation_lo)
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_md)  # &
                fire_activation_lo = np.fmin(Act, fire_lo)  # &
                alert = 'Not Normal situation'
               # print("If gas level is md with low twmp", fire_activation_lo)
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_md)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
              #  print("If gas level is md with md temp", fire_activation_md)
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_md)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
             #   print("If gas level is md with hi twmp", fire_activation_hi)
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_md)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
                # print("If gas level is md with vhi twmp", fire_activation_hi)
        if gas_level_hi:
            if temp_level_vlo:
                # active_rule1 = np.fmax(temp_level_vlo, temp_level_vlo)#||
                # print(active_rule1)
                Act = np.fmin(temp_level_vlo, gas_level_hi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
              #  print("If gas level is hi with vlow twmp",fire_activation_md)
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_hi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
               # print("If gas level is hi with low twmp", fire_activation_md)
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_hi)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
             #   print("If gas level is hi with md temp", fire_activation_hi)
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_hi)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
            #    print("If gas level is hi with hi twmp", fire_activation_hi)
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_hi)  # &
                fire_activation_vhi = np.fmin(Act, fire_vhi)  # &
                alert = 'Extreme bad'
           #     print("If gas level is hi with vhi twmp", fire_activation_vhi)
        if gas_level_vhi:
            if temp_level_vlo:
                Act = np.fmin(temp_level_vlo, gas_level_vhi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Not Normal situation'
            if temp_level_lo:
                Act = np.fmin(temp_level_lo, gas_level_vhi)  # &
                fire_activation_md = np.fmin(Act, fire_md)  # &
                alert = 'Extreme bad'
            if temp_level_md:
                Act = np.fmin(temp_level_md, gas_level_vhi)  # &
                fire_activation_hi = np.fmin(Act, fire_hi)  # &
                alert = 'Extreme bad'
            if temp_level_hi:
                Act = np.fmin(temp_level_hi, gas_level_vhi)  # &
                fire_activation_vhi = np.fmin(Act, fire_vhi)  # &
                alert = 'Extreme bad'
            if temp_level_vhi:
                Act = np.fmin(temp_level_vhi, gas_level_vhi)  # &
                fire_activation_vhi = np.fmin(Act, fire_vhi)  # &
                alert = 'Extreme bad'

    aggregated = np.fmax(fire_activation_vlo,
                         np.fmax(fire_activation_lo,
                                 np.fmax(fire_activation_md, np.fmax(fire_activation_hi, fire_activation_vhi))))
    # Calculate defuzzified result
    fire = fuzz.defuzz(x_fire, aggregated, 'centroid')
    return fire, alert, aggregated
