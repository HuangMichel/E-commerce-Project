import {User} from './user.model';
import {Payment} from './payment.model';
import {Product} from './product.model';
import {Order} from './order.model';
export class Cartitem {
  id: string;
  quantity: Int8Array;
  order: Order;
  product: Product;
  }