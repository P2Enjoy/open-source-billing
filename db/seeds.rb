#users = User.create([
#    {:email => 'imran@nxb.com.pk', :crypted_password => '9027ed25057cef842561eb3f58739556e09d85f4'},
#    {:email => 'muhammad.azeem@nxb.com.pk', :crypted_password => '9027ed25057cef842561eb3f58739556e09d85f4'},
#    {:email => 'sohail.asghar@nxb.com.pk', :crypted_password => '9027ed25057cef842561eb3f58739556e09d85f4'}
#  ])
#taxes = Tax.create([{:name => 'VAT', :percentage => 2.5},{:name => 'GST', :percentage => 4}])
#tax1,tax2 = taxes.first.id,taxes.last.id
#
#items = Item.create([{
#      :item_name => 'Item 1',
#      :item_description => 'Development',
#      :unit_cost => '400',
#      :quantity => 1,
#      :tax_1 => tax1,
#      :tax_2 => tax2,
#      :track_inventory => true},{
#      :item_name => 'Item 2',
#      :item_description => 'Development',
#      :unit_cost => '300',
#      :quantity => 1,
#      :tax_1 => tax1,
#      :tax_2 => tax2,
#      :track_inventory => true}])
#item1,item2 = items.first.id, items.last.id
#
#client = Client.create(
#  :organization_name => 'NXB',
#  :email => 'imran@nxb.com.pk',
#  :first_name => 'Hyper',
#  :last_name => 'Conversion',
#  :home_phone => '000000',
#  :mobile_number => '111111',
#  :send_invoice_by => 'email',
#  :country => 'Pakistan')
#
#invoice = Invoice.create(
#  :invoice_number => '00001',
#  :invoice_date => Date.today,
#  :discount_percentage => 10,
#  :client_id => client.id,
#  :terms => 'none',
#  :notes => 'none',
#  :sub_total => 700,
#  :discount_amount => -70,
#  :tax_amount => 37,
#  :invoice_total => 667
#)
#
#InvoiceLineItem.create([{
#      :invoice_id => invoice.id,
#      :item_id => item1,
#      :item_unit_cost => 400,
#      :item_quantity => 1,
#      :tax_1 => tax1,
#      :tax_2 => tax2},{
#      :invoice_id => invoice.id,
#      :item_id => item2,
#      :item_unit_cost => 300,
#      :item_quantity => 1,
#      :tax_1 => tax2,
#      :tax_2 => tax1
#    }])
EmailTemplate.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM email_templates")
CompanyEmailTemplate.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM company_email_templates")
templates = EmailTemplate.create([
        {
            :torder => 1,
            :status => 'Default',
            :template_type => 'New Invoice',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => '{{client_company}}: {{company_name}} Invoice: {{invoice_number}}',
            :body => '<p>Dear {{client_contact}},</p>
            <p>Thank you for your continued service with {{company_name}}, to download a PDF copy for your invoice, please click on below link:</p>
            <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a> </p>
            <p>Please remit payment at your earliest convenience. For all forms of payment please be sure to include your invoice number {{invoice_number}} for reference.</p>
            <p>If you have any questions or comments please feel free to contact {{company_contact}} at {{company_phone}}.</p>
            <p>Please login to see your invoice <a href="{{new_password_url}}">Login</a></p>
            <p>Thanks,</p>
            <p>{{company_signature}}</p>'
        },
        {
            :torder => 2,
            :status => 'Default',
            :template_type => 'Payment Received',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => '{{company_name}} has received your payment for invoice {{invoice_number}}',
            :body => '<p>We have received your payment in the amount of {{currency_symbol}}{{payment_amount}}  for invoice {{invoice_number}}.
                <p>To view the paid invoice or download a PDF copy for your records, click the link below:</p>
                <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a> </p>
                <p>Thank you. </p>
                <p>{{company_signature}}</p>'
        },
        {   #:no_of_days => 2,
            #:is_late_payment_reminder => true,
            :torder => 3,
            :status => 'Default',
            :template_type => 'First Late Payment Reminder',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => '{{client_company}}: {{company_name}} Invoice is Past Due',
            :body => '<p>Dear {{client_contact}},</p>
           <p>This is a friendly reminder that payment for your {{company_name}} invoice: {{invoice_number}} in the amount of {{currency_symbol}}{{payment_amount_due}} is past due.</p>
           <p>If there is a billing matter that you would like to discuss before submitting payment, please contact us as soon as possible at {{company_phone}}.</p>
           <p>To access your invoice go to: </p>
           <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a> </p>
           <p>Thank you.</p>
           <p>{{company_signature}}</p>'
        },
        # {   :no_of_days => 5,
        #     :is_late_payment_reminder => true,
        #     :torder => 4,
        #     :status => 'Default',
        #     :template_type => 'Second Late Payment Reminder',
        #     :email_from => 'nfor20@yahoo.com',
        #     :subject => '{{client_company}}: {{company_name}} Invoice is Past Due',
        #     :body => '<p>Dear {{client_contact}},</p>
        #    <p>This is a friendly reminder that payment for your {{company_name}} invoice: {{invoice_number}} in the amount of {{currency_symbol}}{{payment_amount_due}} is past due.</p>
        #    <p>If there is a billing matter that you would like to discuss before submitting payment, please contact us as soon as possible at {{company_phone}}.</p>
        #    <p>To access your invoice go to: </p>
        #    <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a> </p>
        #    <p>Thank you.</p>
        #    <p>{{company_signature}}</p>'
        # },
        # {   :no_of_days => 7,
        #     :is_late_payment_reminder => true,
        #     :torder => 5,
        #     :status => 'Default',
        #     :template_type => 'Third Late Payment Reminder',
        #     :email_from => 'nfor20@yahoo.com',
        #     :subject => '{{client_company}}: {{company_name}} Invoice is Past Due',
        #     :body => '<p>Dear {{client_contact}},</p>
        #    <p>This is a friendly reminder that payment for your {{company_name}} invoice: {{invoice_number}} in the amount of {{currency_symbol}}{{payment_amount_due}} is past due.</p>
        #    <p>If there is a billing matter that you would like to discuss before submitting payment, please contact us as soon as possible at {{company_phone}}.</p>
        #    <p>To access your invoice go to: </p>
        #    <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a></p>
        #    <p>Thank you.</p>
        #    <p>{{company_signature}}</p>'
        # },
        {
            :torder => 6,
            :status => 'Default',
            :template_type => 'Dispute Invoice',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => 'Client Dispute Notification: {{client_company}}',
            :body => '<p>{{company_contact}},</p>
           <p>{{client_company}} wishes to dispute {{company_name}} invoice {{invoice_number}}, citing:</p>
           <p>{{reason}}</p>
           <p>Please log into your account and respond accordingly.</p>
           <p>Thanks,</p>
           <p>Open Source Billing</p>'
        },
        {
            :torder => 7,
            :status => 'Default',
            :template_type => 'Dispute Reply',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => '{{company_name}} Dispute Response regarding invoice {{invoice_number}}',
            :body => '<p>Dear {{client_contact}},</p>
           <p>We have carefully reviewed your request regarding invoice number {{invoice_number}}. This is our response:</p>
           <p> {{dispute_response}}
           <p>URL for Invoice Preview:</p>
           <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a></p>
           <p>Thank you.</p>
           <p>{{company_signature}}</p>'
        },
        {
            :torder => 8,
            :status => 'Default',
            :template_type => 'New User',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => "Welcome to {{company_name}}'s invoicing services provided by Open Source Billing.",
            :body => "<p>Welcome to {{company_name}}'s secure online services provided by Open Source Billing.</p>
           <p>To securely access your account information and invoices, go to: </p>
           <p><a href='{{app_url}}'>{{app_url}}</a></p>
           <p>Login using the following username and password:<p>
           <p> Username:  {{user_email}}
           <p>Password: {{user_password}}
           <p>If you have any questions please contact {{company_contact}} at {{company_phone}}.
           <p>Thank you.</p>
           <p>{{company_signature}}</p>"
        },
        {
            :torder => 9,
            :status => 'Default',
            :template_type => 'New Estimate',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => '{{client_company}}: {{company_name}} Estimate: {{estimate_number}}',
            :body => '<p>Dear {{client_contact}},</p>
            <p>Thank you for your continued service with {{company_name}}, to download a PDF copy for your records, click the link below:</p>
            <p><a href="{{estimate_url}}">Estimate# {{estimate_number}}</a> </p>
            <p>If you have any questions or comments please feel free to contact {{company_contact}} at {{company_phone}}.</p>
            <p>Thanks,</p>
            <p>{{company_signature}}</p>'
        },
        {   :torder => 10,
            :status => 'Default',
            :template_type => 'Soft Payment Reminder',
            :email_from => 'billing@p2enjoy.studio',
            :cc => '',
            :bcc => '',
            :subject => '{{client_company}}: {{company_name}} Invoice will Due after 3 Days',
            :body => '<p>Dear {{client_contact}},</p>
           <p>This is a soft reminder that payment for your {{company_name}} invoice: {{invoice_number}} in the amount of {{currency_symbol}}{{payment_amount_due}} will due after 3 days.</p>
           <p>To access your invoice go to: </p>
           <p><a href="{{invoice_url}}">Invoice# {{invoice_number}}</a> </p>
           <p>Please remit payment at your earliest convenience. For all forms of payment please be sure to include your invoice number {{invoice_number}} for reference.</p>
            <p>If you have any questions or comments please feel free to contact {{company_contact}} at {{company_phone}}.</p>
            <p>Thanks,</p>
           <p>{{company_signature}}</p>'
        }
    ])

templates.each do |template|
  CompanyEmailTemplate.create(
      :parent_id => (Account.first.id rescue nil),
      :parent_type => 'Account',
      :template_id => template.id
  )
end

#creating default currencies
Currency.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM currencies")
sample_currencies = []
not_currencies = %w[BTC XAG XAU XDR]
Money::Currency.all.collect{|x| sample_currencies << {code: x.symbol,unit: x.iso_code,title: x.name} if not_currencies.exclude?(x.iso_code)}
Currency.create(sample_currencies)

# set default currencies to clients
default_currency = (Currency.where(unit: 'EUR').first || Currency.first)
Client.where(currency_id: nil).update_all(currency_id: default_currency.id)
Invoice.where(currency_id: nil).update_all(currency_id: default_currency.id)
RecurringProfile.where(currency_id: nil).update_all(currency_id: default_currency.id)

Estimate.where(currency_id: nil).update_all(currency_id: default_currency.id)

CATEGORIES.each do |category|
  ExpenseCategory.create name: category unless ExpenseCategory.find_by_name category
end

Role.delete_all
role = ROLE
Role.create name: role, deletable: false
client_role = CLIENT_ROLE
Role.create name: client_role, for_client: true, deletable: false

Permission.delete_all
Permission.create(role_id: Role.first.id, entity_type: "Invoice", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.first.id, entity_type: "Estimate", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.first.id, entity_type: "Time Tracking", can_read: false, can_update: false, can_delete: false, can_create: false)
Permission.create(role_id: Role.first.id, entity_type: "Payment", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.first.id, entity_type: "Client", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.first.id, entity_type: "Item", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.first.id, entity_type: "Taxes", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.first.id, entity_type: "Report", can_read: true)
Permission.create(role_id: Role.first.id, entity_type: "Settings", can_read: true)

Permission.create(role_id: Role.last.id, entity_type: "Invoice", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Estimate", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Time Tracking", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Payment", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Client", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Item", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Taxes", can_read: true, can_update: true, can_delete: true, can_create: true)
Permission.create(role_id: Role.last.id, entity_type: "Report", can_read: true)
Permission.create(role_id: Role.last.id, entity_type: "Settings", can_read: true)

PaymentTerm.delete_all
PaymentTerm.create(number_of_days: 10, description: "10 days")
PaymentTerm.create(number_of_days: 7, description: "Weekly")
PaymentTerm.create(number_of_days: 30, description: "Monthly")
PaymentTerm.create(number_of_days: -1, description: "Custom")
PaymentTerm.create(number_of_days: 0, description: "Due on received")

Settings.delete_all
Settings.currency = "On"
Settings.default_currency = "EUR"
Settings.date_format = "%Y-%m-%d"
Settings.invoice_number_format = "{{invoice_number}}"
Settings.invoice_item_format = "{{item_description}}"

Account.delete_all
Account.create(org_name: 'P2Enjoy SAS')

Company.delete_all
Company.create(company_name: Account.first.org_name, account_id: Account.first.id)

User.destroy_all
u=User.new
u.email = "billing@p2enjoy.studio"
u.password = "mabe!0301"
u.password_confirmation = "mabe!0301"
u.user_name = "Martino Bettucci"
u.role_id = Role.first.id
u.have_all_companies_access = true
u.current_company = Company.first.id
u.accounts << Account.first
u.save

RecurringFrequency.delete_all
RecurringFrequency.create!(title: 'Weekly', number_of_days: 7)
RecurringFrequency.create!(title: 'Monthly', number_of_days: 30)
RecurringFrequency.create!(title: 'Yearly', number_of_days: 365)