with Types; use Types;

package Radix is

    function Hex_String_To_Bytes(Hex_String : String) return Byte_Array;
    function Bytes_To_B64_String(Bytes : Byte_Array) return String;

private

    Hex_To_Byte_Lookup : constant array (Character, Character) of Byte := (
        '0' => ('0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'a' => 10, 'b' => 11, 'c' => 12, 'd' => 13, 'e' => 14, 'f' => 15, others => 255),
        '1' => ('0' => 16, '1' => 17, '2' => 18, '3' => 19, '4' => 20, '5' => 21, '6' => 22, '7' => 23, '8' => 24, '9' => 25, 'a' => 26, 'b' => 27, 'c' => 28, 'd' => 29, 'e' => 30, 'f' => 31, others => 255),
        '2' => ('0' => 32, '1' => 33, '2' => 34, '3' => 35, '4' => 36, '5' => 37, '6' => 38, '7' => 39, '8' => 40, '9' => 41, 'a' => 42, 'b' => 43, 'c' => 44, 'd' => 45, 'e' => 46, 'f' => 47, others => 255),
        '3' => ('0' => 48, '1' => 49, '2' => 50, '3' => 51, '4' => 52, '5' => 53, '6' => 54, '7' => 55, '8' => 56, '9' => 57, 'a' => 58, 'b' => 59, 'c' => 60, 'd' => 61, 'e' => 62, 'f' => 63, others => 255),
        '4' => ('0' => 64, '1' => 65, '2' => 66, '3' => 67, '4' => 68, '5' => 69, '6' => 70, '7' => 71, '8' => 72, '9' => 73, 'a' => 74, 'b' => 75, 'c' => 76, 'd' => 77, 'e' => 78, 'f' => 79, others => 255),
        '5' => ('0' => 80, '1' => 81, '2' => 82, '3' => 83, '4' => 84, '5' => 85, '6' => 86, '7' => 87, '8' => 88, '9' => 89, 'a' => 90, 'b' => 91, 'c' => 92, 'd' => 93, 'e' => 94, 'f' => 95, others => 255),
        '6' => ('0' => 96, '1' => 97, '2' => 98, '3' => 99, '4' => 100, '5' => 101, '6' => 102, '7' => 103, '8' => 104, '9' => 105, 'a' => 106, 'b' => 107, 'c' => 108, 'd' => 109, 'e' => 110, 'f' => 111, others => 255),
        '7' => ('0' => 112, '1' => 113, '2' => 114, '3' => 115, '4' => 116, '5' => 117, '6' => 118, '7' => 119, '8' => 120, '9' => 121, 'a' => 122, 'b' => 123, 'c' => 124, 'd' => 125, 'e' => 126, 'f' => 127, others => 255),
        '8' => ('0' => 128, '1' => 129, '2' => 130, '3' => 131, '4' => 132, '5' => 133, '6' => 134, '7' => 135, '8' => 136, '9' => 137, 'a' => 138, 'b' => 139, 'c' => 140, 'd' => 141, 'e' => 142, 'f' => 143, others => 255),
        '9' => ('0' => 144, '1' => 145, '2' => 146, '3' => 147, '4' => 148, '5' => 149, '6' => 150, '7' => 151, '8' => 152, '9' => 153, 'a' => 154, 'b' => 155, 'c' => 156, 'd' => 157, 'e' => 158, 'f' => 159, others => 255),
        'a' => ('0' => 160, '1' => 161, '2' => 162, '3' => 163, '4' => 164, '5' => 165, '6' => 166, '7' => 167, '8' => 168, '9' => 169, 'a' => 170, 'b' => 171, 'c' => 172, 'd' => 173, 'e' => 174, 'f' => 175, others => 255),
        'b' => ('0' => 176, '1' => 177, '2' => 178, '3' => 179, '4' => 180, '5' => 181, '6' => 182, '7' => 183, '8' => 184, '9' => 185, 'a' => 186, 'b' => 187, 'c' => 188, 'd' => 189, 'e' => 190, 'f' => 191, others => 255),
        'c' => ('0' => 192, '1' => 193, '2' => 194, '3' => 195, '4' => 196, '5' => 197, '6' => 198, '7' => 199, '8' => 200, '9' => 201, 'a' => 202, 'b' => 203, 'c' => 204, 'd' => 205, 'e' => 206, 'f' => 207, others => 255),
        'd' => ('0' => 208, '1' => 209, '2' => 210, '3' => 211, '4' => 212, '5' => 213, '6' => 214, '7' => 215, '8' => 216, '9' => 217, 'a' => 218, 'b' => 219, 'c' => 220, 'd' => 221, 'e' => 222, 'f' => 223, others => 255),
        'e' => ('0' => 224, '1' => 225, '2' => 226, '3' => 227, '4' => 228, '5' => 229, '6' => 230, '7' => 231, '8' => 232, '9' => 233, 'a' => 234, 'b' => 235, 'c' => 236, 'd' => 237, 'e' => 238, 'f' => 239, others => 255),
        'f' => ('0' => 240, '1' => 241, '2' => 242, '3' => 243, '4' => 244, '5' => 245, '6' => 246, '7' => 247, '8' => 248, '9' => 249, 'a' => 250, 'b' => 251, 'c' => 252, 'd' => 253, 'e' => 254, 'f' => 255, others => 255),
        others => (others => 255)
    );

    Byte_To_B64_Lookup : constant array (Byte) of Character := (
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
        'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
        'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3',
        '4', '5', '6', '7', '8', '9', '+', '/', others => '?'
    );

end Radix;