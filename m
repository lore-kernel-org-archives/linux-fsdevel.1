Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BF1A6816
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783039677; cv=pass; b=Bm8S29B4/lElYX/hAfc9R6wZfOEtSHA+KLiF61v82zHCwk7e8qxm22cLZN3oIGvHKDrxu/kDgiiMUF3Sc8EVXvYLsI+8SCvz+sh2+2C9aa0dLwIv61XfxmCDxNR+ZadK09XAA8pdghAdAHqEp1E4YzPb7noFhcGV9tnsYe2mpdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783039677; c=relaxed/simple;
	bh=XxQQayjzAMUk4qmYjq4zmwN9Ud0QEtqyPATE+A2Dk6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/MivzZGkqBH0N29E85P4IBdyVJgSgIjsob990+FW8R00/PSH6NVJG0VY9kOc//XVsteCfGDLh6bKwSQz3ozAj9IPxf33kyfUyEPbvg6Ue4I6EMRFXa9JmhJyQQV5BLgUujEd+wXnPYazZft562VFG8r74sUqTYXDb3vJs31AcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx30gFFL; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx30gFFL"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebd52488cso54851e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 17:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783039674; cv=none;
        d=google.com; s=arc-20260327;
        b=W41uwylF6SZ8KU9AQsGiPGZqlaL1sgM0YeTA8E+ERE+KeH438YoSzOJXS1O/FcMw1G
         3EHdo2W9o2y/qqsLYnXW0Fxc+LEp1+ugIgHzvtVVyGQ+u6uDQ/KvoKwC/1e2nDXZ+0bP
         Mg7pnDcmQLmqRWd7ZvSDdj1vasgr8qE2sXA9MSXVMuWQwwWlmgE/WLojQB/G11x/Gi+q
         Fosbl5Xt563t30J47Obr/2tY2S/b+wiPlAR5LVwojKm5PAgR9U5oWK0fLu3ahcHpaalf
         gEnWdfgMMoORhvAV5oh8OajXuzUzl/BPDSbmtyjBC8GCQ7Iy72xY4MtNsYX8odNXYC9o
         5mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhGHPyuXZn7SKjMJa/lcf1ft6RupMaimdVhfB5JWkaw=;
        fh=Z4RpIEJ/QD2iMKuRYI89jIZb2UuKJMw7LzNSCB2RHkI=;
        b=SHUnl2i8r2WkMXaMSzj4BqQ6wcL/cJ8mypnCTvf9dgkIagUI65/fBtOke20ovrmF+H
         HVkZmxMOe9emCvh6YRHlD2kxDbCfe4xnit1P3XyE4szIa1TnFpkO79rEqbVoiId9BOB+
         5Bl0XSPCAeqAwQCafBkfnVXebbG2qQLY7y277X6eIDsh5/HSBYInHT8NilwuFyDEt0nf
         hEKxmlxa+yJuQrzWbySHUiq13FF+mMzOKDouf1RwfcYIfKJEWwdvOpvEiLgXgVVZ/0tf
         DXQGFo9EDUPnPnayU1/xwWlOBGml8xvyW9lL8+S3Dhy/c8HT/HakmeLWao0mAcTDUCoP
         Iv1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783039674; x=1783644474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhGHPyuXZn7SKjMJa/lcf1ft6RupMaimdVhfB5JWkaw=;
        b=Sx30gFFL/+ZDWfUQHjhwAr2eDMPkWM9ew4MMtzFhYk0T+6OKrI+vxqqiCFdrUs6VLz
         VMzyBkfCfc6l8izGm5VZ7uLi87bGgnIW9HyqqbVUVZjZ1lmO6YeYYb3DJq4xWZ/tvljo
         oBiVQUJV5IFAJiTf0P0nUVzPbanlUbJvaO/PPM3SDf+BNOGJoT12RBqfZoA+5WepXMFT
         DM6QxYkCrVXEWoxvMTm4v9vlWV961KhjnC51y3NdEgcQTU4IVBOA/jtgw1V8tFG5/xeW
         cYBJp6uhU1tVMoNm9cqvPVCs14Q8KkrRIvdYkdrAcg7nDBn+X45EKj1jhIWRu7URvWp4
         RJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783039674; x=1783644474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhGHPyuXZn7SKjMJa/lcf1ft6RupMaimdVhfB5JWkaw=;
        b=lLw/QfNCS7w12C7reFu+S6tdHE2Ud1mU46kktj7GOSRyBbWQV2JwwQYZvWJUj2ZAGn
         WU+mqpUxlynKInVfQ824SbI6GZkRN0L0cAcT4csnEJPdD65yb+LUsA2X2p5lKu/Pom4D
         ekeO8o8FvDj95cADFsqIMN/O4KqtLuJUBAM4yvMcGf+mj5jA9W+JFe9yivFAySpmRHhF
         fy4e3RcZQ9xjuseO+kzNVcridX6Bx2XqbA8Uw3gdZ8WBPLGVJnEq00IICs9luzV+uIrQ
         ty+Nn1JTGVrwxNJCOQkfBKbYVX5Q3lrV1zYRi7foChaWWnPd+ToH6cFRuSh7BhjxAe4p
         qbiA==
X-Forwarded-Encrypted: i=1; AHgh+RrlwphRTunteewDMSXyVDubYz/LVauJzPZ/1uXq2G32U4MkasZV44aGL8gPEj7xpqolEgry9ARy9DBCcp0z@vger.kernel.org
X-Gm-Message-State: AOJu0YzUceVmKOwgTQszGDIL/2ktI8EKnowOl3xIlN6uCCcqHtRstNeP
	68hv5WaClxp85XqveIVFhueqitdtKwu1JdHZD/ePD0gSAsqatwcmLtPG2rIDUaqrMhe4XkliO8o
	T7xmnRJR3yNt0yjeSSxocGN4S4MP9SU0=
X-Gm-Gg: AfdE7cmvUQoh5w4hodyn93BWRO48kl5edsXihKkCRdQrJ1OOZPE80yjALYtcyr0jlW7
	pjgIWKwzox4eNzwubaBOiI5qymf9N5ZpDFHD63Le/37xVQUr6OirGkw7mFpCIW/aD1CO8IZs6up
	K5h62BlWhfltrDLIyDyvl5mg/OxSIKwbpm8J9thlkmRBhYdiNPLVbi/jSpnTe0EVAyo6bIjQBha
	LufGRY5GLSJf5s3V+xhq149OjP8ccNFfVSreTgJ5i7KvF8mfAF/DZkMnhaWZdauWl9CnqjH
X-Received: by 2002:a05:6512:6407:b0:5ae:af9c:c064 with SMTP id
 2adb3069b0e04-5aec742fa3fmr1830169e87.60.1783039673506; Thu, 02 Jul 2026
 17:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AB8D5E603E6EA856+ae5f622a-dd3a-4e38-bdd2-42276ae0e1a8@smail.nju.edu.cn>
 <CANFS6bYZprQi2J6EbDe-vPh7K9Uvw8tj3YfUZfTnnUHJzH1kpA@mail.gmail.com> <5B2B2B9FB5B21F9B+19d04fd2-4dc7-4593-b5a3-04610c16bced@smail.nju.edu.cn>
In-Reply-To: <5B2B2B9FB5B21F9B+19d04fd2-4dc7-4593-b5a3-04610c16bced@smail.nju.edu.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 3 Jul 2026 09:47:41 +0900
X-Gm-Features: AVVi8CcHIhPJ5l4LX0t3U67zYxGiU6BljD_pq2INzimxMCS8CrCX1fqrE46TLuw
Message-ID: <CANFS6bZfcugQNWkgDX2gg6FWRLT5scfcwKAy4mv1Hc_Y_Q+AcQ@mail.gmail.com>
Subject: Re: [BUG] ntfs: task hung in find_inode due to self-deadlock in
 ntfs_attrlist_update() during unmount
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, syzkaller@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 2:01, Pe=
iyang He <peiyang_he@smail.nju.edu.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
>
>
> On 2026/7/2 08:58, Hyunchul Lee wrote:
> > Hi Peiyang,
> >
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> Root cause
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> A =3D the NTFS base inode whose delayed allocation / mapping pairs are=
 being
> >>     written back.
> >>
> >> B =3D the fake NTFS attribute inode for A's unnamed $ATTRIBUTE_LIST at=
tribute,
> >>     i.e. the inode returned by ntfs_attr_iget(VFS_I(A), AT_ATTRIBUTE_L=
IST, AT_UNNAMED, 0)
> >>
> >> Timeflow (all code should be executed within one task):
> >>
> >> 1. The task starts unmounting the NTFS filesystem that contains A:
> >>
> >>         cleanup_mnt()                    fs/namespace.c:1292
> >>         --> deactivate_super()           fs/super.c:505
> >>         --> deactivate_locked_super()    fs/super.c:471
> >>             --> fs->kill_sb(s)           fs/super.c:476
> >>                 /* ntfs_fs_type.kill_sb is kill_block_super. */
> >>                                            fs/ntfs/super.c:2645
> >>         --> kill_block_super()           fs/super.c:1721
> >>         --> generic_shutdown_super()     fs/super.c:618
> >>
> >>    generic_shutdown_super() clears SB_ACTIVE and then evicts cached in=
odes:
> >>
> >>         sb->s_flags &=3D ~SB_ACTIVE        fs/super.c:626
> >>         evict_inodes(sb)                 fs/super.c:632
> >>
> >> 2. evict_inodes(sb) selects B, marks it I_FREEING, and the same task s=
tarts
> >>    evicting B:
> >>
> >>         evict_inodes(sb)                 fs/inode.c:897
> >>         --> inode_state_set(B, I_FREEING)
> >>                                            fs/inode.c:918
> >>         --> dispose_list(&dispose)       fs/inode.c:875
> >>         --> evict(B)                     fs/inode.c:883
> >>         --> ntfs_evict_big_inode(B)      fs/ntfs/inode.c:2261
> >>
> >>    B is a fake attribute inode.  During its eviction, NTFS drops B's r=
eference
> >>    on its base inode A:
> >>
> >>         iput(VFS_I(B->ext.base_ntfs_ino))
> >>                                            fs/ntfs/inode.c:2307
> >>
> >>    At this point B is still in the inode hash.  VFS removes B from the=
 hash
> >>    and wakes __wait_on_freeing_inode() waiters only after
> >>    ntfs_evict_big_inode(B) returns:
> >>
> >>         remove_inode_hash(B)             fs/inode.c:849
> >>         inode_wake_up_bit(B, __I_NEW)    fs/inode.c:862
> >>
> >> 3. The iput(A) from ntfs_evict_big_inode(B) starts synchronous writeba=
ck of A:
> >>
> >>         iput(A)                         fs/inode.c:1972
> >>         --> iput_final(A)               fs/inode.c:1916
> >>         --> write_inode_now(A, 1)       fs/fs-writeback.c:2961
> >>         --> ntfs_writepages(A->i_mapping)
> >>                                           fs/ntfs/aops.c:244
> >>         --> ntfs_writeback_range(... A ...)
> >>                                           fs/ntfs/iomap.c:861
> >>
> >>    SB_ACTIVE is already clear, so iput_final(A) cannot keep A on the i=
node LRU.
> >>    It has to write and evict A.
> >>
> >> 4. A's writeback updates mapping pairs and then updates A's attribute =
list:
> >>
> >>         __ntfs_write_iomap_begin(A, ...)
> >>                                           fs/ntfs/iomap.c:868
> >>         --> ntfs_attr_map_cluster(A, ...)
> >>                                           fs/ntfs/attrib.c:4948
> >>         --> ntfs_attr_update_mapping_pairs(A, 0)
> >>                                           fs/ntfs/attrib.c:3535
> >>         --> ntfs_attrlist_update(A)      fs/ntfs/attrib.c:3712
> >>         --> ntfs_attr_iget(VFS_I(A),
> >>                            AT_ATTRIBUTE_LIST, AT_UNNAMED, 0)
> >>                                           fs/ntfs/attrlist.c:60
> >>                                           fs/ntfs/inode.c:209
> >>
> >>    This attempts to get B *again* while B is still being evicted.
> >>
> >> 5. ntfs_attr_iget() reaches find_inode().  find_inode() finds B, sees =
that B
> >>    already has I_FREEING set, and sleeps waiting for B's eviction to f=
inish:
> >>
> >>         iget5_locked()                  fs/ntfs/inode.c:224
> >>                                          fs/inode.c:1375
> >>         --> find_inode()                fs/inode.c:1040
> >>         --> __wait_on_freeing_inode(B)  fs/inode.c:1061
> >>                                          fs/inode.c:2537
> >>         --> schedule()                  fs/inode.c:2560
> >>
> >>    This is a self-deadlock.  The task waits for B's eviction to comple=
te, but
> >>    the only code that can complete B's eviction is the later part of e=
vict(B),
> >>    after ntfs_evict_big_inode(B) returns.  The same task cannot return=
 there
> >>    because it is now sleeping in the nested find_inode() path.
> >
> > Thank you for the detailed root cause analysis.
> >
> > Your analysis looks correct. However we would like to discuss whether
> > there is another way to handle this situation.
> >
> > The call stack you provided seems unlikely to occur under normal condit=
ions,
> > because generic_shutdown_super() unconditionally runs sync_filesystems(=
)
> > before calling evict_inodes().
> >
> > Does this issue occur when sync_filesystem() fails, for example due to
> > I/O errors or disk removal?
>
> Hi Hyunchul, thanks for your reply.
>
> I have looked into the kernel log, and YES, this issue occurred because s=
ync_filesystem() hit an unusual path.
> (BTW sorry for not including the kernel log in the attachments at first)
>
> From the kernel log (line 1992~1993), ntfs_attr_add() somehow failed and =
executed
> ntfs_error(sb, "Failed to add resident attribute"); (fs/ntfs/attrib.c:275=
7).
>
> ntfs_handle_error() was then called, and when ON_ERRORS_REMOUNT_RO was se=
t, it set the file system to *read-only* (fs/ntfs/super.c:310),
> which matches line 1994~1995 of the kernel log.
>
> (from line 307 and 356 of the kernel log, we can indeed see that `@errors=
_remount` was enabled in two Syzkaller testcases and thus ON_ERRORS_REMOUNT=
_RO was set:
> https://github.com/google/syzkaller/blob/27192279868f7027c85197e80335f160=
406d6280/sys/linux/filesystem.txt#L612.
> But since multiple testcases were running concurrently, we cannot confirm=
 which testcase triggers the task hung)
>
> When the file system is read-only, sync_filesystem() would return *direct=
ly* without writing back (fs/sync.c:43) so inodes are still dirty.
> All functions in the call stack of this task hung don't check if the file=
 system is read-only.
>
> >
> > If so, would it make sense to mark volume as shutdown (NVolShutdown) or
> Yes, I think marking volume as NVolShutdown would be better. ntfs_writepa=
ges() already checks this.> switch the filesystem to read-only when a write=
back error is encountered?
> >

> Do you mean we check the return value of sync_filesystem() in generic_shu=
tdown_super()?
> For now the return value of sync_filesystem() is indeed ignored in this f=
unction.
> But only checking 'error' may not be enough, since sync_filesystem() retu=
rns 0 directly when the file system is read-only.
>

I initially considered setting NV_Shutdown inside ntfs_handle_error().
However, the flag also blocks open() and readdir() and does not align
with the "errors=3Dcontinue" policy.

Because of these side effects, we will need to redesign the error
handling policy in the long term.

For now, to resolve this deadlock, I suggest we proceed with your
proposed patch with returning -EIO.

> Best,
> Peiyang



--=20
Thanks,
Hyunchul
