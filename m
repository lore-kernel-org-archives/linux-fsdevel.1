Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A536C5BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097012; cv=none; b=Jh6H39wHRhgOcGO2q+gMbaxHEXxQgP2jj1sbFgK9HcVWQSTqRjLUyhI7sMcsZtJIwZ+cGthpsCx2ScnLsKogonYQK9IUn1itohEWiBBTR3e2kUY4Q3Vm4hZUosv5vNhyj0ihH5fCIV2ECGvPO3FeKIy6At6O/16d6/Av70HdWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097012; c=relaxed/simple;
	bh=XkXt5xvWbeRkGH7vkAfiINhBts1WmxKb9QgFAuL7S/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nK/Lbdoc34H7vgD0o98ECIRVq29fPl+Q/fh1Aipcm+lgnbnf9ag7qVKiVT13EM12SZGGQktXlcPl59iLMUPcSQowIMttDQXdZY7+m+MlsXLYzvOFYxyuDIPHsD4rxAsp6ROrOUz0PhFguX53cw9Ez0yLtMzz3NWN67xT5+zqH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5dC71IW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rdcG3MUo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5dC71IW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rdcG3MUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780097008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN/GG/B80cTeN/1dBywgE/jxTvXiCfeDsRJwHlMLSwI=;
	b=O5dC71IWzsrJnrtbXya9SziJVk/2R6hbD3OH6xKK3ktTrM4TNiPPrY9B44KtDHpUjQ09Om
	74FjuSyOP3jQb3szf4heGslWURNta24hvSZ9dF6JWkM4k6gdQZRAetnFMbkpMIW17s0Z1a
	4C6KF0bWKnlcMqj3XVfC5FBQ+zXyH2A=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-WROIskwjMMOdbexbqbWIsQ-1; Fri, 29 May 2026 19:23:27 -0400
X-MC-Unique: WROIskwjMMOdbexbqbWIsQ-1
X-Mimecast-MFC-AGG-ID: WROIskwjMMOdbexbqbWIsQ_1780097006
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69df9b0b773so2685384eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780097006; x=1780701806; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MN/GG/B80cTeN/1dBywgE/jxTvXiCfeDsRJwHlMLSwI=;
        b=rdcG3MUonti+0sllbgFya4EGwzXmDBLyeiizGXTGlhexgUfcanfHn0lNYa2rhJVz5n
         gi55vUFn4R57XToVRIm5Vgp9FtwOp1f9eo+dwpHK787Xdf9qEHzAFRJhRA/U2wKh77tO
         /EKBiN/RNsqH9O8CHeRcJviXvLCGpR2KUoTDo1ldT5lsSjK4ogEySdNXyfl33Yn6H8f2
         SLfytipB25R29911FE78EdQxUF21f9JeLZe+Bmh/P2sVNb4050nFCpM1Xu+QiMKKmq+v
         rozruVdWyOyZJ1byPc18EzQI5zzBMohYmt44BObf9x3VhT0QuM4LS06bGtgyLlvLXZvh
         zF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780097006; x=1780701806;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MN/GG/B80cTeN/1dBywgE/jxTvXiCfeDsRJwHlMLSwI=;
        b=d9lSrXtlhZkvGQT0E9NqEdsL6OQHkq/Wg8NrxM1VvvQ5u+BDwpIQ2q7G8AYOMMAOPf
         nQG1/X7aJAPLCiKyomTSs1mV562h9+bffD7G9XwGjuPV+grUQKBHd5D/DEg7O3sGN+13
         CLFXR2erV4oluAkN5ehUscYhbhCxFglc2oLuKsmJgL4zpzQpfDfWxus8UcqtMGBRmMuC
         5mh9dgszZdxf92uboNTEEH3V1/jgKzASNWrtVsHJBu3yAyMlrOUXuLikots6rjvT3Bx1
         p+WRyf1/s/d3Ivwk+HLZ9MMfayTiunnV5y1/qJZpF/Y7CYnnzHECv5oL6lGk5BpMKc2B
         is+Q==
X-Gm-Message-State: AOJu0Yy/jhNADPIC08NgRaH4m5knl2UM2VKXyrZ5m+nc08hkV3WuxII3
	AtP6UhDSK5CK55M2vzEr50j1dNdS4BidxYpYdOfjg3MFz/sXMoEW1gfF4w6qN98HTljyc3eLrbK
	pxnjKplgKiLI6AicE4YZJuOm4FPsqRY9ijwrCccD6m/AgzJqisLk/8eXn29vB1pgTROI=
X-Gm-Gg: Acq92OF+WTZFsGdzHmTHuMlJdpv/EwLr2j3lCseFnDNlld5LzPwnmofmktGiOc2gc2G
	fqyR3N5M8eInXLuDToRFl/8uCAUfM+6diHvX6+e/xnzvag4Vx53ik/pWmGT6lK4rETEdNt1buvM
	1Ydi/rriH8Iqq72hxdmNwBbzHgwX75006iAeDIt5u5a0jkD3SkceoJyhoGCyoALr6V70cVfWLeV
	eYAxOeag/LIhay/Q2YRPUf2HVwLK4ugkzXqGEM1R0edP07DTd2HeBYPTf1grYfhPNyD1q5zM87q
	oGglDQCb3IKKL+xnIwIR7XxAm4BilE4TjdiU8v1ySkYWR72du+GKg+tUGQOvFaldfJMMh6AE3Bt
	kp9ECw44o8L/bPpYzCKw+MtP1AvZgAEdGVaGRktJ3cxt1C5rXbF4CBjVWcmrk1jc=
X-Received: by 2002:a05:6820:2d0b:b0:696:7f3d:a75d with SMTP id 006d021491bc7-69e0ff718femr666154eaf.27.1780097006433;
        Fri, 29 May 2026 16:23:26 -0700 (PDT)
X-Received: by 2002:a05:6820:2d0b:b0:696:7f3d:a75d with SMTP id 006d021491bc7-69e0ff718femr666149eaf.27.1780097005982;
        Fri, 29 May 2026 16:23:25 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93a22989sm1979271fac.1.2026.05.29.16.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:23:25 -0700 (PDT)
Message-ID: <1924119775624adb4ce3fd7f3d936eaa2fea3c16.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2] hfs: prevent MDB and bitmap
 buffer_head aliasing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Yue Sun <samsun1006219@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 May 2026 16:23:24 -0700
In-Reply-To: <09c2bf1e91f7ddabc24240379cd7dd0b4e15dd8d.camel@redhat.com>
References: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
		 <20260529103428.99099-1-samsun1006219@gmail.com>
	 <09c2bf1e91f7ddabc24240379cd7dd0b4e15dd8d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 14:29 -0700, Viacheslav Dubeyko wrote:
> On Fri, 2026-05-29 at 18:34 +0800, Yue Sun wrote:
> > hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)->mdb_bh is
> > locked. A crafted image can set drVBMSt so that the bitmap block resolv=
es
> > to the same buffer_head as the MDB. When writeback later calls
> > lock_buffer() for that bitmap block, the task tries to lock mdb_bh agai=
n
> > and self-deadlocks in __lock_buffer().
> >=20
> > Reject images whose volume bitmap starts at or before the MDB during
> > mount. Also guard the bitmap writeback path itself: if the bitmap block
> > would resolve to mdb_bh, force the filesystem read-only and stop bitmap
> > writeback before taking the buffer lock. This keeps the deadlock fix in
> > the MDB commit path and reuses the existing bitmap size/writeback logic=
.
> >=20
> > Reported-by: Yue Sun <samsun1006219@gmail.com>
> > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.ker=
nel.org_all_CAEkJfYMB47v1yOWHB8q2dc8kf-3Duj-2DrLO-3D-2ByMyudwPguJ8Kd3jA-40m=
ail.gmail.com_&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_R=
GmnQ2fMWKq4Y4RAkElvUgSs00&m=3D2ATrdgpvRdYnJfz2T53Ih3iQv6Y9wogU2Ba19prTYgchh=
1mh4KI7lo9TYLQnlu3X&s=3DS8XdWVW0SpxB05CfctrqCJtJEXqtWDfLNdtzPHIZAY8&e=3D=
=20
> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > ---
> > Changes in v2:
> > - Add a commit-time guard before locking bitmap buffer_heads.
> > - Replace the mount-time byte-range check with a simple drVBMSt check.
> > - Reuse the existing bitmap writeback size calculation.
> >=20
> >  fs/hfs/mdb.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > index a97cea35ca2e..53cd137892b5 100644
> > --- a/fs/hfs/mdb.c
> > +++ b/fs/hfs/mdb.c
> > @@ -185,6 +185,11 @@ int hfs_mdb_get(struct super_block *sb)
> >  		sb->s_flags |=3D SB_RDONLY;
> >  	}
> > =20
> > +	if (be16_to_cpu(mdb->drVBMSt) <=3D HFS_MDB_BLK) {
>=20
> Technically speaking, if we are trying to check the overlapping of volume=
 bitmap
> with the main MDB record, then we need to check the overlapping with alte=
rnative
> MDB record, and with Catalog File and Extents Overflow File. However, it =
sounds
> like we are trying to add some FSCK logic here. :)
>=20
> > +		pr_err("volume bitmap overlaps MDB\n");
>=20
> This situation means volume corruption. It makes sense to recommend to ru=
n FSCK.
>=20
> > +		return -EIO;
>=20
> This code error is wrong because the read operation was OK. But we have
> corrupted volume. Even if we have overlapping of volume bitmap with MDB r=
ecord,
> then we cannot reject mount operation. We must mount in READ-ONLY mode be=
cause,
> potentially, the rest of metadata could be completely OK. We simply canno=
t mount
> in RW mode.
>=20
> > +	}
> > +
> >  	/* TRY to get the alternate (backup) MDB. */
> >  	sect =3D part_start + part_size - 2;
> >  	bh =3D sb_bread512(sb, sect, mdb2);
> > @@ -341,6 +346,11 @@ void hfs_mdb_commit(struct super_block *sb)
> >  		size =3D (HFS_SB(sb)->fs_ablocks + 7) / 8;
> >  		ptr =3D (u8 *)HFS_SB(sb)->bitmap;
> >  		while (size) {
> > +			if (unlikely(block =3D=3D HFS_SB(sb)->mdb_bh->b_blocknr)) {
> > +				pr_err("volume bitmap overlaps MDB, forcing read-only\n");
> > +				sb->s_flags |=3D SB_RDONLY;
> > +				break;
> > +			}
>=20
> At this point, we already wrote main MDB and alternative MDB to the volum=
e.
> Theoretically, it is possible to imagine that if size of volume bitmap is=
 big
> enough, then we could partially process the bitmap too. Probably, we need=
 to
> check the overlapping at the beginning of the method and reject the whole
> superblock commit.
>=20
> Initial issue was the deadlock. Could we implement some check that buffer=
_heads
> don't overlap before trying to lock? Does it make sense to you?
>=20

By the way, I can see the deadlock in hfs_mdb_commit() even for completely =
valid
HFS volume during generic/013 test run. This issue takes place because foli=
o
lock related issue. I remember that somebody has sent the patch related to =
this
issue but we haven't finished the discussion with some reasonable solution.=
 I
think we need to rework the locking scheme:

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 97e8d1f96d6d..919798eda0f8 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -64,6 +64,7 @@ struct hfs_inode_info {
  * The HFS-specific part of a Linux (struct super_block)
  */
 struct hfs_sb_info {
+	struct mutex mdb_lock;			/* MDB operations lock */
 	struct buffer_head *mdb_bh;		/* The hfs_buffer
 						   holding the real
 						   superblock (aka VIB
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..94497c155d29 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -291,9 +291,9 @@ void hfs_mdb_commit(struct super_block *sb)
 	if (sb_rdonly(sb))
 		return;
=20
-	lock_buffer(HFS_SB(sb)->mdb_bh);
 	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
 		/* These parameters may have been modified, so write them back
*/
+		lock_buffer(HFS_SB(sb)->mdb_bh);
 		mdb->drLsMod =3D hfs_mtime();
 		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
 		mdb->drNxtCNID =3D
@@ -304,6 +304,7 @@ void hfs_mdb_commit(struct super_block *sb)
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
>file_count));
 		mdb->drDirCnt =3D
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
>folder_count));
+		unlock_buffer(HFS_SB(sb)->mdb_bh);
=20
 		/* write MDB to disk */
 		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
@@ -360,7 +361,6 @@ void hfs_mdb_commit(struct super_block *sb)
 			size -=3D len;
 		}
 	}
-	unlock_buffer(HFS_SB(sb)->mdb_bh);
 }
=20
 void hfs_mdb_close(struct super_block *sb)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a466c401f6bb..5d4caf3ddda6 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
 	is_hfs_cnid_counts_valid(sb);
+
+	mutex_lock(&HFS_SB(sb)->mdb_lock);
 	hfs_mdb_commit(sb);
+	mutex_unlock(&HFS_SB(sb)->mdb_lock);
+
 	return 0;
 }
=20
@@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
=20
 	is_hfs_cnid_counts_valid(sb);
=20
+	mutex_lock(&sbi->mdb_lock);
 	hfs_mdb_commit(sb);
+	mutex_unlock(&sbi->mdb_lock);
 }
=20
 void hfs_mark_mdb_dirty(struct super_block *sb)
@@ -339,9 +345,13 @@ static int hfs_fill_super(struct super_block *sb, stru=
ct
fs_context *fc)
 	sb->s_op =3D &hfs_super_operations;
 	sb->s_xattr =3D hfs_xattr_handlers;
 	sb->s_flags |=3D SB_NOATIME | SB_NODIRATIME;
+	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
=20
+	mutex_lock(&sbi->mdb_lock);
 	res =3D hfs_mdb_get(sb);
+	mutex_unlock(&sbi->mdb_lock);
+
 	if (res) {
 		if (!silent)
 			pr_warn("can't find a HFS filesystem on dev %s\n",

What do you think?

Thanks,
Slava.

