import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DashboardComponent }     from './dashboard.component';
import { DevicesComponent }       from './devices.component';
import { UserComponent }          from './user.component';
import { SessionComponent }       from './session.component';
import { RegisterComponent }      from './register.component';
import { DeviceDetailComponent }  from './device-detail.component';
import { MetricDetailComponent }  from './metric-detail.component';

const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'devices/:id', component: DeviceDetailComponent },
  { path: 'devices/:device_id/metrics/:id', component: MetricDetailComponent },
  { path: 'devices', component: DevicesComponent },
  { path: 'profile', component: UserComponent },
  { path: 'sign-in', component: SessionComponent },
  { path: 'sign-up', component: RegisterComponent },
  { path: '**', redirectTo: 'dashboard' }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
