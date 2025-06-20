-- Demo for DB_Maker: Catalog your extensive collection of BetaMax videotape cassettes!
--
-- Copyright (C) 2023 by Jeffrey R. Carter
--
with DB_Maker;
with DB_Strings;
with PragmARC.Title_Comparisons;

procedure Movies is
   subtype Strng is DB_Strings.Strng;
   use type Strng;

   type Movie_Info is record
      Title       : Strng;
      Year        : Strng;
      Director    : Strng;
      Writer      : Strng;
      Male_Lead   : Strng;
      Female_Lead : Strng;
   end record;

   function "=" (Left : Movie_Info; Right : Movie_Info) return Boolean is
      (Left.Title = Right.Title and Left.Year = Right.Year and Left.Director = Right.Director);

   use type PragmARC.Title_Comparisons.Article_List;

   Article : constant PragmARC.Title_Comparisons.Article_List :=
      PragmARC.Title_Comparisons.English & PragmARC.Title_Comparisons.French & "el ";

   function "<" (Left : Movie_Info; Right : Movie_Info) return Boolean is
   begin -- "<"
      if Left.Title /= Right.Title then
         return PragmARC.Title_Comparisons.Less (+Left.Title, +Right.Title, Article);
      end if;

      if Left.Year /= Right.Year then
         return Left.Year < Right.Year;
      end if;

      return Left.Director < Right.Director;
   end "<";

   subtype Field_Number is Integer range 1 .. 6;

   function Field_Name (Field : in Field_Number) return String is
      -- Empty
   begin -- Field_Name
      case Field is
      when 1 =>
         return "Title";
      when 2 =>
         return "Year";
      when 3 =>
         return "Director";
      when 4 =>
         return "Screenplay";
      when 5 =>
         return "Male Lead";
      when 6 =>
         return "Female Lead";
      end case;
   end Field_Name;

   function Value (Item : in Movie_Info; Field : in Field_Number) return String is
      -- Empty
   begin -- Value
      case Field is
      when 1 =>
         return +Item.Title;
      when 2 =>
         return +Item.Year;
      when 3 =>
         return +Item.Director;
      when 4 =>
         return +Item.Writer;
      when 5 =>
         return +Item.Male_Lead;
      when 6 =>
         return +Item.Female_Lead;
      end case;
   end Value;

   procedure Put (Item : in out Movie_Info; Field : in Field_Number; Value : in String) is
      -- Empty
   begin -- Put
      case Field is
      when 1 =>
         Item.Title := +Value;
      when 2 =>
         Item.Year := +Value;
      when 3 =>
         Item.Director := +Value;
      when 4 =>
         Item.Writer := +Value;
      when 5 =>
         Item.Male_Lead := +Value;
      when 6 =>
         Item.Female_Lead := +Value;
      end case;
   end Put;

   package Movie_DB is new DB_Maker (Max_Field_Length => 100,
                                     File_Name        => "Movies",
                                     Field_Number     => Field_Number,
                                     Field_Name       => Field_Name,
                                     Element          => Movie_Info,
                                     Value            => Value,
                                     Put              => Put);
begin -- Movies
   null;
end Movies;
--
-- SPDX-License-Identifier: GPL-2.0-or-later
-- See https://spdx.org/licenses/
-- If you find this software useful, please let me know, either through
-- github.com/jrcarter or directly to pragmada@pragmada.x10hosting.com
