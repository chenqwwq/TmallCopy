package chen.dto;

/**
 * tmallCopy
 * Create by chen on 17-11-2
 */
public class Result {
    private boolean success = true;
    private String inf;

    //操作成功
    public Result(){
    }

    public Result(String info){
        this.inf = info;
        success = false;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getInf() {
        return inf;
    }

    public void setInf(String inf) {
        this.inf = inf;
    }
}
