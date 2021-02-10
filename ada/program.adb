-- compile Ada using gnatmake {filename} on terminal

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics;        use Ada.Numerics;

with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;

procedure Program is
  N     : Integer;
  Done  : Boolean;

  -- type PrimeInt is range 2 .. Integer'Last;
  type PrimePartitionList is array (Natural range<>) of Integer;
  type PrimeNumberList is array (Natural range<>) of Integer;

  StartList : PrimePartitionList (1 .. 0);

  function Is_Prime ( N: Integer ) return Boolean is
  begin
    if N <= 1 then
      return false;
    end if;
    for I in 2 .. Integer ( Sqrt ( Float ( N ))) loop
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
      if Is_Prime (J) then
        PrimesList (I) := J;
        I := I + 1;
      end if;
      exit when I > PrimesList'Length;
    end loop;
    return PrimesList;
  end Primes;

  function Prime_Partitions ( N: Integer; K: Integer; PList: PrimePartitionList ) return Boolean is
    NewPList : PrimePartitionList(0 .. PList'Length);
    Done     : Boolean := true;
  begin
    if N = 0 then
      -- haven't found a clean method for splitting Ada arrays,
      -- so instead iterating over each item
      for I of PList loop
        if I = PList (PList'Last) then
          Put (Integer'Image (I));
        else
          Put (Integer'Image (I) & " +");
        end if;
      end loop;
      New_Line;
    elsif N > K then
      for I in PList'Range loop
         NewPList (I) := PList (I);
      end loop;
      for P of Primes(K + 1, N) loop
        NewPList (NewPList'Last) := P;
        Done := Prime_Partitions (N - P, P, NewPList);
      end loop;
    end if;

    return Done;


  end Prime_Partitions;

begin
  loop
    Put ("Enter a number (non-number to quit): ");
    Get (N);
    New_Line;
    Done := Prime_Partitions(N, 1, StartList);
    Put_Line ("Done :" & Boolean'Image(Done));
  end loop;
exception
  when Data_Error =>
    Put_Line("Thanks for playing, bye!");
end Program;