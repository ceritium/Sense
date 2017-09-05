import 'rxjs/add/operator/switchMap';
import { Component, OnInit, Input }      from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location }               from '@angular/common';

import { Device }        from './device';
import { Metric }        from './metric';
import { MetricService } from './metric.service';

@Component({
  selector: 'metric',
  templateUrl: './metric.component.html',
  styleUrls: [ './metric.component.css' ]
})
export class MetricComponent implements OnInit {
  @Input()
  metric: Metric;
    
  constructor(
    private metricService: MetricService,
    private route: ActivatedRoute,
    private location: Location
  ) {}

  ngOnInit(): void {
    if(this.metric){
      this.metricService.getMetric(this.metric.device_id,
                                   this.metric.id)
        .then(metric => this.metric);
    }
  }

  save(): void {
    this.metricService.update(this.metric)
      .then(() => this.goBack());
  }

  destroy(): void {
    this.metricService.delete(this.metric.id)
      .then(() => this.goBack());
  }
  
  goBack(): void {
    this.location.back();
  }
}
