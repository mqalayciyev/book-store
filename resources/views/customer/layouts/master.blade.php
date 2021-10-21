<!DOCTYPE html>
<html lang="{{ config('app.locale') }}">

<head>
    <meta charset="utf-8">
    <title>@yield('title', config('app.name'))</title>
    <meta name="description" content="@yield('description') {{ old('description', $website_info->description) }}">
    <meta name="keywords" content="@yield('keywords') {{ old('keywords', $website_info->keywords) }}">
    @include('customer.layouts.partials.head')
    @yield('head')
</head>

<body>
@include('customer.layouts.partials.header')
@yield('content')
@include('customer.layouts.partials.footer')

<!-- jQuery Plugins -->
<script src="{{ asset('js/jquery.min.js') }}"></script>
<script src="{{ asset('js/bootstrap.min.js') }}"></script>
<script src="{{ asset('js/slick.min.js') }}"></script>
<script src="{{ asset('js/nouislider.min.js') }}"></script>
<script src="{{ asset('js/jquery.zoom.min.js') }}"></script>
<script src="{{ asset('js/app.js') }}"></script>
<script src="{{ asset('js/main.js') }}"></script>
<script src="{{ asset('js/sweetalert2@10.js') }}"></script>
@yield('footer')
</body>
</html>