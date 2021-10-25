@extends('customer.layouts.master')
@section('title', $category->category_name)
@section('head')
    <style>
        form.inline_block {
            display: inline-block;
        }

        div.section {
            position: relative;
        }

        .cart_div {
            position: fixed;
            right: 0;
            bottom: 0;
            z-index: 1;
        }

        .cart_div .dropdown.default-dropdown>.custom-menu {
            transform: translateX(-95%) translateY(-125px);
            top: 75%;
        }

        .color-red {
            color: #00A2E8;
        }

        .filter_size label:hover {
            cursor: pointer;
        }

        .filter_size input[type='checkbox']:hover {
            cursor: pointer;
        }

        #filter-by-color .colors {
            border: 2px solid transparent;
            padding: 0px;
            width: 38px;
            height: 38px;
            border-radius: 100%;
            margin: 0px;
            display: flex;
            justify-content: center;
            transition: 0.4s;
        }

        #filter-by-color .colors:hover {
            border: 2px solid #00A2E8 !important;
            padding: 0px;
            width: 38px;
            height: 38px;
            border-radius: 100%;
            margin: 0px;
            display: flex;
            justify-content: center;
        }

        #filter-by-color .colors span {
            align-self: center;
            display: inline-block;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
        }

    </style>
@endsection
@section('content')
    <!-- BREADCRUMB -->
    <div id="breadcrumb">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">@lang('content.Home')</a></li>
                <li class="active">{{ $category->category_name }}</li>
            </ul>
        </div>
    </div>
    <!-- /BREADCRUMB -->

    <!-- section -->
    <div class="section">
        <div class="cart_div">
            <ul class="header-btns">
                <!-- Cart -->
                <li class="header-cart dropdown default-dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                        <div class="header-btns-icon">
                            <i class="fa fa-shopping-cart"></i>
                            <span class="qty show_cartCount">{{ Cart::count() }}</span>
                        </div>
                    </a>
                    <div class="custom-menu">
                        <div id="shopping-cart" class="view_cart">
                            @if (count(Cart::content()) > 0)
                                <div class="shopping-cart-btns">
                                    <a href="{{ route('cart') }}" class="main-btn">@lang('header.View Cart')</a>
                                    <a href="{{ route('payment') }}" class="primary-btn">Checkout <i
                                            class="fa fa-arrow-circle-right"></i>
                                    </a>
                                </div>
                            @else
                                @lang('header.Empty, there is no product')
                            @endif
                        </div>
                    </div>
                </li>
                <!-- /Cart -->
            </ul>
        </div>
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div id="main" class="col-12">
                    <div class="store-filter clearfix">
                        <div class="pull-left col-lg-12">
                            <div class="sort-filter">
                                <span class="text-uppercase">@lang('content.Sort By'):</span>
                                <select class="input select">
                                    <option value="created_at">@lang('content.New')</option>
                                    <option value="sale_price">@lang('content.Price')</option>
                                </select>
                                <a href="javascript:void(0);" class="main-btn icon-btn sort_btn" id="desc">
                                    <i class="fa fa-arrow-down"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div id="store">
                        <!-- row -->
                        <div class="row products"></div>
                        <!-- /row -->
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@section('footer')
    <script>
        $(function() {

            $(document).on('click', '.sort_btn', function() {
                var category_name = '{{ $slug_category_name }}';
                var sorting_name = $(`#main .select option:selected`).val();
                var order = $(this).attr('id');
                var arrow = '';
                if (order == 'desc') {
                    arrow = '<i class="fa fa-arrow-up"></i>';
                    $('.sort_btn').attr('id', 'asc');
                    order = $(this).attr('id');
                } else {
                    arrow = '<i class="fa fa-arrow-down"></i>';
                    $('.sort_btn').attr('id', 'desc');
                    order = $(this).attr('id');
                }
                $.ajax({
                    url: '{{ route('category.category_sorting') }}',
                    method: 'GET',
                    data: {
                        sorting_name: sorting_name,
                        order: order,
                        category_name: category_name
                    },
                    success: function(data) {
                        $('.products').hide().html(data).fadeIn('slow');
                        $('.sort_btn').html(arrow);
                    }
                })
            });

            $(document).on('change', '.select', function() {
                var category_name = '{{ $slug_category_name }}';
                var sorting_name = $(this).val();
                var order = $('.sort_btn').attr('id');
                var arrow = '';
                if (order == 'desc') {
                    arrow = '<i class="fa fa-arrow-up"></i>';
                    $('.sort_btn').attr('id', 'asc');
                    order = $('.sort_btn').attr('id');
                } else {
                    arrow = '<i class="fa fa-arrow-down"></i>';
                    $('.sort_btn').attr('id', 'desc');
                    order = $('.sort_btn').attr('id');
                }
                $.ajax({
                    url: '{{ route('category.category_sorting') }}',
                    method: 'GET',
                    data: {
                        sorting_name: sorting_name,
                        order: order,
                        category_name: category_name
                    },
                    success: function(data) {
                        $('.products').hide().html(data).fadeIn('slow');
                        $('.sort_btn').html(arrow);
                    }
                })
            });

            $(document).on('click', '.add-to-cart', function() {
                var id = $(this).attr('id');
                var stok = $(this).attr('data-stok');
                if (parseInt(stok) > 0) {
                    $.ajax({
                        url: '{{ route('cart.add_to_cart') }}',
                        method: 'GET',
                        data: {
                            id: id
                        },
                        dataType: 'JSON',
                        success: function(data) {
                            $('.mobile-navbar').find('#shopping-cart').html(data.output);
                            $('.mobile-navbar').find('.view_cart').html(data.view_cart);
                            $('.mobile-navbar').find('#show_cartTotalPrice').html(data
                                .cart_total);
                            $('.desktop-navbar').find('#shopping-cart').html(data.output);
                            $('.desktop-navbar').find('.view_cart').html(data.view_cart);
                            $('.show_cartCount').html(data.cart_count);
                            $('.desktop-navbar').find('#show_cartTotalPrice').html(data
                                .cart_total);
                        }
                    });
                } else {
                    alert("{{ __('content.Out Stock') }}")
                }
            });

            products();

            function products() {
                var category_name = '{{ $slug_category_name }}';
                $.ajax({
                    url: '{{ route('category.products') }}',
                    method: 'GET',
                    data: {
                        category_name: category_name
                    },
                    success: function(data) {
                        // console.log(data);
                        $('.products').html(data);
                    }
                });




            };

            $(document).on('click', '.add-to-compare', function() {
                var id = $(this).attr('data-id');
                $.ajax({
                    url: "{{ route('compare.add_to_compare') }}",
                    type: "GET",
                    data: {
                        id: id
                    },
                    success: function(data) {
                        alert(data);
                    }
                })
            })
            $(document).on('click', '.add-wish-list', function() {
                var id = $(this).attr("data-id");
                $.ajax({
                    url: '{{ route('add_wish_list') }}',
                    method: 'GET',
                    data: {
                        id: id
                    },
                    success: function(data) {
                        alert(data);
                    }
                });
            })

            $(document).on('mouseenter', '.rating', function() {
                var index = $(this).data('index');
                var product_id = $(this).data('product_id');
                remove_star(product_id);
                for (var count = 1; count <= index; count++) {
                    $('#' + product_id + '-' + count).attr('class', 'rating fa fa-star');
                }
            })

            function remove_star(product_id) {
                for (var count = 1; count <= 5; count++) {
                    $('#' + product_id + '-' + count).attr('class', 'rating fa fa-star-o empty');
                }
            }


            $(document).on('click', '.rating', function() {
                var index = $(this).data('index');
                var product_id = $(this).data('product_id');
                $.ajax({
                    url: '{{ route('homepage.insert_ratings') }}',
                    method: 'GET',
                    data: {
                        index: index,
                        product_id: product_id
                    },
                    success: function(data) {
                        if (data == 'done') {
                            products('products_dotd');
                            products('products_l');
                            products('products_pfy');
                            alert('{{ __('content.Your rate: ') }}' + index);
                        } else {
                            alert('{{ __('content.There is some problem in System') }}');
                        }
                    }
                })
            })

            $(document).on('mouseleave', '.rating', function() {
                var index = $(this).data('index');
                var product_id = $(this).data('product_id');
                var rating = $(this).data('rating');
                remove_star(product_id);
                for (var count = 1; count <= rating; count++) {
                    $('#' + product_id + '-' + count).attr('class', 'rating fa fa-star');
                }
            })

            $(document).on('click', '.filter_brand', function() {
                var id = $(this).attr('id');
                var category_name = '{{ $slug_category_name }}';
                $.ajax({
                    url: '{{ route('category.brand_filter') }}',
                    method: 'GET',
                    data: {
                        id: id,
                        category_name: category_name
                    },
                    success: function(data) {
                        // console.log(data);
                        $('.products').hide().html(data).fadeIn('slow');
                    }
                });
            });
            $(document).on('click', '.filter_size', function() {
                var name = $("#filter-size").find('input:checked');
                console.log(name.length);
                let size = [];
                if (name.length > 0) {

                    for (let i = 0; i < name.length; i++) {
                        let id = name[i].id
                        if (size.indexOf(id) === -1) {
                            size.push(id);
                        }
                    }
                    var category_name = '{{ $slug_category_name }}';
                    $.ajax({
                        url: '{{ route('category.size_filter') }}',
                        method: 'GET',
                        data: {
                            size: size,
                            category_name: category_name
                        },
                        success: function(data) {
                            // console.log(data);
                            $('.products').hide().html(data).fadeIn('slow');
                        }
                    });
                } else {
                    products();
                }


            });
            $(document).on('click', '.filter_color', function() {
                var color = $(this).find('span').attr('data-color');
                var category_name = '{{ $slug_category_name }}';
                $.ajax({
                    url: '{{ route('category.color_filter') }}',
                    method: 'GET',
                    data: {
                        color: color,
                        category_name: category_name
                    },
                    success: function(data) {
                        // console.log(data);
                        $('.products').hide().html(data).fadeIn('slow');
                    }
                });
            });

            $(document).on('click', '.open-filters', function() {
                $("#aside.filter-area").css("display", 'block')
                $("body").css('overflow', 'hidden')
            })




            // PRICE SLIDER
            var slider = document.getElementById('price-slider');
            if (slider) {
                noUiSlider.create(slider, {
                    start: [0, 1000],
                    connect: true,
                    tooltips: [true, true],
                    format: {
                        to: function(value) {
                            return value.toFixed(2);
                        },
                        from: function(value) {
                            return value
                        },
                    },
                    range: {
                        'min': 0,
                        'max': 5000
                    }
                });


                document.getElementById('price-slider').addEventListener('click', function() {
                    var values = slider.noUiSlider.get();
                    var category_name = '{{ $slug_category_name }}';
                    $.ajax({
                        url: "{{ route('category.price_filter') }}",
                        type: "GET",
                        data: {
                            values: values,
                            category_name: category_name
                        },
                        success: function(data) {
                            $('.products').hide().html(data).fadeIn('slow');
                        }
                    });
                });

            }


        });
    </script>
@endsection
