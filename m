Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756951;
	b=tc9fG7+g5Sk5R4gZk9BbMMDWgs6AB9j9018ytRxNKInNTOZuWaJTUb4/5JBQq5eTJdSi
	 aioYw+g+SnhaGXESeIWlIJLZXEKDV36e50yTTHqsAQitGeqqXm84xXgALE34l4zXpOUJV
	 ZILVYh15R0kRziHGUYfueiV3PKmFVE20nDgIDzUMl8dSsBS4+oJY+gLtNbWixwUa/nvnx
	 xCkJt/1qpfzKcCUovlDwv86giiav8d9yTMKuDeusIIrlsLPI9eNmiNeWDYbRVQgcGObBl
	 hJbGbOJTgY9WPx3zWVQC9ekY/QF8vfvGOjs16iMR2eh7I0RtaD7Ousnv98wvkpUGh/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756951;
	h=DMARC-Filter:Received:From:Subject:To:Cc:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:Date;
	bh=ltXkE7mwzP9g+X9pU6NJuXSGJbWkJKiU2bpHIKU/k9Q=;
	b=CXjM2RZJL4UslIj5gz9dBkenv857HvG7fA8Iv2/DoAXZGA1q2CcJH6N7UR7TcrczlAR5
	 7futCM5dRR31RXgBjm9+Qh8STv9DUFitKAGh7sryzXssa4vQwKdKlIk/Nvnp0uA0befYv
	 LsQldymcoYBLHTqIixE+opZaDvaNCwUbtg5YFLXBm5S3alLbKO9I6tPu2Gef+0mmjhyin
	 TsqrDEE3jKCk0JGVD/elbe1q8KOPv9v0uEpQ6V/MFtYSXRUm7wcP+l/bzb3KeoLv2paH1
	 eCS2wpVH1tYg26LI14Nn/274ar5519ZSZnAg+J7BwbA7p50fSJPNQAQlm3WYY1BjLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB26606A329;
	Fri, 27 Nov 2026 05:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB26606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 14263C935F; Fri, 27 Nov 2026 14:22:30 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH 3/4] ufs: let FreeBSD see that its soft updates journal is out
 of date
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    Ali Ahmet Memis <ali@iusegentoo.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Message-ID: <20261127-ufs-suj-3-v1@snowrabbit.org>
In-Reply-To: <20261127-ufs-suj-0-v1@snowrabbit.org>
References: <20261127-ufs-suj-0-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 27 Nov 2026 14:22:30 +0900 (JST)

fsck on FreeBSD uses the journal of a filesystem with journaled soft
updates when the time stored with the journal is fs_mtime, and then does
not do the full check.  FreeBSD sets fs_mtime at each read-write mount.
ufs does not, so after a crash of Linux fsck recovers from a journal
that has nothing of what Linux wrote, and marks the filesystem clean.

Set fs_mtime when the filesystem becomes read-write.

With only fs_clean cleared, fsck_ffs -p of FreeBSD 15.0 used the journal
and marked clean all eight of the copies from the first patch, and
fsck_ffs -fn then found 154 to 225 errors in each.  With this it says

  Journal timestamp does not match fs mount time

goes on to the full check, and asks for a manual fsck.  This is about
fsck_ffs -p; I did not look at the background fsck of a filesystem with
soft updates only, or at gjournal.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ufs/super.c  | 26 ++++++++++++++++++++++++++
 fs/ufs/ufs_fs.h |  4 +++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index c204af7ce..716867fac 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -599,6 +599,31 @@ static void ufs_put_cstotal(struct super_block *sb)
 	UFSD("EXIT\n");
 }
 
+/*
+ * FreeBSD's fsck takes the soft updates journal as current when the time
+ * kept with it is fs_mtime, and then skips the full check.  FreeBSD sets
+ * fs_mtime at each read-write mount; do the same, as the journal knows
+ * nothing about what is written here.
+ */
+static void ufs_44bsd_set_mtime(struct super_block *sb)
+{
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	struct ufs_super_block_first *usb1 = ubh_get_usb_first(uspi);
+	struct ufs_super_block_third *usb3 = ubh_get_usb_third(uspi);
+	time64_t now = ktime_get_real_seconds();
+	__fs64 mtime;
+
+	/* Without these the place belongs to fields of the old superblock. */
+	if (uspi->fs_magic != UFS2_MAGIC &&
+	    !(usb1->fs_flags & UFS_FLAGS_UPDATED))
+		return;
+	memcpy(&mtime, usb3->fs_un2.fs_44.fs_mtime, sizeof(mtime));
+	if (now == fs64_to_cpu(sb, mtime))
+		now++;
+	mtime = cpu_to_fs64(sb, now);
+	memcpy(usb3->fs_un2.fs_44.fs_mtime, &mtime, sizeof(mtime));
+}
+
 /*
  * FreeBSD keeps fs_clean at 0 and NetBSD at 2 or 0 while a filesystem is
  * mounted read-write, and at 1 otherwise, so that their fsck checks it after
@@ -613,6 +638,7 @@ static void ufs_44bsd_set_active(struct super_block *sb)
 		return;
 	sbi->s_was_clean = usb1->fs_clean == UFS_FSCLEAN;
 	usb1->fs_clean = UFS_FSACTIVE;
+	ufs_44bsd_set_mtime(sb);
 	ubh_mark_buffer_dirty(USPI_UBH(sbi->s_uspi));
 	ubh_sync_block(USPI_UBH(sbi->s_uspi));
 }
diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index b8dc354ae..c5e9c6aab 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -937,7 +937,9 @@ struct ufs_super_block_third {
 			__fs32	fs_qfmask[2];	/* ~usb_fmask */
 		} fs_sunx86;
 		struct {
-			__fs32	fs_sparecon[50];/* reserved for future constants */
+			__fs32	fs_sparecon[23];/* reserved for future constants */
+			__fs32	fs_mtime[2];	/* last mount or fsck time */
+			__fs32	fs_sparecon2[25];/* reserved for future constants */
 			__fs32	fs_contigsumsize;/* size of cluster summary array */
 			__fs32	fs_maxsymlinklen;/* max length of an internal symlink */
 			__fs32	fs_inodefmt;	/* format of on-disk inodes */
-- 
2.54.0 (Apple Git-157)

