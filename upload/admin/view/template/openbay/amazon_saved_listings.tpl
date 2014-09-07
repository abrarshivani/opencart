<?php echo $header; ?><?php echo $menu; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <a href="<?php echo $link_overview; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn"><i class="fa fa-reply"></i></a>
      </div>
      <h1 class="panel-title"><i class="fa fa-pencil-square fa-lg"></i> <?php echo $text_title; ?></h1>
    </div>
    <div class="panel-body">
      <div class="alert alert-info"><?php echo $text_description; ?></div>
      <div class="well">
        <div class="row">
          <div class="col-sm-12">
            <div class="pull-right">
              <a id="button-upload" class="btn btn-primary"><i class="fa fa-cloud-upload fa-lg"></i> <?php echo $text_btn_upload; ?></a>
            </div>
          </div>
        </div>
      </div>
      <table class="table">
        <thead>
          <tr>
            <th><?php echo $text_name_column; ?></th>
            <th><?php echo $text_model_column; ?></th>
            <th class="text-center"><?php echo $text_sku_column; ?></th>
            <th class="text-center"><?php echo $text_amazon_sku_column; ?></th>
            <th class="text-right"><?php echo $text_actions_column; ?></th>
          </tr>
        </thead>
        <tbody>
          <?php if (!empty($saved_products)) { ?>
            <?php foreach ($saved_products as $saved_product) { ?>
              <tr>
                <td class="text-left"><?php echo $saved_product['product_name']; ?></td>
                <td class="text-left"><?php echo $saved_product['product_model']; ?></td>
                <td class="text-center"><?php echo $saved_product['product_sku']; ?></td>
                <td class="text-center"><?php echo $saved_product['amazon_sku']; ?></td>
                <td class="text-right">
                  <a class="btn btn-primary" href="<?php echo $saved_product['edit_link']; ?>" data-toggle="tooltip" data-original-title="<?php echo $text_actions_edit; ?>"><i class="fa fa-pencil"></i></a>
                  <a class="btn btn-danger" onclick="removeSaved('<?php echo $saved_product['product_id']; ?>', '<?php echo $saved_product['var']; ?>', this)" data-toggle="tooltip" data-original-title="<?php echo $text_actions_remove; ?>"><i class="fa fa-times-circle"></i></a>
                </td>
              </tr>
            <?php } ?>
          <?php } else { ?>
            <tr>
              <td colspan="5" class="text-center"><?php echo $text_no_results; ?></td>
            </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script type="text/javascript">
  function removeSaved(id, optionVar, button) {
    if (!confirm("<?php echo $text_delete_confirm; ?>")) {
      return;
    }
    $.ajax({
      url: '<?php echo html_entity_decode($deleteSavedAjax); ?>',
      type: 'get',
      data: 'product_id=' + id + '&var=' + optionVar,
      beforeSend: function () {
        $(button).empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
      },
      success: function () {
        window.location.href = window.location.href;
      },
      error: function (xhr, ajaxOptions, thrownError) {
        if (xhr.status != 0) { alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText); }
      }
    });
  }

  $('#button-upload').bind('click', function() {
    $.ajax({
      url: '<?php echo html_entity_decode($uploadSavedAjax); ?>',
      dataType: 'json',
      beforeSend: function () {
        $('#upload_button').empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
      },
      complete: function () {
        $('#upload_button').empty().html('<i class="fa fa-cloud-upload fa-lg"></i> <?php echo $text_btn_upload; ?>').removeAttr('disabled');
      },
      success: function (data) {
        if (data['status'] == 'ok') {
          alert('<?php echo $text_uploaded_alert; ?>');
        } else if (data['error_message'] !== undefined) {
          alert(data['error_message']);
          return;
        } else {
          alert('Unknown error.');
          return;
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        if (xhr.status != 0) { alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText); }
      }
    });
  });
</script>
<?php echo $footer; ?>