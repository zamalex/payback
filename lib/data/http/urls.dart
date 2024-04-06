class Url {
  static const BASE_URL = 'https://payback.b1rincitech.com/api'; //test
  static const LOGIN_URL = '/login';
  static const USERS_URL = '/admin/users';
  static const REGISTER_URL = '/register';
  static const SUBSCRIPTIONS_URL = '/subscriptions';
  static const SUBSCRIBE_URL = '/subscribe';
  static const SOCIAL_LOGIN_URL = '/social-login';
  static const VERIFY_URL = '/verify';
  static const FORGOT_URL = '/forget-password';
  static const CHECK_TOKEN_URL = '/check-token';
  static const RESET_PASSWORD_URL = '/reset-password';
  static const CHANGE_PASSWORD_URL = '/change-password';
  static const NOTIFICATIONS_URL = '/admin/mobile-notifications';
  static const SETTINGS_URL = '/admin/settings';
  static const CATEGORIES_URL = '/admin/categories';
  static const PRODUCTS_URL = '/admin/products';
  static const Vendorrs_URL = '/admin/vendors';
  static const BRANCHES_URL = '/admin/branches';
  static const PARTNERS_URL = '/admin/partners';
  static const PARTNERS_CUSTOM_FIELDS_URL = '/admin/partners/';
  static const COMMIMENTS_URL = '/admin/commitments';
  static const SORT_COMMIMENTS_URL = '/admin/commitments/sort';
  static const CREATE_COMMIMENTS_URL = '/admin/commitments/create';
  static const SHARE_INVITATION_URL = '/admin/share-commitments';
  static const GET_HELP_COMUNITY_URL = '/admin/cashback/community';
  static const COMMIMENTS_CATEGORIES_URL = '/admin/commitment-categories';
  static const ONBOARDING_URL = '/admin/screens';
  static const DELIVERY_URL = '/admin/delivery-methods';
  static const CITIES_URL = '/admin/cities';
  static const SEND_FCM_TOKEN_URL = '/fcm';
  static const CREATE_ORDER_URL = '/admin/orders/create';
  static const CORDERS_URL = '/admin/orders';
  static const PAYMENTS_URL = '/admin/payment-settings';
  static const UPDATE_USER_DATA_URL = '/users/profile';
  static const UPDATE_USER_EMAIL_URL = '/users/email/edit';
  static const UPDATE_USER_AVATER_URL = '/users/avatar';

  static const GET_CASHBACK_URL = '/cashbacks';
  static const GET_CASHBACK_HISTORY_URL = '/admin/cashback/categories';
  static const GET_CASHBACK_TRANSACTIONS_URL = '/admin/cashback/balances';
  static const ERROR_IMAGE = 'https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg';

  static String TOKEN = '';
  static String LOCALE = 'ar';


  static String NO_CASHBACK="""
   {
        "deposit": "0",
        "withdraw": "0",
        "withdraw_unsigned_balance": "0",
        "deposit_unsigned_balance": "0",
        "withdraw_assigned_balance": "0",
        "deposit_assigned_balance": "0"
    }
  """;
  static String PARTNER_JSON = """ {
            "id": 1,
            "name": "Partner",
            "description": "Partner",
            "image": "https://payback.b1rincitech.com/storage/10/01HPCZ31MECN1Y2WA3BYZSNG7D.png"
        }""";
  static String PRODUCT_JSON = """{
            "id": 1,
            "name": "tea",
            "description": "tea",
            "quantity": "10",
            "price": "50.00",
            "featured_image": "01HNZ0GCB3D6F5DY95F5N5HDHT.jpg",
            "gallery": null,
            "created_at": "2024-02-05T23:57:04.000000Z",
            "updated_at": "2024-02-06T10:48:02.000000Z",
            "category_id": null
        }""";

  static String COMMITMENT_JSON = """{
            "id": 1,
            "name": "asdasdasd",
            "partner_id": "1",
            "category_id": "1",
            "payment_target": "123.00",
            "partner":{            
            "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrD9evOAc2Bj-rUWZ5I79EiHHGVNy7Wp3L9w&usqp=CAU"
            },
            "cashback_to_commitment": "10.00",
            "due_date": "2024-02-11",
            "type": "repeatable",
            "notify": "1",
            "created_at": "2024-02-11T20:54:25.000000Z",
            "updated_at": "2024-02-11T20:54:25.000000Z"
        }""";

  static String mocCategories = """{
   "categories":[
      {
         "id":2,
         "name":"Fruits",
         "parent_id":"1",
         "description":null
    
      },{
         "id":2,
         "name":"Fruits",
         "parent_id":"1",
         "description":null
    
      },{
         "id":2,
         "name":"Fruits",
         "parent_id":"1",
         "description":null
    
      },{
         "id":2,
         "name":"Fruits",
         "parent_id":"1",
         "description":null
    
      },{
         "id":2,
         "name":"Fruits",
         "parent_id":"1",
         "description":null
    
      },{
         "id":2,
         "name":"Fruits",
         "parent_id":"1",
         "description":null
    
      }]}""";



  static String STATIC_ORDER= """
  {
            "id": 17,
            "order_id": "14",
            "product_id": "2",
            "qty": "1",
            "price": "13.00",
            "tax_amount": "0.00",
            "created_at": "2024-03-23T21:54:45.000000Z",
            "updated_at": "2024-03-23T21:54:45.000000Z",
            "product": {
                "id": 2,
                "name": "Printing services",
                "quantity": "55",
                "featured_image": "path/to/featured_image.jpg",
                "price": "13.00"
            },
            "order": {
                "id": 14,
                "vendor_id": "1",
                "delivery_method_id": "1",
                "user_id": "16",
                "status": "pending",
                "delivery_method": {
                    "id": 1,
                    "name": "Cash On Delivery"
                    
                },
                "vendor": {
                    "id": 1,
                     "store_name": "Gutkowski-Hintz"
                },
                "user": {
                    "id": 16,
                    "name": "safax ezz",
                    "phone": "+201115597889"
                   
                }
            }
        }
  """;
}
