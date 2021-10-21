<?php

namespace App\Http\Controllers\Customer;

use App\Models\Order;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::select('order.*')->leftJoin('cart', 'cart.id', 'order.cart_id')->where('cart.user_id', auth()->id())->orderByDesc('order.created_at')->get();
        
        return view('customer.pages.orders', compact('orders'));
    }

    public function detail($id)
    {
        $order = Order::select('order.*')->leftJoin('cart', 'cart.id', 'order.cart_id')->where('cart.user_id', auth()->id())->where('order.id', $id)->firstOrFail();

        return view('customer.pages.order', compact('order'));
    }
}
