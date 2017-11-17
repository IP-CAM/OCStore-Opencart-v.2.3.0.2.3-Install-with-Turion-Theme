 <div class="sidebar-widget hot-deals wow fadeInUp outer-bottom-xs">
     <h3 class="panel-heading"><p><?php echo $heading_title; ?></p></h3>
<div class="owl-carousel sidebar-carousel custom-carousel owl-theme outer-top-ss">
    <?php foreach (array_chunk($products, ceil(count($products) / 3)) as $products) { ?>
    <div class="item">
    <div class="products">
      <?php foreach ($products as $product) { ?>
      <div class="row">
        <div class="col-xs-5">
          <div class="image">
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a>
          </div>
        </div>
        <div class="col-xs-7">
           <div class="product-info text-left m-t-20">
              <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
              <div class="rating rateit-small"></div>
              <div class="product-price"> 
                <?php if ($product['price']) { ?>
                <p class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                <?php } ?>
                <?php if ($product['tax']) { ?>
                <!-- <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                <?php } ?> -->
                  </p>
              <?php } ?>        
              </div>
            </div>
        </div>
    
      </div>
       <?php } ?>
    </div>
  </div>
    
     <?php } ?>
</div>
</div>