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
    while (!isNaN(number)) {
        number = window.prompt("Please enter a number. Type any non-number to quit");
        if (isNaN(number)) {break;}
        primePartitions(number);
    }
    console.log("goodbye");
}

main();
