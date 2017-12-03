package chen.entity;

/**
 * 因为在显示商品属性的时候，不仅仅需要属性的id 还需要知道属性的具体名称.
 */
public class PropertyValue {
    private Integer id;

    //产品id
    private Integer pid;

    //属性id
    private Integer ptid;

    private String value;

    private Property property;

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getPtid() {
        return ptid;
    }

    public void setPtid(Integer ptid) {
        this.ptid = ptid;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }

    @Override
    public String toString() {
        return "PropertyValue{" +
                "id=" + id +
                ", pid=" + pid +
                ", ptid=" + ptid +
                ", value='" + value + '\'' +
                '}';
    }
}