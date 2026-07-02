Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03E246778
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953934; cv=pass; b=igRp0IqzN60D7nPxYvgBrFqiMMH2eB4Q9fCdyyLy6Du0EV4aZdzwPUPqO5iEwIbU0igYn6sz3EpBj8fQxGhY44qT7SQVeKfJJRSJQ4spzTX4BIhuqZybLmUKTTiLjZksI+XxWo3itjp2thUiVDY/WNQcdVVt+mwygdAoquhFEQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953934; c=relaxed/simple;
	bh=cDzMCG2cY3JWYeU+Zw/aK8t82rRQdCwWcp8y3LVWZ9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUgm8hXkhdknWULkBZ3Buwwr1JCb6YWXVgnoErx0V7/yqwuB0pMAMeyIxyTPybqPuAi1s3+d87GFCaYAYi5LCZM26m76pZfTB+H4hZOkZVoz6XfNCiXn9qRomx41NJsAnmuI3W0aqbH+3pWOwuzOU69iPWmz2yMFTJXTq7rV7+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWfQXK+U; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWfQXK+U"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1231053e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 17:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782953931; cv=none;
        d=google.com; s=arc-20260327;
        b=JNN2eqk4/fm+0gpdb6hTX7CUEIXcd7e+WbmRNlv+0w1Gmy9c2U5CutbcHIpA6N690q
         qXgg0yXwqgmRwUtrNugJTOKCNsBEPprzmND6JMeKZa+6kQqt1ggR8/lPi+O3ngWy1QEg
         6gmyt4RrMYcq0LbrNxFhFPziCwDa1tmIEmi7fQ9+LC522C/0YcoYoC93EIJFiTdtIsu1
         Fz9Jwpb2/jsyUtGBGKotp7uQK9P4FufHzFTauJR6l5Hf6D55dhz8bIOijOwcHyXQu+Bd
         3L5jlEpeqBlcp+gSEnd3VMI1dZ2BlgPZlOj77ZkHbeCnOjlUVrRxlRpeBFsOUXyT/y7/
         V9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3drquKihckTnGVZSYZBdpAUGibfRA7+AgpgP4XRvaMg=;
        fh=72Q1U5sxjSN+KEmxqPuV1kSTVRmolcpzN5Ey7fYHCFI=;
        b=XrlXPABvfEhjjVIkDrwvNh0B0y8iKU48DzG0d/pPReAORShl62C0VHUvQ6aPgc4Fzn
         N0j9fWxwqK7P2PVKHLkSYXdlplb+4GOV2S1p2CjEcXoNSClC6/fs01O+6jfqU8cF1sjD
         zrHXP2trssprwBIwr3KL+AsivF75YUyCwbAIKzq3Y0v2rNmvkE0yGyurWo4uYfYhztOD
         /wSlNAQp/k1WDN2My17ThinFu0uwAS+uwgxCsdDeQYasGeTcePQODxcLPAqPxd/A1qkS
         VOe3UyEb3vJWKB0dwNt/37UYPzHaj6pXPwlM9LqyfdOfroT2GxQF4reL7Ehvwkc15tx/
         b9ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782953931; x=1783558731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3drquKihckTnGVZSYZBdpAUGibfRA7+AgpgP4XRvaMg=;
        b=qWfQXK+UV21vHSlFnn0iQxuIDAvkLNyojFANbQU47VKP73TbEErhbtCaucQkOu6By5
         BDWEeOptE7jalNdPFRTJXFCpcZmX+sCD9loOWazOTnghDDwq0rYfonG8pbchGXlQicug
         0iXiUsmxWTGZXcGPPoEN9Dhz4CdRivh0POvT0sH6eln9FflHYViG5EUdrIxhfidG9uu0
         k0xxHQLk9BfWDcER0h+Yg65nN8b8+JLUkCAeHvG5p7X70PpAie5Qweh2Ww/zzP+435GQ
         poGPwOXeb1hBhReHoJYvhavxHiVsmRNO/VOVkreoZtLPgT4wFZRJN5kU9IW9BoizztFr
         I3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782953931; x=1783558731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3drquKihckTnGVZSYZBdpAUGibfRA7+AgpgP4XRvaMg=;
        b=P98Ttiy8j4eNjI+QmJ1yE5sE1dm7aQIOvSgdod6fkB6cWu3ML96hm0v9UZ9cihpPG7
         ourK81Hcq9057OEvlnp4RW/rGEi04IT1Nbo1MrJN4HhGNod6WLSqgwR2/5PGEQwYjYj6
         r10RXlvPPsWxRmHVYA4V15yLbfmHdOSx1ln6VILAl55sZgtm0wlHmg7VFXuJxdbsgVb5
         t9DzogPtPK/ghtEVHzKpX9QBIsEa7l7V8wJCrtX4WIHai/CG92kl/+p4ibR2g6qtKnCG
         RU7K6p+svAD7ezS0558LbinNM1hrHqMGdNC5qcIWLvBE9XMwecZIC6A2P9Eg72fPNZAF
         3SPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4ysWyywFtT7sPyr/aEgeCfdL9y/3igUqvXNXzRNNuD7BFIh9CpuJixGA26LVsHavYRbXJPP1sdSQpKu09@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qfg7HwiCtf2AfhbhldVpbmQNAehkko8JpQ9HuCPklitdw5PJ
	wKbvqP5wVeqdYy6T/viEgs0YLVw6MgkabAM/AHYRLtMi0npMKxC7nIFkRw+dqoPMOFo/BKpmX9Y
	yqxBK3BG55jDMg6ttDAjFuSQZ/p6ApzayDe2l
X-Gm-Gg: AfdE7clim51Op+3vffT12ns3oyaquUWAZ9x82/EJjvAGx/xHIoOmPPJEwzq3dQGV8sB
	U8EPR82GnEeTIQNjySlKz0isrASosJ/Th17hSQ452Lrxw/72dfahX9wKHZPcX4oPkT66p1v7F1K
	+PtIzsVAwR/MQz79DSXSeFhLI++lUYv6GeKTOAteLgwGprFAC1TLGUZcOtbLvRqfhk14Jmf4vaS
	5DdFOO/mh899O7LiyGZmM4nCY7U5ac/ly4IY7muGw1fDBUQRz3aRws3IlHcIWemTMaa+SR1
X-Received: by 2002:a05:6512:1557:b0:5ae:c7d1:2d97 with SMTP id
 2adb3069b0e04-5aec7d12ef7mr438205e87.33.1782953930823; Wed, 01 Jul 2026
 17:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AB8D5E603E6EA856+ae5f622a-dd3a-4e38-bdd2-42276ae0e1a8@smail.nju.edu.cn>
In-Reply-To: <AB8D5E603E6EA856+ae5f622a-dd3a-4e38-bdd2-42276ae0e1a8@smail.nju.edu.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 2 Jul 2026 09:58:38 +0900
X-Gm-Features: AVVi8Cf4WjQpgSiSNYr7I2afPobIJMKOw_qbLgdlO6EoHwZrNXJ48tw1QQrx4Qw
Message-ID: <CANFS6bYZprQi2J6EbDe-vPh7K9Uvw8tj3YfUZfTnnUHJzH1kpA@mail.gmail.com>
Subject: Re: [BUG] ntfs: task hung in find_inode due to self-deadlock in
 ntfs_attrlist_update() during unmount
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, syzkaller@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Peiyang,

> ==========
> Root cause
> ==========
>
> A = the NTFS base inode whose delayed allocation / mapping pairs are being
>     written back.
>
> B = the fake NTFS attribute inode for A's unnamed $ATTRIBUTE_LIST attribute,
>     i.e. the inode returned by ntfs_attr_iget(VFS_I(A), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0)
>
> Timeflow (all code should be executed within one task):
>
> 1. The task starts unmounting the NTFS filesystem that contains A:
>
>         cleanup_mnt()                    fs/namespace.c:1292
>         --> deactivate_super()           fs/super.c:505
>         --> deactivate_locked_super()    fs/super.c:471
>             --> fs->kill_sb(s)           fs/super.c:476
>                 /* ntfs_fs_type.kill_sb is kill_block_super. */
>                                            fs/ntfs/super.c:2645
>         --> kill_block_super()           fs/super.c:1721
>         --> generic_shutdown_super()     fs/super.c:618
>
>    generic_shutdown_super() clears SB_ACTIVE and then evicts cached inodes:
>
>         sb->s_flags &= ~SB_ACTIVE        fs/super.c:626
>         evict_inodes(sb)                 fs/super.c:632
>
> 2. evict_inodes(sb) selects B, marks it I_FREEING, and the same task starts
>    evicting B:
>
>         evict_inodes(sb)                 fs/inode.c:897
>         --> inode_state_set(B, I_FREEING)
>                                            fs/inode.c:918
>         --> dispose_list(&dispose)       fs/inode.c:875
>         --> evict(B)                     fs/inode.c:883
>         --> ntfs_evict_big_inode(B)      fs/ntfs/inode.c:2261
>
>    B is a fake attribute inode.  During its eviction, NTFS drops B's reference
>    on its base inode A:
>
>         iput(VFS_I(B->ext.base_ntfs_ino))
>                                            fs/ntfs/inode.c:2307
>
>    At this point B is still in the inode hash.  VFS removes B from the hash
>    and wakes __wait_on_freeing_inode() waiters only after
>    ntfs_evict_big_inode(B) returns:
>
>         remove_inode_hash(B)             fs/inode.c:849
>         inode_wake_up_bit(B, __I_NEW)    fs/inode.c:862
>
> 3. The iput(A) from ntfs_evict_big_inode(B) starts synchronous writeback of A:
>
>         iput(A)                         fs/inode.c:1972
>         --> iput_final(A)               fs/inode.c:1916
>         --> write_inode_now(A, 1)       fs/fs-writeback.c:2961
>         --> ntfs_writepages(A->i_mapping)
>                                           fs/ntfs/aops.c:244
>         --> ntfs_writeback_range(... A ...)
>                                           fs/ntfs/iomap.c:861
>
>    SB_ACTIVE is already clear, so iput_final(A) cannot keep A on the inode LRU.
>    It has to write and evict A.
>
> 4. A's writeback updates mapping pairs and then updates A's attribute list:
>
>         __ntfs_write_iomap_begin(A, ...)
>                                           fs/ntfs/iomap.c:868
>         --> ntfs_attr_map_cluster(A, ...)
>                                           fs/ntfs/attrib.c:4948
>         --> ntfs_attr_update_mapping_pairs(A, 0)
>                                           fs/ntfs/attrib.c:3535
>         --> ntfs_attrlist_update(A)      fs/ntfs/attrib.c:3712
>         --> ntfs_attr_iget(VFS_I(A),
>                            AT_ATTRIBUTE_LIST, AT_UNNAMED, 0)
>                                           fs/ntfs/attrlist.c:60
>                                           fs/ntfs/inode.c:209
>
>    This attempts to get B *again* while B is still being evicted.
>
> 5. ntfs_attr_iget() reaches find_inode().  find_inode() finds B, sees that B
>    already has I_FREEING set, and sleeps waiting for B's eviction to finish:
>
>         iget5_locked()                  fs/ntfs/inode.c:224
>                                          fs/inode.c:1375
>         --> find_inode()                fs/inode.c:1040
>         --> __wait_on_freeing_inode(B)  fs/inode.c:1061
>                                          fs/inode.c:2537
>         --> schedule()                  fs/inode.c:2560
>
>    This is a self-deadlock.  The task waits for B's eviction to complete, but
>    the only code that can complete B's eviction is the later part of evict(B),
>    after ntfs_evict_big_inode(B) returns.  The same task cannot return there
>    because it is now sleeping in the nested find_inode() path.

Thank you for the detailed root cause analysis.

Your analysis looks correct. However we would like to discuss whether
there is another way to handle this situation.

The call stack you provided seems unlikely to occur under normal conditions,
because generic_shutdown_super() unconditionally runs sync_filesystems()
before calling evict_inodes().

Does this issue occur when sync_filesystem() fails, for example due to
I/O errors or disk removal?

If so, would it make sense to mark volume as shutdown (NVolShutdown) or
switch the filesystem to read-only when a writeback error is encountered?
