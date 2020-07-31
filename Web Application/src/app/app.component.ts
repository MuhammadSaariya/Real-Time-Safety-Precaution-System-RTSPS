import { Component,OnInit, OnDestroy } from '@angular/core';
import {TestService} from './test.service';
import { Subscription } from 'rxjs';




@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']

})
export class AppComponent implements OnInit, OnDestroy {
  title(title: any) {
    throw new Error("Method not implemented.");
  }
  // getTempSubs: Subscription; 
  

  constructor  (/*private testService : TestService*/) {}
  ngOnDestroy(): void {
    throw new Error("Method not implemented.");
  }
  // ngOnDestroy(): void {
  //   this.getTempSubs.unsubscribe();
  // }
  ngOnInit()
  {
    // console.log('Getting db items');
    // let temp = [];
    // this.getTempSubs = this.testService.getTemerature().subscribe(data => {console.log('subscription hit');temp = data.map(item =>item.payload.toJSON());console.log(temp)});
    // console.log(temp);

  
  }
}
