// Created by Mateus Lino

import Foundation

enum Endpoint: String {
    case landing
    case onboardingNameStep
    case onboardingEmailStep

    var interface: Data {
        switch self {
        case .landing:
            let json = """
            {
                "components": [
                    {
                        "identifier": "landing_spacer_component",
                        "name": "spacer_component",
                        "content": {}
                    },
                    {
                        "identifier": "landing_sign_up_button_component",
                        "name": "button_component",
                        "content": {
                            "title": "Sign up",
                            "action": {
                                "identifier": "onboarding_step",
                                "content": {
                                    "step": "name"
                                }
                            }
                        }
                    }
                ]
            }
            """
            return Data(json.utf8)
        case .onboardingNameStep:
            let json = """
            {
                "components": [
                    {
                        "identifier": "onboarding_name_text_field_component",
                        "name": "text_field_component",
                        "content": {
                            "placeholder": "Your name"
                        }
                    },
                    {
                        "identifier": "landing_spacer_component",
                        "name": "spacer_component",
                        "content": {}
                    },
                    {
                        "identifier": "onboarding_name_continue_button_component",
                        "name": "button_component",
                        "content": {
                            "title": "Continue",
                            "action": {
                                "identifier": "onboarding_step",
                                "content": {
                                    "step": "email"
                                }
                            }
                        }
                    }
                ]
            }
            """
            return Data(json.utf8)
        case .onboardingEmailStep:
            let json = """
            {
                "components": [
                    {
                        "identifier": "onboarding_email_text_field_component",
                        "name": "text_field_component",
                        "content": {
                            "placeholder": "Your email"
                        }
                    },
                    {
                        "identifier": "landing_spacer_component",
                        "name": "spacer_component",
                        "content": {}
                    },
                    {
                        "identifier": "onboarding_email_continue_button_component",
                        "name": "button_component",
                        "content": {
                            "title": "Continue",
                            "action": {
                                "identifier": "onboarding_success"
                            }
                        }
                    }
                ]
            }
            """
            return Data(json.utf8)
        }
    }
}
