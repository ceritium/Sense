import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule }   from '@angular/forms';
import { HttpModule }    from '@angular/http';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent }         from './app.component';
import { DashboardComponent }   from './dashboard.component';
import { DevicesComponent }      from './devices.component';
import { UserComponent }      from './user.component';
import { DeviceDetailComponent }  from './device-detail.component';
import { DeviceService }          from './device.service';
import { MetricService }          from './metric.service';
import { MeasureService }          from './measure.service';
import { UserService }          from './user.service';
import { DeviceSearchComponent }  from './device-search.component';
import { MetricComponent }      from './metric.component';
import { MetricDetailComponent }      from './metric-detail.component';
import { MeasureComponent }      from './measure.component';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule
  ],
  declarations: [
    AppComponent,
    DashboardComponent,
    DeviceDetailComponent,
    DevicesComponent,
    DeviceSearchComponent,
    MetricComponent,
    MetricDetailComponent,
    MeasureComponent,
    UserComponent
  ],
    providers: [ DeviceService, MetricService, MeasureService, UserService ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
