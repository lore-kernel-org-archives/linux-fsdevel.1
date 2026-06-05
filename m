Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64551390231
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631862; cv=pass; b=FK+thj0ax2LUssXQwGkCShhdyKpvZIs48QocoKx44x/DsFYhMT55q8g1d8LidRMH15Q2FilooJTaTpmqHWO/JUZTMe6+Xl/ZsYqH5s0q4Xs/pSH00A4FGBQiuInlOJTVBChXeqG+hPjtW3UxlVVox+zHYmxzDfGoB34QxCEPfdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631862; c=relaxed/simple;
	bh=Wg5IMY2JTom+BRcqo8+AIth8oRu8/OP/k7k2+phwb3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbCQGuANqhavkiSkArhLMo97iq+tdqKVmN2dBxq8WhxYM0PYhKt6FemW/W5A/kADa7KYqMj9eZO/nQO1FYQDjw+ZLbT8QWrnl51twie8kH9o0LZaZPLO55LAy7gT4ohCm1gv4HO1n+OAYr8HT+uh+Lghzg+91ySq2LWBF/6uTnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkiT0Npl; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkiT0Npl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so11927416d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 20:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780631860; cv=none;
        d=google.com; s=arc-20240605;
        b=ByZn8u7Tg96Lu+kHLrvlN1k9DT58OphUZU3EYd4Fb5SUTw+J3XAdUIwpiRpI5k3v0P
         e9+Lkw9FE+5bYqoFTAW+5fnO+cWJG8XbcY9itrry6uaTtdArrzUbCbtC5DrN0Fc0utoN
         yR+gtWvWTk1IVAmFylZDo5ZtIXcFmxe9kX1ZHHEb/qQKnKsyuDABvwb4fr/LD7V3OsTB
         XKgwoFI435ObDDFNWyIGYG9Zvb4IgY6k/TzytSz6g+Dk0HO3e0HwPWBLS06kGVZggIks
         gIVvPt4cxYENBo2b+OI5mRbD0Qp8pYNcjW80cb9OmUwEPfhLpZLq0LFXjpgl9h7hEqv9
         fsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W6dpMvATQjJN1yn4tGzn3aYtwN9B/bLm0axGRogG+1k=;
        fh=IjbonZjfONyb/acf+ayXlP3Ws4l7PrsUCMDrORFp3PA=;
        b=jiftN56GNEEqTr9chA+ysgM+jTKhFQPBsyWG6Sxh94sqXNLszJQfnzWt9WWThir/rw
         YDdlDQjBjbfvnen0luQI1w3qcqD3LlzWN7WY2sYccDH/NXqd3NrsFQ6wF/Ua6rtZZE/g
         tU3RD+9trrh22igIOS6CeeVLSMch00UQ0ppph4fuk6scp6KXEQjTCNdM8Q2fR6T/E6BR
         oJ2UboLsc958wQoDY3jJ3VQsgo1T0IYhcBG2Mrr1eQR/UrcpK2ZaUN72tVOGueks4fnx
         m4j8KwSu+es4jd0geQ9nTqGW6Ye9oTF+RwZvDVt1B8KgUAsnf7+/KD5ImNp7MszzUkIE
         DpBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780631860; x=1781236660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6dpMvATQjJN1yn4tGzn3aYtwN9B/bLm0axGRogG+1k=;
        b=IkiT0Npl+fM9jOOlRrbzS6wn+qL5+gGATd7Epc+UWMPXn6UtrpzqpjvQ4p9IgCwxOg
         y1o04G8kxrtUSwP71z748BO2F/Hc8IoEh7ThlPHryzGLz0eQ4K0yeJaC5iuEpwuwkwNM
         vhcpw+RsK+hHEt2te9jVUKdVvkSZH7++0fvUst+B63pSVtXyJkBdIRQ8stc/Zvcy0MPk
         FP94cfFQsN8D0b/yR5Qbh35ihTBHc6CHdZtb7ucf30xBoJzgHz0uD362WidNI8hYEPnE
         Viu4LLvNUsMVjAdDF++0e1YrYK75gY/pRCSiS9CFdM8iD9JEuBSBNfIFbTbD4LWlkTHi
         cudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631860; x=1781236660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6dpMvATQjJN1yn4tGzn3aYtwN9B/bLm0axGRogG+1k=;
        b=Xah8HdtumaebtG18yqlgXPyy6W33yQrhruoAEKt0sV41hfP/SlQLSR3QXzRuvtlIZN
         WPTGlbkDBQe7GymDM2MmxQ4pPC867a5a6y7CYoAWR5hDcqITe78NFw7xu/EvD8cTxick
         y3tES9FwPlnjAGVkMoBefxwkiXN8aTfk4Ra/qC2jdt2sPBnrlCU66HnZqG1dOreCdm0h
         Vd0eq6FoCs8qWjfo71k1nu0gvSJ1t1cXUV8su8mQiosGuPv13W9MUpTCO2Bj3jeGC7OS
         h+anVOO2Xf+KeYZi5z5n6cNDnw5vp+lVCK3vOA1N9b0d1xw7XMEqn7why94AOdmqwlNR
         Wyfw==
X-Forwarded-Encrypted: i=1; AFNElJ+HUNipzvPFtBPy6QVSrSbchpSwmhpDrziclNCToh6GyZiGwiSebPhI5TErCpAsiIYy07U20HQisdS6RRkU@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYs8LkhG07SAicCQPbaqlQWPriEyzsTyRabCClFVvKk3fTnE/
	QP8NNlo3jpbiE/P2Pz6gaPK+J5TH9RDgd4/DY3u2Bq3antaM/PanFEr0+QgWtdZNgMiP9WydpMH
	ma+sNmBb/xN0OenpoykREwa9fAJzQkkbzxjlWQzm/tQ==
X-Gm-Gg: Acq92OGg0joV7rAV3AsNRSh8BphBzJQO5gE54gKigTizBhTMtNT2btNOIeglXZ3c3xR
	ZzirUvVt2V6hBcfGI6IiBqFnGJnczDNJVMCmmRCCD2tDvdU26zq1LPhQizCCQ3ZgMuJgN4/X+91
	AZGxbXxJ+2wEij9tzkkLGOaFG3+KyMSXXGqZeom4sQYc3egAd2gFCoxEulpPPbpBpKsS2lGIeOB
	ZpHpt6MsTC+UmTvuGiUBTRcfhKSMJWzOwtekcjPBeNnpEwamkVURHDiK9vqRx6A2D8sAIyvYnD3
	ES91trwblyL9mqKiPcA=
X-Received: by 2002:a05:6214:4e09:b0:8ce:b2e9:a4bc with SMTP id
 6a1803df08f44-8cee5ffcaf2mr29905146d6.15.1780631860241; Thu, 04 Jun 2026
 20:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
 <20260604180306.18672-1-samsun1006219@gmail.com> <8e4f04261421e7c904eabbf702e5eb66c9e20bd1.camel@dubeyko.com>
In-Reply-To: <8e4f04261421e7c904eabbf702e5eb66c9e20bd1.camel@dubeyko.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 5 Jun 2026 11:57:27 +0800
X-Gm-Features: AVVi8CeJp9Nga6vvmGaSjEflg94PJ09L-PDRTSgQU9lSpeWF1eTP5YtBQ8QxWP0
Message-ID: <CAEkJfYM20=S+F-x7RsvLo8gi40JJn_6-8tBmtED3CNZ=_wdsXQ@mail.gmail.com>
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 5:25=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> On Fri, 2026-06-05 at 02:02 +0800, Yue Sun wrote:
> > On Thu, Jun 4, 2026 at 12:25 AM <slava@dubeyko.com> wrote:
> > >
> > > Could you please take a deeper look into my diff that I've shared
> > > with
> > > you before? I don't see the point to review your suggestion if you
> > > completely ignored my diff. From my point of view you suggested
> > > completely the same approach but in more complicated manner.
> >
> > You are right. I am sorry for the confusion.
> >
> > I should have looked more carefully at your diff and based my reply
> > on
> > it. Adding an HFS-level MDB mutex and avoiding holding mdb_bh across
> > the
> > whole hfs_mdb_commit() path is the right direction. My previous reply
> > mixed that with extra cleanups and a separate corrupted-layout check,
> > which made it look like I was proposing a different approach. That
> > was
> > my mistake.
> >
> > I am not very familiar with HFS internals, so please treat the
> > following
> > only as a small suggestion. After re-reading your diff, the only
> > detail
> > I am still unsure about is the HFS_FLG_ALT_MDB_DIRTY path. In that
> > path,
> > hfs_inode_write_fork() gets MDB fields as output buffers:
> >
> >         hfs_inode_write_fork(..., mdb->drXTExtRec,
> >                              &mdb->drXTFlSize, NULL);
> >         hfs_inode_write_fork(..., mdb->drCTExtRec,
> >                              &mdb->drCTFlSize, NULL);
>
>
> I've started to think that, maybe, the location of these
> hfs_inode_write_fork() calls is not correct. We are trying to save the
> current size of Catalog File and Extents Overflow File. OK, we need to
> update this if size is changed. But we can save the sizes during every
> call of hfs_mdb_commit(). It's logically incorrect to call these
> methods in the alternative MDB section because it is the content of
> primary MDB. I suggest to move these two hfs_inode_write_fork() to
> primary MDB writing section:
>
> lock_buffer(HFS_SB(sb)->mdb_bh);
>                 /* These parameters may have been modified, so write
> them back */
>                 mdb->drLsMod =3D hfs_mtime();
>                 mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> >free_ablocks);
>                 mdb->drNxtCNID =3D
>                         cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >next_id));
>                 mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
>                 mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)->root_dirs);
>                 mdb->drFilCnt =3D
>                         cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >file_count));
>                 mdb->drDirCnt =3D
>                         cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >folder_count));
>
>                 hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb-
> >drXTExtRec,
>                                      &mdb->drXTFlSize, NULL);
>                 hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb-
> >drCTExtRec,
>                                      &mdb->drCTFlSize, NULL);
>
>                 /* write MDB to disk */
>                 mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> unlock_buffer(HFS_SB(sb)->mdb_bh);
>
> In this case, we don;'t need to overlap the locks. What do you think?
> Sounds like reasonable solution?
>
> Thanks,
> Slava.
>

Yes, this makes sense to me. Moving the two hfs_inode_write_fork()
calls into the primary MDB update section looks like a cleaner
solution. Then all direct updates to the primary MDB buffer are done
while mdb_bh is locked, and the alternative MDB path can just copy the
already prepared primary MDB contents after that. I agree that your
suggested direction is better.

Thanks,
Yue

>
> > Since mdb points into mdb_bh->b_data, these calls seem to update
> > fields
> > in the primary MDB buffer. So I was thinking that we could keep your
> > locking scheme, but move unlock_buffer(mdb_bh) slightly later, after
> > these primary MDB updates and mark_buffer_dirty(mdb_bh). The
> > alternate
> > MDB copy/sync and the bitmap writeback would still happen after
> > mdb_bh
> > is unlocked, so the main deadlock fix remains the same.
> >
> > If this concern is not valid, or if the current HFS update rules
> > already
> > make your shorter window sufficient, please ignore this. I defer to
> > your
> > judgment here.
> >
> > Below is your diff with only that small adjustment.
> >
> > Thanks,
> > Yue
> >
> > diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> > index ac0e83f77a0f..00651f42ba38 100644
> > --- a/fs/hfs/hfs_fs.h
> > +++ b/fs/hfs/hfs_fs.h
> > @@ -66,6 +66,7 @@ struct hfs_inode_info {
> >   * The HFS-specific part of a Linux (struct super_block)
> >   */
> >  struct hfs_sb_info {
> > +     struct mutex mdb_lock;                  /* MDB operations
> > lock */
> >       struct buffer_head *mdb_bh;             /* The hfs_buffer
> >                                                  holding the real
> >                                                  superblock (aka
> > VIB
> > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > index a97cea35ca2e..d81e3545a045 100644
> > --- a/fs/hfs/mdb.c
> > +++ b/fs/hfs/mdb.c
> > @@ -287,6 +287,7 @@ int hfs_mdb_get(struct super_block *sb)
> >  void hfs_mdb_commit(struct super_block *sb)
> >  {
> >       struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> > +     bool write_backup =3D false;
> >
> >       if (sb_rdonly(sb))
> >               return;
> > @@ -314,11 +315,17 @@ void hfs_mdb_commit(struct super_block *sb)
> >        * files grow. */
> >       if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)-
> > >flags) &&
> >           HFS_SB(sb)->alt_mdb) {
> > +             write_backup =3D true;
> >               hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> > mdb->drXTExtRec,
> >                                    &mdb->drXTFlSize, NULL);
> >               hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> > mdb->drCTExtRec,
> >                                    &mdb->drCTFlSize, NULL);
> >
> > +             mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> > +     }
> > +     unlock_buffer(HFS_SB(sb)->mdb_bh);
> > +
> > +     if (write_backup) {
> >               lock_buffer(HFS_SB(sb)->alt_mdb_bh);
> >               memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb,
> > HFS_SECTOR_SIZE);
> >               HFS_SB(sb)->alt_mdb->drAtrb |=3D
> > cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
> > @@ -360,7 +367,6 @@ void hfs_mdb_commit(struct super_block *sb)
> >                       size -=3D len;
> >               }
> >       }
> > -     unlock_buffer(HFS_SB(sb)->mdb_bh);
> >  }
> >
> >  void hfs_mdb_close(struct super_block *sb)
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index a4f2a2bfa6d3..06ab904b3a42 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
> >  static int hfs_sync_fs(struct super_block *sb, int wait)
> >  {
> >       is_hfs_cnid_counts_valid(sb);
> > +
> > +     mutex_lock(&HFS_SB(sb)->mdb_lock);
> >       hfs_mdb_commit(sb);
> > +     mutex_unlock(&HFS_SB(sb)->mdb_lock);
> > +
> >       return 0;
> >  }
> >
> > @@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
> >
> >       is_hfs_cnid_counts_valid(sb);
> >
> > +     mutex_lock(&sbi->mdb_lock);
> >       hfs_mdb_commit(sb);
> > +     mutex_unlock(&sbi->mdb_lock);
> >  }
> >
> >  void hfs_mark_mdb_dirty(struct super_block *sb)
> > @@ -339,9 +345,12 @@ static int hfs_fill_super(struct super_block
> > *sb, struct fs_context *fc)
> >       sb->s_op =3D &hfs_super_operations;
> >       sb->s_xattr =3D hfs_xattr_handlers;
> >       sb->s_flags |=3D SB_NODIRATIME;
> > +     mutex_init(&sbi->mdb_lock);
> >       mutex_init(&sbi->bitmap_lock);
> >
> > +     mutex_lock(&sbi->mdb_lock);
> >       res =3D hfs_mdb_get(sb);
> > +     mutex_unlock(&sbi->mdb_lock);
> >       if (res) {
> >               if (!silent)
> >                       pr_warn("can't find a HFS filesystem on dev
> > %s\n",
