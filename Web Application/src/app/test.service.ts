import { Injectable } from '@angular/core';
import { AngularFireDatabase } from '@angular/fire/database';
import {AngularFirestore} from '@angular/fire/firestore';


@Injectable({
  providedIn: 'root'
})
export class TestService {
  

  constructor(public fireservices : AngularFireDatabase) { }

  getTemperatureData() {
    return this.fireservices.list('DHT22/Temperature').snapshotChanges();
  }

getHumidity()
{
  return this.fireservices.list('DHT22/Humidity').snapshotChanges();
}

 
getDust()
{
  return this.fireservices.list('Dust/Density').snapshotChanges();
}

getLPG ()
{
  return this.fireservices.list('Gas/LPG').snapshotChanges();
  
}

getCO ()
{
  return this.fireservices.list('Gas/CO').snapshotChanges();
  
}
getSmoke()
{
  return this.fireservices.list('Gas/Smoke').snapshotChanges();
}
getFlame()
{
  return this.fireservices.list('Flame').snapshotChanges();
}

}
