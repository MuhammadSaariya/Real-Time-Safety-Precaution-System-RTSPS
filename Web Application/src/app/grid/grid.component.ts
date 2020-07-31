import { Component, OnInit, IterableDiffers } from '@angular/core';
import { ChartDataSets, ChartOptions } from 'chart.js';
import { Color, Label } from 'ng2-charts';
import {Chart} from 'chart.js';
import { NullAstVisitor } from '@angular/compiler';
import { HttpClient } from "@angular/common/http";
import { Router } from '@angular/router';
import * as admin from 'firebase-admin';
import {AngularFireDatabase} from 'angularfire2/database';
import * as firebase from 'firebase';
import { Observable, Subscription } from 'rxjs';
import {TestService} from '../test.service';
import { tick } from '@angular/core/testing';
import { time, timeline } from 'console';

@Component({
    selector: 'app-grid',
    templateUrl: './grid.component.html',
    styleUrls: ['./grid.component.css']
  })

export class GridComponent implements OnInit {
    getTempSubs: Subscription;
    LineChart=[];
    LineChart3=[];
    LineChart4=[];
    LineChart2=[];
    graphYaxisData =[];
    Dusttt = [];
    LPG = [];
    CO = [];
    Smoke = [];
    Humidity = [];
    F = [];

    temperatureDummyData = {
      "Tempeature" :[
        {
          "Labels" : "12:00pm",
          "data" : 33
        },
        {
          "Labels" : "12:01pm",
          "data" : 32
        },
        {
          "Labels" : "12:02pm",
          "data" : 19
        },
        {
          "Labels" : "12:03pm",
          "data" : 18
        },
        {
          "Labels" : "12:04pm",
          "data" : 17.5
        },
        {
          "Labels" : "12:05pm",
          "data" : 21.8
        },
        {
          "Labels" : "12:06pm",
          "data" : 10
        },
        {
          "Labels" : "12:07pm",
          "data" : 15
        },
        {
          "Labels" : "12:08pm",
          "data" : 16
        },
        {
          "Labels" : "12:09pm",
          "data" : 20
        },
        {
          "Labels" : "12:10pm",
          "data" : 3
        },
        {
          "Labels" : "12:11pm",
          "data" : 1
        },
        {
          "Labels" : "12:12pm",
          "data" : 1
        },
        {
          "Labels" : "12:13pm",
          "data" : 1
        },
        {
          "Labels" : "12:14pm",
          "data" : 1
        },
        {
          "Labels" : "12:15pm ",
          "data" : 1
        },
        {
          "Labels" : "12:16pm",
          "data" : 1
        },
        {
          "Labels" : "12:17pm",
          "data" : 1
        },
        {
          "Labels" : "12:18pm",
          "data" : 1
        },
        {
          "Labels" : "12:19pm",
          "data" : 1
        },
      ]
    }
    dummyTemepratureValues = [];

    //------------------------------//

    // Temperature Chart Variables
    temperatureSubscription: Subscription;
    temperatureValuesFromDB = [];
    temperatureTimestamps = [];
    temperatureAndHumidityLineChart;

    // Humidity Chart Variables
    humiditySubscription: Subscription;
    humidityValuesFromDB = [];
    humdidtyTimestamps = [];

    //Flame Chart Variables
    Flame_Subscription : Subscription;
    Flame_Values = [];
    Flame_TimeStamps = [];
    FlameChart;

    //DustVariables
   Dust_Subscription : Subscription;
   Dust_Values = [];
   Dust_TimeStamps = [];
   DustChart;


   //GasesVariables
   CO_Subscription : Subscription;
   CO_Values = [];
   CO_TimeStamps = [];
   LPG_Subscription : Subscription;
   LPG_Values = [];
   LPG_TimeStamps = [];
   Smoke_Subscription : Subscription;
   Smoke_Values = [];
   Smoke_TimeStamps = [];

   Gas_Chart;

   

    constructor(public testservice : TestService) {}

    ngOnInit(): void 
    {
      // Temperature and Humidity Block
      //************************************************************************************** */
      // Temperature Subscription
      this.temperatureSubscription = this.testservice.getTemperatureData().subscribe(data => {
        data.splice(0, (data.length-10));
        // Data Mapping
        this.temperatureValuesFromDB = data.map(item =>+item.payload.toJSON().toString().replace('°C',''));
        this.temperatureTimestamps = data.map(item => {
          let today = new Date ();
          let time = today.getHours() + ":" +  today.getMinutes() + ":" + today.getSeconds();
          return time;
          
        });
        console.log('Subscription hit:', this.temperatureValuesFromDB);

        // Redraw graph
        // var labels1 = this.temperatureDummyData.Tempeature.map(function(e) {
        //   return e.Labels;
        //   });
        console.log('labels1', this.temperatureTimestamps)
        this.temperatureAndHumidityLineChart = new Chart('lineChart', {
          type: 'line',
          data: {
            labels: this.temperatureTimestamps,
            datasets: [
              {
                label: 'Temp',
                data:  this.temperatureValuesFromDB,
                fill:false,
                lineTension:1,
                borderColor:"pink",
                borderWidth: 1,
                pointBackgroundColor:'red',
                pointHoverBackgroundColor: 'red',
                cubicInterpolationMode: "monotone",
              },
              {
                label : "Humidity",
                data : this.humidityValuesFromDB,
                fill:false,
                lineTension:1,
                borderColor:"#8C54FF",
                borderWidth: 2,
                pointBackgroundColor:'#8C54FF',
                pointHoverBackgroundColor: '#8C54FF',
                cubicInterpolationMode: "monotone",
              }
            ]
          },
          options: {
            responsive : true,
            title:{
              text:"Temperature Sensor",
              display:true
            },
            scales: {
              yAxes:[{
              scaleLabel: {
                  display: true,
              },
                ticks: {
                    beginAtZero:true
                }
              }]
              },
              animation:
              {
                duration:3000,
                easing:'linear',
              }
            }
          });
      });


      // Humidity Subscription
      this.humiditySubscription = this.testservice.getHumidity().subscribe(data => {

        // Keep latest 10 points
        data.splice(0, (data.length-10));

        // Data Mapping
        this.humidityValuesFromDB = data.map(item =>+item.payload.toJSON().toString().replace('%',''));
        this.humdidtyTimestamps = data.map(item => {
          let today = new Date ();
          let time = today.getHours() + ":" +  today.getMinutes() + ":" + today.getSeconds();
          return time;
        });
        console.log('Humidity Subscription hit:', this.humidityValuesFromDB);

        this.temperatureAndHumidityLineChart = new Chart('lineChart', {
          type: 'line',
          data: {
            labels: this.temperatureTimestamps,
            datasets: [
              {
                label: 'Temp',
                data:  this.temperatureValuesFromDB,
                fill:false,
                lineTension:1,
                borderColor:"pink",
                borderWidth: 1,
                pointBackgroundColor:'red',
                pointHoverBackgroundColor: 'red',
                cubicInterpolationMode: "monotone",
              },
              {
                label : "Humidity",
                data : this.humidityValuesFromDB,
                fill:false,
                lineTension:1,
                borderColor:"#8C54FF",
                borderWidth: 1,
                pointBackgroundColor:'#8C54FF',
                pointHoverBackgroundColor: '#8C54FF',
                cubicInterpolationMode: "monotone",
              }
            ]
          },
          options: {
            responsive : true,
            title:{
              text:"Temperature Sensor",
              display:true
            },
            scales: {
              yAxes:[{
              scaleLabel: {
                  display: true,
              },
                ticks: {
                    beginAtZero:true
                }
              }]
              },
              animation:
              {
                duration:3000,
                easing:'linear',
              }
            }
          });
      })
      //************************************************************************************** */
        //Data Subscription 
      this.Flame_Subscription = this.testservice.getFlame().subscribe (data => {

      //   //Data Slicing
        data.splice (0, (data.length - 10));

        //
        this.Flame_Values = data.map (item => +item.payload.toJSON().toString().replace ('' , ''));
        this.Flame_TimeStamps  = data.map ( data => {
          let today = new Date();
          let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
          return time;

        });
        var labels1 = this.temperatureDummyData.Tempeature.map(function(e) {
          return e.Labels;
          });
        console.log('labels1', this.Flame_TimeStamps)
        console.log ( "Flame Subscription Hit" , this.Flame_Values);
        this.FlameChart = new Chart('lineChart4', {
          type: 'line',
          data: {
            labels: this.Flame_TimeStamps,
            datasets: [
              {
                label: 'Flame',
                data:  this.Flame_Values,
                fill:false,
                lineTension:1,
                borderColor:"#2CC2A5",
                borderWidth: 1,
                pointBackgroundColor:'#2CC2A5',
                pointHoverBackgroundColor: '#2CC2A5',
                cubicInterpolationMode: "monotone",
              },
             
            ]
          },
          options: {
            responsive : true,
            title:{
              text:"Flame Sensor",
              display:true
            },
            scales: {
              yAxes:[{
              scaleLabel: {
                  display: true,
              },
                ticks: {
                    beginAtZero:true
                }
              }]
              },
              animation:
              {
                duration:3000,
                easing:'linear',
              }
            }
          });

      })

      this.Dust_Subscription = this.testservice.getDust().subscribe (data => {

        //   //Data Slicing
          data.splice (0, (data.length - 10));
  
          //
          this.Dust_Values = data.map (item => +item.payload.toJSON().toString().replace ('ug/m^3' , ''));
          this.Dust_TimeStamps  = data.map ( data => {
            let today = new Date();
            let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
            return time;
  
          });
          var labels1 = this.temperatureDummyData.Tempeature.map(function(e) {
            return e.Labels;

            });
          console.log('labels1', this.Dust_TimeStamps)
          console.log ( "Dust Subscription Hit" , this.Dust_Values);
          this.DustChart = new Chart('lineChart2', {
            type: 'line',
            data: {
              labels: this.Dust_TimeStamps,
              datasets: [
                {
                  label: 'Dust',
                  data:  this.Dust_Values,
                  fill:false,
                  lineTension:1,
                  borderColor:"#2E5BFF",
                  borderWidth: 1,
                  pointBackgroundColor:'#2E5BFF',
                  pointHoverBackgroundColor: '#2E5BFF',
                  cubicInterpolationMode: "monotone",
                },
               
              ]
            },
            options: {
              responsive : true,
              title:{
                text:"Dust Sensor",
                display:true
              },
              scales: {
                yAxes:[{
                scaleLabel: {
                    display: true,
                },
                  ticks: {
                      beginAtZero:true
                  }
                }]
                },
                animation:
                {
                  duration:3000,
                  easing:'linear',
                }
              }
            });
  
        })

         this.CO_Subscription = this.testservice.getCO().subscribe (data => {

          //   //Data Slicing
          data.splice (0, (data.length - 10));
    
            //
          this.CO_Values = data.map (item => +item.payload.toJSON().toString().replace ('ppm' , ''));
          this.CO_TimeStamps  = data.map ( data => {
            let today = new Date();
            let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
              return time;
    
            });
            var labels1 = this.temperatureDummyData.Tempeature.map(function(e) {
            return e.Labels;
              });

          console.log('labels1', this.CO_TimeStamps)
          console.log ( " CO Subscription Hit" , this.CO_Values);
           
                
            
            

            
    

          

            this.Gas_Chart = new Chart('lineChart3', {
              type: 'line',
              data: {
                labels: this.CO_TimeStamps,
                datasets: [
                  {
                    label: 'CO',
                    data:  this.CO_Values,
                    fill:false,
                    lineTension:1,
                    borderColor:"#2CC2A5",
                    borderWidth: 1,
                    pointBackgroundColor:'#2CC2A5',
                    pointHoverBackgroundColor: '#2CC2A5',
                    cubicInterpolationMode: "monotone",
                  },
                  {
                    label: 'LPG',
                    data:  this.LPG_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"	#778899",
                    borderWidth: 1,
                    pointBackgroundColor:"	#778899",
                    pointHoverBackgroundColor: '	#778899',
                    cubicInterpolationMode: "monotone",
                  },
                  {
                    label: 'Smoke',
                    data:  this.Smoke_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"#6A5ACD",
                    borderWidth: 2,
                    pointBackgroundColor:'#6A5ACD',
                    pointHoverBackgroundColor: '#6A5ACD',
                    cubicInterpolationMode: "monotone",
                  },
                  
              
              
                 
                ]
              },
              options: {
                responsive : true,
                title:{
                  text:"Gas Sensor",
                  display:true
                },
                scales: {
                  yAxes:[{
                  scaleLabel: {
                      display: true,
                  },
                    ticks: {
                        beginAtZero:true
                    }
                  }]
                  },
                  animation:
                  {
                    duration:3000,
                    easing:'linear',
                  }
                }
              });
    
          })

          this.LPG_Subscription = this.testservice.getLPG().subscribe (data => {

            //   //Data Slicing
            data.splice (0, (data.length - 10));
      
              //
            this.LPG_Values = data.map (item => +item.payload.toJSON().toString().replace ('ppm' , ''));
            this.LPG_TimeStamps  = data.map ( data => {
              let today = new Date();
              let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                return time;
      
              });
              var labels1 = this.temperatureDummyData.Tempeature.map(function(e) {
              return e.Labels;
                });
  
            console.log('labels1', this.LPG_TimeStamps)
            console.log ( " CO Subscription Hit" , this.LPG_Values);
            this.Gas_Chart = new Chart('lineChart3', {
              type: 'line',
              data: {
                labels: this.LPG_TimeStamps,
                datasets: [
                  {
                    label: 'CO',
                    data:  this.CO_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"#2CC2A5",
                    borderWidth: 1,
                    pointBackgroundColor:'#2CC2A5',
                    pointHoverBackgroundColor: '#2CC2A5',
                    cubicInterpolationMode: "monotone",
                  },
                  {
                    label: 'LPG',
                    data:  this.LPG_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"	#778899",
                    borderWidth: 1,
                    pointBackgroundColor:'	#778899',
                    pointHoverBackgroundColor: '	#778899',
                    cubicInterpolationMode: "monotone",
                  },
                  {
                    label: 'Smoke',
                    data:  this.Smoke_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"#6A5ACD",
                    borderWidth: 1,
                    pointBackgroundColor:'#6A5ACD',
                    pointHoverBackgroundColor: '#6A5ACD',
                    cubicInterpolationMode: "monotone",
                  },
                  
                  
                  
              
              
                 
                ]
              },
              options: {
                responsive : true,
                title:{
                  text:"Gas Sensor",
                  display:true
                },
                scales: {
                  yAxes:[{
                  scaleLabel: {
                      display: true,
                  },
                    ticks: {
                        beginAtZero:true
                    }
                  }]
                  },
                  animation:
                  {
                    duration:3000,
                    easing:'linear',
                  }
                }
              });
    
          })


          this.Smoke_Subscription = this.testservice.getSmoke().subscribe (data => {

            //   //Data Slicing
            data.splice (0, (data.length - 10));
      
              //
            this.Smoke_Values = data.map (item => +item.payload.toJSON().toString().replace ('ppm' , ''));
            this.Smoke_TimeStamps  = data.map ( data => {
              let today = new Date();
              let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                return time;
      
              });
              var labels1 = this.temperatureDummyData.Tempeature.map(function(e) {
              return e.Labels;
                });
  
            console.log('labels1', this.Smoke_TimeStamps)
            console.log ( " CO Subscription Hit" , this.Smoke_Values);
            this.Gas_Chart = new Chart('lineChart3', {
              type: 'line',
              data: {
                labels: this.LPG_TimeStamps,
                datasets: [
                  {
                    label: 'CO',
                    data:  this.CO_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"#2E5BFF",
                    borderWidth: 1,
                    pointBackgroundColor:'#2E5BFF',
                    pointHoverBackgroundColor: '#2E5BFF',
                    cubicInterpolationMode: "monotone",
                  },
                  {
                    label: 'LPG',
                    data:  this.LPG_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"	#778899",
                    borderWidth: 1,
                    pointBackgroundColor:'	#778899',
                    pointHoverBackgroundColor: '	#778899',
                    cubicInterpolationMode: "monotone",
                  },
                  {
                    label: 'Smoke',
                    data:  this.Smoke_Values,
                    fill:false,
                    lineTension:2,
                    borderColor:"#6A5ACD",
                    borderWidth: 1,
                    pointBackgroundColor:'#6A5ACD',
                    pointHoverBackgroundColor: '#6A5ACD',
                    cubicInterpolationMode: "monotone",
                  },
                  
                  
                  
              
              
                 
                ]
              },
              options: {
                responsive : true,
                title:{
                  text:"Gas Sensor",
                  display:true
                },
                scales: {
                  yAxes:[{
                  scaleLabel: {
                      display: true,
                  },
                    ticks: {
                        beginAtZero:true
                    }
                  }]
                  },
                  animation:
                  {
                    duration:3000,
                    easing:'linear',
                  }
                }
              });
    
          })
        }

}
