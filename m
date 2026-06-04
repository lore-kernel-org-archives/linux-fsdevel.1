Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20017372057
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617176; cv=none; b=kBWpMfALVSQjeSgRlcBawx1xe6bbHkJbaMjzGCnawVY3CkUxippAAZqyOewF/gTMXy3JnlPJscfaUlLjuZ+UH9NMVdUWl17LInXUMmj8qlky127/13UCByd/rRJ3NWJZ6V6KT02/1y6mXqb8mc9ZBf/TE2iyM2WtnI403QO2eAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617176; c=relaxed/simple;
	bh=nHR6HOoWItaO+hq1nmJUk7KITXZ7RhQzj3Wh5eNGHk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0kUihMpoeqMfxFYFlxdZCisCtQdMMh7pk6X2zSr1WiiPwHeAzSJllRZSXVdB2HJlgWT3iNeDtjh0/VggIktKHySB7pwiAKH2NBW1PrSPpWt23KQFHgVLKR3WFiZL3fuJ0qE9pJOi5I9JwP5UQ6kuxLEyFzN9KT87XzHKgIOZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=GKPZgbx2; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="GKPZgbx2"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dd7818ac2aso17622867b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780617174; x=1781221974; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5tEQupdmCV1bWJrwcYoMC/D8qNjBNPUGtrSGvjyI1LM=;
        b=GKPZgbx2B9dTo9AHWLbuimSHIrPB8sKPPlNLtUzzII5tugE0xarGB2kWRICN8U15Bv
         fVx7Dh2q/VacoY9oo9+fJYu3pMOhvfXMgAHYAxKLUaSWxdFgI2QlBEBut+9ayqF5Z8zh
         wwO2MZ1HmYHUFw/ZX8YLsM2lx+MTBc1PyzK5HpZhrmnBKsdmDwhhnxz9x+tF90DZC8S0
         hhP0ZMQZqOvfMsd11Z0bXMUWbHjWW3FHnDlFtIJK/4ixky/1lZjI6ekjArk0zdPMw688
         tWi0mG7fAephJg8xsCZIgq0uKNB/T4uQXSKfEKkCPr0eleo5RQvD3rjJ5N0bcJIHoilZ
         8fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617174; x=1781221974;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tEQupdmCV1bWJrwcYoMC/D8qNjBNPUGtrSGvjyI1LM=;
        b=XWN4ybnJ5RaBveSZBUW/3xbdqxCnDyR3m6vmaG6adcuwg74MdVooEGUR2WNoDtoFAS
         0jYflLIdfrtdItoVW3EVi7/dSXFkmLhEK3QXyIiUURVxL6RdzCzvh4e1ZihdgLUXBcSp
         d4BGTXjLhaPpQc8doNzQflF7xNhl97oW4VWGUzKNsmt4z9C/YX54J06Jy8wCQeo+Tx+h
         bhX45W8axbj5Pye/YJbJlz3js/gm4Llktzklp0b/nyNw/NTi0z0uixymzMmxgcflTnS9
         PeqGha+IPgFxFXHxUAVePhhFzUGLDwiczQiMBPt0m7Htgx28+veKTHB2WAXjESOwadcC
         iB2g==
X-Gm-Message-State: AOJu0Yy62ZwRcWSxbBAuLisZEoCHpdYEoGQNBjvpNOzrHyqnO4egwKAD
	inAZY18gkVXn6zZsndUjDBcduPBmPYjJGnnptrljKuupK8wupwjjmapXyAkeb0ePU10=
X-Gm-Gg: Acq92OHxdDhQctI8qclXCJPeV7llgWFwQcDipqYFVEL83cimNeDXWY5FUP0vKDyQrBf
	n2LqPcTMW5qoBFfPyFwHgnQGLsCeWbduZMKuDBwCKL6BczlZQhnAbN3mjJ9q9fKeiErkIz7TE/p
	0obJInzNi5Bf2HG8DhzbbTlj+gqBgvdEjmlp11vOsnjcZjLDurA2ewYOTXiSS/M2oZo7m39gwSN
	l86HCIC5DjoVArpvswWryVMZElygz1E/g5foOm/IlL10CtmCTbqct4ELy4OY5cl1pbZwdRHbRtR
	bxwoaG285t6C/d6MqhhhQDQrGgxTkTWwRDcyZKNQjYn8RhPr5xRCtFUkl4Rq21C+NTYa4Jrj9EB
	LmB0CWlAs6+135mKWjHAQZuYnRn7GMQwuw4g50NW+bkvJV4P0LocHH8iE+u8ggE1mp2Mfik8IYu
	cZiEKtH1OXQzX6rLfXcWaZaoNQoc2c51vjM5T0Jt48w99yDG7JugezJWDBtysIIKJGSHlgvQdBo
	EwsHaSVE38viRrXSoG83z3TsX1kZ0sDLeMcbtZfX3C+PIEBy8rjXwATdAzqBVgXM/AR
X-Received: by 2002:a05:690c:7006:b0:7dc:7ccb:33a1 with SMTP id 00721157ae682-7ed0f82813dmr10383947b3.23.1780617174021;
        Thu, 04 Jun 2026 16:52:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:80ee:99ae:6c1:509d? ([2600:1700:6476:1430:80ee:99ae:6c1:509d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23b92944sm41877447b3.41.2026.06.04.16.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:52:53 -0700 (PDT)
Message-ID: <fc2326a0ba9f73c4151352ab5449197e5f0048c2.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yue Sun <samsun1006219@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 16:52:52 -0700
In-Reply-To: <8e4f04261421e7c904eabbf702e5eb66c9e20bd1.camel@dubeyko.com>
References: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
		 <20260604180306.18672-1-samsun1006219@gmail.com>
	 <8e4f04261421e7c904eabbf702e5eb66c9e20bd1.camel@dubeyko.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 14:25 -0700, Viacheslav Dubeyko wrote:
> On Fri, 2026-06-05 at 02:02 +0800, Yue Sun wrote:
> > On Thu, Jun 4, 2026 at 12:25 AM <slava@dubeyko.com> wrote:
> > >=20
> > > Could you please take a deeper look into my diff that I've shared
> > > with
> > > you before? I don't see the point to review your suggestion if
> > > you
> > > completely ignored my diff. From my point of view you suggested
> > > completely the same approach but in more complicated manner.
> >=20
> > You are right. I am sorry for the confusion.
> >=20
> > I should have looked more carefully at your diff and based my reply
> > on
> > it. Adding an HFS-level MDB mutex and avoiding holding mdb_bh
> > across
> > the
> > whole hfs_mdb_commit() path is the right direction. My previous
> > reply
> > mixed that with extra cleanups and a separate corrupted-layout
> > check,
> > which made it look like I was proposing a different approach. That
> > was
> > my mistake.
> >=20
> > I am not very familiar with HFS internals, so please treat the
> > following
> > only as a small suggestion. After re-reading your diff, the only
> > detail
> > I am still unsure about is the HFS_FLG_ALT_MDB_DIRTY path. In that
> > path,
> > hfs_inode_write_fork() gets MDB fields as output buffers:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(..., md=
b->drXTExtRec,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(..., md=
b->drCTExtRec,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
>=20
>=20
> I've started to think that, maybe, the location of these
> hfs_inode_write_fork() calls is not correct. We are trying to save
> the
> current size of Catalog File and Extents Overflow File. OK, we need
> to
> update this if size is changed. But we can save the sizes during
> every
> call of hfs_mdb_commit(). It's logically incorrect to call these
> methods in the alternative MDB section because it is the content of
> primary MDB. I suggest to move these two hfs_inode_write_fork() to
> primary MDB writing section:
>=20
> lock_buffer(HFS_SB(sb)->mdb_bh);
> 		/* These parameters may have been modified, so write
> them back */
> 		mdb->drLsMod =3D hfs_mtime();
> 		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> > free_ablocks);
> 		mdb->drNxtCNID =3D
> 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> > next_id));
> 		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
> 		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)-
> >root_dirs);
> 		mdb->drFilCnt =3D
> 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> > file_count));
> 		mdb->drDirCnt =3D
> 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> > folder_count));
>=20
> 		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> mdb-
> > drXTExtRec,
> 				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> 		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> mdb-
> > drCTExtRec,
> 				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
>=20
> 		/* write MDB to disk */
> 		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> unlock_buffer(HFS_SB(sb)->mdb_bh);
>=20
> In this case, we don;'t need to overlap the locks. What do you think?
> Sounds like reasonable solution?
>=20
>=20

Frankly speaking, I don't like this approach of assigning the pointer
on bh->b_data to HFS_SB(sb)->mdb:=20

data =3D (void *)(__bh->b_data + __offset);

We manipulate by various fields of HFS_SB(sb)->mdb throughout of the
hfs_mdb_commit(). I think that we need to allocate buffer for struct
hfs_mdb *mdb during hfs_mdb_get() (and destroy in hfs_mdb_put()) and
synchronize its content with struct buffer_head *mdb_bh. Otherwise, we
never can resolve the problem of proper locking in hfs_mdb_commit().
What do you think?

Thanks,
Slava.

>=20
> > Since mdb points into mdb_bh->b_data, these calls seem to update
> > fields
> > in the primary MDB buffer. So I was thinking that we could keep
> > your
> > locking scheme, but move unlock_buffer(mdb_bh) slightly later,
> > after
> > these primary MDB updates and mark_buffer_dirty(mdb_bh). The
> > alternate
> > MDB copy/sync and the bitmap writeback would still happen after
> > mdb_bh
> > is unlocked, so the main deadlock fix remains the same.
> >=20
> > If this concern is not valid, or if the current HFS update rules
> > already
> > make your shorter window sufficient, please ignore this. I defer to
> > your
> > judgment here.
> >=20
> > Below is your diff with only that small adjustment.
> >=20
> > Thanks,
> > Yue
> >=20
> > diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> > index ac0e83f77a0f..00651f42ba38 100644
> > --- a/fs/hfs/hfs_fs.h
> > +++ b/fs/hfs/hfs_fs.h
> > @@ -66,6 +66,7 @@ struct hfs_inode_info {
> > =C2=A0 * The HFS-specific part of a Linux (struct super_block)
> > =C2=A0 */
> > =C2=A0struct hfs_sb_info {
> > +	struct mutex mdb_lock;			/* MDB operations
> > lock */
> > =C2=A0	struct buffer_head *mdb_bh;		/* The hfs_buffer
> > =C2=A0						=C2=A0=C2=A0 holding the
> > real
> > =C2=A0						=C2=A0=C2=A0 superblock (aka
> > VIB
> > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > index a97cea35ca2e..d81e3545a045 100644
> > --- a/fs/hfs/mdb.c
> > +++ b/fs/hfs/mdb.c
> > @@ -287,6 +287,7 @@ int hfs_mdb_get(struct super_block *sb)
> > =C2=A0void hfs_mdb_commit(struct super_block *sb)
> > =C2=A0{
> > =C2=A0	struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> > +	bool write_backup =3D false;
> > =C2=A0
> > =C2=A0	if (sb_rdonly(sb))
> > =C2=A0		return;
> > @@ -314,11 +315,17 @@ void hfs_mdb_commit(struct super_block *sb)
> > =C2=A0	 * files grow. */
> > =C2=A0	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)-
> > > flags) &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0 HFS_SB(sb)->alt_mdb) {
> > +		write_backup =3D true;
> > =C2=A0		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> > mdb->drXTExtRec,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> > =C2=A0		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> > mdb->drCTExtRec,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
> > =C2=A0
> > +		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> > +	}
> > +	unlock_buffer(HFS_SB(sb)->mdb_bh);
> > +
> > +	if (write_backup) {
> > =C2=A0		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
> > =C2=A0		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb,
> > HFS_SECTOR_SIZE);
> > =C2=A0		HFS_SB(sb)->alt_mdb->drAtrb |=3D
> > cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
> > @@ -360,7 +367,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > =C2=A0			size -=3D len;
> > =C2=A0		}
> > =C2=A0	}
> > -	unlock_buffer(HFS_SB(sb)->mdb_bh);
> > =C2=A0}
> > =C2=A0
> > =C2=A0void hfs_mdb_close(struct super_block *sb)
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index a4f2a2bfa6d3..06ab904b3a42 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
> > =C2=A0static int hfs_sync_fs(struct super_block *sb, int wait)
> > =C2=A0{
> > =C2=A0	is_hfs_cnid_counts_valid(sb);
> > +
> > +	mutex_lock(&HFS_SB(sb)->mdb_lock);
> > =C2=A0	hfs_mdb_commit(sb);
> > +	mutex_unlock(&HFS_SB(sb)->mdb_lock);
> > +
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > @@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
> > =C2=A0
> > =C2=A0	is_hfs_cnid_counts_valid(sb);
> > =C2=A0
> > +	mutex_lock(&sbi->mdb_lock);
> > =C2=A0	hfs_mdb_commit(sb);
> > +	mutex_unlock(&sbi->mdb_lock);
> > =C2=A0}
> > =C2=A0
> > =C2=A0void hfs_mark_mdb_dirty(struct super_block *sb)
> > @@ -339,9 +345,12 @@ static int hfs_fill_super(struct super_block
> > *sb, struct fs_context *fc)
> > =C2=A0	sb->s_op =3D &hfs_super_operations;
> > =C2=A0	sb->s_xattr =3D hfs_xattr_handlers;
> > =C2=A0	sb->s_flags |=3D SB_NODIRATIME;
> > +	mutex_init(&sbi->mdb_lock);
> > =C2=A0	mutex_init(&sbi->bitmap_lock);
> > =C2=A0
> > +	mutex_lock(&sbi->mdb_lock);
> > =C2=A0	res =3D hfs_mdb_get(sb);
> > +	mutex_unlock(&sbi->mdb_lock);
> > =C2=A0	if (res) {
> > =C2=A0		if (!silent)
> > =C2=A0			pr_warn("can't find a HFS filesystem on
> > dev
> > %s\n",
