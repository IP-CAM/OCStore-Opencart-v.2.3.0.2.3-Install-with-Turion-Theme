<div class="panel panel-default">
  <div class="panel-heading"><?php echo $heading_title; ?></div>
  <div class="list-group">
    <?php foreach ($filter_groups as $filter_group) { ?>
    <a class="list-group-item"><?php echo $filter_group['name']; ?></a>
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
  <div class="panel-footer text-right">
    <button type="button" id="button-filter" class="btn btn-primary"><?php echo $button_filter; ?></button>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function () {
  // body...
    // ajaxFilter
  $('input[type="checkbox"]').bind("change", function() {
    var filter = [];
    console.log('shit happens');
    $('input[name^=\'filter\']:checked').each(function(element) {
      filter.push(this.value);

    });
    var path = '<?php echo $ajaxPath ?>';
    console.log('index.php?route=product/category/ajaxFilter&path='+path+'&filter='+filter.join(','));
    $.ajax({
       url: 'index.php?route=product/category/ajaxFilter',
       type: 'post',
       data: 'path='+path+'&filter='+filter.join(','),
       dataType: 'html',
       beforeSend: function() {

        console.log('отослано','   ',filter);
       },
       success: function(json) {
        console.log(json.replace(/\n/g, " "));
        var $html = $('<div>' + json.replace(/\n/g, " ") + '</div>');
        $(".product-layout").html($html);
        if ($(".product-list").length == 0 &&  $(".product-grid").length == 0) {
            $("#content .content:eq(1)").replaceWith($html.html());
        }
      }
    });
  });
});

	// $('input[name^=\'filter\']:checked').each(function(element) {
	// 	filter.push(this.value);
	// });

	// location = '<?php echo $action; ?>&filter=' + filter.join(',');
 //  alert(location);
//--></script>
