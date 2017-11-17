<div class="panel ">
  <div class="panel-heading"><?php echo $heading_title; ?></div>
  <div class="list-group">
    <?php foreach ($filter_groups as $filter_group) { ?>
    <span class="list-group-item"><i class="fa fa-angle-right" aria-hidden="true"></i><?php echo $filter_group['name']; ?> <i class="fa fa-plus-square pull-right" aria-hidden="true"></i></span>
    <div class="list-group-item">
      <div id="filter-group<?php echo $filter_group['filter_group_id']; ?>">
        <?php foreach ($filter_group['filter'] as $filter) { ?>
        <div class="checkbox">
          <label>
            <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
            <input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" checked="checked" />
            <?php echo $filter['name']; ?>
            <?php } else { ?>
            <input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" />
            <?php echo $filter['name']; ?>
            <?php } ?>
          </label>
        </div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
  </div>
  <div class="list-group range-slider"> 
   <input type="text" id="range" value="" name="range" />
   </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function () {
  var obj = {};
  var filter = {};
  filter.price = {};
  filter.sorted = [];
  filter.limit = 15;
  filter.attr = [];
  filter.ajaxRequest = function(){
    var path = '<?php echo $ajaxPath ?>';
    var dataRequest = '';
    
    if(this.price.from && this.price.from.length){
      dataRequest += '&from='+parseInt(this.price.from);
    }
    if(this.price.to && this.price.to.length){
      dataRequest += '&to='+parseInt(this.price.to);
    }
    if(this.attr.length && this.attr){
      dataRequest += '&filter='+this.attr.join(',');
    }
    if(this.sorted && this.sorted.length){
      dataRequest += '&sort='+this.sorted[0];
      dataRequest += '&order='+this.sorted[1];
    }
    if(this.limit && this.limit){
      dataRequest += '&limit='+parseInt(this.limit);
    }
    console.log(dataRequest);
    $.ajax({
      url: 'index.php?route=product/category/ajaxFilter',
      type: 'post',
      data: 'path='+path+dataRequest,
      dataType: 'html',
      beforeSend: function() {
        console.log('отослано');
      },
      success: function(json) {
        var $html = $('<div>' + json.replace(/\n/g, " ") + '</div>');
        $("#content").html(json);
        $(".product-layout").html($html);
        if ($(".product-list").length == 0 &&  $(".product-grid").length == 0) {
            $("#content .content:eq(1)").replaceWith($html.html());
        }
        initQVP();
        $('#grid-view').click();
      }
    });
  }

  $("#range").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: '<?php echo $filterMin; ?>',
            max: '<?php echo $filterMax; ?>',
            from:  '<?php echo $filterMin; ?>',
            to: '<?php echo $filterMax; ?>',
            type: 'double',
            step: 1,
            grid: true,
  });
  $(document).on('mouseup','.to , .from , .irs-line , irs-line-mid ',function () { 
    var to = $('.irs-to').html().match(/\w+/g);
    var from = $('.irs-from').html().match(/\w+/g);
    console.log('from : '+from.join('')+', to : '+to.join(''));
    
    filter.price.to = to.join('');
    filter.price.from = from.join('');
   
    filter.ajaxRequest();  
  
  });
  $(document).on('click','.to , .from , .irs-line , irs-line-mid ',function () { 
    var to = $('.irs-to').html().match(/\w+/g);
    var from = $('.irs-from').html().match(/\w+/g);
    console.log('from : '+from.join('')+', to : '+to.join(''));
    
    filter.price.to = to.join('');
    filter.price.from = from.join('');
   
    filter.ajaxRequest();  
  
  });
  $('input[type="checkbox"]').bind("change", function() {

    filter.attr = [];

    $('input[name^=\'filter\']:checked').each(function(element) {
      filter.attr.push(this.value);

    });

    filter.ajaxRequest();
  
  });

  $(document).on('change','#input-sort,#input-limit',function() {
    
    var number = $("#input-limit option:selected").attr('value');
    var sorted_order = $("#input-sort option:selected").attr('value');
    var sorted = sorted_order.match(/(sort=)([A-z.]+)/);
    var order = sorted_order.match(/(order=)([A-z.]+)/);

    filter.sorted = [sorted[2],order[2]];
    number = number.match(/(limit=)([0-9]+)/);
    filter.limit = number[2];

    filter.ajaxRequest();

  });


});
</script>

