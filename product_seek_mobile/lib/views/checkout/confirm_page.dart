import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/checkout_view_model.dart';
import 'package:product_seek_mobile/views/order/order_page.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage({this.checkoutitems, this.paymentType, this.isFromCart});

  final CheckoutModel checkoutitems;
  final String paymentType;
  final bool isFromCart;

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final formKey = GlobalKey<FormState>();

  bool _isCard = false;
  bool _saveCard = false;
  bool _isLoading = false;
  bool _showPassword = false;

  final TextEditingController _cardNumber =
      new MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _cardExpiry =
      new MaskedTextController(mask: '00/00');
  final TextEditingController _cardCvv = TextEditingController();

  final TextEditingController _paypalEmail = TextEditingController();
  final TextEditingController _paypalPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    switch (widget.paymentType) {
      case "card":
        {
          _isCard = true;
          break;
        }
      case "paypal":
        {
          _isCard = false;
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm order"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Form(
                  key: formKey,
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: _isCard,
                            child: _buildCardNumberForm(),
                          ),
                          Visibility(
                            visible: !_isCard,
                            child: _buildEmailFormField(),
                          ),
                          Visibility(
                            visible: !_isCard,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                _buildPasswordFormField(),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _isCard,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                _buildCardExpiry(),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _isCard,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                _buildCardCvv(),
                              ],
                            ),
                          ),
                        ],
                      ))),
            )),
            Container(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount.",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.checkoutitems.total.toString(),
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      onPressed: _isLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                checkoutViewModel
                                    .orderItems(widget.checkoutitems)
                                    .then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (widget.isFromCart) {
                                    checkoutViewModel.clearCart();
                                  }
                                  globalScaffoldkey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                        child:
                                            Text("Item ordered successfully")),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                });
                              }
                            },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        child: Center(
                          child: Text("Pay Now",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberForm() {
    return TextFormField(
      controller: _cardNumber,
      validator: (value) {
        if (value.trim().isEmpty) {
          return "Please enter your card number";
        } else if (value.trim().length != 19) {
          return "Please enter valid card number";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.credit_card),
          border: OutlineInputBorder(),
          labelText: 'Card Number'),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildCardExpiry() {
    return TextFormField(
      controller: _cardExpiry,
      validator: (value) {
        if (value.trim().isEmpty) {
          return "Please enter your card's expiry date";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.date_range),
          border: OutlineInputBorder(),
          labelText: 'Expiry Date (mm/yy)'),
      keyboardType: TextInputType.datetime,
    );
  }

  Widget _buildCardCvv() {
    return TextFormField(
      controller: _cardCvv,
      validator: (value) {
        if (value.trim().isEmpty) {
          return "Please enter your card cvv number";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.date_range),
          border: OutlineInputBorder(),
          labelText: 'Cvv'),
      keyboardType: TextInputType.datetime,
      inputFormatters: [LengthLimitingTextInputFormatter(3)],
    );
  }

  Widget _buildSaveCard() {
    return Row(
      children: [
        Checkbox(
            value: _saveCard,
            onChanged: (value) {
              setState(() {
                _saveCard = value;
              });
            }),
        Text("Save card info for this device")
      ],
    );
  }

  Widget _buildEmailFormField() {
    return TextFormField(
      controller: _paypalEmail,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(),
          labelText: 'Email'),
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: _paypalPassword,
      validator: validatePassword,
      obscureText: !_showPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showPassword = !this._showPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Password'),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.trim().isNotEmpty) {
      if (!regex.hasMatch(value.trim()))
        return 'Please enter valid email';
      else
        return null;
    } else
      return 'Please enter your Email';
  }

  String validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.trim().length < 8)
        return 'Password must be more than or equal to 8 characters';
      else
        return null;
    } else
      return 'Please enter your password';
  }
}
