using System;
using System.Collections.Generic;

namespace C_
{
    class Program
    {
        private static bool isPrime(int n) {
            if (n <= 1) {
                return false;
            }
            for (int x=2; x < (int)(Math.Sqrt(n)) + 1; x++) {
                if (n%x == 0) {
                    return false;
                }
            }
            return true;
        }

        private static List<int> primes(int a, int b) {
            var primesList = new List<int>();
            for (int i=a; i<=b; i++) {
                if (isPrime(i)) {
                    primesList.Add(i);
                }
            }
            return primesList;
        } 

        private static void primePartitions(int n, int k=1, List<int> lst = null) {
            if (lst == null) {
                lst = new List<int>();
            }
            if (n==0) {
                for (int i=0; i<lst.Count; i++) {
                    Console.Write(lst[i]);
                    if (i<lst.Count -1) {
                        Console.Write(" + ");
                    }
                    else {
                        Console.Write("\n");
                    }
                }
            }
            else if (n > k) {
                foreach (int p in primes(k+1, n)) {
                    List<int> newLst = new List<int>(lst);
                    newLst.Add(p);
                    primePartitions(n - p, p, newLst);
                }
            }
        }
        static void Main(string[] args)
        {
            string input = "0";
            int parsedInt;
            while (int.TryParse(input, out parsedInt)) {
                Console.Write("Enter a number for the partitions, or anything else to quit: ");
                input = Console.ReadLine();
                if (int.TryParse(input, out parsedInt)) {
                    primePartitions(parsedInt);
                }
            }
            Console.WriteLine("Goodbye");
        }
    }
}
