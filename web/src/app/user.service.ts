import { Injectable }    from '@angular/core';
import { Headers, Http } from '@angular/http';

import 'rxjs/add/operator/toPromise';

import { User } from './user';

@Injectable()
export class UserService {

  private headers = new Headers({'Content-Type': 'application/json'});
  private usersUrl = 'http://localhost:4000/api/v1/users';
  private currentUserUrl = '${usersUrl}/current';
  private authenticateUserUrl = '${usersUrl}/authenticate';
    
  constructor(private http: Http) { }

  getCurrentUser(): Promise<User> {
    return this.http.get(this.currentUserUrl)
      .toPromise()
      .then(response => response.json().data as User)
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
    console.error('An error occurred', error); // for demo purposes only
    return Promise.reject(error.message || error);
  }
}

