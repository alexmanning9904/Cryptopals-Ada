with Interfaces; use Interfaces;

package Types is

    -- Bytes
    type Byte is new Unsigned_8;
    type Byte_Array is array (Integer range <>) of Byte;

    -- Byte Operations
    function "xor" (Left, Right : Byte_Array) return Byte_Array with
    Pre => Left'Length >= Right'Length;
    function "xor" (Left : Byte_Array; Right : Byte) return Byte_Array;

    -- Other Functions
    function Hamming_Distance (Left, Right : Byte_Array) return Natural with
    Pre => Left'Length = Right'Length;

end Types;