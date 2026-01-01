-- A generic for creating simple DBs (one table in an RDBMS) with PragmARC.Persistent_Skip_List_Unbounded and an Ada-GUI UI
--
-- Copyright (C) by Jeffrey R. Carter
--
generic -- DB_Maker
   Max_Field_Length : Positive;
   File_Name        : String; -- ".psl" will be appended

   type Field_Number is range <>;

   with function Field_Name (Field : in Field_Number) return String;

   type Element is private; -- Cannot contain access values

   with function Value (Item : in Element; Field : in Field_Number) return String;
   with procedure Put (Item : in out Element; Field : in Field_Number; Value : in String);
   with function "<" (Left : in Element; Right : in Element) return Boolean is <>;
   with function "=" (Left : in Element; Right : in Element) return Boolean is <>;
package DB_Maker is
   pragma Elaborate_Body;
end DB_Maker;
--
-- SPDX-License-Identifier: GPL-2.0-or-later WITH GNAT-exception
-- See https://spdx.org/licenses/
-- If you find this software useful, please let me know, either through
-- github.com/jrcarter or directly to pragmada@pragmada.x10hosting.com
