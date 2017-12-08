import { Component} from '@angular/core';
import { Router }            from '@angular/router';
import { Location }               from '@angular/common';

import { User }                from './user';
import { UserService }         from './user.service';

@Component({
  selector: 'user-component',
  templateUrl: './user.component.html',
  styleUrls: [ './user.component.css' ]
})

export class UserComponent {
  user: User;

  constructor(
    private userService: UserService,
    private location: Location
  ) { }

  login(user: string, password: string):void {
    
  }
}

