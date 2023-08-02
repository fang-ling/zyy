//
//  Swift.swift
//
//
//  Created by Fang Ling on 2023/4/13.
//

import Foundation
import RegexBuilder

struct SwiftLexicalStruct {
    //------------------------------------------------------------------------//
    //                        Grammar of an identifier                        //
    //------------------------------------------------------------------------//
    static let identifier_head = Regex {
        ChoiceOf {
            /* Upper- or lowercase letter A through Z or _ */
            #/\w/#
            /* U+00A8, U+00AA, U+00AD, U+00AF, U+00B2–U+00B5, or U+00B7–U+00BA */
            #/\u00A8/#
            #/\u00AA/#
            #/\u00AD/#
            #/\u00AF/#
            #/\u00B2/#
            #/\u00B5/#
            #/[\u00B7–\u00BA]/#
            /* U+00BC–U+00BE, U+00C0–U+00D6, U+00D8–U+00F6, or U+00F8–U+00FF */
            #/[\u00BC–\u00BE]/#
            #/[\u00C0–\u00D6]/#
            #/[\u00D8–\u00F6]/#
            #/[\u00F8–\u00FF]/#
            /* U+0100–U+02FF, U+0370–U+167F, U+1681–U+180D, or U+180F–U+1DBF */
            #/[\u0100–\u02FF]/#
            #/[\u0370–\u167F]/#
            #/[\u1681–\u180D]/#
            #/[\u180F–\u1DBF]/#
            /* U+1E00–U+1FFF */
            #/[\u1E00–\u1FFF]/#
            /* U+200B–U+200D, U+202A–U+202E,
             * U+203F–U+2040, U+2054, or U+2060–U+206F
             */
            #/[\u200B–\u200D]/#
            #/[\u202A–\u202E]/#
            #/[\u203F–\u2040]/#
            #/\u2054/#
            #/[\u2060–\u206F]/#
            /* U+2070–U+20CF, U+2100–U+218F, U+2460–U+24FF, or U+2776–U+2793 */
            #/[\u2070–\u20CF]/#
            #/[\u2100–\u218F]/#
            #/[\u2460–\u24FF]/#
            #/[\u2776–\u2793]/#
            /* U+2C00–U+2DFF or U+2E80–U+2FFF */
            #/[\u2C00–\u2DFF]/#
            #/[\u2E80–\u2FFF]/#
            /* U+3004–U+3007, U+3021–U+302F, U+3031–U+303F, or U+3040–U+D7FF */
            #/[\u3004–\u3007]/#
            #/[\u3021–\u302F]/#
            #/[\u3031–\u303F]/#
            #/[\u3040–\uD7FF]/#
            /* U+F900–U+FD3D, U+FD40–U+FDCF, U+FDF0–U+FE1F, or U+FE30–U+FE44 */
            #/[\uF900–\uFD3D]/#
            #/[\uFD40–\uFDCF]/#
            #/[\uFDF0–\uFE1F]/#
            #/[\uFE30–\uFE44]/#
            /* U+FE47–U+FFFD */
            #/[\uFE47–\uFFFD]/#

            /// Current not support Non-BMP characters
            /* U+10000–U+1FFFD, U+20000–U+2FFFD,
             * U+30000–U+3FFFD, or U+40000–U+4FFFD
             */
    //        /[\u10000–\u1FFFD]/
    //        /[\u20000–\u2FFFD]/
    //        /[\u30000–\u3FFFD]/
    //        /[\u40000–\u4FFFD]/
            /* U+50000–U+5FFFD, U+60000–U+6FFFD,
             * U+70000–U+7FFFD, or U+80000–U+8FFFD
             */
    //        /[\u50000–\u5FFFD]/
    //        /[\u60000–\u6FFFD]/
    //        /[\u70000–\u7FFFD]/
    //        /[\u80000–\u8FFFD]/
            /* U+90000–U+9FFFD, U+A0000–U+AFFFD,
             * U+B0000–U+BFFFD, or U+C0000–U+CFFFD
             */
    //        /[\u90000–\u9FFFD]/
    //        /[\uA0000–\uAFFFD]/
    //        /[\uB0000–\uBFFFD]/
    //        /[\uC0000–\uCFFFD]/
            /* U+D0000–U+DFFFD or U+E0000–U+EFFFD */
    //        /[\uD0000–\uDFFFD]/
    //        /[\uE0000–\uEFFFD]/
        }
    }

    static let identifier_character = Regex {
        ChoiceOf {
            /* Digit 0 through 9 */
            #/\d/#
            /* U+0300–U+036F, U+1DC0–U+1DFF, U+20D0–U+20FF, or U+FE20–U+FE2F */
            #/[\u0300–\u036F]/#
            #/[\u1DC0–\u1DFF]/#
            #/[\u20D0–\u20FF]/#
            #/[\uFE20–\uFE2F]/#

            identifier_head
        }
    }

    static let identifier_characters = Regex {
        OneOrMore {
            identifier_character
        }
    }

    static let implicit_paramter_name = Regex {
        #/\$/#
        decimal_digits
    }

    static let property_wrapper_projection = Regex {
        #/\$/#
        identifier_characters
    }

    static let identifier = Regex {
        ChoiceOf {
            /* identifier-head identifier-characters? */
            Regex {
                identifier_head
                ZeroOrMore {
                    identifier_characters
                }
            }
            /* `identifier-head identifier-characters?` */
            Regex {
                #/`/#
                identifier_head
                ZeroOrMore {
                    identifier_characters
                }
                #/`/#
            }
            /* implicit-parameter-name */
            implicit_paramter_name
            /* property-wrapper-projection */
            property_wrapper_projection
        }
    }

    //------------------------------------------------------------------------//
    //                   Grammar of an integer literal                        //
    //------------------------------------------------------------------------//
    static let binary_digit = Regex {
        /* Digit 0 or 1 */
        #/[0-1]/#
    }

    static let binary_literal_character = Regex {
        /* binary-digit | _ */
        ChoiceOf {
            binary_digit
            #/_/#
        }
    }

    static let binary_literal_characters = Regex {
        /* binary-literal-character binary-literal-characters? */
        OneOrMore {
            binary_literal_character
        }
    }

    static let binary_literal = Regex {
        /* 0b binary-digit binary-literal-characters? */
        #/0b/#
        binary_digit
        ZeroOrMore {
            binary_literal_characters
        }
    }

    static var octal_digit = Regex {
        /* Digit 0 through 7 */
        #/[0-7]/#
    }

    static var octal_literal_character = Regex {
        /* octal-digit | _ */
        ChoiceOf {
            octal_digit
            #/_/#
        }
    }

    static var octal_literal_characters = Regex {
        /* octal-literal-character octal-literal-characters? */
        OneOrMore {
            octal_literal_character
        }
    }

    static var octal_literal = Regex {
        /* 0o octal-digit octal-literal-characters? */
        #/0o/#
        octal_digit
        ZeroOrMore {
            octal_literal_characters
        }
    }

    static var decimal_digit = Regex {
        /* Digit 0 through 9 */
        #/[0-9]/#
    }

    static var decimal_digits = Regex {
        /* decimal-digit decimal-digits? */
        OneOrMore {
            decimal_digit
        }
    }

    static var decimal_literal_character = Regex {
        /* decimal-digit | _ */
        ChoiceOf {
            decimal_digit
            #/_/#
        }
    }

    static var decimal_literal_characters = Regex {
        /* decimal-literal-character decimal-literal-characters? */
        OneOrMore {
            decimal_literal_character
        }
    }

    static var decimal_literal = Regex {
        /* decimal-digit decimal-literal-characters? */
        decimal_digit
        ZeroOrMore {
            decimal_literal_characters
        }
    }

    static var hexadecimal_digit = Regex {
        /* Digit 0 through 9, a through f, or A through F */
        #/[0-9a-fA-F]/#
    }

    static var hexadecimal_literal_character = Regex {
        /* hexadecimal-digit | _ */
        ChoiceOf {
            hexadecimal_digit
            #/_/#
        }
    }

    static var hexadecimal_literal_characters = Regex {
        /* hexadecimal-literal-character hexadecimal-literal-characters? */
        OneOrMore {
            hexadecimal_literal_character
        }
    }

    static var hexadecimal_literal = Regex {
        /* 0x hexadecimal-digit hexadecimal-literal-characters? */
        #/0x/#
        hexadecimal_digit
        ZeroOrMore {
            hexadecimal_literal_characters
        }
    }

    static var integer_literal = Regex {
        /* decimal must have lowest priority: (0x, 0b and 0o) */
        Capture {
            ChoiceOf {
                binary_literal
                octal_literal
                hexadecimal_literal
                decimal_literal
            }
        }
    }
}
