# TmallCopy

1.在web.xml增加MultipartFilters之后会报
    java.lang.IllegalStateException:
     Unable to process parts as no multi-part configuration has been provided错误

2.将spring-web.xml的multipartResolver改名之后,会报空指针异常.文件无法正常上传