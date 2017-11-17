<div class="list-group side-bar">
    <ul>
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['category_id'] == $category_id) { ?>
        <li>
            <a href="<?php echo $category['href']; ?>" class="list-group-item active">
                <?php echo $category['name']; ?>
            </a>
            <?php if ($category['children']) { ?>
            <div class="sub-menu ">
                <h3>
                    <?php echo $category['name']; ?> </h3>
                    <ul>
                        <?php foreach ($category['children'] as $child) { ?>
                        <?php if ($child['category_id'] == $child_id) { ?>
                        <li>
                            <a href="<?php echo $child['href']; ?>" class="list-group-item active">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?> <i class="fa fa-angle-double-right pull-right"></i></a>
                        </li>
                        <?php } else { ?>
                        <li>
                            <a href="<?php echo $child['href']; ?>" class="list-group-item">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
                        </li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
            </div>
        </li>
        <?php } ?>
        <?php } else { ?>
        <li>
            <a href="<?php echo $category['href']; ?>" class="list-group-item">
                <?php echo $category['name']; ?> <i class="fa fa-angle-double-right pull-right"></i></a>
            <?php if ($category['children']) { ?>
            <div class="sub-menu ">
                <h3>
                    <?php echo $category['name']; ?> </h3>
                    <ul>
                        <?php foreach ($category['children'] as $child) { ?>
                        <?php if ($child['category_id'] == $child_id) { ?>
                        <li>
                            <a href="<?php echo $child['href']; ?>" class="list-group-item active">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?> <i class="fa fa-angle-double-right pull-right"></i></a>
                        </li>
                        <?php } else { ?>
                        <li>
                            <a href="<?php echo $child['href']; ?>" class="list-group-item">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
                        </li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
            </div>
        </li>
        <?php } ?>
        </li>
        <?php } ?>
        <?php } ?>
    </ul>
</div>