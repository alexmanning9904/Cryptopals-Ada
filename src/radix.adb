package body Radix is

    function Hex_String_To_Bytes(Hex_String : String) return Byte_Array is
        Bytes : Byte_Array (1 .. Hex_String'Length/2) := (others => 0);
    begin
        for I in 1 .. Hex_String'Length/2 loop -- Loop through String 2 at a time
            declare
                Current_Hex_Upper_Nibble : Character renames Hex_String( 2*I - 1 ); -- Upper Nibble rename
                Current_Hex_Lower_Nibble : Character renames Hex_String( 2*I ); -- Lower Nubble Rename
            begin
                Bytes(I) := Hex_To_Byte_Lookup(Current_Hex_Upper_Nibble, Current_Hex_Lower_Nibble); -- Perform the lookup
                    
            end;
        end loop;
        return Bytes;
    end Hex_String_To_Bytes;

    function Bytes_To_Hex_String(Bytes : Byte_Array) return String is
        Hex_String : String (1 .. Bytes'Length * 2);
    begin
        for I in Bytes'Range loop
            declare
                Current_Byte : Byte renames Bytes(I);
            begin
                Hex_String(2*I - 1) := Byte_To_Hex_Lookup(Shift_Right(Current_Byte, 4));
                Hex_String(2*I) := Byte_To_Hex_Lookup(Current_Byte and 2#00001111#);
            end;
        end loop;
        return Hex_String;
    end Bytes_to_Hex_String;

    function Bytes_To_ASCII_String(Bytes : Byte_Array) return String is
        ASCII_String : String (1 .. Bytes'Length);
    begin
        for I in Bytes'Range loop
            ASCII_String(I) := Byte_To_ASCII_Lookup(Bytes(I));
        end loop;
        return ASCII_String;
    end Bytes_to_ASCII_String;

    function ASCII_String_To_Bytes(ASCII_String : String) return Byte_Array is
        Bytes : Byte_Array(ASCII_String'Range);
    begin
        for I in ASCII_String'Range loop
            Bytes(I) := ASCII_To_Byte_Lookup(ASCII_String(I));
        end loop;
        return Bytes;
    end ASCII_String_To_Bytes;

    function Bytes_To_B64_String(Bytes : Byte_Array) return String is
        B64_String : String (1 .. Bytes'Length * 4/3) := (others => '?');
    begin
        for I in 1 .. Bytes'Length/3 loop -- Handle 3 Bytes at a time (maps to 4 B64 characters) 
            declare
                Byte_1 : Byte renames Bytes( 3*I - 2);
                Byte_2 : Byte renames Bytes( 3*I - 1);
                Byte_3 : Byte renames Bytes( 3*I - 0);
            begin
                B64_String(4*I - 3 .. 4*I) :=   Byte_To_B64_Lookup(Shift_Right(Byte_1, 2)) &
                                                Byte_To_B64_Lookup(Shift_Left(Byte_1 and 2#0000_0011#, 4) or Shift_Right(Byte_2, 4)) &
                                                Byte_To_B64_Lookup(Shift_Left(Byte_2 and 2#0000_1111#, 2) or Shift_Right(Byte_3, 6)) &
                                                Byte_To_B64_Lookup(Byte_3 and 2#0011_1111#); -- Write the String
            end;
        end loop;
        return B64_String;
    end Bytes_To_B64_String;

    function B64_String_To_Bytes_Length(B64_String : String) return Natural is
        Output : Natural := B64_String'Length * 3/4; -- B64 string can carry at most 3/4 data density
    begin
        if B64_String(B64_String'Last) = '=' then
            Output := Output - 1;  -- Last byte is padding

            if B64_String(B64_String'Last - 1) = '=' then
                Output := Output - 1;  -- Last byte is padding -- Last 2 bytes are padding
            end if;
        end if;

        return Output;
    end B64_String_To_Bytes_Length;

    function B64_String_To_Bytes(B64_String : String) return Byte_Array is
        Bytes : Byte_Array(1 .. B64_String_To_Bytes_Length(B64_String));
    begin
        for I in 1 .. B64_String'Length/4 loop -- Handle 4 B64 Chars at a time (maps to 3 bytes)
            declare
                Char_1 : Character renames B64_String( 4*I - 3);
                Char_2 : Character renames B64_String( 4*I - 2);
                Char_3 : Character renames B64_String( 4*I - 1);
                Char_4 : Character renames B64_String( 4*I - 0);
            begin
                Bytes(3*I - 2) := Shift_Left(B64_To_Byte_Lookup(Char_1), 2) or Shift_Right(B64_To_Byte_Lookup(Char_2), 4);

                if Char_3 /= '=' then -- No padding, so there is a second byte
                    Bytes(3*I - 1) := Shift_Left(B64_To_Byte_Lookup(Char_2), 4) or Shift_Right(B64_To_Byte_Lookup(Char_3), 2);
                end if;

                if Char_4 /= '=' then -- No padding, so there is a third byte
                    Bytes(3*I) := Shift_Left(B64_To_Byte_Lookup(Char_3), 6) or B64_To_Byte_Lookup(Char_4);
                end if;
            end;
        end loop;

        return Bytes;
    end B64_String_To_Bytes;

end Radix;