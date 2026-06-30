Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804643C06F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830661; cv=none; b=haRxx+583MyWegR7ubpw9vZ3jR3OnbmdZytrUx+2KqFlCGeuLLxF+DurcPYIa5XTxpSfAv2PfvbYs6tnTvSxvTVmtpvuz6i8N8mejvz7nkntjMVq+G7M3/jtcZz+FLXsAyes2OqvcABScymUVE2Gx9vDDGI47iyDJM0xn2AzEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830661; c=relaxed/simple;
	bh=XXz9zIlxLSQo0paP0etE8KuL1q6rijNhQ63/Xuy55ZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+iqm+F23WGIy+uw1iLUuIKDWfmT0g2lO4Ex4jvx+n/ncPt2u4YkTXcOdfUzg5uMae86lqYZir1PlCzxmZdUv3xK9/faMfFGsxs7tIgcdHzAQAhvHlcMLL3fzgop7JAnW61DeWbpOxgGakH0K9x67Y896YUecJZDiQntkcHgyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=heCHQFFB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="heCHQFFB"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80bb578d58bso41163587b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782830659; x=1783435459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fbYdcKvuEZ/LzI7dRcuhRizhiFPHz8tZa6tHHK273sE=;
        b=heCHQFFBsMoGB2GXi6w5cBaCS9tGcu3vQg93iBikaEBbXhx1iPPxpVLVtPWgS+rANZ
         sNEafFSrQs6/ndPdCilWmhJFmD4/U8+fWXzPuy5GGbzQKE4mwPMVmoaHTxX6P1mjiIjk
         BlHr6YFWJZpB9rZ/3gohy8eySxTIXIg5Evv087yEm70K8q8/jDfPsVNpI5M832zAgI0F
         Pebs8BpQMgWo8th3cbjMcmly+cLbQ0/j3M6TPAig5Stwv9EZ3oTUrSgvgIQ2mvsjO4Bi
         CIemsT/SXcQAUhZrWX9zQu1V2+ace3uSmpQ07h3qzzMxJSVeLZuW4UAshcl5IwMsAqhb
         g7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830659; x=1783435459;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbYdcKvuEZ/LzI7dRcuhRizhiFPHz8tZa6tHHK273sE=;
        b=hkuCKolQQ3KSoUmBo+NdH3KrIDvJv6irROde2LGOZvk0SXP56850vNrpblgd6SbkXS
         X4wiWaC7DVwGw138SYKKjJahwNX8m6Z7HK6lVRM5kBz5PP5i5e6oiyspt4dToGw43eJq
         n5aJMA4r0dSmX5cdBW60Znpwv81UqceQMc6cSx4am7MO3mR4LNUsQOdbhSiW9GLh6l5r
         MPgVugyYe559JnPQlYh/+j5JcK7IuPwEFxrHP3Gxd4DBVmBenuZ8/dc8wcNZsFVk/83g
         0qOADiAiiKJThVL5zxUWnr8frcYi7c3aMFBAnJraFDKt2dXQnrwfTCM0GeuDCjWLr+MX
         lHJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMPwdu90CvUYjj6iJAPrIH+gep8kl01j6aZy189MXDpP43LL3I3tIxN97BPBAoSUZXfURziJENBmHH3qp0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nsQRfv3ZlWsLwionmWPD6wD4PGnhjKriU0mej8AajxfFKFaI
	LsAVeZ40CbCYUw5bbjdfjiaYHuYoAxCJ1QX54yJ1eGPp5VzZLBRkccElUdSuYyUialQ=
X-Gm-Gg: AfdE7ckJ+XxEi0gGB4kOm82HJjyA4x2j3k1cHZnC1NwDkMWpOAY77EApaOPvrvhyRoA
	wXuE3TOtoZ7eawdJHE4CL81F4aoe5eTCnMjtqp87c9n4DCFgYZ5K89Kh21+1vp3k6us6fve7gxY
	toL+ldsuCLuA7P64qRdEKSVhnJmnLKgGsVc9xyXIh3cWKxS6hrYTiVBwYDCWL20BNARh27mRBOU
	8jIitCqqBFuIaGjeaPDjys7UK8h3trEYXZUL9GHfGEoqa4kblxMuQHfLZzwjbSPHmq+tXWavtTP
	mndZWSZICizx7YoiIBdGG5iEmUQwk5rnS41GJuJBsPtH82nm4pVXOTtlJzM8UCi8o1FVfGJTJVb
	GwZYsTsR1NlzPStj0oquX9jofelMeimkVpGz6Za0puBqH8zs6IYgPFoZ4GJEEgQSkYjnvT1Dup1
	pI9zVXbHsKWRGIWWyhRWROU0zlX698k87DIMOMHM9eLPSNadCXdCEoItg2npT/j5t04ox3jhkSI
	LiWQY2PW75Sj1m64SmuQRSh3sO7RhoSR2MrftWovg6rnFJqI442c76H7XvIL796dYCls4VTK5Sc
	+QUPHEM=
X-Received: by 2002:a05:690c:7341:b0:80c:cad:c4e4 with SMTP id 00721157ae682-810d89e8be1mr41270987b3.28.1782830658424;
        Tue, 30 Jun 2026 07:44:18 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e7a722ddsm11617317b3.18.2026.06.30.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:44:17 -0700 (PDT)
Message-ID: <f43b31b0e988e06b724dcd9f2c1278d58c2ec6f9.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: validate corrupt catalog and btree metadata
 before hfs_write_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Tue, 30 Jun 2026 07:44:16 -0700
In-Reply-To: <20260624135412.7208-1-davemadmaxxx@gmail.com>
References: <20260624135412.7208-1-davemadmaxxx@gmail.com>
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

On Wed, 2026-06-24 at 13:54 +0000, David Maximiliano Hermitte wrote:
> Hello Slava, Jori, all,
>=20
> I am following up with a refined test patch for the same HFS syzbot
> reproducer.
>=20
> This variant does not change hfs_write_inode(), hfs_test_inode(), or
> the BUG() site. It rejects corrupted catalog/B-tree metadata earlier:
>=20
> - hfs_brec_read(): rejects invalid entry offset/length, caches
> node_size locally, and uses overflow-safe bounds arithmetic.
> - hfs_read_inode(): rejects invalid file/directory CNIDs before
> writeback.
>=20
> Local validation on commit 840ef6c78e6a:
>=20
> - git diff --check: pass
> - checkpatch.pl --strict: 0 errors, 0 warnings
> - make -j2 fs/hfs/: pass
> - bzImage built
> - QEMU/TCG with the same public syzbot ReproC:
> =C2=A0 - BEFORE: repro_started=3Dtrue, kernel_bug_seen=3Dtrue
> =C2=A0 - AFTER: repro_started=3Dtrue, repro_done=3Dtrue,
> kernel_bug_seen=3Dfalse, hfs_write_inode_seen=3Dfalse, kasan_seen=3Dfalse=
,
> oops_seen=3Dfalse
> =C2=A0 - verdict=3DREPRO_RAN_NO_BUG_SEEN
>=20
> I have prepared this refined variant because the hfs_brec_read()
> bounds check now validates entryoffset before computing node_size -
> entryoffset, caches node_size locally, and rejects entryoffset >=3D
> node_size explicitly. I am including it inline because it avoids
> potential integer overflow in the bounds check while preserving the
> same QEMU validation result.
>=20
> I am sending it as a test patch / direction check, not as a final
> maintainer-ready fix. The point is that validating corrupt catalog/B-
> tree metadata before hfs_write_inode() prevents this reproducer from
> reaching the BUG() endpoint.
>=20
> I would appreciate your opinion on whether this placement/direction
> is closer to the expected HFS fix.
>=20
> Best regards,
> David
>=20
> Patch follows:
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index d56e47bdc517..e48a7110e342 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -170,12 +170,20 @@ int hfs_brec_find(struct hfs_find_data *fd)
> =C2=A0int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
> =C2=A0{
> =C2=A0	int res;
> +	u32 node_size;
> =C2=A0
> =C2=A0	res =3D hfs_brec_find(fd);
> =C2=A0	if (res)
> =C2=A0		return res;
> +	node_size =3D fd->bnode->tree->node_size;

These multiple dereferences make me really nervous. As some pointer
potentially could be NULL as node_size could be not valid.

> +	if (fd->entryoffset < 0 || fd->entrylength <=3D 0)
> +		return -EFSCORRUPTED;
> +	if (fd->entryoffset >=3D node_size)
> +		return -EFSCORRUPTED;
> +	if (fd->entrylength > node_size - fd->entryoffset)
> +		return -EFSCORRUPTED;
> =C2=A0	if (fd->entrylength > rec_len)
> -		return -EINVAL;
> +		return -EFSCORRUPTED;

These values are not records from the volume. So, these values could be
wrong because of file system logic bugs but because the volume is
corrupted. And, frankly speaking, I don't see connection between the
issue that you are trying to solve and these checks.

> =C2=A0	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd-
> >entrylength);
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index ac4a9055c5c0..7283b9541064 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -367,6 +367,9 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	rec =3D idata->rec;
> =C2=A0	switch (rec->type) {
> =C2=A0	case HFS_CDR_FIL:
> +		/* Reject corrupted user file CNIDs before
> writeback. */
> +		if (be32_to_cpu(rec->file.FlNum) <
> HFS_FIRSTUSER_CNID)
> +			return -EFSCORRUPTED;

Please, see my explanation below.

> =C2=A0		if (!HFS_IS_RSRC(inode)) {
> =C2=A0			hfs_inode_read_fork(inode, rec->file.ExtRec,
> rec->file.LgLen,
> =C2=A0					=C2=A0=C2=A0=C2=A0 rec->file.PyLen,
> be16_to_cpu(rec->file.ClpSize));
> @@ -390,6 +393,10 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0		inode->i_mapping->a_ops =3D &hfs_aops;
> =C2=A0		break;
> =C2=A0	case HFS_CDR_DIR:
> +		/* Only the root directory may use a reserved CNID
> here. */
> +		if (be32_to_cpu(rec->dir.DirID) < HFS_FIRSTUSER_CNID
> &&
> +		=C2=A0=C2=A0=C2=A0 be32_to_cpu(rec->dir.DirID) !=3D HFS_ROOT_CNID)
> +			return -EFSCORRUPTED;

Please, see my explanation below.

> =C2=A0		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> =C2=A0		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> =C2=A0		HFS_I(inode)->fs_blocks =3D 0;

If we have corrupted Catalog File, then, the root folder record could
be corrupted too. So, first of all, we need to manage this case in
hfs_fill_super() [1]. If something is going wrong, then hfs_iget() can
return bad inode [2,3] or NULL [4]. So, hfs_fill_super() shoudl be
ready to manage this situation and it should not mount volume with
corrupted root folder.

Also, we need to check the CNID validity:

+/*
+ * is_valid_cnid
+ *
+ * Validate the CNID of a catalog record
+ */
+static inline
+bool is_valid_cnid(u32 cnid, u8 type)
+{
+	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
+		return true;
+
+	switch (cnid) {
+	case HFS_ROOT_CNID:
+		return type =3D=3D HFS_CDR_DIR;
+	case HFS_EXT_CNID:
+	case HFS_CAT_CNID:
+		return type =3D=3D HFS_CDR_FIL;
+	case HFS_POR_CNID:
+		/* No valid record with this CNID */
+		break;
+	case HFS_BAD_CNID:
+	case HFS_EXCH_CNID:
+		/* Not implemented */
+		break;
+	default:
+		/* Invalid reserved CNID */
+		break;
+	}
+
+	return false;
+}

And hfs_read_inode() should execute this check:

 /*
  * hfs_read_inode
  */
@@ -350,6 +382,8 @@ static int hfs_read_inode(struct inode *inode, void
*data)
 	rec =3D idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (!is_valid_cnid(rec->file.FlNum, HFS_CDR_FIL))
+			goto make_bad_inode;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec,
rec->file.LgLen,
 					    rec->file.PyLen,
be16_to_cpu(rec->file.ClpSize));
@@ -371,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, void
*data)
 		inode->i_mapping->a_ops =3D &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (!is_valid_cnid(rec->dir.DirID, HFS_CDR_DIR))
+			goto make_bad_inode;
 		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
 		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks =3D 0;
@@ -380,8 +416,12 @@ static int hfs_read_inode(struct inode *inode,
void *data)
 		inode->i_op =3D &hfs_dir_inode_operations;
 		inode->i_fop =3D &hfs_dir_operations;
 		break;
+	make_bad_inode:
+		pr_warn("rejected cnid %lu. Volume is probably
corrupted, try performing fsck.\n", inode->i_ino);
+		fallthrough;
 	default:
 		make_bad_inode(inode);
+		break;
 	}
 	return 0;
 }

Potentially, hfs_write_inode() could employ this check too:

@@ -441,20 +481,19 @@ int hfs_write_inode(struct inode *inode, struct
writeback_control *wbc)
 	if (res)
 		return res;
=20
-	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
-		switch (inode->i_ino) {
-		case HFS_ROOT_CNID:
-			break;
-		case HFS_EXT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)-
>ext_tree);
-			return 0;
-		case HFS_CAT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)-
>cat_tree);
-			return 0;
-		default:
-			BUG();
-			return -EIO;
-		}
+	if (!is_valid_cnid(inode->i_ino,
+			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR :
HFS_CDR_FIL))
+		BUG();
+
+	switch (inode->i_ino) {
+	case HFS_EXT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
+		return 0;
+	case HFS_CAT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
+		return 0;
+	default:
+		break;
 	}

The most tricky part is to check the CNID in file or folder record.
File and folder records always have a key that contains a non-empty
nodeName. The key for a thread record is the file's or folder's CNID
(not the CNID of the parent folder) and an empty (zero length)
nodeName. This allows a file or folder to by found using just the CNID.
The thread record contains the parentID and nodeName field of the file
or folder itself. Finding a file or folder by its CNID is a two-step
process. The first step is to use the CNID to look up the thread record
for the file or folder. This yields the file or folder's parent folder
ID and name. The second step is to use that information to look up the
real file or folder record.

So, the key of thread record could contain the valid CNID but the found
file or folder record could contain corrupted CNID value. So, my vision
is that hfs_cat_find_brec() needs to check that found record contains
valid CNID value.

Thanks,
Slava.=20

[1] https://elixir.bootlin.com/linux/v7.1/source/fs/hfs/super.c#L370
[2] https://elixir.bootlin.com/linux/v7.1/source/fs/hfs/inode.c#L433
[3] https://elixir.bootlin.com/linux/v7.1/source/fs/hfs/inode.c#L403
[4] https://elixir.bootlin.com/linux/v7.1/source/fs/hfs/inode.c#L431


