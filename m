Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023981DD0EF
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632071; cv=pass; b=n2ixT1xNgUtsoEYlpU85JVcBnpyEyFTJgPGuuGdWxjolgdSuVVoNxprvAuUhVjQqqTiaaFpP8OPV87p1W52lAe4fT7cC1717OiGjOONiBFSgVXLeaoAm8AzjatCmHPYmw2OAd/IEKqzRO3qE8dftNvJhV3vhwD1xJ6kOQL1y4Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632071; c=relaxed/simple;
	bh=EAqDqW3MreoFvVFwtgFkGeJLdCNMAX7M5jzjl8mlhgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouP4opeXEDzMGXCRXC1rJZxftqyCX90OhdOirFzjEmpAhR13IuOZSUVrvaXmJGhIRzhAJOMB2tu7RrBRmml6chw/iLK4oLhplkGtU2n4Ju3k8N9sc+guEJKvPZMQ5hGkZlOjWqioSqm+GuAhyEX8B18W2s6JI0yVmkRMI1f9l7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bViLBFBu; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bViLBFBu"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so16889306d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 21:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780632069; cv=none;
        d=google.com; s=arc-20240605;
        b=eGl2a9nMlJs+InEvKHRYNN5ltgSAWxGG2JX9eAJSOUyV5n2D7wk/an+lE1Djsb6BMC
         CpJ9NH41Kmex3W5V8oUYhx6bDWcrEq+o91lAy7OGP3A8VGC+qhfMxoKRqYwac4+oXY2A
         qtZ1yJp9zMpNzY+iteunejlSmTnzeSgPE+UC5oPQsTnv4v0FF8BcVtNolMOFa6iHYzUk
         HIiwnIwSr+r72+7g3tLGxR+SPJ2cZ91/m9VOyCRBspVX723PnH+B8AiB+CMXG9Au02zs
         TppCZfSE4yI7/nApgdqHiLPGxuBfjAUb2MceZSfq+p3daCnFtaIlSNetvilu7EV5Hj3Z
         80BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S9UJw/kvglknmyUtxj/wGwvZEMz2yHBrv2SKKbfk1yk=;
        fh=SdDNURFKyi0o+0yYz8nNbBbN7ehsUF/m1bQJskPtc8s=;
        b=RnHME2dk4rvRzPeEhXIBnd+dui1ak2piXmJbOOVAweP54x7TXN8am3flxT0CZ0s4hN
         3MMjMWjI6J6ZIIg72tuyAinPjNOi61QxoaEVWThbEIv6+wNhhYAO28UbdtFH2i1Xy3ro
         VUZ7lP8iY1okcWp5kERGrOs72FDSph84oJnRbpXUqZCRtsaR/WoLrTvUmGC+gDfUUZdV
         nzrOEe+/h9tQCtXiTTmabSjyAi+JJx+2JzmfVCEHIAj2zHslRdWK90m+G+eqnrO4/hXd
         X12QRbY3TdTtzzoiMHMqF6gymMOpI+6W2Wf/+xmI30Z+Ak9Z9oupoV2Rm+kBdxm+/0t8
         7z5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780632069; x=1781236869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9UJw/kvglknmyUtxj/wGwvZEMz2yHBrv2SKKbfk1yk=;
        b=bViLBFBueEpHs2Vl4rqy6SDaRQ2SWnDr6czWTpKIf47uPFwRUrbgaw7fEOPC2x0uyz
         1KfzB14Ryaxsfe3fCspNenpOnlAHkBIUVK4z9h9cY/rKdo8qHAAWM8qQnE+7vfcJQZLW
         lce/y+0w8AuXtfO6X7sqMjKp4DanerGuoW8uTJtjG9x8Zwxb89cBhAFQV8+yHJ0f1fXl
         bINLOLwmz3RxkSmVP4FwbV+lK3Ew14Aq7b6r0v1PxLLQB53M0rFoISG/ofRXh/WXvnDC
         toeYAuR75SNLfKXo/4nXC72BlAVDz/B8FZ0RjgkDkhCJ8hImtZuWJoqqxt9KtQcfYfjq
         vAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780632069; x=1781236869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9UJw/kvglknmyUtxj/wGwvZEMz2yHBrv2SKKbfk1yk=;
        b=dVAXVygcLjkqx+t+w3z3hgN4rlnRDYAiwyIRIMseXAt4HavWNXI8338vXEp8LU3y1h
         GesPDiaOfgNjRLqCDkJOwZCrZblnK6x2Fd236yRezBgzP9jz/BAG5SDiZcXKFBNFJ4pu
         bB0mReIXFADVAeHNJ8FrfO3KeCIazpC/hgkwAt5gl+wso2+vH/yUIms68Tp/Ji8sJ/fy
         ixLMl1cyR5qPeGR1TnxNeCPhqdZsKSAJSxROhLawvM25mJHMcB1AGxrbbnrgZ+Xj9vKV
         YrY65snwJsIANMQ9Ir6LDZrwJBgFRzQ58T/DZoaylVGQZs1Af0JpDZbpHRtgEbErVMtF
         F8pA==
X-Forwarded-Encrypted: i=1; AFNElJ+b8PqwL+59VAPYEz5CL8r/QX+r304p6Gxn6QC/JVM0+HIbdi4TtwSfQm8nS/r9+aOeV0peRvCb5oHTuzDY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9y2aezfiafR6z3Fc8UrKYCcqraw+2qM4V0Uk0oIiTxA1dv/PY
	hAyMBuXfPW48dAz97zUhjsEl9BKukuJWF3WIFn66SeNSb+rXPfutX9HnKwfmeA6L6INREPAvgRp
	K6wgGdy69ELle610rLMDWCpFvsRa8lgQ=
X-Gm-Gg: Acq92OG/4cbsRO5ynwrM5619BJcDbqQC/L0w2reudeK0AwLoGOiZ/m/xQ/pfrIkCjma
	d//2jvjkWMEFMJGWXWXM0LkrF53EucXTztIvbMMs6u4ZXBBtL7aY0OsZfWgM0lUmmT6orRBKGMm
	tmz04/L2DfpgeUSnjourBRflW6RuC2f7zRx1qBG+C9rZs/5SXvkufvBp+IZFXUr7s/vxub+SQfH
	Aq33RZEkhzy49Ls9lMlcnt4DswhsYxXIJhkVsgCKaFkLfvwNgVuCoyH6DSLNBdRIkUvtgz+583N
	FyJUeQEtyBzEqrLy1gA=
X-Received: by 2002:ad4:45b0:0:b0:8cc:e87b:2cc with SMTP id
 6a1803df08f44-8cee62a93c8mr29072226d6.34.1780632068828; Thu, 04 Jun 2026
 21:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
 <20260604180306.18672-1-samsun1006219@gmail.com> <8e4f04261421e7c904eabbf702e5eb66c9e20bd1.camel@dubeyko.com>
 <fc2326a0ba9f73c4151352ab5449197e5f0048c2.camel@dubeyko.com>
In-Reply-To: <fc2326a0ba9f73c4151352ab5449197e5f0048c2.camel@dubeyko.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 5 Jun 2026 12:00:57 +0800
X-Gm-Features: AVVi8CeFLqhuIHRn-DLt_EJ7D8r_xdMb0VvzQ4PUnq6J5Ghllw1j7qihVMlZNh8
Message-ID: <CAEkJfYO+0+SuaA3iVjrRQu-TUxoJ6_E+WjRFi+FP6Gi-cF2FsQ@mail.gmail.com>
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:52=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> On Thu, 2026-06-04 at 14:25 -0700, Viacheslav Dubeyko wrote:
> > On Fri, 2026-06-05 at 02:02 +0800, Yue Sun wrote:
> > > On Thu, Jun 4, 2026 at 12:25 AM <slava@dubeyko.com> wrote:
> > > >
> > > > Could you please take a deeper look into my diff that I've shared
> > > > with
> > > > you before? I don't see the point to review your suggestion if
> > > > you
> > > > completely ignored my diff. From my point of view you suggested
> > > > completely the same approach but in more complicated manner.
> > >
> > > You are right. I am sorry for the confusion.
> > >
> > > I should have looked more carefully at your diff and based my reply
> > > on
> > > it. Adding an HFS-level MDB mutex and avoiding holding mdb_bh
> > > across
> > > the
> > > whole hfs_mdb_commit() path is the right direction. My previous
> > > reply
> > > mixed that with extra cleanups and a separate corrupted-layout
> > > check,
> > > which made it look like I was proposing a different approach. That
> > > was
> > > my mistake.
> > >
> > > I am not very familiar with HFS internals, so please treat the
> > > following
> > > only as a small suggestion. After re-reading your diff, the only
> > > detail
> > > I am still unsure about is the HFS_FLG_ALT_MDB_DIRTY path. In that
> > > path,
> > > hfs_inode_write_fork() gets MDB fields as output buffers:
> > >
> > >         hfs_inode_write_fork(..., mdb->drXTExtRec,
> > >                              &mdb->drXTFlSize, NULL);
> > >         hfs_inode_write_fork(..., mdb->drCTExtRec,
> > >                              &mdb->drCTFlSize, NULL);
> >
> >
> > I've started to think that, maybe, the location of these
> > hfs_inode_write_fork() calls is not correct. We are trying to save
> > the
> > current size of Catalog File and Extents Overflow File. OK, we need
> > to
> > update this if size is changed. But we can save the sizes during
> > every
> > call of hfs_mdb_commit(). It's logically incorrect to call these
> > methods in the alternative MDB section because it is the content of
> > primary MDB. I suggest to move these two hfs_inode_write_fork() to
> > primary MDB writing section:
> >
> > lock_buffer(HFS_SB(sb)->mdb_bh);
> >               /* These parameters may have been modified, so write
> > them back */
> >               mdb->drLsMod =3D hfs_mtime();
> >               mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> > > free_ablocks);
> >               mdb->drNxtCNID =3D
> >                       cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> > > next_id));
> >               mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
> >               mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)-
> > >root_dirs);
> >               mdb->drFilCnt =3D
> >                       cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> > > file_count));
> >               mdb->drDirCnt =3D
> >                       cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> > > folder_count));
> >
> >               hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> > mdb-
> > > drXTExtRec,
> >                                    &mdb->drXTFlSize, NULL);
> >               hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> > mdb-
> > > drCTExtRec,
> >                                    &mdb->drCTFlSize, NULL);
> >
> >               /* write MDB to disk */
> >               mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> > unlock_buffer(HFS_SB(sb)->mdb_bh);
> >
> > In this case, we don;'t need to overlap the locks. What do you think?
> > Sounds like reasonable solution?
> >
> >
>
> Frankly speaking, I don't like this approach of assigning the pointer
> on bh->b_data to HFS_SB(sb)->mdb:
>
> data =3D (void *)(__bh->b_data + __offset);
>
> We manipulate by various fields of HFS_SB(sb)->mdb throughout of the
> hfs_mdb_commit(). I think that we need to allocate buffer for struct
> hfs_mdb *mdb during hfs_mdb_get() (and destroy in hfs_mdb_put()) and
> synchronize its content with struct buffer_head *mdb_bh. Otherwise, we
> never can resolve the problem of proper locking in hfs_mdb_commit().
> What do you think?
>
> Thanks,
> Slava.
>

Yes, I agree. Keeping HFS_SB(sb)->mdb as a separate in-memory copy sounds
cleaner than pointing it directly into mdb_bh->b_data.

For the immediate deadlock fix, I think moving hfs_inode_write_fork() into =
the
primary MDB update section as you suggested sounds like a good minimal step=
. The
separate in-memory MDB copy sounds like a larger cleanup that could follow =
if
you think that is the right direction.

Thanks,
Yue

> >
> > > Since mdb points into mdb_bh->b_data, these calls seem to update
> > > fields
> > > in the primary MDB buffer. So I was thinking that we could keep
> > > your
> > > locking scheme, but move unlock_buffer(mdb_bh) slightly later,
> > > after
> > > these primary MDB updates and mark_buffer_dirty(mdb_bh). The
> > > alternate
> > > MDB copy/sync and the bitmap writeback would still happen after
> > > mdb_bh
> > > is unlocked, so the main deadlock fix remains the same.
> > >
> > > If this concern is not valid, or if the current HFS update rules
> > > already
> > > make your shorter window sufficient, please ignore this. I defer to
> > > your
> > > judgment here.
> > >
> > > Below is your diff with only that small adjustment.
> > >
> > > Thanks,
> > > Yue
> > >
> > > diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> > > index ac0e83f77a0f..00651f42ba38 100644
> > > --- a/fs/hfs/hfs_fs.h
> > > +++ b/fs/hfs/hfs_fs.h
> > > @@ -66,6 +66,7 @@ struct hfs_inode_info {
> > >   * The HFS-specific part of a Linux (struct super_block)
> > >   */
> > >  struct hfs_sb_info {
> > > +   struct mutex mdb_lock;                  /* MDB operations
> > > lock */
> > >     struct buffer_head *mdb_bh;             /* The hfs_buffer
> > >                                                holding the
> > > real
> > >                                                superblock (aka
> > > VIB
> > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > index a97cea35ca2e..d81e3545a045 100644
> > > --- a/fs/hfs/mdb.c
> > > +++ b/fs/hfs/mdb.c
> > > @@ -287,6 +287,7 @@ int hfs_mdb_get(struct super_block *sb)
> > >  void hfs_mdb_commit(struct super_block *sb)
> > >  {
> > >     struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> > > +   bool write_backup =3D false;
> > >
> > >     if (sb_rdonly(sb))
> > >             return;
> > > @@ -314,11 +315,17 @@ void hfs_mdb_commit(struct super_block *sb)
> > >      * files grow. */
> > >     if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)-
> > > > flags) &&
> > >         HFS_SB(sb)->alt_mdb) {
> > > +           write_backup =3D true;
> > >             hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> > > mdb->drXTExtRec,
> > >                                  &mdb->drXTFlSize, NULL);
> > >             hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> > > mdb->drCTExtRec,
> > >                                  &mdb->drCTFlSize, NULL);
> > >
> > > +           mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> > > +   }
> > > +   unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > +
> > > +   if (write_backup) {
> > >             lock_buffer(HFS_SB(sb)->alt_mdb_bh);
> > >             memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb,
> > > HFS_SECTOR_SIZE);
> > >             HFS_SB(sb)->alt_mdb->drAtrb |=3D
> > > cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
> > > @@ -360,7 +367,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > >                     size -=3D len;
> > >             }
> > >     }
> > > -   unlock_buffer(HFS_SB(sb)->mdb_bh);
> > >  }
> > >
> > >  void hfs_mdb_close(struct super_block *sb)
> > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > index a4f2a2bfa6d3..06ab904b3a42 100644
> > > --- a/fs/hfs/super.c
> > > +++ b/fs/hfs/super.c
> > > @@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
> > >  static int hfs_sync_fs(struct super_block *sb, int wait)
> > >  {
> > >     is_hfs_cnid_counts_valid(sb);
> > > +
> > > +   mutex_lock(&HFS_SB(sb)->mdb_lock);
> > >     hfs_mdb_commit(sb);
> > > +   mutex_unlock(&HFS_SB(sb)->mdb_lock);
> > > +
> > >     return 0;
> > >  }
> > >
> > > @@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
> > >
> > >     is_hfs_cnid_counts_valid(sb);
> > >
> > > +   mutex_lock(&sbi->mdb_lock);
> > >     hfs_mdb_commit(sb);
> > > +   mutex_unlock(&sbi->mdb_lock);
> > >  }
> > >
> > >  void hfs_mark_mdb_dirty(struct super_block *sb)
> > > @@ -339,9 +345,12 @@ static int hfs_fill_super(struct super_block
> > > *sb, struct fs_context *fc)
> > >     sb->s_op =3D &hfs_super_operations;
> > >     sb->s_xattr =3D hfs_xattr_handlers;
> > >     sb->s_flags |=3D SB_NODIRATIME;
> > > +   mutex_init(&sbi->mdb_lock);
> > >     mutex_init(&sbi->bitmap_lock);
> > >
> > > +   mutex_lock(&sbi->mdb_lock);
> > >     res =3D hfs_mdb_get(sb);
> > > +   mutex_unlock(&sbi->mdb_lock);
> > >     if (res) {
> > >             if (!silent)
> > >                     pr_warn("can't find a HFS filesystem on
> > > dev
> > > %s\n",
