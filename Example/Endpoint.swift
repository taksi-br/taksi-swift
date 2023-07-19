// Created by Mateus Lino

import Foundation

enum Endpoint: String {
    case landing
    case login
    case home

    var interface: Data {
        switch self {
        case .landing:
            let json = """
            {
                "components": [
                    {
                        "identifier": "landing_labels_component",
                        "name": "landing_labels_component",
                        "content": {
                            "title": "Login and explore a dynamic world",
                            "subtitle": "Catch a Taksi and get a ride with the backend."
                        }
                    },
                    {
                        "identifier": "landing_sign_in_button_component",
                        "name": "button_component",
                        "content": {
                            "title": "Login",
                            "action": {
                                "identifier": "navigation",
                                "content": {
                                    "interface_identifier": "login"
                                }
                            }
                        }
                    }
                ]
            }
            """
            return Data(json.utf8)
        case .login:
            let json = """
            {
                "components": [
                    {
                        "identifier": "login_email_text_field_component",
                        "name": "text_field_component",
                        "content": {
                            "placeholder": "Your email"
                        }
                    },
                    {
                        "identifier": "login_password_text_field_component",
                        "name": "text_field_component",
                        "content": {
                            "placeholder": "Your password",
                            "is_secure": true
                        }
                    },
                    {
                        "identifier": "login_spacer_component",
                        "name": "spacer_component",
                        "content": {}
                    },
                    {
                        "identifier": "login_continue_button_component",
                        "name": "button_component",
                        "content": {
                            "title": "Continue",
                            "is_enabled": false,
                            "action": {
                                "identifier": "login_success"
                            }
                        }
                    }
                ]
            }
            """
            return Data(json.utf8)
        case .home:
            let json = """
            {
                "components": [
                    {
                        "identifier": "categories_label_component",
                        "name": "label_component",
                        "content": {
                            "value": "Categories",
                            "kind": "subtitle"
                        }
                    },
                    {
                        "identifier": "categories_collection_component",
                        "name": "collection_component",
                        "content": {
                            "component_name": "categories_component",
                            "values": []
                        }
                    },
                    {
                        "identifier": "restaurant_label_component",
                        "name": "label_component",
                        "content": {
                            "value": "Restaurants",
                            "kind": "subtitle"
                        }
                    },
                    {
                        "identifier": "restaurants_collection_component",
                        "name": "collection_component",
                        "content": {
                            "component_name": "restaurant_component",
                            "values": []
                        }
                    },
                    {
                        "identifier": "home_spacer_component",
                        "name": "spacer_component",
                        "content": {}
                    }
                ]
            }
            """
            return Data(json.utf8)
        }
    }

    var interfaceData: Data? {
        switch self {
        case .landing, .login:
            return nil
        case .home:
            let json = """
            {
                "interface_data": [
                    {
                        "identifier": "categories_collection_component",
                        "content": {
                            "values": [
                                {
                                    "categories": [
                                        {
                                            "icon_url": "https://t4.ftcdn.net/jpg/05/85/29/13/360_F_585291338_0J8Q8vYbKDCu8yqqwAO8PsQZ4ESP2zd8.jpg",
                                            "kind": "american"
                                        },
                                        {
                                            "icon_url": "https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png",
                                            "kind": "italian"
                                        }
                                    ]
                                }
                            ]
                        }
                    },
                    {
                        "identifier": "restaurants_collection_component",
                        "content": {
                            "values": [
                                {
                                    "icon_url": "https://designportugal.net/wp-content/uploads/2016/04/m-mcdonalds.jpg",
                                    "title": "McDonald's",
                                    "kind": "american",
                                    "rating": 3.8
                                },
                                {
                                    "icon_url": "https://assets.b9.com.br/wp-content/uploads/2020/03/dominos-fica-em-casa.jpg",
                                    "title": "Domino's",
                                    "kind": "italian",
                                    "rating": 3.4
                                }
                            ]
                        }
                    }
                ]
            }
            """
            return Data(json.utf8)
        }
    }

}
