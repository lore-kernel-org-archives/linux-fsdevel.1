Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510568;
	b=n5XaIqI9apzBzh/f2vyv/jx+JktzFFW7T9zMTViFdsF2T/dp8NSjhL3VA8Iyky1i1I8Z
	 oyBTeGVS8ontXD27X+28u0y3LNA4Z5k0+FFDwpywa97dJt7YTxWDwZI86tbMEglhuESQJ
	 lPk/M3O36qyYQnN26krN8FoxQWiahwEYjkaZHMz6oM8qQh5Fnzm1bh65QCxe6sAfGz2jr
	 Gh86qKxVQQgmv1diNReZQvSD687swENj8UPsXttjnQeNH1L63A3vUhkAAtf8F7bLZnyyo
	 Z7Zi+FWYiBLJLzUc5vAkqibpsiytZhVT2aIe5qzusgMKYGhAvSvv//ED7L2KVjgXa6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X4RkaRO34zwhb3y2ZY0P2m2fdXJ0xGr/34bmaboHeu4=;
	b=xhae8qtGTqy/6wlWaukfPXw4UGG2nzyekO/C+iuryQ0TUodujugTxOX1CnuPocWbi5od
	 9Ad7gtrMvUXbJpYOZJoVP/GRLdZbb/Cguy8UDHYjTAjfIi11HtVNNurUxud8jbJzLmJM9
	 NScJ/Mr3W7b6hwdj5eMzvFsAwNy846759B4lB35SfnhmwIGfIvgiYRameWSHnHTujs63t
	 l+mgrHmn2EvXRzlKph1V76czlRwGMxMn0ubEIPIuNO3lxw43Q/Wj9SQeozBUkYoFUdT9J
	 /0f7sSQhKq3vVRWFhGdbGIPyLBrrHh9bRpo9Zm4YCwlhh0+tTlVkrBFqiyzix9ZTEYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=S2gujuqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E360A2603;
	Thu, 12 Nov 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=S2gujuqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2571F000D0;
	Thu, 12 Nov 2026 19:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794510567;
	bh=X4RkaRO34zwhb3y2ZY0P2m2fdXJ0xGr/34bmaboHeu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S2gujuqjXs2blV+0XNHq59fKnWACZiB0i6K46vLyBMO/cIx0epicB10t6biaJ9RHb
	 KgesT8UlQAAJvF1/fmi/0MmHOopQ5FSK45vM4NfLxi/uzUnieX4vgafxyDxzrtVDk0
	 +brVPx8wr0M6i0K4FwtKi7AaSZ63+65M1meJZVaw=
Date: Thu, 12 Nov 2026 11:09:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christian
 Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v2 17/22] Squashfs: don't store large export table
 indexes in memory
Message-Id: <20261112110927.6add17b0552922c5b6b93515@linux-foundation.org>
In-Reply-To: <20261111234402.252354-18-phillip@squashfs.org.uk>
References: <20261111234402.252354-1-phillip@squashfs.org.uk>
	<20261111234402.252354-18-phillip@squashfs.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 23:43:57 +0000 Phillip Lougher <phillip@squashfs.org.uk> wrote:

> When mounting a Squashfs filesystem, the code reads the entire
> export table indexes into memory.  Their size is determined by the
> number of inodes in the filesystem.  For the maximum inode
> count of 2^32, this will allocate and read 32 MiB.
> 
> This is an excessive and unnecessary amount of memory because the
> indexes do not need to be read into memory in their entirety.  In
> addition kmalloc() is used to allocate memory, and this can fail when
> large amounts of memory are requested.  Kmalloc() on modern kernels is
> usually limited to 4096 KiB.  If panic-on-warn is set, then failure to
> allocate memory will result in a kernel panic.
> 
> This commit uses a 4 page cache if the size of the export table indexes
> are 4 pages in size or larger.  A simple and fast lookup array is
> retained where the total index size is less than 4 pages in size, which
> is the vast majority of Squashfs filesystems.

Thanks.  This patch didn't anticipate the presence of Christian's
"squashfs: identify device in mount errors".  To make life easier I've
staged Christian's patch behind this 22-patch series.

This required a bit of rework of Christian's patch.  While in there I
filled in a few more places which needed Christian's treatment and I
made the whole thing more 80-column friendly where that made sense.

Please check:

From: Christian Loehle <christian.loehle@arm.com>
Subject: squashfs: identify device in mount errors
Date: Sat, 12 Sep 2026 15:53:14 +0100

Squashfs mount failures reported through fs_context do not identify the
backing device, fix this by printing the block device.

Repeated automount failures used to be ambiguous, for example:
  Filesystem uses "xz" compression. This is not supported

All of the affected errors occur after get_tree_bdev() has opened the
block device and setup_bdev_super() has assigned sb->s_bdev.  Use it to
identify the failing Squashfs image even when the mount is retried.  For
example, the error above now reads:
  Filesystem on loop0 uses "xz" compression. This is not supported

Link: https://lore.kernel.org/20260912145314.788588-1-christian.loehle@arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
---

 fs/squashfs/super.c |   48 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

--- a/fs/squashfs/super.c~squashfs-identify-device-in-mount-errors
+++ a/fs/squashfs/super.c
@@ -151,26 +151,26 @@ static int squashfs_parse_param(struct f
 }
 
 static const struct squashfs_decompressor *supported_squashfs_filesystem(
-	struct fs_context *fc,
+	struct super_block *sb, struct fs_context *fc,
 	short major, short minor, short id)
 {
 	const struct squashfs_decompressor *decompressor;
 
 	if (major < SQUASHFS_MAJOR) {
-		errorf(fc, "Major/Minor mismatch, older Squashfs %d.%d "
-		       "filesystems are unsupported", major, minor);
+		errorf(fc, "Unsupported older Squashfs %d.%d filesystem on %pg",
+		       major, minor, sb->s_bdev);
 		return NULL;
 	} else if (major > SQUASHFS_MAJOR || minor > SQUASHFS_MINOR) {
-		errorf(fc, "Major/Minor mismatch, trying to mount newer "
-		       "%d.%d filesystem", major, minor);
+		errorf(fc, "Major/Minor mismatch, trying to mount newer %d.%d filesystem on %pg",
+		       major, minor, sb->s_bdev);
 		errorf(fc, "Please update your kernel");
 		return NULL;
 	}
 
 	decompressor = squashfs_lookup_decompressor(id);
 	if (!decompressor->supported) {
-		errorf(fc, "Filesystem uses \"%s\" compression. This is not supported",
-		       decompressor->name);
+		errorf(fc, "Filesystem on %pg uses \"%s\" compression. This is not supported",
+		       sb->s_bdev, decompressor->name);
 		return NULL;
 	}
 
@@ -217,7 +217,8 @@ static int squashfs_fill_super(struct su
 	TRACE("Entered squashfs_fill_superblock\n");
 
 	if (!devblksize) {
-		errorf(fc, "squashfs: unable to set blocksize\n");
+		errorf(fc, "squashfs: unable to set blocksize on %pg\n",
+		       sb->s_bdev);
 		return -EINVAL;
 	}
 
@@ -246,7 +247,8 @@ static int squashfs_fill_super(struct su
 	sblk = squashfs_read_table(sb, SQUASHFS_START, sizeof(*sblk));
 
 	if (IS_ERR(sblk)) {
-		errorf(fc, "unable to read squashfs_super_block");
+		errorf(fc, "unable to read squashfs_super_block on %pg",
+		       sb->s_bdev);
 		err = PTR_ERR(sblk);
 		sblk = NULL;
 		goto failed_mount;
@@ -271,7 +273,7 @@ static int squashfs_fill_super(struct su
 
 	/* Check the MAJOR & MINOR versions and lookup compression type */
 	msblk->decompressor = supported_squashfs_filesystem(
-			fc,
+			sb, fc,
 			le16_to_cpu(sblk->s_major),
 			le16_to_cpu(sblk->s_minor),
 			le16_to_cpu(sblk->compression));
@@ -295,8 +297,8 @@ static int squashfs_fill_super(struct su
 	 * block size (by default 128K).  This is currently not supported.
 	 */
 	if (PAGE_SIZE > msblk->block_size) {
-		errorf(fc, "Page size > filesystem block size (%d).  This is "
-		       "currently not supported!", msblk->block_size);
+		errorf(fc, "Page size > filesystem block size (%d) on %pg is not supported",
+		       msblk->block_size, sb->s_bdev);
 		goto failed_mount;
 	}
 
@@ -355,7 +357,8 @@ static int squashfs_fill_super(struct su
 	msblk->read_page = squashfs_cache_init("data",
 		SQUASHFS_READ_PAGES, msblk->block_size);
 	if (IS_ERR(msblk->read_page)) {
-		errorf(fc, "Failed to allocate read_page block");
+		errorf(fc, "Failed to allocate read_page block for %pg",
+		       sb->s_bdev);
 		err = PTR_ERR(msblk->read_page);
 		goto failed_mount;
 	}
@@ -394,7 +397,8 @@ static int squashfs_fill_super(struct su
 	err = squashfs_read_xattr_id_table(sb, msblk->xattr_id_table,
 				&msblk->xattr_table, &msblk->xattr_ids);
 	if (err < 0) {
-		errorf(fc, "unable to read xattr id index table");
+		errorf(fc, "unable to read xattr id index table on %pg",
+		       sb->s_bdev);
 		if (err != -ENOTSUPP)
 			goto failed_mount;
 	}
@@ -405,7 +409,7 @@ allocate_id_index_table:
 	msblk->id_table = squashfs_read_id_index_table(sb,
 		le64_to_cpu(sblk->id_table_start), next_table, msblk->ids);
 	if (IS_ERR(msblk->id_table)) {
-		errorf(fc, "unable to read id index table");
+		errorf(fc, "unable to read id index table on %pg", sb->s_bdev);
 		err = PTR_ERR(msblk->id_table);
 		msblk->id_table = NULL;
 		goto failed_mount;
@@ -421,13 +425,15 @@ allocate_id_index_table:
 	err = squashfs_read_inode_lookup_table(sb, msblk->lookup_table,
 			next_table, msblk->inodes);
 	if (err < 0) {
-		errorf(fc, "unable to read inode lookup table");
+		errorf(fc, "unable to read inode lookup table on %pg",
+		       sb->s_bdev);
 		goto failed_mount;
 	}
 
 	err = squashfs_inode_lookup_start(sb, 1);
 	if (err < 0) {
-		errorf(fc, "unable to read inode lookup table");
+		errorf(fc, "unable to read inode lookup table on %pg",
+		       sb->s_bdev);
 		goto failed_mount;
 	}
 	next_table = msblk->lookup_table_start = err;
@@ -450,13 +456,15 @@ handle_fragments:
 	err = squashfs_read_fragment_index_table(sb, msblk->fragment_table,
 			next_table, fragments);
 	if (err < 0) {
-		errorf(fc, "unable to read fragment index table");
+		errorf(fc, "unable to read fragment index table on %pg",
+		       sb->s_bdev);
 		goto failed_mount;
 	}
 
 	err = squashfs_frag_lookup_start(sb, 0);
 	if (err < 0) {
-		errorf(fc, "unable to read fragment index table");
+		errorf(fc, "unable to read fragment index table on %pg",
+		       sb->s_bdev);
 		goto failed_mount;
 	}
 	next_table = msblk->fragment_table_start = err;
@@ -502,7 +510,7 @@ check_directory_table:
 	return 0;
 
 insanity:
-	errorf(fc, "squashfs image failed sanity check");
+	errorf(fc, "squashfs image on %pg failed sanity check", sb->s_bdev);
 failed_mount:
 	squashfs_cache_delete(msblk->block_cache);
 	squashfs_cache_delete(msblk->fragment_cache);
_

