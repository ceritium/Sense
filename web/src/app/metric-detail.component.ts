import 'rxjs/add/operator/switchMap';
import { Component, OnInit }      from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location }               from '@angular/common';
import { MatSnackBar }            from '@angular/material';

import { Metric }        from './metric';
import { Measure }        from './measure';
import { MetricService } from './metric.service';
import { MeasureService } from './measure.service';
import { MeasureComponent } from './measure.component';

import {DataSource} from '@angular/cdk/collections';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/of';

@Component({
  selector: 'metric-detail',
  templateUrl: './metric-detail.component.html',
  styleUrls: [ './metric-detail.component.css' ]
})
export class MetricDetailComponent implements OnInit {
  metric: Metric;
  measures: Measure[];
  metric_id: number;
  device_id: number;
  dataSource = {
    "chart": {
      "exportenabled": "1",
      "theme": "fusion",
      "rotatelabels": "1"
    },
    "data": [],
    "categories": [{
      "category": []
    }],
    "dataset": [{
      "seriesName": "Measure value",
      "renderAs": "line",
      "data": []
    }]
  };

  constructor(
    private metricService: MetricService,
    private measureService: MeasureService,
    private route: ActivatedRoute,
    private location: Location,
    public snackBar: MatSnackBar
  ) {}

  ngOnInit(): void {
    this.route.params
      .switchMap((params: Params) => this.metricService.getMetric(+params['device_id'], +params['id']))
      .subscribe(metric => this.metric = metric);
    this.route.params
      .switchMap((params: Params) => this.measureService.getMeasures(+params['device_id'], +params['id']))
      .subscribe(measures => {
        this.measures = measures
        measures.map( m =>  this.dataSource["dataset"][0]["data"].push({"value": m.value}))
        measures.map( m =>  this.dataSource["categories"][0]["category"].push({"label": m.timestamp.toString() | date:"short"}))
      });
  }

  openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, { duration: 2000 });
  }

  save(): void {
    this.metricService.update(this.metric)
      .then(() =>  this.openSnackBar('Metric saved', ''));
  }

  destroy(): void {
    this.metricService.delete(this.metric.id)
      .then(
        () =>
          this.openSnackBar('Metric destroyed', '') &&
          this.goBack());
  }

  goBack(): void {
    this.location.back();
  }
}
