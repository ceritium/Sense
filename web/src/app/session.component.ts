import { Component} from '@angular/core';
import { Router }            from '@angular/router';
import { Location }               from '@angular/common';
import { FormBuilder, Validators } from '@angular/forms';

import { User }                from './user';
import { UserService }         from './user.service';

@Component({
  selector: 'session-component',
  templateUrl: './session.component.html',
  styleUrls: [ './session.component.css' ]
})

export class SessionComponent {
  user = User;
  public loginForm = this.fb.group({
    email: ["", Validators.email],
    password: ["", Validators.required]
  });
  
  constructor(
    private userService: UserService,
    private location: Location,
    public fb: FormBuilder
  ) { }

  login(user_attrs):void {
    let values = this.loginForm.controls
    this.userService.login(values.email.value, values.password.value)
      .then( (value: User) => alert("yay! logged") || console.log(value))
      .catch( () => alert("nope"))
  }
}
