Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407D386450;
	Sat,  1 Aug 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624994; cv=pass; b=Fhhy4mmuR7N6vupajkVhy+2Du8J+X//VcWZUZ35sZRpwse1kKWWc4GXkIHVUzFDtGp4YJNVpZqeBUXta9/K1GUxsbfpKVAbIuM/eGG9LIaeLq2drEb3B245ByR6g/pmYvtTV05TdAeRymjgAej+hRFVF9C4q14+txtRP6WQ7Au8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624994; c=relaxed/simple;
	bh=/NoyGdJ9moH/axh6d3ycP6BhBtVeLPCfJmdyuh5IoXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnIhbid+vZS2qv2BLZWcsX7dhm19uM+G6t2YnGn9usxONCUJEqu8PVgrnERw2xwq5kkhtrkvr/844LEqfTzIU0coP3MckB+YId8eL49uZ72tEC+wz74IBXjLSq4jMZJ6OzyLBOgoXHHT4lFvQvLR925A2Ar77tlkG6i9mKTabG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=qFEpNcFx; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="qFEpNcFx"
ARC-Seal: i=1; a=rsa-sha256; t=1785624968; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HFPkMPVzyfalcf6x7As5reKcu9PwOhCHf3RSg1W2ctprKtX4wChU9HD73MKvEUPbukCVbmXQaQeUPzYCEwBBCe8ue0scOGKZTLF6b54+Dt4oZr/l7oPg0vdBrsvkr3DMCsKKgbbOwJ+0iXQNtbe4J1fMInrA6d2465YC1GR1qks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624968; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ko2TnwIe3lyl7C9oAsBcfzPhCKT0Je6i14RhDjnEQXI=; 
	b=GCHlbWzZ4eYg3ELqb6lWUxwOiDv+UkBP9uHNpAdtmfzqyu6PK+iHQdCOO0/xR7iohpzvJhmKYhVBVvDbAJJ6BHtot0saK1b9oi61KWwmsdw/DmlRUHtAJomXuRliL6Lt/O1g2e9dls45Z266ZU5j5PLqbmBClLq4an2vmVUExoE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624968;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ko2TnwIe3lyl7C9oAsBcfzPhCKT0Je6i14RhDjnEQXI=;
	b=qFEpNcFxg+zeDWbW04F8H8F5VkaYgQXbKy5YhdFCshV0Nqdu5ZChBFbDebWKyBik
	jBx+BGDjqwxeSyP5mEyMTd0khpDkeXo5dKXzjz8VaYOsnwJnQJhF68iJQ4/G/OMVvyv
	T7kenweyWhsAadGYCeQ70KfvinSYuv1LOq/ryETw=
Received: by mx.zoho.eu with SMTPS id 1785624965764458.8001401329035;
	Sun, 2 Aug 2026 00:56:05 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ufs: name the modern UFS2 superblock fields
Date: Sat,  1 Aug 2026 22:55:21 +0000
Message-ID: <20260801225530.148386-2-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The 4.4BSD derived superblock that UFS2 uses has grown a number of
fields since Linux last looked at it. All of them currently sit inside
fs_44.fs_sparecon[50], so nothing in fs/ufs can tell that a filesystem
uses snapshots, soft updates journalling or metadata check hashes.

Split fs_sparecon[] into the fields FreeBSD defines, counting from
fs_pendinginodes: fs_snapinum[20], fs_avgfilesize, fs_avgfpdir,
fs_available_spare, fs_mtime, fs_sujfree, 21 remaining spare words,
fs_ckhash, fs_metackhash and the 32 bit fs_flags, followed by the
already named fs_contigsumsize. That is exactly 50 words, so the layout
does not change; sizeof(struct ufs_super_block_third) stays 356 and
fs_contigsumsize stays at offset 292.

The 8 bit fs_flags next to fs_clean is a different field, FreeBSD's
fs_old_flags. Rename it accordingly so the two cannot be confused. It
has no users.

Add the UFS_FS_* values for the 32 bit fs_flags and UFS_FSMAXSNAP.
No functional change; later patches use these.

Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/ufs_fs.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index b8dc354ae90f..32925c356fa2 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -154,6 +154,26 @@ typedef __u16 __bitwise __fs16;
 #define UFS_FSLOG     ((__s8)0xfd)	/* logging fs */
 #define UFS_FSFIX     ((__s8)0xfc)	/* being repaired while mounted */
 
+/* maximum number of snapshots recorded in fs_snapinum */
+#define UFS_FSMAXSNAP 20
+
+/*
+ * Values for the 32 bit fs_flags of the modern (4.4BSD derived) superblock.
+ * Not to be confused with the historic 8 bit fs_old_flags.
+ */
+#define UFS_FS_UNCLEAN		0x00000001
+#define UFS_FS_DOSOFTDEP	0x00000002
+#define UFS_FS_NEEDSFSCK	0x00000004
+#define UFS_FS_SUJ		0x00000008
+#define UFS_FS_ACLS		0x00000010
+#define UFS_FS_MULTILABEL	0x00000020
+#define UFS_FS_GJOURNAL		0x00000040
+#define UFS_FS_FLAGS_UPDATED	0x00000080
+#define UFS_FS_NFS4ACLS		0x00000100
+#define UFS_FS_METACKHASH	0x00000200
+#define UFS_FS_TRIM		0x00000400
+#define UFS_FS_INDEXDIRS	0x01000000
+
 /* From here to next blank line, s_flags for ufs_sb_info */
 /* directory entry encoding */
 #define UFS_DE_MASK		0x00000010	/* mask for the following */
@@ -865,7 +885,7 @@ struct ufs_super_block_first {
 	__s8	fs_fmod;
 	__s8	fs_clean;
 	__s8	fs_ronly;
-	__s8	fs_flags;
+	__s8	fs_old_flags;
 	__s8	fs_fsmnt[UFS_MAXMNTLEN - 212];
 
 };
@@ -937,7 +957,16 @@ struct ufs_super_block_third {
 			__fs32	fs_qfmask[2];	/* ~usb_fmask */
 		} fs_sunx86;
 		struct {
-			__fs32	fs_sparecon[50];/* reserved for future constants */
+			__fs32	fs_snapinum[UFS_FSMAXSNAP];/* snapshot inode numbers */
+			__fs32	fs_avgfilesize;	/* expected average file size */
+			__fs32	fs_avgfpdir;	/* expected # of files per directory */
+			__fs32	fs_available_spare;/* old scratch space */
+			__fs32	fs_mtime[2];	/* last mount or fsck time */
+			__fs32	fs_sujfree;	/* SUJ free list */
+			__fs32	fs_sparecon[21];/* reserved for future constants */
+			__fs32	fs_ckhash;	/* if CK_SUPERBLOCK, its check-hash */
+			__fs32	fs_metackhash;	/* metadata check-hash, see CK_ */
+			__fs32	fs_flags;	/* see UFS_FS_* above */
 			__fs32	fs_contigsumsize;/* size of cluster summary array */
 			__fs32	fs_maxsymlinklen;/* max length of an internal symlink */
 			__fs32	fs_inodefmt;	/* format of on-disk inodes */
-- 
2.55.0

