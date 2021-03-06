import { Injectable } from '@angular/core';
import { Http, Headers, RequestOptions, Response } from '@angular/http'
import 'rxjs/add/operator/map'
import { User } from '../model/user.model';
import { AppComponent } from '../app.component';

@Injectable()
// Injectable
// ({
//   providedIn: 'root'
// })
export class AuthService {

  constructor(public http: Http) { }



  public logIn(user: User){

    let headers = new Headers();
    headers.append('Accept', 'application/json')
    // creating base64 encoded String from user name and password

    var base64Credential: string = btoa( user.mail+ ':' + user.password);
    headers.append("Authorization", "Basic " + base64Credential);

    let options = new RequestOptions();
    options.headers=headers;
    localStorage.clear;
    return this.http.get(AppComponent.API_URL+"/account/login" ,   options)
      .map((response: Response) => {
      // login successful if there's a jwt token in the response
      let user = response.json().principal;// the returned user object is a principal object
      console.log(response.json());
      if (user) {
        // store user details  in local storage to keep user logged in between page refreshes
        localStorage.setItem('currentUser', JSON.stringify(user));
      }
    });
  }

  logOut() {
    // remove user from local storage to log user out
    return this.http.get(AppComponent.API_URL+"/account/logout")
      .map((response: Response) => {
        localStorage.removeItem('currentUser');
      });

  }
}
