import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule }   from '@angular/forms';
import { HttpModule }    from '@angular/http';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent }         from './app.component';
import { DashboardComponent }   from './dashboard.component';
import { DevicesComponent }      from './devices.component';
import { DeviceDetailComponent }  from './device-detail.component';
import { DeviceService }          from './device.service';
import { MetricService }          from './metric.service';
import { MeasureService }          from './measure.service';
import { DeviceSearchComponent }  from './device-search.component';
import { MetricDetailComponent }      from './metric-detail.component';
import { MeasureComponent }      from './measure.component';

import { MaterialModule } from './material.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { FusionChartsModule } from 'angular-fusioncharts';
import FusionCharts from 'fusioncharts/core';
import MSCombi2D from 'fusioncharts/viz/mscombi2d';
import FusionTheme from 'fusioncharts/themes/es/fusioncharts.theme.fusion'

FusionChartsModule.fcRoot(FusionCharts, MSCombi2D, FusionTheme)

@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        HttpModule,
        AppRoutingModule,
        MaterialModule,
        BrowserAnimationsModule,
        FusionChartsModule
    ],
    declarations: [
        AppComponent,
        DashboardComponent,
        DeviceDetailComponent,
        DevicesComponent,
        DeviceSearchComponent,
        MetricDetailComponent,
        MeasureComponent
    ],
    providers: [ DeviceService, MetricService, MeasureService ],
    bootstrap: [ AppComponent ]
})
export class AppModule { }
