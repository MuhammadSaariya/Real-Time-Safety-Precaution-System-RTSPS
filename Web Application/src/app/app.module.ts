import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule } from "@angular/router";
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavBarComponent } from './nav-bar/nav-bar.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
// import { from } from 'rxjs';
import { MaterialModule } from './material/material.module';
import { GridComponent } from './grid/grid.component';
import {ChartsModule} from 'ng2-charts';
import {FlexLayoutModule} from '@angular/flex-layout';
import { LiveFeedComponent } from './live-feed/live-feed.component';
import { HttpClientModule } from '@angular/common/http';
import {MatVideoModule} from 'mat-video';
import { AngularFireModule } from '@angular/fire';
// import { AngularFirestoreModule } from '@angular/fire/firestore';
import { environment } from '../environments/environment';  
import { initializeApp } from 'firebase-admin';
import {AngularFireDatabaseModule, AngularFireDatabase} from '@angular/fire/database';
import {TestService} from './test.service';



@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    GridComponent,
    LiveFeedComponent,
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule,
    ChartsModule,
    FlexLayoutModule,
    RouterModule,
    HttpClientModule,
    MatVideoModule,
    AngularFireModule.initializeApp(environment.firebase),
  
    AngularFireDatabaseModule
  
    
    
  ],
  providers: [TestService,AngularFireDatabase],
  bootstrap: [AppComponent]
})
export class AppModule { }
