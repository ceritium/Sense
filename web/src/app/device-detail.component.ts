import 'rxjs/add/operator/switchMap';
import { Component, OnInit }      from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location }               from '@angular/common';

import { Device }        from './device';
import { Metric }        from './metric';
import { DeviceService } from './device.service';
import { MetricService } from './metric.service';
import { MetricComponent } from './metric.component';

@Component({
  selector: 'device-detail',
  templateUrl: './device-detail.component.html',
  styleUrls: [ './device-detail.component.css' ]
})
export class DeviceDetailComponent implements OnInit {
  device: Device;
  metrics: Metric[];
  
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
