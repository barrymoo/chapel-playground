// Matrix Vector Multiply
// \mat(A) \times B = C

use ReplicatedDist;
use CyclicDist;
use VisualDebug;

// By default, only use one task per locale
config const tasksPerLocale : int = 1;

// The initial dimension as a config const
config const dimension : int = 10;

// Create a grid for the Locales, makes Cyclic dmap easier
const localeGrid = reshape(Locales, {0..#numLocales, 0..0});

// Matrix domain, rows distributed to locales using cyclic distribution
const matrixCyclic = {0..#dimension, 0..#dimension} dmapped Cyclic(startIdx = (0, 0), targetLocales = localeGrid);
var A : [matrixCyclic] int;

// Vector domains
// -> B is replicated across locales
// -> C is a row distributed cyclically similar to matrixCyclic
const vectorCyclicReplicated = {0..#numLocales, 0..#dimension} dmapped Cyclic(startIdx = (0, 0), targetLocales = localeGrid);
const vectorCyclic = matrixCyclic[.., 0];
var B : [vectorCyclicReplicated] int;
var C : [vectorCyclic] int;

// Initialize A and B to 1
forall a in A do a = 1;
forall b in B do b = 1;

// Start the visual debugger, will create directory `vis`
// -> Make sure to remove its contents if changing numLocales
startVdebug("vis");

// The business, 
forall (i, c) in zip(vectorCyclic, C) {
    for (a, j) in zip(A.localSlice(i..i, ..), 0..#dimension) {
        c += a * B(here.id, j);
    }
}

// Stop the visual debugger
stopVdebug();

// Write C, each element should equal the dimension
writeln(C);
