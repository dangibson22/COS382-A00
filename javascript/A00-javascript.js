const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

function isPrime (n) {
    if (n<=1) {
        return false;
    } else {
        for (let i=2; i<n; i++) {
            if (n%i == 0) {
                return false;
            }
        }
        return true;
    }
}

function primes(a, b) {
    let primeList = [];
    for (let i=a; i<=b; i++) {
        if (isPrime(i)) {
            primeList.push(i);
        }
    }
    return primeList;
}

function primePartitions(n, k=1, lst=[]) {
    if (n == 0) {
        console.log(lst.join(" + "));
    } else if (n>k) {
        let primesList = primes(k + 1, n)
        for (let i=0; i<primesList.length; i++) {
            let p = primesList[i]
            let newList = lst.slice();
            newList.push(p);
            primePartitions(n - p, p, newList)
        }
    }
}

function main() {
    let number = 0;
    //while (!isNaN(number)) {
        rl.question("Please enter a number. Type any non-number to quit: ", (num) => {
            number = num
            if (isNaN(number)) {
                console.log("goodbye");
                process.exit();
            }
            primePartitions(number);
            main();
        });
    //}
}

main();