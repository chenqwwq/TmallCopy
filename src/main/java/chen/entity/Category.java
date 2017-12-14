package chen.entity;

import java.util.List;

public class Category {
    private Integer id;

    private String name;

    //分类下的所有商品
    private List<Product> products;

    //按照固定数目的分组
    private List<List<Product>> groupProducts;

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public List<List<Product>> getGroupProducts() {
        return groupProducts;
    }

    public void setGroupProducts(List<List<Product>> groupProducts) {
        this.groupProducts = groupProducts;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", products=" + products +
                ", groupProducts=" + groupProducts +
                '}';
    }
}