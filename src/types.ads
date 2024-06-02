with Interfaces; use Interfaces;

package Types is

    -- Bytes
    type Byte is new Unsigned_8;
    type Byte_Array is array (Integer range <>) of Byte;

end Types;