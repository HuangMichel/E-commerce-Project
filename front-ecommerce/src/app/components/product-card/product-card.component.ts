import { Component, OnInit, Input} from '@angular/core';
import {Product} from './../../model/product.model';

@Component({
  selector: 'app-product-card',
  templateUrl: './product-card.component.html',
  styleUrls: ['./product-card.component.css']
})
export class ProductCardComponent implements OnInit {

    @Input() product : Product;
    listCart :any;

  constructor() { }

  ngOnInit() {

  }

  onAdd(product: Product){
    var item = {id : product.productID, quantity : 1, ref: product.reference, price : product.price};
    console.log(JSON.parse(localStorage.getItem("cart")));
    this.listCart = JSON.parse(localStorage.getItem("cart"));
    if(this.listCart===null){
        this.listCart = [];
    }
    this.listCart.push(item);
    localStorage.setItem("cart", JSON.stringify(this.listCart));
  }
}