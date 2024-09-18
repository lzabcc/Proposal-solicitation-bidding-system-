package com.example.demo.utils;

import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.stream.Collectors;

public class TFIDF {

    /*
    把字符按空格切分
    */
    public static List<String> spliteBySpace(String text){
        String s[] = text.split("\\s+");
        return new ArrayList<String>(Arrays.asList(s));
    }

    /*
    * https://blog.csdn.net/weixin_42242538/article/details/84754491
    * 分词算法
    */
    public static List<String> segmenter(List<String> dir, String text){
        List<String> result = new ArrayList<>();
        int jud=0;//找到匹配字符串与否的标志
        int j=0;
        String temp=null;//初始化临时字符串
        for(;text.length()>0;)
        {
            for(int i = 0;i<text.length();i++)
            {
                temp = text.substring(i);//每次截取掉首个字符
                if(dir.contains(temp))//如果目标字符串在数组中
                {
                    result.add(temp);
                    jud = 1;
                    int number = temp.length();
                    text = text.substring(0,text.length()-number);
                }
            }
            if(jud == 0)//没有找到匹配字符串
            {
                result.add(text.substring(text.length()-1,text.length()));//将最后一个元素放在cs2里面
                text = text.substring(0, text.length()-1);//截掉最后一个元素继续循环。
            }
            jud = 0;
            j++;
        }
        return result;
    }

    /*
    例1
    有很多不同的数学公式可以用来计算TF-IDF。这边的例子以上述的数学公式来计算。
    词频 (TF) 是一词语出现的次数除以该文件的总词语数。
    假如一篇文件的总词语数是100个，而词语“母牛”出现了3次，那么“母牛”一词在该文件中的词频就是3/100=0.03。
    一个计算文件频率 (IDF) 的方法是文件集里包含的文件总数除以测定有多少份文件出现过“母牛”一词。
    所以，如果“母牛”一词在1,000份文件出现过，而文件总数是10,000,000份的话，
    其逆向文件频率就是 lg(10,000,000 / 1,000)=4。最后的TF-IDF的分数为0.03 * 4=0.12。
    例2
    在某个一共有一千词的网页中“原子能”、“的”和“应用”分别出现了 2 次、35 次 和 5 次，
    那么它们的词频就分别是 0.002、0.035 和 0.005。 我们将这三个数相加，其和 0.042
    就是相应网页和查询“原子能的应用” 相关性的一个简单的度量。概括地讲，如果一个查询包含关键词 w1,w2,...,wN,
    它们在一篇特定网页中的词频分别是: TF1, TF2, ..., TFN。 （TF: term frequency)。
    那么，这个查询和该网页的相关性就是:TF1 + TF2 + ... + TFN。
     */
    public static List<String> getKeys(List<String> seg, int keyCounts){
        //总词数
        int totalWord = seg.size();
        //创建该文本词的集合
        Set<String> set = new CopyOnWriteArraySet<>();
        for(String s : seg){
            set.add(s);
        }
        //计算词出现的频率
        Map<String, Integer> wordsCount = new HashMap<>();
        for(String s : seg){
            Integer lastCountInterger = wordsCount.get(s);
            int lastCount = lastCountInterger == null? 0 : lastCountInterger;
            wordsCount.put(s, lastCount + 1);
        }
        //计算tf-idf评分
        Map<String, Float> wordsScore = new HashMap<>();
        for(Map.Entry<String, Integer> s : wordsCount.entrySet()){
            //逆向文件频率
            float idf = (float) Math.log (totalWord / (float)s.getValue());
            //tf-idf评分
            float score = idf * s.getValue();
            wordsScore.put(s.getKey(), score);
        }
        //对评分进行排序
        Map<String, Float> sorted = wordsScore.entrySet().stream().sorted(new Comparator<Map.Entry<String, Float>>() {
            @Override
            public int compare(Map.Entry<String, Float> o1, Map.Entry<String, Float> o2) {
                return (int) (o2.getValue() - o1.getValue());
            }
        }).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e2,
                LinkedHashMap::new));

        //获取最终关键字
        List<String> keys = new ArrayList<>();
        for(String k : sorted.keySet()){
            if(keys.size() < keyCounts){
                keys.add(k);
            }
        }
        return keys;
    }



}
