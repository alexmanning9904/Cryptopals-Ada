with Interfaces; use Interfaces;

package Types is

    -- Bytes
    type Byte is new Unsigned_8;
    type Byte_Array is array (Integer range <>) of Byte;

    -- Byte Operations
    function "xor" (Left, Right : Byte_Array) return Byte_Array;

end Types;