-- compile Ada using gnatmake {filename} on terminal

with Ada.TEXT_IO;

procedure Greet is
begin
  -- Print "Hello, World!" to the screen
  Ada.TEXT_IO.Put_Line ("Hello, World!");
end Greet;