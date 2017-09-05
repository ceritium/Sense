import 'rxjs/add/operator/switchMap';
import { Component, OnInit }      from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location }               from '@angular/common';

import { Metric }        from './metric';
import { Measure }        from './measure';
import { MetricService } from './metric.service';
import { MeasureService } from './measure.service';
import { MeasureComponent } from './measure.component';

@Component({
  selector: 'metric-detail',
  templateUrl: './metric-detail.component.html',
  styleUrls: [ './metric-detail.component.css' ]
})
export class MetricDetailComponent implements OnInit {
  metric: Metric;
  measures: Measure[];
  
  constructor(
    private metricService: MetricService,
    private measureService: MeasureService,
    private route: ActivatedRoute,
    private location: Location
  ) {}

  ngOnInit(): void {
    this.route.params
      .switchMap((params: Params) => this.metricService.getMetric(+params['device_id'], +params['id']))
      .subscribe(metric => this.metric = metric);
    this.route.params
      .switchMap((params: Params) => this.measureService.getMeasures(+params['device_id'], +params['id']))
      .subscribe(measures => this.measures = measures);    
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
