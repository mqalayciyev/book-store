@extends('customer.layouts.master')
@section('title', __('content.Payment'))
@section('head')
    <style>
        /* CSS for Credit Card Payment form */
        .credit-card-box .panel-title {
            display: inline;
            font-weight: bold;
        }

        .credit-card-box .form-control.error {
            border-color: red;
            outline: 0;
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(255, 0, 0, 0.6);
        }

        .credit-card-box label.error {
            font-weight: bold;
            color: red;
            padding: 2px 8px;
            margin-top: 2px;
        }

        .credit-card-box .payment-errors {
            font-weight: bold;
            color: red;
            padding: 2px 8px;
            margin-top: 2px;
        }

        .credit-card-box label {
            display: block;
        }

        /* The old "center div vertically" hack */
        .credit-card-box .display-table {
            display: table;
        }

        .credit-card-box .display-tr {
            display: table-row;
        }

        .credit-card-box .display-td {
            display: table-cell;
            vertical-align: middle;
            width: 50%;
        }

        /* Just looks nicer */
        .credit-card-box .panel-heading img {
            min-width: 180px;
        }
    </style>
@endsection
@section('content')
    <!-- BREADCRUMB -->
    <div id="breadcrumb">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="{{ route('homepage') }}">@lang('content.Home')</a></li>
                <li class="active">@lang('content.Payment')</li>
            </ul>
        </div>
    </div>
    <!-- /BREADCRUMB -->
    <div class="section">
        <div class="container">
            @include('common.errors.validate')
            <div class="row">
                <form action="{{ route('pay') }}" method="post">
                    {{ csrf_field() }}
                    
                    <div class="col-md-6">
                        <div class="billing-details">
                            <div class="section-title">
                                <h3 class="title">@lang('content.Billing Details')</h3>
                            </div>
                            <div class="form-group">
                                <input class="input" type="text" name="first_name" placeholder="@lang('content.First Name')"
                                       value="{{ old('first_name', auth()->user()->first_name) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="text" name="last_name" placeholder="@lang('content.Last Name')" value="{{ old('last_name', auth()->user()->last_name) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="email" name="email" placeholder="@lang('content.Email')" value="{{ old('email', auth()->user()->email) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="text" name="address" placeholder="@lang('content.Address')" value="{{ old('address', $user_detail->address) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="text" name="city" placeholder="@lang('content.City')" value="{{ old('city', $user_detail->city) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="text" name="country" placeholder="@lang('content.Country')" value="{{ old('country', $user_detail->country) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="text" name="zip_code" placeholder="@lang('content.ZIP Code')" value="{{ old('zip_code', $user_detail->zip_code) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="tel" name="phone" placeholder="@lang('content.Phone')" value="{{ old('phone', $user_detail->phone) }}">
                            </div>
                            <div class="form-group">
                                <input class="input" type="tel" name="mobile" placeholder="@lang('content.Mobile')" value="{{ old('mobile', auth()->user()->mobile) }}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        {{-- <div class="shiping-methods">
                            <div class="section-title">
                                <h4 class="title">@lang('content.Shipping Methods')</h4>
                            </div>
                            <div class="input-checkbox">
                                <input type="radio" name="shipping" id="shipping-1" checked>
                                <label for="shipping-1">@lang('content.Free Shipping') - 0.00 $</label>
                                <div class="caption">
                                    <p>@lang('content.Free Shipping Description')<p>
                                </div>
                            </div>
                            <div class="input-checkbox">
                                <input type="radio" name="shipping" id="shipping-2">
                                <label for="shipping-2">Standard - $4.00</label>
                                <div class="caption">
                                    <p>@lang('content.Standard Description')<p>
                                </div>
                            </div>
                        </div> --}}

                        <div class="payments-methods">
                            <input type="hidden" id="paymentMethod" name="payment_method" value="1">
                            <div class="section-title">
                                <h4 class="title">@lang('content.Payments Methods')</h4>
                            </div>
                            {{-- <div class="input-checkbox">
                                <input type="radio" name="payments" id="payments-1" checked>
                                <label for="payments-1">Çatdırıldıqda nağd ödə</label>
                                <div class="caption">
                                    <p>
                                        {{ old('delivery', $website_info->delivery) }}
                                    <p>
                                </div>
                            </div> --}}
                            <div class="input-checkbox">
                                <input type="radio" name="payments" id="payments-2" checked>
                                <label for="payments-2">@lang('content.Direct Bank Transfer')</label>
                                <div class="caption">
                                    <p>
                                        {{ old('delivery', $website_info->delivery) }}
                                    <p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="pull-left">
                            <button type="submit" value="1" class="primary-btn">@lang('content.Pay')</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
@section('footer')
    <script>
        var $form = $('#payment-form');
        $form.find('.subscribe').on('click', payWithStripe);
        
        
        $("form").find("input[name='payments']").on('change', function(){
            let id = $(this).attr('id')
            let value = id.split("-")
            $("#paymentMethod").val(value[1])
            if(value[1] == 2){
                $('input[name=cardNumber]').attr('required', 'required');
                $('input[name=cardCVC]').attr('required', 'required');
                $('input[name=cardExpiry').attr('required', 'required');
            }
            else{
                $('input[name=cardNumber]').removeAttr('required');
                $('input[name=cardCVC]').removeAttr('required');
                $('input[name=cardExpiry').removeAttr('required');
            }
        })

       

        /* Fancy restrictive input formatting via jQuery.payment library*/
        $('input[name=cardNumber]').payment('formatCardNumber');
        $('input[name=cardCVC]').payment('formatCardCVC');
        $('input[name=cardExpiry').payment('formatCardExpiry');

        

        paymentFormReady = function () {
            if ($form.find('[name=cardNumber]').hasClass("success") &&
                $form.find('[name=cardExpiry]').hasClass("success") &&
                $form.find('[name=cardCVC]').val().length > 1) {
                return true;
            } else {
                return false;
            }
        }

        $form.find('.subscribe').prop('disabled', true);
        var readyInterval = setInterval(function () {
            if (paymentFormReady()) {
                $form.find('.subscribe').prop('disabled', false);
                clearInterval(readyInterval);
            }
        }, 250);
    </script>
@endsection