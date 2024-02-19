

class Url {
  static const BASE_URL = 'https://payback.b1rincitech.com/api'; //test
  static const LOGIN_URL = '/login';
  static const REGISTER_URL = '/register';
  static const SOCIAL_LOGIN_URL = '/social-login';
  static const VERIFY_URL = '/verify';
  static const FORGOT_URL = '/forget-password';
  static const CHECK_TOKEN_URL = '/check-token';
  static const RESET_PASSWORD_URL = '/reset-password';
  static const CATEGORIES_URL = '/admin/categories';
  static const PRODUCTS_URL = '/admin/products';
  static const PARTNERS_URL = '/admin/partners';
  static const COMMIMENTS_URL = '/admin/commitments';
  static const COMMIMENTS_CATEGORIES_URL = '/admin/commitment-categories';
  static const ONBOARDING_URL = '/admin/screens';

  static String TOKEN = '';
  static String LOCALE = 'ar';

  static String PARTNER_JSON = """ {
            "id": 1,
            "name": "Partner",
            "description": "Partner",
            "image": "https://payback.b1rincitech.com/storage/10/01HPCZ31MECN1Y2WA3BYZSNG7D.png"
        }""";
  static String PRODUCT_JSON ="""{
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


  static String COMMITMENT_JSON ="""{
            "id": 1,
            "name": "asdasdasd",
            "partner_id": "1",
            "category_id": "1",
            "payment_target": "123.00",
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
}
