import { Component} from '@angular/core';
import { Router }            from '@angular/router';
import { Location }               from '@angular/common';
import { FormBuilder, Validators } from '@angular/forms';

import { User }                from './user';
import { UserService }         from './user.service';

@Component({
  selector: 'register-component',
  templateUrl: './register.component.html',
  styleUrls: [ './register.component.css' ]
})

export class RegisterComponent {
  user = User;
  public registerForm = this.fb.group({
    first_name: ["", Validators.required],
    last_name: ["", Validators.required],
    username: ["", Validators.required],
    email: ["", Validators.required],
    password: ["", Validators.required]
  });
  
  constructor(
    private userService: UserService,
    private location: Location,
    public fb: FormBuilder
  ) { }

  register(user_attrs):void {
    let values = this.registerForm.controls
    var user: User = {id: null, email: values.email.value , first_name: values.first_name.value, last_name: values.last_name.value, username: values.username.value, password: values.password.value} 
    this.userService.create(user)
      .then( () => this.goBack())
      // .catch( alert();
  }

  goBack(): void {
    this.location.back(); 
  }
}
