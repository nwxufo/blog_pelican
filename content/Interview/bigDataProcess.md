1. Given file a、b, saved 5 billion url, each url 64KB, Memory limited fo 4GB, find the common url of a,b file.

1st Method.
file size : 5GB * 64B ～ 320G.
1. hash(a)/1000 => a0 a1 ...... a999   each size approximated 300M < limited 4G.
2. hash(b)/1000 => b0 b2 ...... b999
------------------------------------
compare: (a0 vs b0) (a1 vs b1) ...... (a999 vs b999) .
to get the same url.
============
2nd Method:
If error rate permited. Could use Bloom filter.
what's the Bloom filter

2. 10 file, every file size is 1G. each line of each file saved user's query which could be repeated in each file. sort the query according repeated time.
1st Method:
 1. read 10 file, [hash(query）% 10] gen new 10 files.
 2. hash_map(query,query_count) statisfy the query counter in each new files..
 3. heap sort /quick sort/ conquer sort , get 10 new sorted files.
 4. conquer sort 10 files

2nd Method:
朴素的方法：把所有的query一次性的加入到内存。这样，就可以采用trie树，/has_map/等直接来统计每个query的次数，然后进行快排/堆/归并排序。

3nd Method.
与方案一类似，昨晚hash后，采用分布式架构来处理，比如MapReduce. 之后再 conquer.

3.Each line is a word which limited 16B saved in 1G file. Memory just 1M. return top 100 repeated word.

4.sea data log. find the topes vist count IP address.

5.在2.5亿数中找到不重复的整数，内存不足以容纳这2.5亿个整数。

6.海量数据分布在100台电脑中，要求高效统计数据的top100.

7.海量数据中找出重复次数最多的一个。

8.上千万或上亿数据（有重复），统计其中出现次数最多的前n个数据。

9.1000万字符串，去重。

10. 文本文件每行一词，约10000行，求top10, 分析时间复杂度。

11. 文本文件，找出top10 wold, 文件较长，上亿行，无法一次读入内存。

12. 100w个数中找出最大的100个数据。

13.寻找热门查询。
搜索引擎会通过日志文件把用户每次检索使用的所有检索窜都记录下来，每个查询的长度位1-255字节。 假设目前有1 千万记录，这些查询串的重复比较高，虽然总数是1 千万. 如果去重，不超过3 million. 求top10字符串， 要求使用内存不超过1G.

14. 一共N个机器，每个机器有N个数。每个机器最多存O(N)个数并对他们操作，如何找到N^2个数中的中数。