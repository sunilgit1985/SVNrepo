package com.invessence.web.service.custody;

import com.invessence.custody.uob.dao.UOBDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by abhangp on 11/10/2017.
 */
@Service("uobCustodyService")
public class UOBCustodyServiceImpl implements CustodyService
{
   @Autowired
   UOBDao uobDao;
   @Override
   public void save()
   {

   }

   @Override
   public void save1()
   {

   }

   @Override
   public void save2()
   {

   }

   @Override
   public void save3()
   {

   }

   @Override
   public Object fetch()
   {
      return null;
   }
}