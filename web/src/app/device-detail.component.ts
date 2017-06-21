import 'rxjs/add/operator/switchMap';
import { Component, OnInit }      from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location }               from '@angular/common';

import { Device }        from './device';
import { DeviceService } from './device.service';

@Component({
  selector: 'device-detail',
  templateUrl: './device-detail.component.html',
  styleUrls: [ './device-detail.component.css' ]
})
export class DeviceDetailComponent implements OnInit {
  device: Device;

  constructor(
    private deviceService: DeviceService,
    private route: ActivatedRoute,
    private location: Location
  ) {}

  ngOnInit(): void {
    this.route.params
      .switchMap((params: Params) => this.deviceService.getDevice(+params['id']))
      .subscribe(device => this.device = device);
  }

  save(): void {
    this.deviceService.update(this.device)
      .then(() => this.goBack());
  }

  goBack(): void {
    this.location.back();
  }
}
