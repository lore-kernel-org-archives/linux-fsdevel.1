Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A53AFCE2
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322505; cv=pass; b=tAgdDcyADcGrgOOkeHM2P6cQLT6WlqM0E7vgJfDDMIpByzDhnqANWiCeOj8k/H1q8/24GIVisTO+W3z7VKlMqQ+e8VE/xjDnxj6+ZUY4s/6JxN/xvqikhxJSDxultI/jmkTzwH7D76RUTuJB6NBruar1P6Cw9gmPf7rkMJXY/6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322505; c=relaxed/simple;
	bh=suE30liw0z0Qp5smIrPkjpuKOhKuyqeoe3mMMph/POE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPWqanmNfD5PmcK03mJR7UXNjVzFsz/4StjWWXej4dvrFBnzgMCJL94E/307ND3KPmv2dWukJTmgRoTy2QnLLFfnKDp4gHOePAVOvYHJTkSCsoBo2LMar+CmScOxtxp/n2a7Syqa3sHamZ43GIT/OYnXT3Jsy+W1W6hXORFES08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTM0yuj2; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTM0yuj2"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso16121016d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 07:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780322501; cv=none;
        d=google.com; s=arc-20240605;
        b=O/bHRZxj6ayqIxoEZKMfqAA+i4EdYX5U71w2u3ImbpEND37taZ3dPtCKKbxuxp+GtB
         VHSZ+5BPC2T4/2hbhYpcluv8NQ4Vkq9X66iiqlHQtCUsp4npCP+zDU66vlAp0embFYUK
         PGS29rfcmYyrnSFKpCaQ+wtRzYf2n0/7jNu6803x0167P7EOMNBSWSFjyg79LXkKr9eB
         ZGygrRWoqlkn5OECzkzCwbV2t480nug4E+h6gE+QVtBwLbcLMg3Bj/iO9whvHD2TOlSB
         649bGsgerlQq5UX36Q7hqUn0oec5OhOga54XRxdMikZYsfDBEgkdt1gh8oWsVyevrAcn
         C9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0KyH2L7swZlONCm8qiA88ofQeyQkcQTcm0Ac9yPNEG8=;
        fh=C2/xn7cymZ12r6axks2AttMhhy1LZPfnSmYhbgP0ui4=;
        b=XdfdNTj9AXhgwkB2JqOA0S26i9o/rr7dM8MFifbWmM1ootzsaf1dTRTPmiIcCuwyEv
         M3XF0B2+J8eBvmawDPP1SSihZUR6OfRA3LKDC13jGqy4OaI9Ex5LjN5+hU+SI0ult3wR
         NICJgu0+rnY+t8VOo2ZEVDagUo/XmNMoVWFm5dow605aT4tykVe851m09pRmED5OJzem
         Y8CyCYXp80mbR8iKLlhsi9qDdMo0iDAuxFNu6L52y1loVKhDUkXXMYQytg40zfxqGAPV
         D7Ivr38MqI6YzRlGDTMoRYbagdbI6XMd2okgTi3FGCDih5ENX6aQbA0fE+8GQPW6SMQM
         piBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780322501; x=1780927301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0KyH2L7swZlONCm8qiA88ofQeyQkcQTcm0Ac9yPNEG8=;
        b=CTM0yuj26euyk4P1k5ADur5tj5j1AYBteTFtxWbbaurlMfym+9iAg4N/ZbvxrTGW4T
         XoaRQTYWvMlmy8DXnKjPDxYVPqEmWPJJ/AYLjZsjtUyD4FFzxyoOLNbui+sV2Indv1sw
         rCKQgPCIzXBPN1QQ2dIOrz2fqa9p6lncfsGR7HXJuj+l6momcHn5Wphh5k9+NjVsyjdw
         OP0ZhQoZKEyew9Wi9YJ6yZM20NK1IFkk2O2d59kEDrqweMkCKwgXIQ4G6pO8JuHV9IXe
         E7X/hAVWBgU7SklJSQDzQ6dS+VHdTxn4c947B9ueUvdC9pzrnfl1l7TZHfiajPEwMcW1
         WlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322501; x=1780927301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KyH2L7swZlONCm8qiA88ofQeyQkcQTcm0Ac9yPNEG8=;
        b=hXmIPm77ZavMWtjmebS8g1R5RX0qqrnRmZ0O+Uni4bms7wHEc+BTr8xFig5M5Q0eu0
         L9FyWiHUCAWaznA7VUVkFgJ++LiDVZHwgOAjy6C3Dbqag0IN1GEHSFBkxyzAr/kQJwDI
         nPRsue0biU3RKSijZJT3100+o/ynIUUEMKPJBUCar7KgQcxpK0bqM8wv+y/ygs+zUdJd
         5U0vwbjITyHAlXSxi4RIyLlpFvF/kttwZKHtnW0fREH4KmL9ArTx4yI7dX5pIg/+94MP
         brYHwHM8cj4Ay0SCiKe6w7pSbAxMSqTSlugE6tM8oyuYC//uY09VcuFGyPrHKY7gaSvk
         qQ2w==
X-Forwarded-Encrypted: i=1; AFNElJ/pOXocTT9UigFtbA4dx7QCAFMbtSbE6G8mHnQv2QwvOJ09Ywo/HxOhD85y0+4EWmkSrZb4N8/P0/RgdcA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9EavWDAMA0Qy4Bl2zANdT3KeubXy8qbWaBgAhEuPIkf8BKCf
	gfYoLsnAkSKBRrTot5wB87+NVUkbU1LlkQ9FH1sDjbtyCKvIJUcr8MyPfJVfc51UQ5frB8lIyDO
	fz/BVNnWH3m0r+nttlB3387msx3EcEcI=
X-Gm-Gg: Acq92OHFx1zkPA4sIFrj+kVBUYpQPnHmtXw1rqD4RpRLM9Gtny4kSlIKCqXDheGxCW5
	dDTstNPDjDtj2ca72ZN2cd98r++4dCWQ/EtguK/hJWHM8xDGDji3zjXCyhDGiTYrgNr6TEr4aHE
	7YEsWpIVgu1B991Cqa8V7bUKPe+phWU78zF2dORAIVdOpuIVPnPFm5HQDfDoqLS7jdRLvmSGEvc
	fwXqcIBhHgRDnuQl+ewBKkl2yUsL4YiX0F/KmSf7OtMyPtzl7gn4gII3Gw7IlpljaKsw2NymEff
	2zm889X7jl0Gipz+p2M=
X-Received: by 2002:a05:6214:4905:b0:8ca:2413:607a with SMTP id
 6a1803df08f44-8ccefb25d5emr199433596d6.5.1780322500125; Mon, 01 Jun 2026
 07:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
 <20260529103428.99099-1-samsun1006219@gmail.com> <09c2bf1e91f7ddabc24240379cd7dd0b4e15dd8d.camel@redhat.com>
 <1924119775624adb4ce3fd7f3d936eaa2fea3c16.camel@redhat.com>
In-Reply-To: <1924119775624adb4ce3fd7f3d936eaa2fea3c16.camel@redhat.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 1 Jun 2026 22:01:28 +0800
X-Gm-Features: AVHnY4LwmbZ9Ht_-0eG0kGsb9M35v53EYhJJtcMgkrRqbFtR_VBCO39vnCFwifo
Message-ID: <CAEkJfYMoOOgRibSC4UB+1mU35NTP2MZB2_+eSDzrs+VKLpPL5A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000352453065331a2aa"

--000000000000352453065331a2aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 7:23=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Fri, 2026-05-29 at 14:29 -0700, Viacheslav Dubeyko wrote:
> > On Fri, 2026-05-29 at 18:34 +0800, Yue Sun wrote:
> > > hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)->mdb_bh is
> > > locked. A crafted image can set drVBMSt so that the bitmap block reso=
lves
> > > to the same buffer_head as the MDB. When writeback later calls
> > > lock_buffer() for that bitmap block, the task tries to lock mdb_bh ag=
ain
> > > and self-deadlocks in __lock_buffer().
> > >
> > > Reject images whose volume bitmap starts at or before the MDB during
> > > mount. Also guard the bitmap writeback path itself: if the bitmap blo=
ck
> > > would resolve to mdb_bh, force the filesystem read-only and stop bitm=
ap
> > > writeback before taking the buffer lock. This keeps the deadlock fix =
in
> > > the MDB commit path and reuses the existing bitmap size/writeback log=
ic.
> > >
> > > Reported-by: Yue Sun <samsun1006219@gmail.com>
> > > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.k=
ernel.org_all_CAEkJfYMB47v1yOWHB8q2dc8kf-3Duj-2DrLO-3D-2ByMyudwPguJ8Kd3jA-4=
0mail.gmail.com_&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1=
_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3D2ATrdgpvRdYnJfz2T53Ih3iQv6Y9wogU2Ba19prTYgc=
hh1mh4KI7lo9TYLQnlu3X&s=3DS8XdWVW0SpxB05CfctrqCJtJEXqtWDfLNdtzPHIZAY8&e=3D
> > > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Add a commit-time guard before locking bitmap buffer_heads.
> > > - Replace the mount-time byte-range check with a simple drVBMSt check=
.
> > > - Reuse the existing bitmap writeback size calculation.
> > >
> > >  fs/hfs/mdb.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > index a97cea35ca2e..53cd137892b5 100644
> > > --- a/fs/hfs/mdb.c
> > > +++ b/fs/hfs/mdb.c
> > > @@ -185,6 +185,11 @@ int hfs_mdb_get(struct super_block *sb)
> > >             sb->s_flags |=3D SB_RDONLY;
> > >     }
> > >
> > > +   if (be16_to_cpu(mdb->drVBMSt) <=3D HFS_MDB_BLK) {
> >
> > Technically speaking, if we are trying to check the overlapping of volu=
me bitmap
> > with the main MDB record, then we need to check the overlapping with al=
ternative
> > MDB record, and with Catalog File and Extents Overflow File. However, i=
t sounds
> > like we are trying to add some FSCK logic here. :)
> >
> > > +           pr_err("volume bitmap overlaps MDB\n");
> >
> > This situation means volume corruption. It makes sense to recommend to =
run FSCK.
> >
> > > +           return -EIO;
> >
> > This code error is wrong because the read operation was OK. But we have
> > corrupted volume. Even if we have overlapping of volume bitmap with MDB=
 record,
> > then we cannot reject mount operation. We must mount in READ-ONLY mode =
because,
> > potentially, the rest of metadata could be completely OK. We simply can=
not mount
> > in RW mode.
> >
> > > +   }
> > > +
> > >     /* TRY to get the alternate (backup) MDB. */
> > >     sect =3D part_start + part_size - 2;
> > >     bh =3D sb_bread512(sb, sect, mdb2);
> > > @@ -341,6 +346,11 @@ void hfs_mdb_commit(struct super_block *sb)
> > >             size =3D (HFS_SB(sb)->fs_ablocks + 7) / 8;
> > >             ptr =3D (u8 *)HFS_SB(sb)->bitmap;
> > >             while (size) {
> > > +                   if (unlikely(block =3D=3D HFS_SB(sb)->mdb_bh->b_b=
locknr)) {
> > > +                           pr_err("volume bitmap overlaps MDB, forci=
ng read-only\n");
> > > +                           sb->s_flags |=3D SB_RDONLY;
> > > +                           break;
> > > +                   }
> >
> > At this point, we already wrote main MDB and alternative MDB to the vol=
ume.
> > Theoretically, it is possible to imagine that if size of volume bitmap =
is big
> > enough, then we could partially process the bitmap too. Probably, we ne=
ed to
> > check the overlapping at the beginning of the method and reject the who=
le
> > superblock commit.
> >
> > Initial issue was the deadlock. Could we implement some check that buff=
er_heads
> > don't overlap before trying to lock? Does it make sense to you?
> >
>
> By the way, I can see the deadlock in hfs_mdb_commit() even for completel=
y valid
> HFS volume during generic/013 test run. This issue takes place because fo=
lio
> lock related issue. I remember that somebody has sent the patch related t=
o this
> issue but we haven't finished the discussion with some reasonable solutio=
n. I
> think we need to rework the locking scheme:
>
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 97e8d1f96d6d..919798eda0f8 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -64,6 +64,7 @@ struct hfs_inode_info {
>   * The HFS-specific part of a Linux (struct super_block)
>   */
>  struct hfs_sb_info {
> +       struct mutex mdb_lock;                  /* MDB operations lock */
>         struct buffer_head *mdb_bh;             /* The hfs_buffer
>                                                    holding the real
>                                                    superblock (aka VIB
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index a97cea35ca2e..94497c155d29 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -291,9 +291,9 @@ void hfs_mdb_commit(struct super_block *sb)
>         if (sb_rdonly(sb))
>                 return;
>
> -       lock_buffer(HFS_SB(sb)->mdb_bh);
>         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
>                 /* These parameters may have been modified, so write them=
 back
> */
> +               lock_buffer(HFS_SB(sb)->mdb_bh);
>                 mdb->drLsMod =3D hfs_mtime();
>                 mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
>                 mdb->drNxtCNID =3D
> @@ -304,6 +304,7 @@ void hfs_mdb_commit(struct super_block *sb)
>                         cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >file_count));
>                 mdb->drDirCnt =3D
>                         cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >folder_count));
> +               unlock_buffer(HFS_SB(sb)->mdb_bh);
>
>                 /* write MDB to disk */
>                 mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> @@ -360,7 +361,6 @@ void hfs_mdb_commit(struct super_block *sb)
>                         size -=3D len;
>                 }
>         }
> -       unlock_buffer(HFS_SB(sb)->mdb_bh);
>  }
>
>  void hfs_mdb_close(struct super_block *sb)
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a466c401f6bb..5d4caf3ddda6 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
>  static int hfs_sync_fs(struct super_block *sb, int wait)
>  {
>         is_hfs_cnid_counts_valid(sb);
> +
> +       mutex_lock(&HFS_SB(sb)->mdb_lock);
>         hfs_mdb_commit(sb);
> +       mutex_unlock(&HFS_SB(sb)->mdb_lock);
> +
>         return 0;
>  }
>
> @@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
>
>         is_hfs_cnid_counts_valid(sb);
>
> +       mutex_lock(&sbi->mdb_lock);
>         hfs_mdb_commit(sb);
> +       mutex_unlock(&sbi->mdb_lock);
>  }
>
>  void hfs_mark_mdb_dirty(struct super_block *sb)
> @@ -339,9 +345,13 @@ static int hfs_fill_super(struct super_block *sb, st=
ruct
> fs_context *fc)
>         sb->s_op =3D &hfs_super_operations;
>         sb->s_xattr =3D hfs_xattr_handlers;
>         sb->s_flags |=3D SB_NOATIME | SB_NODIRATIME;
> +       mutex_init(&sbi->mdb_lock);
>         mutex_init(&sbi->bitmap_lock);
>
> +       mutex_lock(&sbi->mdb_lock);
>         res =3D hfs_mdb_get(sb);
> +       mutex_unlock(&sbi->mdb_lock);
> +
>         if (res) {
>                 if (!silent)
>                         pr_warn("can't find a HFS filesystem on dev %s\n"=
,
>
> What do you think?
>
> Thanks,
> Slava.
>

Thanks for the detailed comments. I agree that my patch was too
narrow. It only handled the corrupted-layout case without fixing the
more general locking problem in hfs_mdb_commit(), including the case
you mentioned where a valid HFS volume can still deadlock during
xfstests.

I also agree with your main direction that the MDB buffer lock should
not be used as a transaction lock for the whole MDB commit. However,
one detail in the locking sketch worries me, though. After narrowing
the mdb_bh lock, the HFS_FLG_ALT_MDB_DIRTY path still modifies the
primary MDB buffer through hfs_inode_write_fork():
hfs_inode_write_fork(..., mdb->drXTExtRec, &mdb->drXTFlSize, NULL);
hfs_inode_write_fork(..., mdb->drCTExtRec, &mdb->drCTFlSize, NULL);

hfs_inode_write_fork() writes to the extent record and size pointers that
are passed to it, so these are still direct writes into mdb_bh->b_data.
The new HFS-level mdb_lock serializes HFS MDB commits, but generic
buffer writeback does not take that filesystem-private mutex. It only
synchronizes with the buffer_head lock. So I think these primary MDB
updates still need to be covered by lock_buffer(mdb_bh), even if
HFS_FLG_MDB_DIRTY itself is not set.

The approach I am considering is to split the fix into two parts:

1. Rework the locking in hfs_mdb_commit().
   Add an HFS-level mdb_lock and take it inside hfs_mdb_commit(), so all
   MDB commits are serialized at the HFS layer. Then narrow the mdb_bh
   buffer lock so it only covers direct updates of the primary MDB
   buffer, including the hfs_inode_write_fork() calls from the
   HFS_FLG_ALT_MDB_DIRTY path. mark_buffer_dirty(mdb_bh) is done in that
   short critical section. The alternate MDB sync and bitmap writeback
   happen after mdb_bh has been unlocked.

2. Handle the corrupted volume-bitmap layout separately.
   Instead of trying to do broader fsck-style validation, only check the
   condition relevant to this report: whether the volume bitmap's HFS
   512-byte sector range overlaps the main MDB sector. If this is found
   during mount, warn and keep the filesystem read-only, rather than
   returning -EIO. In hfs_mdb_commit(), check the same condition before
   clearing dirty bits or doing any writeback, force read-only, and
   return. I also keep a flag for this condition so a later remount-rw
   attempt leaves the filesystem read-only as well.

Draft patches are attached to this email. What do you think?

Thanks,
Yue

--000000000000352453065331a2aa
Content-Type: text/plain; charset="US-ASCII"; 
	name="hfs-mdb-locking-rfc-email-with-draft-patches.txt"
Content-Disposition: attachment; 
	filename="hfs-mdb-locking-rfc-email-with-draft-patches.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpv9zqnj0>
X-Attachment-Id: f_mpv9zqnj0

LS0tIGRyYWZ0IHBhdGNoIDE6IGhmczogc2VyaWFsaXplIE1EQiBjb21taXRzIGFuZCBuYXJyb3cg
bWRiX2JoIGxvY2tpbmcgLS0tCmRpZmYgLS1naXQgYS9mcy9oZnMvaGZzX2ZzLmggYi9mcy9oZnMv
aGZzX2ZzLmgKaW5kZXggYWMwZTgzZjc3YTBmLi5lNGVkOTA3MWM0OTggMTAwNjQ0Ci0tLSBhL2Zz
L2hmcy9oZnNfZnMuaAorKysgYi9mcy9oZnMvaGZzX2ZzLmgKQEAgLTEyNCw2ICsxMjQsNyBAQCBz
dHJ1Y3QgaGZzX3NiX2luZm8gewogCiAJaW50IHNlc3Npb24sIHBhcnQ7CiAJc3RydWN0IG5sc190
YWJsZSAqbmxzX2lvLCAqbmxzX2Rpc2s7CisJc3RydWN0IG11dGV4IG1kYl9sb2NrOwkJCS8qIHNl
cmlhbGl6ZXMgTURCIHVwZGF0ZXMgKi8KIAlzdHJ1Y3QgbXV0ZXggYml0bWFwX2xvY2s7CiAJdW5z
aWduZWQgbG9uZyBmbGFnczsKIAl1MTYgYmxvY2tvZmZzZXQ7CmRpZmYgLS1naXQgYS9mcy9oZnMv
bWRiLmMgYi9mcy9oZnMvbWRiLmMKaW5kZXggYTk3Y2VhMzVjYTJlLi45OTEwMTNhZTBjMzMgMTAw
NjQ0Ci0tLSBhL2ZzL2hmcy9tZGIuYworKysgYi9mcy9oZnMvbWRiLmMKQEAgLTI4Niw2MCArMjg2
LDc0IEBAIGludCBoZnNfbWRiX2dldChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogICovCiB2b2lk
IGhmc19tZGJfY29tbWl0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCiB7Ci0Jc3RydWN0IGhmc19t
ZGIgKm1kYiA9IEhGU19TQihzYiktPm1kYjsKKwlzdHJ1Y3QgaGZzX3NiX2luZm8gKnNiaSA9IEhG
U19TQihzYik7CisJc3RydWN0IGhmc19tZGIgKm1kYiA9IHNiaS0+bWRiOworCWJvb2wgbWRiX2Rp
cnR5LCBhbHRfZGlydHksIGJpdG1hcF9kaXJ0eTsKIAogCWlmIChzYl9yZG9ubHkoc2IpKQogCQly
ZXR1cm47CiAKLQlsb2NrX2J1ZmZlcihIRlNfU0Ioc2IpLT5tZGJfYmgpOwotCWlmICh0ZXN0X2Fu
ZF9jbGVhcl9iaXQoSEZTX0ZMR19NREJfRElSVFksICZIRlNfU0Ioc2IpLT5mbGFncykpIHsKKwlt
dXRleF9sb2NrKCZzYmktPm1kYl9sb2NrKTsKKwlpZiAoc2JfcmRvbmx5KHNiKSkKKwkJZ290byBv
dXQ7CisKKwltZGJfZGlydHkgPSB0ZXN0X2FuZF9jbGVhcl9iaXQoSEZTX0ZMR19NREJfRElSVFks
ICZzYmktPmZsYWdzKTsKKwlhbHRfZGlydHkgPSB0ZXN0X2FuZF9jbGVhcl9iaXQoSEZTX0ZMR19B
TFRfTURCX0RJUlRZLCAmc2JpLT5mbGFncykgJiYKKwkJICAgIHNiaS0+YWx0X21kYjsKKwliaXRt
YXBfZGlydHkgPSB0ZXN0X2FuZF9jbGVhcl9iaXQoSEZTX0ZMR19CSVRNQVBfRElSVFksICZzYmkt
PmZsYWdzKTsKKworCWlmIChtZGJfZGlydHkgfHwgYWx0X2RpcnR5KQorCQlsb2NrX2J1ZmZlcihz
YmktPm1kYl9iaCk7CisJaWYgKG1kYl9kaXJ0eSkgewogCQkvKiBUaGVzZSBwYXJhbWV0ZXJzIG1h
eSBoYXZlIGJlZW4gbW9kaWZpZWQsIHNvIHdyaXRlIHRoZW0gYmFjayAqLwogCQltZGItPmRyTHNN
b2QgPSBoZnNfbXRpbWUoKTsKLQkJbWRiLT5kckZyZWVCa3MgPSBjcHVfdG9fYmUxNihIRlNfU0Io
c2IpLT5mcmVlX2FibG9ja3MpOworCQltZGItPmRyRnJlZUJrcyA9IGNwdV90b19iZTE2KHNiaS0+
ZnJlZV9hYmxvY2tzKTsKIAkJbWRiLT5kck54dENOSUQgPQotCQkJY3B1X3RvX2JlMzIoKHUzMilh
dG9taWM2NF9yZWFkKCZIRlNfU0Ioc2IpLT5uZXh0X2lkKSk7Ci0JCW1kYi0+ZHJObUZscyA9IGNw
dV90b19iZTE2KEhGU19TQihzYiktPnJvb3RfZmlsZXMpOwotCQltZGItPmRyTm1SdERpcnMgPSBj
cHVfdG9fYmUxNihIRlNfU0Ioc2IpLT5yb290X2RpcnMpOworCQkJY3B1X3RvX2JlMzIoKHUzMilh
dG9taWM2NF9yZWFkKCZzYmktPm5leHRfaWQpKTsKKwkJbWRiLT5kck5tRmxzID0gY3B1X3RvX2Jl
MTYoc2JpLT5yb290X2ZpbGVzKTsKKwkJbWRiLT5kck5tUnREaXJzID0gY3B1X3RvX2JlMTYoc2Jp
LT5yb290X2RpcnMpOwogCQltZGItPmRyRmlsQ250ID0KLQkJCWNwdV90b19iZTMyKCh1MzIpYXRv
bWljNjRfcmVhZCgmSEZTX1NCKHNiKS0+ZmlsZV9jb3VudCkpOworCQkJY3B1X3RvX2JlMzIoKHUz
MilhdG9taWM2NF9yZWFkKCZzYmktPmZpbGVfY291bnQpKTsKIAkJbWRiLT5kckRpckNudCA9Ci0J
CQljcHVfdG9fYmUzMigodTMyKWF0b21pYzY0X3JlYWQoJkhGU19TQihzYiktPmZvbGRlcl9jb3Vu
dCkpOwotCi0JCS8qIHdyaXRlIE1EQiB0byBkaXNrICovCi0JCW1hcmtfYnVmZmVyX2RpcnR5KEhG
U19TQihzYiktPm1kYl9iaCk7CisJCQljcHVfdG9fYmUzMigodTMyKWF0b21pYzY0X3JlYWQoJnNi
aS0+Zm9sZGVyX2NvdW50KSk7CiAJfQogCiAJLyogd3JpdGUgdGhlIGJhY2t1cCBNREIsIG5vdCBy
ZXR1cm5pbmcgdW50aWwgaXQgaXMgd3JpdHRlbi4KIAkgKiB3ZSBvbmx5IGRvIHRoaXMgd2hlbiBl
aXRoZXIgdGhlIGNhdGFsb2cgb3IgZXh0ZW50cyBvdmVyZmxvdwogCSAqIGZpbGVzIGdyb3cuICov
Ci0JaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChIRlNfRkxHX0FMVF9NREJfRElSVFksICZIRlNfU0Io
c2IpLT5mbGFncykgJiYKLQkgICAgSEZTX1NCKHNiKS0+YWx0X21kYikgewotCQloZnNfaW5vZGVf
d3JpdGVfZm9yayhIRlNfU0Ioc2IpLT5leHRfdHJlZS0+aW5vZGUsIG1kYi0+ZHJYVEV4dFJlYywK
KwlpZiAoYWx0X2RpcnR5KSB7CisJCWhmc19pbm9kZV93cml0ZV9mb3JrKHNiaS0+ZXh0X3RyZWUt
Pmlub2RlLCBtZGItPmRyWFRFeHRSZWMsCiAJCQkJICAgICAmbWRiLT5kclhURmxTaXplLCBOVUxM
KTsKLQkJaGZzX2lub2RlX3dyaXRlX2ZvcmsoSEZTX1NCKHNiKS0+Y2F0X3RyZWUtPmlub2RlLCBt
ZGItPmRyQ1RFeHRSZWMsCisJCWhmc19pbm9kZV93cml0ZV9mb3JrKHNiaS0+Y2F0X3RyZWUtPmlu
b2RlLCBtZGItPmRyQ1RFeHRSZWMsCiAJCQkJICAgICAmbWRiLT5kckNURmxTaXplLCBOVUxMKTsK
Kwl9CisJaWYgKG1kYl9kaXJ0eSB8fCBhbHRfZGlydHkpIHsKKwkJbWFya19idWZmZXJfZGlydHko
c2JpLT5tZGJfYmgpOworCQl1bmxvY2tfYnVmZmVyKHNiaS0+bWRiX2JoKTsKKwl9CiAKLQkJbG9j
a19idWZmZXIoSEZTX1NCKHNiKS0+YWx0X21kYl9iaCk7Ci0JCW1lbWNweShIRlNfU0Ioc2IpLT5h
bHRfbWRiLCBIRlNfU0Ioc2IpLT5tZGIsIEhGU19TRUNUT1JfU0laRSk7Ci0JCUhGU19TQihzYikt
PmFsdF9tZGItPmRyQXRyYiB8PSBjcHVfdG9fYmUxNihIRlNfU0JfQVRUUklCX1VOTU5UKTsKLQkJ
SEZTX1NCKHNiKS0+YWx0X21kYi0+ZHJBdHJiICY9IGNwdV90b19iZTE2KH5IRlNfU0JfQVRUUklC
X0lOQ05TVE5UKTsKLQkJdW5sb2NrX2J1ZmZlcihIRlNfU0Ioc2IpLT5hbHRfbWRiX2JoKTsKKwlp
ZiAoYWx0X2RpcnR5KSB7CisJCWxvY2tfYnVmZmVyKHNiaS0+YWx0X21kYl9iaCk7CisJCW1lbWNw
eShzYmktPmFsdF9tZGIsIHNiaS0+bWRiLCBIRlNfU0VDVE9SX1NJWkUpOworCQlzYmktPmFsdF9t
ZGItPmRyQXRyYiB8PSBjcHVfdG9fYmUxNihIRlNfU0JfQVRUUklCX1VOTU5UKTsKKwkJc2JpLT5h
bHRfbWRiLT5kckF0cmIgJj0gY3B1X3RvX2JlMTYofkhGU19TQl9BVFRSSUJfSU5DTlNUTlQpOwor
CQl1bmxvY2tfYnVmZmVyKHNiaS0+YWx0X21kYl9iaCk7CiAKLQkJbWFya19idWZmZXJfZGlydHko
SEZTX1NCKHNiKS0+YWx0X21kYl9iaCk7Ci0JCXN5bmNfZGlydHlfYnVmZmVyKEhGU19TQihzYikt
PmFsdF9tZGJfYmgpOworCQltYXJrX2J1ZmZlcl9kaXJ0eShzYmktPmFsdF9tZGJfYmgpOworCQlz
eW5jX2RpcnR5X2J1ZmZlcihzYmktPmFsdF9tZGJfYmgpOwogCX0KIAotCWlmICh0ZXN0X2FuZF9j
bGVhcl9iaXQoSEZTX0ZMR19CSVRNQVBfRElSVFksICZIRlNfU0Ioc2IpLT5mbGFncykpIHsKKwlp
ZiAoYml0bWFwX2RpcnR5KSB7CiAJCXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7CiAJCXNlY3Rvcl90
IGJsb2NrOwogCQljaGFyICpwdHI7CiAJCWludCBvZmYsIHNpemUsIGxlbjsKIAotCQlibG9jayA9
IGJlMTZfdG9fY3B1KEhGU19TQihzYiktPm1kYi0+ZHJWQk1TdCkgKyBIRlNfU0Ioc2IpLT5wYXJ0
X3N0YXJ0OworCQlibG9jayA9IGJlMTZfdG9fY3B1KHNiaS0+bWRiLT5kclZCTVN0KSArIHNiaS0+
cGFydF9zdGFydDsKIAkJb2ZmID0gKGJsb2NrIDw8IEhGU19TRUNUT1JfU0laRV9CSVRTKSAmIChz
Yi0+c19ibG9ja3NpemUgLSAxKTsKIAkJYmxvY2sgPj49IHNiLT5zX2Jsb2Nrc2l6ZV9iaXRzIC0g
SEZTX1NFQ1RPUl9TSVpFX0JJVFM7Ci0JCXNpemUgPSAoSEZTX1NCKHNiKS0+ZnNfYWJsb2NrcyAr
IDcpIC8gODsKLQkJcHRyID0gKHU4ICopSEZTX1NCKHNiKS0+Yml0bWFwOworCQlzaXplID0gKHNi
aS0+ZnNfYWJsb2NrcyArIDcpIC8gODsKKwkJcHRyID0gKHU4ICopc2JpLT5iaXRtYXA7CiAJCXdo
aWxlIChzaXplKSB7CiAJCQliaCA9IHNiX2JyZWFkKHNiLCBibG9jayk7CiAJCQlpZiAoIWJoKSB7
CkBAIC0zNjAsNyArMzc0LDkgQEAgdm9pZCBoZnNfbWRiX2NvbW1pdChzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiKQogCQkJc2l6ZSAtPSBsZW47CiAJCX0KIAl9Ci0JdW5sb2NrX2J1ZmZlcihIRlNfU0Io
c2IpLT5tZGJfYmgpOworCitvdXQ6CisJbXV0ZXhfdW5sb2NrKCZzYmktPm1kYl9sb2NrKTsKIH0K
IAogdm9pZCBoZnNfbWRiX2Nsb3NlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCmRpZmYgLS1naXQg
YS9mcy9oZnMvc3VwZXIuYyBiL2ZzL2hmcy9zdXBlci5jCmluZGV4IGE0ZjJhMmJmYTZkMy4uNjBh
OTNjMzFiM2ZmIDEwMDY0NAotLS0gYS9mcy9oZnMvc3VwZXIuYworKysgYi9mcy9oZnMvc3VwZXIu
YwpAQCAtMzM5LDYgKzMzOSw3IEBAIHN0YXRpYyBpbnQgaGZzX2ZpbGxfc3VwZXIoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCXNiLT5zX29wID0gJmhmc19z
dXBlcl9vcGVyYXRpb25zOwogCXNiLT5zX3hhdHRyID0gaGZzX3hhdHRyX2hhbmRsZXJzOwogCXNi
LT5zX2ZsYWdzIHw9IFNCX05PRElSQVRJTUU7CisJbXV0ZXhfaW5pdCgmc2JpLT5tZGJfbG9jayk7
CiAJbXV0ZXhfaW5pdCgmc2JpLT5iaXRtYXBfbG9jayk7CiAKIAlyZXMgPSBoZnNfbWRiX2dldChz
Yik7CgotLS0gZHJhZnQgcGF0Y2ggMjogaGZzOiBkZXRlY3Qgdm9sdW1lIGJpdG1hcCBvdmVybGFw
IHdpdGggTURCIC0tLQpkaWZmIC0tZ2l0IGEvZnMvaGZzL2hmc19mcy5oIGIvZnMvaGZzL2hmc19m
cy5oCmluZGV4IGU0ZWQ5MDcxYzQ5OC4uZGY2ZWQxMjk4MTUxIDEwMDY0NAotLS0gYS9mcy9oZnMv
aGZzX2ZzLmgKKysrIGIvZnMvaGZzL2hmc19mcy5oCkBAIC0xMzgsNiArMTM4LDcgQEAgc3RydWN0
IGhmc19zYl9pbmZvIHsKICNkZWZpbmUgSEZTX0ZMR19CSVRNQVBfRElSVFkJMAogI2RlZmluZSBI
RlNfRkxHX01EQl9ESVJUWQkxCiAjZGVmaW5lIEhGU19GTEdfQUxUX01EQl9ESVJUWQkyCisjZGVm
aW5lIEhGU19GTEdfVkJNX09WRVJMQVAJMwogCiAvKiBiaXRtYXAuYyAqLwogZXh0ZXJuIHUzMiBo
ZnNfdmJtX3NlYXJjaF9mcmVlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHUzMiBnb2FsLCB1MzIg
Km51bV9iaXRzKTsKZGlmZiAtLWdpdCBhL2ZzL2hmcy9tZGIuYyBiL2ZzL2hmcy9tZGIuYwppbmRl
eCA5OTEwMTNhZTBjMzMuLjRiNmYxZGY1ZTRhOCAxMDA2NDQKLS0tIGEvZnMvaGZzL21kYi5jCisr
KyBiL2ZzL2hmcy9tZGIuYwpAQCAtODUsNiArODUsMjQgQEAgYm9vbCBpc19oZnNfY25pZF9jb3Vu
dHNfdmFsaWQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAlyZXR1cm4gIWNvcnJ1cHRlZDsKIH0K
IAorc3RhdGljIGJvb2wgaGZzX3ZibV9vdmVybGFwc19tZGIoc3RydWN0IHN1cGVyX2Jsb2NrICpz
YikKK3sKKwlzdHJ1Y3QgaGZzX3NiX2luZm8gKnNiaSA9IEhGU19TQihzYik7CisJc2VjdG9yX3Qg
bWRiX3N0YXJ0LCB2Ym1fc3RhcnQsIHZibV9lbmQ7CisJdTMyIHZibV9ieXRlcywgdmJtX3NlY3Rv
cnM7CisKKwl2Ym1fYnl0ZXMgPSAoc2JpLT5mc19hYmxvY2tzICsgNykgLyA4OworCWlmICghdmJt
X2J5dGVzKQorCQlyZXR1cm4gZmFsc2U7CisKKwltZGJfc3RhcnQgPSBzYmktPnBhcnRfc3RhcnQg
KyBIRlNfTURCX0JMSzsKKwl2Ym1fc3RhcnQgPSBzYmktPnBhcnRfc3RhcnQgKyBiZTE2X3RvX2Nw
dShzYmktPm1kYi0+ZHJWQk1TdCk7CisJdmJtX3NlY3RvcnMgPSBESVZfUk9VTkRfVVAodmJtX2J5
dGVzLCBIRlNfU0VDVE9SX1NJWkUpOworCXZibV9lbmQgPSB2Ym1fc3RhcnQgKyB2Ym1fc2VjdG9y
czsKKworCXJldHVybiB2Ym1fc3RhcnQgPCBtZGJfc3RhcnQgKyAxICYmIG1kYl9zdGFydCA8IHZi
bV9lbmQ7Cit9CisKIC8qCiAgKiBoZnNfbWRiX2dldCgpCiAgKgpAQCAtMTg1LDYgKzIwMywxMiBA
QCBpbnQgaGZzX21kYl9nZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAkJc2ItPnNfZmxhZ3Mg
fD0gU0JfUkRPTkxZOwogCX0KIAorCWlmIChoZnNfdmJtX292ZXJsYXBzX21kYihzYikpIHsKKwkJ
cHJfd2Fybigidm9sdW1lIGJpdG1hcCBvdmVybGFwcyBNREIsIHJ1bm5pbmcgZnNjay5oZnMgaXMg
cmVjb21tZW5kZWQuIE1vdW50aW5nIHJlYWQtb25seS5cbiIpOworCQlzZXRfYml0KEhGU19GTEdf
VkJNX09WRVJMQVAsICZIRlNfU0Ioc2IpLT5mbGFncyk7CisJCXNiLT5zX2ZsYWdzIHw9IFNCX1JE
T05MWTsKKwl9CisKIAkvKiBUUlkgdG8gZ2V0IHRoZSBhbHRlcm5hdGUgKGJhY2t1cCkgTURCLiAq
LwogCXNlY3QgPSBwYXJ0X3N0YXJ0ICsgcGFydF9zaXplIC0gMjsKIAliaCA9IHNiX2JyZWFkNTEy
KHNiLCBzZWN0LCBtZGIyKTsKQEAgLTI5Niw2ICszMjAsMTMgQEAgdm9pZCBoZnNfbWRiX2NvbW1p
dChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCW11dGV4X2xvY2soJnNiaS0+bWRiX2xvY2spOwog
CWlmIChzYl9yZG9ubHkoc2IpKQogCQlnb3RvIG91dDsKKwlpZiAodGVzdF9iaXQoSEZTX0ZMR19W
Qk1fT1ZFUkxBUCwgJnNiaS0+ZmxhZ3MpIHx8CisJICAgIGhmc192Ym1fb3ZlcmxhcHNfbWRiKHNi
KSkgeworCQlwcl9lcnIoInZvbHVtZSBiaXRtYXAgb3ZlcmxhcHMgTURCLCBmb3JjaW5nIHJlYWQt
b25seVxuIik7CisJCXNldF9iaXQoSEZTX0ZMR19WQk1fT1ZFUkxBUCwgJnNiaS0+ZmxhZ3MpOwor
CQlzYi0+c19mbGFncyB8PSBTQl9SRE9OTFk7CisJCWdvdG8gb3V0OworCX0KIAogCW1kYl9kaXJ0
eSA9IHRlc3RfYW5kX2NsZWFyX2JpdChIRlNfRkxHX01EQl9ESVJUWSwgJnNiaS0+ZmxhZ3MpOwog
CWFsdF9kaXJ0eSA9IHRlc3RfYW5kX2NsZWFyX2JpdChIRlNfRkxHX0FMVF9NREJfRElSVFksICZz
YmktPmZsYWdzKSAmJgpkaWZmIC0tZ2l0IGEvZnMvaGZzL3N1cGVyLmMgYi9mcy9oZnMvc3VwZXIu
YwppbmRleCA2MGE5M2MzMWIzZmYuLjgxZGU5NjA3YWIyNCAxMDA2NDQKLS0tIGEvZnMvaGZzL3N1
cGVyLmMKKysrIGIvZnMvaGZzL3N1cGVyLmMKQEAgLTEzMyw2ICsxMzMsMTAgQEAgc3RhdGljIGlu
dCBoZnNfcmVjb25maWd1cmUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCQkJcHJfd2FybigiZmls
ZXN5c3RlbSBpcyBtYXJrZWQgbG9ja2VkLCBsZWF2aW5nIHJlYWQtb25seS5cbiIpOwogCQkJc2It
PnNfZmxhZ3MgfD0gU0JfUkRPTkxZOwogCQkJZmMtPnNiX2ZsYWdzIHw9IFNCX1JET05MWTsKKwkJ
fSBlbHNlIGlmICh0ZXN0X2JpdChIRlNfRkxHX1ZCTV9PVkVSTEFQLCAmSEZTX1NCKHNiKS0+Zmxh
Z3MpKSB7CisJCQlwcl93YXJuKCJ2b2x1bWUgYml0bWFwIG92ZXJsYXBzIE1EQiwgcnVubmluZyBm
c2NrLmhmcyBpcyByZWNvbW1lbmRlZC4gIGxlYXZpbmcgcmVhZC1vbmx5LlxuIik7CisJCQlzYi0+
c19mbGFncyB8PSBTQl9SRE9OTFk7CisJCQlmYy0+c2JfZmxhZ3MgfD0gU0JfUkRPTkxZOwogCQl9
CiAJfQogCXJldHVybiAwOwo=
--000000000000352453065331a2aa--
