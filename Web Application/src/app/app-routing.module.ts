import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LiveFeedComponent } from './live-feed/live-feed.component';
import { GridComponent } from './grid/grid.component';



const routes: Routes = [
  {path:'', component: GridComponent},
  {path : 'live-feed' , component: LiveFeedComponent }

];
  

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

