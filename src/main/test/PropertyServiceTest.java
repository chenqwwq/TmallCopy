import chen.entity.Property;
import chen.service.PropertyService;
import chen.util.CommonUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;


/**
 * Create by chen on 17-11-4
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring/*.xml")
public class PropertyServiceTest {

    @Autowired
    private PropertyService propertyService;

    public PropertyServiceTest() {
    }


    @Test
    public void allAboutProperty(){
        Property property = propertyService.get(257);
        System.out.println(property);
        propertyService.delete(257);
        List propertyList= propertyService.list(60);
        CommonUtil.showList(propertyList);
    }
}
