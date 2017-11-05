package chen.util;

/**
 * tmallCopy
 * Create by chen on 17-11-2
 * Page类是专门为分页提供必要的信息的工具类.而不是entity
 */
public class Page {
    private int start;  //开始的页数
    private int count;  //每页显示个数
    private int total;  //数据总个数
    private String param;   //参数 作用未知
    //默认每页显示个数
    private static final int DEFAULT_COUNT = 6;

    /**
     * 构造函数
     * 无参构造直接赋值每页为6个
     */
    public Page(){
        count = DEFAULT_COUNT;
    }

    public Page(int start,int count,int total){
        this.start = start;
        this.count = count;
        this.total = total;
    }
    public Page(int start){
        this.start = start;
        count =DEFAULT_COUNT;
    }

    public Page(int start,int count){
        this.start = start;
        this.count = count;
    }

    /**
     * 获取总共有多少页
     * 根据总数据个数和每页显示个数
     * @return
     */
    public int getTotalPage(){
        int num = total/count;
        return total%count==0?(num==0?1:num):num+1;
    }

    /**
     * 获取最后一页的开头
     * @return
     */
    public int getLast(){
        int st1 = total - count;
        int st2 = total - total%count;
        return total % count==0?(st1 < 0?0:st1):(st2 < 0?0:st2);
    }

    /**
     * 是否有前一页
     * @return
     */
    public boolean hasPreviouse(){
        return start != 0;
    }

    /**
     * 是否由后一页
     * @return
     */
    public boolean hasNext(){
        return start != getLast();
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    @Override
    public String toString() {
        return "Page{" +
                "start=" + start +
                ", count=" + count +
                ", total=" + total +
                ", param='" + param + '\'' +
                '}';
    }
}
