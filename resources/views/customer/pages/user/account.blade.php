@extends('customer.layouts.master')
@section('title', __('footer.My Account'))
@section('content') <!-- BREADCRUMB -->
<div id="breadcrumb">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">@lang('content.Home')</a></li>
            <li class="active">@lang('footer.My Account')</li>
        </ul>
    </div>
</div> <!-- /BREADCRUMB -->
<div class="section">
    <div class="container">
        <div class="myAccountPage myAccountStyle">
            <div class="section-title"><h3 class="title">@lang('header.My Account')</h3></div>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-12 MyAccountMenu">

                    <div class="panel-group accountMenu" id="accordion-2" role="tablist" aria-multiselectable="true">
                        <div class="panel">
                            <ul class="accountSubMenu">
                                <li class="{{ url()->current() == route('user.my_account') ? 'active' : '' }}">
                                    <a href="{{ route('user.my_account') }}">
                                        @lang('header.My Account')
                                    </a>
                                </li>
                                <li class="{{ url()->current() == route('orders')  ? 'active' : '' }}"><a
                                        href="{{ route('orders') }}">
                                        @lang('content.Orders')
                                    </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-9 col-sm-12">
                    @yield('content.account')
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('footer')
    @yield('script')
@endsection