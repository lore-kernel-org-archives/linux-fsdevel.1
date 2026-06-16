Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04313C1970
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590721; cv=none; b=LoDYNRC0DJueZwEyJxYmHme7AZSfhHaax6RnaQpW1ZOWjly9mdGAtBXERzYKOTMN50UtOn7lU3HYvS6VhpTe3EHHEVLH5vUfSZqsH5B/OSZToAEgeV23Ve91GXSZXvZSSe/BqN6nWaUzdZkjNn9QncUGiR/gKQC6kea2nSmoIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590721; c=relaxed/simple;
	bh=AxUlvz0jKM/mTPX63rOzUbcs9rJUpmquvwyE17UGtaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyXBaRzypAs+7kbdTGDTsPmigfbvLHIhfYDfIjjJqX0s5YSgcNvmtfMHifBWhRkqnDta70rP0uOdibusthhD349fQwitYReUTcXu6xS1ds0hk//Vfk0U+vfU0YJvgjBqAXUA+kfSxjV2tnhqAa5cSdmTMUqa3L8nITxx8MWWNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=hv2r2u1R; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="hv2r2u1R"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so4707381e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781590717; x=1782195517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbtzrA9lzbQ25gtyd1mUa09G2mp8hWm3XJb/VcbI/4I=;
        b=hv2r2u1RRqebVVF7hGW9CmsH5I4qRSKQJuzpAN5civyWRAcQ3iQarCZT59NjMeYsf+
         vo1gKqF+sN5qw8FiIBV5Pecfk1ysbjpagQR+WLdWerhehnXBimEf2n40fR28xOvoIh7m
         TqKu+j4OfnM808Du0LA/AZFGUgc3afDRZcP1gy8uNbs7vAa2RY13HLm3wKLSb3BGdQnw
         BNYltmT0Svc5E1EsCdH1GHTYZdgcTjFmpVd6htLOgIomQeO1A7B31K1p5mjDVJZ7Fg3e
         nMSL1AMiq5KIYVxHhJi23S8fFGGIyShOzb9DE7HQpI7LPUR+sleifKXrvr1IOAIXDOmG
         Wf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590717; x=1782195517;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbtzrA9lzbQ25gtyd1mUa09G2mp8hWm3XJb/VcbI/4I=;
        b=J5qD9rkEo9qQzmUq4EMZ4F6RBbiC4LiCegm8dwEXLUIH9GIdnb1ypl4LDy91orEM+l
         HtgGLZABss7SzGn8waMf3gAhYHx4cCAqba3ma2iXLXnoHmr+q7qmXumrQ1Cb8EdV2wK4
         XYk6sKbvBq5dA3gR3KhdOn4rPypqG9cD6lQw8bef2kCoqlal3xgL0xfCLCpEYL9DJD+o
         Voz+UDv8jZ44OuQaj6NU8dmO97gZDrAEJ1KgGrWWwV1r/kA3br5HZpI31PQVtzkYlNHW
         3xgKdRztwyfkwDmPHmp5+XEHLI/qgU39cEGW7tTDHpse1xpjRA2S79k4OBF0eW3zjnOY
         PtQg==
X-Gm-Message-State: AOJu0YzSukUuX9lnX/bp5fdhRiWdNTM1qNsh2y2lp4HLciNawUz/Am4d
	SjmXRzA9kh1yPytR3iz3PPhP1XIDdXLXAnIyx0RMjq1vGP8yKBiZbYOhg2D6cxE4SbA=
X-Gm-Gg: Acq92OGnckwi+BRUAqu811XcgWUHzOlN9yNna2AUK+Yc9vw9KFQKQ2RgnR3af01blRy
	ddHeM+hmdb72XNEeRFuXl7cQiM0TOYq/47BzUGDDflnArnhrco9xNUXB/z9z6q0XEcr9eG28H7n
	31Pvsj2mvcIJtyOOtCiqJiXjy6l+mBpvKSHXtKNno5rkI+xEaJtw7QZXzYch9ILIivtLAw4bVWg
	+t7DNNgxGYIdemRE63CcunRHnaDGZHRVIye6fD4c6E5zcCCJKBGAu6CUEHRE5+uv1ty1OIeupRy
	mHXIxafQ6vXEyyWL7kBMUQs1c7gF8WWGODsN4iYe/G31oVvTZcZg1ox50vJU3tonsz4ZaYsoPal
	IKG9940Iik2ms5pT0ymfRSvwUZFUYJUjtlPVNWBBqjOHf/+4zES2elKG9keeH4otpv0uZXz37wq
	UO5BWWQGx50i5PDRgxOd1gtKo8lLvJ2ojiKbdgOSVHA2lk7sOybufjraHYnyyOk12cpXqCsC5+E
	8vH/bVeQw==
X-Received: by 2002:ac2:54a3:0:b0:5aa:7880:5246 with SMTP id 2adb3069b0e04-5ad427a8fc5mr574471e87.31.1781590716631;
        Mon, 15 Jun 2026 23:18:36 -0700 (PDT)
Received: from [192.168.3.148] ([31.23.24.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad4090e632sm611496e87.8.2026.06.15.23.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:18:36 -0700 (PDT)
Message-ID: <87ee43f4be0098fe843a70702c41f405b7580755.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfs: avoid deadlock in hfs_mdb_commit()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yue Sun <samsun1006219@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 23:18:33 -0700
In-Reply-To: <20260613054702.54437-1-samsun1006219@gmail.com>
References: <20260529103428.99099-1-samsun1006219@gmail.com>
	 <20260613054702.54437-1-samsun1006219@gmail.com>
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

On Sat, 2026-06-13 at 13:47 +0800, Yue Sun wrote:
> From: Sam Sun <samsun1006219@gmail.com>
>=20
> hfs_mdb_commit() currently uses the primary MDB buffer lock as a
> broad
> commit lock. It keeps HFS_SB(sb)->mdb_bh locked while it may also
> write
> the alternate MDB and the volume bitmap.
>=20
> This can deadlock. A corrupted image can set drVBMSt so that the
> bitmap
> block maps to the same buffer_head as the primary MDB. The bitmap
> writeback path then calls lock_buffer() on the same buffer_head while
> mdb_bh is already locked by hfs_mdb_commit(). A similar locking
> problem
> can also happen on valid images when hfs_mdb_commit() performs I/O
> while
> mdb_bh remains locked.
>=20
> Do not use mdb_bh as the HFS commit serialization lock. Add an HFS-
> level
> mdb_lock and take it around hfs_mdb_commit() callers. Then keep
> mdb_bh
> locked only while updating the primary MDB buffer and marking it
> dirty.
>=20
> The catalog/extents fork records and sizes are fields in the primary
> MDB,
> so update them in the primary MDB write section, not in the alternate
> MDB
> section. The alternate MDB sync and bitmap writeback then run after
> mdb_bh has been unlocked.
>=20
> HFS_FLG_ALT_MDB_DIRTY is set together with HFS_FLG_MDB_DIRTY when the
> catalog or extents overflow files grow, so the primary MDB fork
> records
> are refreshed before the alternate MDB copies the primary MDB
> contents.
>=20
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes:
> https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=3Duj-rLO=3D+yMyudw=
PguJ8Kd3jA@mail.gmail.com/
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: Sam Sun <samsun1006219@gmail.com>
> ---
> Changes in v3:
> - Follow Viacheslav's suggestion to move hfs_inode_write_fork() into
> =C2=A0 the primary MDB write section.
> - Rework the fix as MDB commit locking instead of corrupted-layout
> =C2=A0 validation.
> - Add mdb_lock to serialize HFS MDB commits.
> - Keep mdb_bh locked only while updating the primary MDB buffer.
> - Leave alternate MDB sync and bitmap writeback outside the mdb_bh
> lock.
>=20
> Changes in v2:
> - Added a commit-time guard before locking volume bitmap
> buffer_heads.
> - Replaced the v1 bitmap byte-range check with a simple drVBMSt
> check.
> - Reused the existing bitmap writeback size calculation.
>=20
> v1:
> - Initial mount-time check rejecting volume bitmap/MDB aliasing.
>=20
> =C2=A0fs/hfs/hfs_fs.h |=C2=A0 1 +
> =C2=A0fs/hfs/mdb.c=C2=A0=C2=A0=C2=A0 | 15 ++++++++-------
> =C2=A0fs/hfs/super.c=C2=A0 |=C2=A0 9 +++++++++
> =C2=A03 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index ac0e83f77a0f..00651f42ba38 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -66,6 +66,7 @@ struct hfs_inode_info {
> =C2=A0 * The HFS-specific part of a Linux (struct super_block)
> =C2=A0 */
> =C2=A0struct hfs_sb_info {
> +	struct mutex mdb_lock;			/* MDB operations
> lock */
> =C2=A0	struct buffer_head *mdb_bh;		/* The hfs_buffer
> =C2=A0						=C2=A0=C2=A0 holding the real
> =C2=A0						=C2=A0=C2=A0 superblock (aka
> VIB
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index a97cea35ca2e..c2f4bda6fd00 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -291,8 +291,9 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0	if (sb_rdonly(sb))
> =C2=A0		return;
> =C2=A0
> -	lock_buffer(HFS_SB(sb)->mdb_bh);
> =C2=A0	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)-
> >flags)) {
> +		lock_buffer(HFS_SB(sb)->mdb_bh);
> +
> =C2=A0		/* These parameters may have been modified, so write
> them back */
> =C2=A0		mdb->drLsMod =3D hfs_mtime();
> =C2=A0		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> >free_ablocks);
> @@ -305,8 +306,14 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0		mdb->drDirCnt =3D
> =C2=A0			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >folder_count));
> =C2=A0
> +		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> mdb->drXTExtRec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> +		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> mdb->drCTExtRec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
> +
> =C2=A0		/* write MDB to disk */
> =C2=A0		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> +		unlock_buffer(HFS_SB(sb)->mdb_bh);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* write the backup MDB, not returning until it is written.
> @@ -314,11 +321,6 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0	 * files grow. */
> =C2=A0	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)-
> >flags) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 HFS_SB(sb)->alt_mdb) {
> -		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> mdb->drXTExtRec,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> -		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> mdb->drCTExtRec,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
> -
> =C2=A0		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
> =C2=A0		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb,
> HFS_SECTOR_SIZE);
> =C2=A0		HFS_SB(sb)->alt_mdb->drAtrb |=3D
> cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
> @@ -360,7 +362,6 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0			size -=3D len;
> =C2=A0		}
> =C2=A0	}
> -	unlock_buffer(HFS_SB(sb)->mdb_bh);
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_mdb_close(struct super_block *sb)
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a4f2a2bfa6d3..06ab904b3a42 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
> =C2=A0static int hfs_sync_fs(struct super_block *sb, int wait)
> =C2=A0{
> =C2=A0	is_hfs_cnid_counts_valid(sb);

I think that is_hfs_cnid_counts_valid() is better to check under lock.

> +
> +	mutex_lock(&HFS_SB(sb)->mdb_lock);
> =C2=A0	hfs_mdb_commit(sb);
> +	mutex_unlock(&HFS_SB(sb)->mdb_lock);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
> =C2=A0
> =C2=A0	is_hfs_cnid_counts_valid(sb);
> =C2=A0
> +	mutex_lock(&sbi->mdb_lock);
> =C2=A0	hfs_mdb_commit(sb);
> +	mutex_unlock(&sbi->mdb_lock);
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_mark_mdb_dirty(struct super_block *sb)
> @@ -339,9 +345,12 @@ static int hfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_op =3D &hfs_super_operations;
> =C2=A0	sb->s_xattr =3D hfs_xattr_handlers;
> =C2=A0	sb->s_flags |=3D SB_NODIRATIME;
> +	mutex_init(&sbi->mdb_lock);
> =C2=A0	mutex_init(&sbi->bitmap_lock);
> =C2=A0
> +	mutex_lock(&sbi->mdb_lock);
> =C2=A0	res =3D hfs_mdb_get(sb);
> +	mutex_unlock(&sbi->mdb_lock);
> =C2=A0	if (res) {
> =C2=A0		if (!silent)
> =C2=A0			pr_warn("can't find a HFS filesystem on dev
> %s\n",

I think we cannot completely eliminate the potential deadlock or race
condition until introduction of copy of MDB record in memory but not
accessing it in buffer head. Because, hfs_mdb_commit() uses the primary
MDB record's values during alternative MDB record and volume bitmap
processing. The fix looks much cleaner now. But we need to add more
functionality if we really would like to eliminate the issue.

Thanks,
Slava.
