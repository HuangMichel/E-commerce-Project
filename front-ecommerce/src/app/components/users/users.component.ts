import { Component, OnInit } from '@angular/core';
import {User} from '../../model/user.model';
import {UpdateUserService} from '../../services/updateUser.service';
import {AuthService} from '../../services/auth.service';
import {Router} from '@angular/router';
import {Http} from '@angular/http';
import {AccountService} from '../../services/account.service';
import {UsersService} from '../../services/users.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  currentUser: User;
  usersPage:any;
  newUser: User=new User();
  userDelete:User=new User();
  userModified: User=new User();
  errorMessage: string;
  constructor(public updateUserService:UpdateUserService,public usersService:UsersService,public accountService: AccountService, public router: Router,public http: Http) {

  }

  ngOnInit() {
    this.getUsers();

  }
  saveUser() {
    console.log(this.newUser);
    this.accountService.createAccount(this.newUser)
      .subscribe(data => {
        this.router.navigate(['/users']);
        //console.log(data);
      }, err => {
        console.log(err);
        this.errorMessage = "username already exist";console.log(this.errorMessage);
      }
    )
  }
  onEditUser(user:User){
    this.newUser=user;
  }
  updateUser(){

    this.userModified.firstName=this.newUser.firstName;
    this.userModified.lastName=this.newUser.lastName;
    this.userModified.gender=this.newUser.gender;
    this.userModified.password=this.newUser.password;
    this.userModified.mail=this.newUser.mail;
    this.userModified.address=this.newUser.address;
    this.userModified.country=this.newUser.country;
    this.userModified.town=this.newUser.town;
    this.userModified.postalCode=this.newUser.postalCode;
    this.userModified.phoneNumber=this.newUser.phoneNumber;
    this.userModified.dateOfBirth=this.newUser.dateOfBirth;
    this.userModified.role=this.newUser.role;
    this.updateUserService.saveUser(this.userModified)
      .subscribe(data=>{
       //console.log(data);
      },

      err=>console.log(err));
  }
  DeleteUser(user:User){

    this.userDelete.mail=user.mail;
    this.updateUserService.deleteUser(this.userDelete)
      .subscribe(data=>{
        //console.log(data);
        alert("deleted")
      },
        err=>console.log(err));
  }
  getUsers(){
    this.usersService.getUsers()
      .subscribe(data=>{
          this.usersPage=data;
          //console.log(data);
        },
        err=>{

          console.log(err);
        })
    }
}
