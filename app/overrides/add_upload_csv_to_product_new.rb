Deface::Override.new(virtual_path:  'spree/admin/products/new',
                     insert_before: 'erb[loud]:contains("form_for")',
                     partial:       'spree/admin/products/upload_products_from_csv')
