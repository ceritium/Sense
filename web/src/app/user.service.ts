import { Injectable }    from '@angular/core';
import { Headers, Http } from '@angular/http';
import { Observable } from "rxjs/Rx"

import 'rxjs/add/operator/toPromise';

import { User } from './user';

@Injectable()
export class UserService {

  private headers = new Headers({'Content-Type': 'application/json'});
  private usersUrl = 'http://localhost:4000/api/v1/users';
  private currentUserUrl = `${this.usersUrl}/current`;
  private authenticateUserUrl = `${this.usersUrl}/authenticate`;
    
  constructor(private http: Http) { }

  getCurrentUser(): Promise<User> {
    return this.http.get(this.currentUserUrl)
      .toPromise()
      .then(response => response.json().data as User)
      .catch(this.handleError);
  }

  login(email, password): Promise<User> {
    let body = {user: {email: email, password: password}}
    console.log(body);
    return this.http.post(this.authenticateUserUrl, JSON.stringify(body), {headers: this.headers})
      .toPromise()
      .then( res => res.json().data as User)
      .catch(this.handleError);
    
  }

  create(user: User): Promise<User> {
    return this.http
      .post( this.usersUrl, JSON.stringify({user: user}), {headers: this.headers})
      .toPromise()
      .then(res => res.json().data as User)
      .catch(this.handleError);
  }

  updateCurrentUser(user: User): Promise<User> {
  var body:any={user: user};
    return this.http
      .put(this.currentUserUrl, JSON.stringify(body), {headers: this.headers})
      .toPromise()
      .then(() => user)
      .catch(this.handleError);
  }

  private handleError(error: any): Promise<any> {
    console.info('An error occurred', error);
    return Promise.reject(error.message || error);
  }
}

