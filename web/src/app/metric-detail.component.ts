import 'rxjs/add/operator/switchMap';
import { Component, OnInit }      from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location }               from '@angular/common';

import { Metric }        from './metric';
import { Measure }        from './measure';
import { MetricService } from './metric.service';
import { MeasureService } from './measure.service';

@Component({
  selector: 'metric-detail',
  templateUrl: './metric-detail.component.html',
  styleUrls: [ './metric-detail.component.css' ]
})
export class MetricDetailComponent implements OnInit {
  metric: Metric;
  measures: Measure[];
  
  constructor(
    private deviceService: DeviceService,
    private metricService: MetricService,
    private route: ActivatedRoute,
    private location: Location
  ) {}

  ngOnInit(): void {
    this.route.params
      .switchMap((params: Params) => this.deviceService.getDevice(+params['id']))
      .subscribe(device => this.device = device);
    this.route.params
      .switchMap((params: Params) => this.metricService.getMetrics(+params['id']))
      .subscribe(metrics => this.metrics = metrics);    
  }

  save(): void {
    this.deviceService.update(this.device)
      .then(() => this.goBack());
  }

  destroy(): void {
    this.deviceService.delete(this.device.id)
      .then(() => this.goBack());
  }
  
  goBack(): void {
    this.location.back();
  }
}
