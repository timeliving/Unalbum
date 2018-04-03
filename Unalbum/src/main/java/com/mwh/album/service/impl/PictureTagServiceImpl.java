package com.mwh.album.service.impl;

import com.mwh.album.mapper.PictureTagMapper;
import com.mwh.album.model.Picture;
import com.mwh.album.model.PictureTag;
import com.mwh.album.service.PictureTagService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class PictureTagServiceImpl implements PictureTagService {

    private PictureTagMapper pictureTagMapper;

    public List<PictureTag> findAll() {
        List<PictureTag> pictureTagList = pictureTagMapper.findAll();

        return pictureTagList;
    }

    public List<PictureTag> findByPictureId(int pictureId) {
        List<PictureTag> pictureTagList = pictureTagMapper.findByPictureId(pictureId);

        return pictureTagList;
    }

    public List<PictureTag> findByTagId(int tagId) {
        List<PictureTag> pictureTagList = pictureTagMapper.findByTagId(tagId);

        return pictureTagList;
    }

    public PictureTag findByTagIdAndPictureId(int tagId, int pictureId) {
        PictureTag pictureTag = pictureTagMapper.findByTagIdAndPictureId(tagId, pictureId);
        if(pictureTag == null){
            return new PictureTag();
        }
        return pictureTag;
    }

    public List<Picture> findPicturesNoTag() {
        return pictureTagMapper.findPicturesNoTag();
    }

    public void save(PictureTag pictureTag) {
        PictureTag tag = findByTagIdAndPictureId(pictureTag.getTagId(), pictureTag.getPictureId());
        if(tag == null){
            pictureTag.setCreateDate(new Date());
            pictureTagMapper.save(pictureTag);
        }
    }

    public void delete(int id) {
        pictureTagMapper.delete(id);
    }

    public void deleteByPictureId(int pictureId) {
        pictureTagMapper.deleteByPictureId(pictureId);
    }

    @Resource
    public void setPictureTagMapper(PictureTagMapper pictureTagMapper) {
        this.pictureTagMapper = pictureTagMapper;
    }
}
