import { Component, OnInit } from '@angular/core';
import { Router }            from '@angular/router';

import { Observable }        from 'rxjs/Observable';
import { Subject }           from 'rxjs/Subject';

// Observable class extensions
import 'rxjs/add/observable/of';

// Observable operators
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/debounceTime';
import 'rxjs/add/operator/distinctUntilChanged';

import { DeviceSearchService } from './device-search.service';
import { Device } from './device';

@Component({
  selector: 'device-search',
  templateUrl: './device-search.component.html',
  styleUrls: [ './device-search.component.css' ],
  providers: [DeviceSearchService]
})
export class DeviceSearchComponent implements OnInit {
  devices: Observable<Device[]>;
  private searchTerms = new Subject<string>();

  constructor(
    private deviceSearchService: DeviceSearchService,
    private router: Router) {}

  // Push a search term into the observable stream.
  search(term: string): void {
    this.searchTerms.next(term);
  }

  ngOnInit(): void {
    this.devices = this.searchTerms
      .debounceTime(300)        // wait 300ms after each keystroke before considering the term
      .distinctUntilChanged()   // ignore if next search term is same as previous
      .switchMap(term => term   // switch to new observable each time the term changes
        // return the http search observable
        ? this.deviceSearchService.search(term)
        // or the observable of empty heroes if there was no search term
        : Observable.of<Device[]>([]))
      .catch(error => {
        // TODO: add real error handling
        console.log(error);
        return Observable.of<Device[]>([]);
      });
  }

  gotoDetail(device: Device): void {
    let link = ['/detail', device.id];
    this.router.navigate(link);
  }
}


/*
Copyright 2017 Google Inc. All Rights Reserved.
Use of this source code is governed by an MIT-style license that
can be found in the LICENSE file at http://angular.io/license
*/
