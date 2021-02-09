-- compile Ada using gnatmake {filename} on terminal

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics;        use Ada.Numerics;

with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;

procedure Program is
  N     : Integer;
  Prime : Boolean;
  X     : Integer;

  -- type PrimeInt is range 2 .. Integer'Last;
  type PrimePartitionList is array (Natural range<>) of Integer;
  type PrimeNumberList is array (Natural range<>) of Integer;

  StartList : PrimePartitionList (1 .. 0);

  function Is_Prime ( N: Integer ) return Boolean is
  begin
    if N <= 1 then
      return false;
    end if;
    for I in 2 .. Integer (Sqrt (Float (N))) loop
      if N mod I = 0 then
        return false;
      end if;
    end loop;
    return true;
  end Is_Prime;

  function GetListLength ( A, B: Natural ) return Integer is
    Size : Integer := (B - A) + 1;
  begin
    for I in A .. B loop
       if not Is_Prime(I) then
        Size := Size - 1;
      end if;
    end loop;
    return size;
  end GetListLength;

  function Primes(A, B: Integer) return PrimeNumberList is
    PrimesList : PrimeNumberList(1 .. GetListLength(A, B));
    I : Integer := 1;
  begin
    for J in A .. B loop
      exit when I > PrimesList'Length;
       if Is_Prime (J) then
        PrimesList (I) := J;
        I := I + 1;
      end if;
    end loop;
    return PrimesList;
  end Primes;

  function Recursive_Test ( X: Integer; PrevList: PrimePartitionList ) return Integer is
    NewList : PrimePartitionList(0 .. PrevList'Length);
    Value : Integer;
  begin
    for I in PrevList'Range loop
       NewList (I) := PrevList (I);
    end loop;
    NewList (NewList'Last) := NewList'Last;
    for I in NewList'Range loop
       Put (Integer'Image (NewList (I)));
    end loop;
    New_Line;
    if X < 3 then
      Value := Recursive_Test (X + 1, NewList);
    end if;
    return 1;
  end Recursive_Test;

begin
  Put ("Enter a number: ");
  Get (N);
  Put_Line("number:" & Integer'Image (N));
  Prime := Is_Prime (N);
  Put_Line("is prime: " & Boolean'Image (Prime));

  X := Recursive_Test(0, StartList);
  Put_Line("finished" & Integer'Image (X));


end Program;