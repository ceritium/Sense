import { Injectable }    from '@angular/core';
import { Headers, Http } from '@angular/http';

import 'rxjs/add/operator/toPromise';

import { Device } from './device';

@Injectable()
export class DeviceService {

  private headers = new Headers({'Content-Type': 'application/json'});
  private devicesUrl = 'http://localhost:4000/api/v1/devices';

  constructor(private http: Http) { }

  getDevices(): Promise<Device[]> {
    return this.http.get(this.devicesUrl)
               .toPromise()
               .then(response => response.json().data as Device[])
               .catch(this.handleError);
  }


  getDevice(id: number): Promise<Device> {
    const url = `${this.devicesUrl}/${id}`;
    return this.http.get(url)
      .toPromise()
      .then(response => response.json().data as Device)
      .catch(this.handleError);
  }

  delete(id: number): Promise<void> {
    const url = `${this.devicesUrl}/${id}`;
    return this.http.delete(url, {headers: this.headers})
      .toPromise()
      .then(() => null)
      .catch(this.handleError);
  }

  create(name: string): Promise<Device> {
    return this.http
      .post(this.devicesUrl, JSON.stringify({name: name}), {headers: this.headers})
      .toPromise()
      .then(res => res.json().data as Device)
      .catch(this.handleError);
  }

  update(device: Device): Promise<Device> {
    const url = `${this.devicesUrl}/${device.id}`;
    return this.http
      .post(url, JSON.stringify(device), {headers: this.headers})
      .toPromise()
      .then(() => device)
      .catch(this.handleError);
  }

  private handleError(error: any): Promise<any> {
    console.error('An error occurred', error); // for demo purposes only
    return Promise.reject(error.message || error);
  }
}



/*
Copyright 2017 Google Inc. All Rights Reserved.
Use of this source code is governed by an MIT-style license that
can be found in the LICENSE file at http://angular.io/license
*/
