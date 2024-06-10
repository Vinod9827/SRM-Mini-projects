import multiprocessing
import re
from collections import defaultdict

def mapper(line):
    word_freq = defaultdict(int)
    words = re.findall(r'\b\w+\b', line.lower())
    for word in words:
        word_freq[word] += 1
    return word_freq

def reducer(results):
    word_freq = defaultdict(int)
    for result in results:
        for word, count in result.items():
            word_freq[word] += count
    return word_freq

def map_reduce(data, mapper_func, reducer_func, num_workers=2):
    with multiprocessing.Pool(num_workers) as pool:
        mapped_data = pool.map(mapper_func, data)
    reduced_data = reducer_func(mapped_data)
    return reduced_data

if __name__ == "__main__":
    # Example data (list of lines from a text file)
    data = [
        "Hello world",
        "Hello again world",
        "Goodbye world"
    ]

    # Perform MapReduce
    word_freq = map_reduce(data, mapper, reducer)

    # Print the word frequency
    for word, count in word_freq.items():
        print(f"{word}: {count}")
