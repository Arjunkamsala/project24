<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Virat Shopping - TShirt Collections</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            color: #333;
        }

        /* HEADER */
        header {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: white;
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 70px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        .logo {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .logo span { color: #e94560; }
        nav a {
            color: #ccc;
            text-decoration: none;
            margin-left: 25px;
            font-size: 15px;
            transition: color 0.2s;
        }
        nav a:hover { color: #e94560; }
        .cart-btn {
            background: #e94560;
            color: white !important;
            padding: 8px 18px;
            border-radius: 20px;
        }

        /* HERO BANNER */
        .hero {
            background: linear-gradient(135deg, #e94560, #0f3460);
            color: white;
            text-align: center;
            padding: 60px 20px;
        }
        .hero h1 { font-size: 42px; margin-bottom: 10px; }
        .hero p { font-size: 18px; opacity: 0.85; margin-bottom: 25px; }
        .hero .shop-btn {
            background: white;
            color: #e94560;
            padding: 12px 35px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s;
        }
        .hero .shop-btn:hover { transform: scale(1.05); }

        /* CATEGORIES */
        .categories {
            display: flex;
            justify-content: center;
            gap: 15px;
            padding: 30px 40px 10px;
            flex-wrap: wrap;
        }
        .category-btn {
            padding: 8px 22px;
            border: 2px solid #e94560;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            background: white;
            color: #e94560;
            transition: all 0.2s;
        }
        .category-btn:hover, .category-btn.active {
            background: #e94560;
            color: white;
        }

        /* SECTION TITLE */
        .section-title {
            text-align: center;
            padding: 30px 20px 10px;
            font-size: 28px;
            font-weight: 700;
            color: #1a1a2e;
        }
        .section-title span { color: #e94560; }
        .section-subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 25px;
            font-size: 15px;
        }

        /* PRODUCT GRID */
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 25px;
            padding: 20px 40px 50px;
            max-width: 1300px;
            margin: 0 auto;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
            position: relative;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .badge {
            position: absolute;
            top: 12px;
            left: 12px;
            background: #e94560;
            color: white;
            padding: 4px 10px;
            border-radius: 10px;
            font-size: 11px;
            font-weight: bold;
            z-index: 1;
        }
        .badge.new { background: #28a745; }
        .badge.sale { background: #e94560; }
        .badge.hot { background: #ff6b35; }

        .product-img {
            width: 100%;
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 70px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        }

        .product-info { padding: 15px; }
        .product-name {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 5px;
            color: #1a1a2e;
        }
        .product-desc {
            font-size: 13px;
            color: #888;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .sizes {
            display: flex;
            gap: 6px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }
        .size-tag {
            border: 1px solid #ddd;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 11px;
            color: #666;
        }

        .price-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .price {
            font-size: 20px;
            font-weight: 800;
            color: #e94560;
        }
        .old-price {
            font-size: 13px;
            text-decoration: line-through;
            color: #aaa;
            margin-left: 6px;
        }
        .add-btn {
            background: #1a1a2e;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: background 0.2s;
        }
        .add-btn:hover { background: #e94560; }

        /* STATS BAR */
        .stats-bar {
            background: #1a1a2e;
            color: white;
            display: flex;
            justify-content: space-around;
            padding: 25px;
            text-align: center;
        }
        .stat h3 { font-size: 28px; color: #e94560; }
        .stat p { font-size: 13px; color: #aaa; margin-top: 4px; }

        /* FOOTER */
        footer {
            background: #0f0f1a;
            color: #aaa;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }
        footer span { color: #e94560; }
    </style>
</head>
<body>

<!-- HEADER -->
<header>
    <div class="logo">Mahesh <span>Shopping</span></div>
    <nav>
        <a href="#">Home</a>
        <a href="#">TShirts</a>
        <a href="#">Hoodies</a>
        <a href="#">Sale</a>
        <a href="#" class="cart-btn">🛒 Cart (0)</a>
    </nav>
</header>

<!-- HERO -->
<div class="hero">
    <h1>🔥 New TShirt Collections 2026</h1>
    <p>Premium Quality | 100% Cotton | Free Shipping above ₹499</p>
    <a href="#products" class="shop-btn">Shop Now</a>
</div>

<!-- CATEGORIES -->
<div class="categories">
    <button class="category-btn active">All</button>
    <button class="category-btn">Graphic Tees</button>
    <button class="category-btn">Plain & Solid</button>
    <button class="category-btn">Oversized</button>
    <button class="category-btn">Polo</button>
    <button class="category-btn">Sports</button>
    <button class="category-btn">Printed</button>
</div>

<!-- PRODUCTS -->
<h2 class="section-title" id="products">Our <span>TShirt Collections</span></h2>
<p class="section-subtitle">Hand-picked premium quality tshirts for every occasion</p>

<div class="products">

    <div class="product-card">
        <div class="badge new">NEW</div>
        <div class="product-img">👕</div>
        <div class="product-info">
            <div class="product-name">Classic White Crew Neck</div>
            <div class="product-desc">100% premium cotton, everyday comfort</div>
            <div class="sizes">
                <span class="size-tag">S</span><span class="size-tag">M</span>
                <span class="size-tag">L</span><span class="size-tag">XL</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹399</span><span class="old-price">₹599</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="badge hot">HOT</div>
        <div class="product-img">🖤</div>
        <div class="product-info">
            <div class="product-name">Oversized Black Drop</div>
            <div class="product-desc">Streetwear style oversized fit, drop shoulder</div>
            <div class="sizes">
                <span class="size-tag">S</span><span class="size-tag">M</span>
                <span class="size-tag">L</span><span class="size-tag">XL</span><span class="size-tag">XXL</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹549</span><span class="old-price">₹799</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="badge sale">SALE</div>
        <div class="product-img">🌊</div>
        <div class="product-info">
            <div class="product-name">Ocean Blue Graphic Tee</div>
            <div class="product-desc">Abstract ocean wave graphic print design</div>
            <div class="sizes">
                <span class="size-tag">S</span><span class="size-tag">M</span><span class="size-tag">L</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹449</span><span class="old-price">₹699</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="badge new">NEW</div>
        <div class="product-img">🟢</div>
        <div class="product-info">
            <div class="product-name">Forest Green Polo</div>
            <div class="product-desc">Smart casual polo with button collar</div>
            <div class="sizes">
                <span class="size-tag">S</span><span class="size-tag">M</span>
                <span class="size-tag">L</span><span class="size-tag">XL</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹599</span><span class="old-price">₹899</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="product-img">🔴</div>
        <div class="product-info">
            <div class="product-name">Red Vintage Round Neck</div>
            <div class="product-desc">Washed vintage look, soft cotton blend</div>
            <div class="sizes">
                <span class="size-tag">M</span><span class="size-tag">L</span>
                <span class="size-tag">XL</span><span class="size-tag">XXL</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹479</span><span class="old-price">₹699</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="badge hot">HOT</div>
        <div class="product-img">⚡</div>
        <div class="product-info">
            <div class="product-name">Thunder Sports DryFit</div>
            <div class="product-desc">Moisture wicking dryfit for gym & sports</div>
            <div class="sizes">
                <span class="size-tag">S</span><span class="size-tag">M</span>
                <span class="size-tag">L</span><span class="size-tag">XL</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹499</span><span class="old-price">₹799</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="badge sale">SALE</div>
        <div class="product-img">🌸</div>
        <div class="product-info">
            <div class="product-name">Pastel Pink Floral Print</div>
            <div class="product-desc">Subtle floral all-over print, relaxed fit</div>
            <div class="sizes">
                <span class="size-tag">XS</span><span class="size-tag">S</span>
                <span class="size-tag">M</span><span class="size-tag">L</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹429</span><span class="old-price">₹649</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

    <div class="product-card">
        <div class="badge new">NEW</div>
        <div class="product-img">🦁</div>
        <div class="product-info">
            <div class="product-name">Lion King Printed Tee</div>
            <div class="product-desc">Bold lion face graphic, unisex streetwear</div>
            <div class="sizes">
                <span class="size-tag">S</span><span class="size-tag">M</span>
                <span class="size-tag">L</span><span class="size-tag">XL</span><span class="size-tag">XXL</span>
            </div>
            <div class="price-row">
                <div><span class="price">₹529</span><span class="old-price">₹799</span></div>
                <button class="add-btn">Add to Cart</button>
            </div>
        </div>
    </div>

</div>

<!-- STATS -->
<div class="stats-bar">
    <div class="stat"><h3>10,000+</h3><p>Happy Customers</p></div>
    <div class="stat"><h3>500+</h3><p>TShirt Designs</p></div>
    <div class="stat"><h3>100%</h3><p>Cotton Quality</p></div>
    <div class="stat"><h3>Free</h3><p>Shipping above ₹499</p></div>
</div>

<!-- FOOTER -->
<footer>
    <p>&copy; 2024 <span>Mahesh Shopping</span> | Premium TShirt Collections | Made with ❤️ in India</p>
</footer>

</body>
</html>
