import { Component, OnInit } from '@angular/core';
import { Router }            from '@angular/router';

import { Device }                from './device';
import { DeviceService }         from './device.service';

@Component({
  selector: 'my-devices',
  templateUrl: './devices.component.html',
  styleUrls: [ './devices.component.css' ]
})
export class DevicesComponent implements OnInit {
  devices: Device[];
  selectedDevice: Device;

  constructor(
    private deviceService: DeviceService,
    private router: Router) { }

  getDevices(): void {
    this.deviceService
        .getDevices()
        .then(devices => this.devices = devices);
  }

  add(name: string): void {
    name = name.trim();
    if (!name) { return; }
    this.deviceService.create(name)
      .then(hero => {
        this.devices.push(hero);
        this.selectedDevice = null;
      });
  }

  delete(device: Device): void {
    this.deviceService
        .delete(device.id)
        .then(() => {
          this.devices = this.devices.filter(d => d !== device);
          if (this.selectedDevice === device) { this.selectedDevice = null; }
        });
  }

  ngOnInit(): void {
    this.getDevices();
  }

  onSelect(device: Device): void {
    this.selectedDevice = device;
  }

  gotoDetail(): void {
    this.router.navigate(['/devices', this.selectedDevice.id]);
  }
}


/*
Copyright 2017 Google Inc. All Rights Reserved.
Use of this source code is governed by an MIT-style license that
can be found in the LICENSE file at http://angular.io/license
*/
