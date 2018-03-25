package com.mwh.album.service.impl;

import com.mwh.album.mapper.TagMapper;
import com.mwh.album.model.Tag;
import com.mwh.album.service.TagService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class TagServiceImpl implements TagService {
    private TagMapper tagMapper;

    public List<Tag> findAll() {
        List<Tag> tagList = tagMapper.findAll();
        if(tagList.isEmpty()){
            tagList.add(new Tag());
        }
        return tagList;
    }

    public Tag findById(int id) {
        Tag tag = new Tag();
        tag = tagMapper.findById(id);
        if(tag.getId() == null){
            return new Tag();
        }
        return tag;
    }

    public List<Tag> findByTagName(String tagName) {
        List<Tag> tagList = tagMapper.findByTagName(tagName);
        if(tagList.isEmpty()){
            tagList.add(new Tag());
        }
        return tagList;
    }

    public Tag findByTagNameNoBlur(String tagName) {
        Tag tag1 = tagMapper.findByTagNameNoBlur(tagName);
        if(tag1 == null){
            tag1 = new Tag();
        }
        return tag1;
    }

    public int save(Tag tag) {
        Tag tag1 = tagMapper.findByTagNameNoBlur(tag.getTagName());
        if(tag1 == null){
            tagMapper.save(tag);
        }
        tag1 = tagMapper.findByTagNameNoBlur(tag.getTagName());
        return tag1.getId();
    }

    public void delete(int id) {
        Tag tag = new Tag();
        tag = tagMapper.findById(id);
        if(tag == null){
            tagMapper.delete(id);
        }
    }

    @Resource
    public void setTagMapper(TagMapper tagMapper) {
        this.tagMapper = tagMapper;
    }
}
