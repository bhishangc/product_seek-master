<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
          $table->id();
          $table->string('order_no');
          $table->longText('products');
          $table->bigInteger('user_id');
          $table->string('status');
          $table->boolean('return_request');
          $table->boolean('returned');
          $table->date('delivered_date')->nullable();
          $table->longText('return_note')->nullable();
          $table->float('quantity');
          $table->float('total');
          $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
