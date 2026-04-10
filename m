Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9221CC5A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801226; cv=none; b=U6vI6HALe6vOX/WdDZQCA3PjOczW1X9eLuTFuo6Jj20OgvfN39+Nm4Eca1REduoGmMO+F0YGWSjcl1ZttQAmmzCpMX1eZVipzXIxvOsWnsZTkIJo34J5cEeMPXfN1v7ohMuWce1Uz5pjDImA465UslCTPRsYzdwy9H+CCYR+Vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801226; c=relaxed/simple;
	bh=RjwBPRkeG5Ef4je2thKei9pgNx738xHF3O0Sl352Vog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qnz73flFxy0dNND5R900fGKUgnmzUGzGY6UfEup5RA9+nkrI9Cy5ed0CEoFmCdF1CIQ6OXQelUKxw/VR56ALJdkfWvIos5OVxPHfxZ78U01shaLF5itGOzybwoCUts+AK5ssRg4rqgrGKrNH+w61FcxhS9GVlwNQGXcM8+8eQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvQA953i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvQA953i"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so24867605e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775801223; x=1776406023; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZqLnP2didcYOQ2rnG5G8sET7hVx2awOo8mfcDB6qns=;
        b=nvQA953iuOf3iE5R5d/0WgNVpXZU00h86XqLXariE3RxKu2pzGgV9hGCTpLE18FGfZ
         mD0KVuxZ5pNE6PNOXOeem+OgPYalQuflwA2HNBvI9Fhipg1VfahNekDewQD6KHnR5aJb
         PDJeZfS1ftv9CQv5/Qtu0rkidFQ0DnZCprrPPUQ3ZmH2+xBh/gtHmMdqBOFNQyKVlztU
         /T95T7awWkedeNrIEE9wvKqsZFBRHAfPHD60xp0CuvqodKMnQX12i4/xjW3fQ3RwvVEB
         VFogGoBKGFs5gB4yuEqY9vg4rJhafUe8hgxRoQJ12zAnsQes6boy8wFy8GWpUVPmY3nk
         k/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775801223; x=1776406023;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZqLnP2didcYOQ2rnG5G8sET7hVx2awOo8mfcDB6qns=;
        b=jhyjkRwjjai61q+LBVtRRQuFFOj8+w3I4T/AYjxFIXBDiHR1VL3zwx1+lpGWVB1zv6
         syw21GH4wa7bNv7BM03Qvarh8J1SxluAnwUFhHNZONFhXpATo4fEuw+wrPDEmiVOVCZd
         QFuKX88LGGkUfzQ3XIhNAI2X/qoZf6EscDv93f4C44s8NoC1m3hZ8PUIIi+491xICC6M
         3RSq9W5WY9B36uQdbYkaEtT0lt58mXyCdpjsBrk469pqaUNWSlVhcCg0xAK+RcW00fNs
         MD2Sw58DzNIzEqp+oT5V0fJPVZqmL1Vo8xJjiWXTDFzXJhjO9/UU3e9ahnJ6vw1rUWWE
         qNiA==
X-Gm-Message-State: AOJu0Yys0qcLDyrHlFAFZehaN2N50CwBGf0Wu9ZvgdVZO5dl+uI+ru5W
	F/DTsF9xAEIVTrWjOWwPt20/muMiLXO/NLuYmj+f93d6Tw86HvEL01sDHkdpiC3I
X-Gm-Gg: AeBDietDuVrd1AANp0KZaSMVkXQMiob4HsbYmxrKXchKLGdkRTnNzQ3E1Kmd00F3N1W
	540X70S3rt/LAL2FdfR4BOHCLiRpzrtSe3tfO5GzOKf4K1qPzu14ir5CLijdR2wssnxBRBNF+vP
	C98vHhRHMuBz4qs2ze8WfjsSutyQTr46qG34tT8usfQBeGl/MVpPqLmyIH7xxoOrehtZvdoewFm
	w4OZ9cyqGE8pgwkISIVbNWI3HujxCtRj/S85ofp48ubs7dZASYoMQG8B2YANVIKBk2F6UY4cdDI
	P4M1NR2HSq1m7O0EQ0zq7F+gUX+JUYFx+2jVKrYrhM3LrRwjHpNMyJn53tASCCkIBbaB3V6yWS3
	QiwtjaH6IRrldh8LkcaqF8bmD8if2Q/HF+ClbSCQmYl7FdRn+zesQqwX71CLj1jgHmiAweMnOrb
	ZwCFYUmfENR4g8zlZbbrM=
X-Received: by 2002:a5d:5f53:0:b0:43d:1dfe:350a with SMTP id ffacd0b85a97d-43d6425d63cmr2646683f8f.22.1775801222768;
        Thu, 09 Apr 2026 23:07:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e468d0sm4929160f8f.18.2026.04.09.23.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:07:02 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:06:59 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: update iomap and address space operations
Message-ID: <adiTg9E-Y4PEKwyG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namjae Jeon,

Commit b041ca562526 ("ntfs: update iomap and address space
operations") from Feb 13, 2026 (linux-next), leads to the following
Smatch static checker warning:

	fs/ntfs/iomap.c:517 ntfs_write_simple_iomap_begin_non_resident()
	error: uninitialized symbol 'err'.

fs/ntfs/iomap.c
    379 static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_t offset,
    380                                                       loff_t length, struct iomap *iomap)
    381 {
    382         struct ntfs_inode *ni = NTFS_I(inode);
    383         struct ntfs_volume *vol = ni->vol;
    384         loff_t vcn_ofs, rl_length;
    385         struct runlist_element *rl, *rlc;
    386         bool is_retry = false;
    387         int err;

I think the intent was to initialize err to zero.

    388         s64 vcn, lcn;
    389         s64 max_clu_count =
    390                 ntfs_bytes_to_cluster(vol, round_up(length, vol->cluster_size));
    391 
    392         vcn = ntfs_bytes_to_cluster(vol, offset);
    393         vcn_ofs = ntfs_bytes_to_cluster_off(vol, offset);
    394 
    395         down_read(&ni->runlist.lock);
    396         rl = ni->runlist.rl;
    397         if (!rl) {
    398                 up_read(&ni->runlist.lock);
    399                 err = ntfs_map_runlist(ni, vcn);
    400                 if (err) {
    401                         mutex_unlock(&ni->mrec_lock);
    402                         return -ENOENT;
    403                 }

Otherwise if rl is true

    404                 down_read(&ni->runlist.lock);
    405                 rl = ni->runlist.rl;
    406         }
    407         up_read(&ni->runlist.lock);
    408 
    409         down_write(&ni->runlist.lock);
    410 remap_rl:
    411         /* Seek to element containing target vcn. */
    412         rl = __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
    413         if (IS_ERR(rl)) {
    414                 up_write(&ni->runlist.lock);
    415                 mutex_unlock(&ni->mrec_lock);
    416                 return -EIO;
    417         }
    418         lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
    419 
    420         if (lcn <= LCN_RL_NOT_MAPPED && is_retry == false) {
    421                 is_retry = true;
    422                 if (!ntfs_map_runlist_nolock(ni, vcn, NULL)) {
    423                         rl = ni->runlist.rl;
    424                         goto remap_rl;
    425                 }
    426         }
    427 
    428         max_clu_count = min(max_clu_count, rl->length - (vcn - rl->vcn));
    429         if (max_clu_count == 0) {
    430                 ntfs_error(inode->i_sb,
    431                                 "runlist(vcn : %lld, length : %lld) is corrupted\n",
    432                                 rl->vcn, rl->length);
    433                 up_write(&ni->runlist.lock);
    434                 mutex_unlock(&ni->mrec_lock);
    435                 return -EIO;
    436         }
    437 
    438         iomap->bdev = inode->i_sb->s_bdev;
    439         iomap->offset = offset;
    440 
    441         if (lcn <= LCN_DELALLOC) {
    442                 if (lcn < LCN_DELALLOC) {
    443                         max_clu_count =
    444                                 ntfs_available_clusters_count(vol, max_clu_count);
    445                         if (max_clu_count < 0) {
    446                                 err = max_clu_count;
    447                                 up_write(&ni->runlist.lock);
    448                                 mutex_unlock(&ni->mrec_lock);
    449                                 return err;
    450                         }
    451                 }
    452 
    453                 iomap->type = IOMAP_DELALLOC;
    454                 iomap->addr = IOMAP_NULL_ADDR;
    455 
    456                 if (lcn <= LCN_HOLE) {
    457                         size_t new_rl_count;
    458 
    459                         rlc = kmalloc(sizeof(struct runlist_element) * 2,
    460                                         GFP_NOFS);
    461                         if (!rlc) {
    462                                 up_write(&ni->runlist.lock);
    463                                 mutex_unlock(&ni->mrec_lock);
    464                                 return -ENOMEM;
    465                         }
    466 
    467                         rlc->vcn = vcn;
    468                         rlc->lcn = LCN_DELALLOC;
    469                         rlc->length = max_clu_count;
    470 
    471                         rlc[1].vcn = vcn + max_clu_count;
    472                         rlc[1].lcn = LCN_RL_NOT_MAPPED;
    473                         rlc[1].length = 0;
    474 
    475                         rl = ntfs_runlists_merge(&ni->runlist, rlc, 0,
    476                                         &new_rl_count);
    477                         if (IS_ERR(rl)) {
    478                                 ntfs_error(vol->sb, "Failed to merge runlists");
    479                                 up_write(&ni->runlist.lock);
    480                                 mutex_unlock(&ni->mrec_lock);
    481                                 kvfree(rlc);
    482                                 return PTR_ERR(rl);
    483                         }
    484 
    485                         ni->runlist.rl = rl;
    486                         ni->runlist.count = new_rl_count;
    487                         ni->i_dealloc_clusters += max_clu_count;
    488                 }
    489                 up_write(&ni->runlist.lock);
    490                 mutex_unlock(&ni->mrec_lock);
    491 
    492                 if (lcn < LCN_DELALLOC)
    493                         ntfs_hold_dirty_clusters(vol, max_clu_count);
    494 
    495                 rl_length = ntfs_cluster_to_bytes(vol, max_clu_count);
    496                 if (length > rl_length - vcn_ofs)
    497                         iomap->length = rl_length - vcn_ofs;
    498                 else
    499                         iomap->length = length;
    500 
    501                 iomap->flags = IOMAP_F_NEW;
    502                 if (lcn <= LCN_HOLE) {
    503                         loff_t end = offset + length;
    504 
    505                         if (vcn_ofs || ((vol->cluster_size > iomap->length) &&
    506                                         end < ni->initialized_size)) {
    507                                 loff_t z_start, z_end;
    508 
    509                                 z_start = vcn << vol->cluster_size_bits;
    510                                 z_end = min_t(loff_t, z_start + vol->cluster_size,
    511                                               i_size_read(inode));
    512                                 if (z_end > z_start)
    513                                         err = ntfs_zero_range(inode,
    514                                                               z_start,
    515                                                               z_end - z_start);

And we don't hit this assignment

    516                         }
--> 517                         if ((!err || err == -EPERM) &&
                                      ^^^
then err is uninitialized

    518                             max_clu_count > 1 &&
    519                             (iomap->length & vol->cluster_size_mask &&
    520                              end < ni->initialized_size)) {
    521                                 loff_t z_start, z_end;
    522 
    523                                 z_start = (vcn + max_clu_count - 1) <<
    524                                         vol->cluster_size_bits;
    525                                 z_end = min_t(loff_t, z_start + vol->cluster_size,
    526                                               i_size_read(inode));
    527                                 if (z_end > z_start)
    528                                         err = ntfs_zero_range(inode,
    529                                                               z_start,
    530                                                               z_end - z_start);
    531                         }
    532 
    533                         if (err == -EPERM)
    534                                 err = 0;
    535                         if (err) {
    536                                 ntfs_release_dirty_clusters(vol, max_clu_count);
    537                                 return err;
    538                         }
    539                 }
    540         } else {
    541                 up_write(&ni->runlist.lock);
    542                 mutex_unlock(&ni->mrec_lock);
    543 
    544                 iomap->type = IOMAP_MAPPED;
    545                 iomap->addr = ntfs_cluster_to_bytes(vol, lcn) + vcn_ofs;
    546 
    547                 rl_length = ntfs_cluster_to_bytes(vol, max_clu_count);
    548                 if (length > rl_length - vcn_ofs)
    549                         iomap->length = rl_length - vcn_ofs;
    550                 else
    551                         iomap->length = length;
    552         }
    553 
    554         return 0;
    555 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
