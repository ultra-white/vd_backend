<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = ['name', 'price', 'image', 'quantity'];

    public function images() {
        return $this->hasMany(ProductImage::class);
    }

    public function detail() {
        return $this->hasOne(ProductDetail::class);
    }

    public function orderItems() {
        return $this->hasMany(OrderItem::class);
    }
}
