Received: from a14-58.smtp-out.amazonses.com (a14-58.smtp-out.amazonses.com [54.240.14.58])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8384BAA0C;
	Sat, 10 Oct 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.14.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659726; cv=none; b=WbhfbNY0RptHXaBCv485kPs38b5QrJBVgVZ7SnGGpqGeESsTv1SVXWO2DFs3tSKCJatwiuX99FS/NWXNM8yvGgp9b4ghGgpzENEqOZUQwGP8UUPS9fc8Dez10PwxfIDwy2l2LrAbdylTDRgASGfRVoV2+oc0rr/2DwrDYs5DD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659726; c=relaxed/simple;
	bh=uZghW09ekWYoJaATpd3YSaijIX3k0cAVXVF1c0qef9E=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=up26LChD3bDvNuuaIzNsO6UFhN01phuK6PLn1VxgTD/IlMBtB55CssoH9171o0NmFJZJFQIhzKfkjEJMNJfSIUU0i5Ao5x565d8YX7Jff8Vqao1kkhKTKTEverHDgCXraG1sl5SKdaaNnGwgPCS0C45UxbmMWi+wIoLhwYYclU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nicolasfalesy.com; spf=pass smtp.mailfrom=send.nicolasfalesy.com; dkim=pass (1024-bit key) header.d=nicolasfalesy.com header.i=@nicolasfalesy.com header.b=L1FZa8An; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=g8qrX2MK; arc=none smtp.client-ip=54.240.14.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nicolasfalesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.nicolasfalesy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nicolasfalesy.com header.i=@nicolasfalesy.com header.b="L1FZa8An";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="g8qrX2MK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=nicolasfalesy.com; t=1791659713;
	h=In-Reply-To:References:From:To:Cc:Reply-To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=uZghW09ekWYoJaATpd3YSaijIX3k0cAVXVF1c0qef9E=;
	b=L1FZa8An6AEXXJ2T1u4j8vcMrfXXHNCbq7GKrAeI8w4Fj+YgQOaD7TOPRhdtUDo8
	Jp904axirpJk9K7SQFG7XsQPDs540cQ3tRsi9QqL48gzCB7ZVWNYZqo0t53Uk2Ircot
	bL8HIC4Tj/p0LueXpsaj78uyZbuLBh1HsF+Unnco=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1791659713;
	h=In-Reply-To:References:From:To:Cc:Reply-To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=uZghW09ekWYoJaATpd3YSaijIX3k0cAVXVF1c0qef9E=;
	b=g8qrX2MK8Ec+MiXlpN+LhenRaIa6f3Jz3c+3UCE91yahCEu1z7yFT7HW3u2MyfCE
	bY7lMa97Ns6xvPtNB8qqyReFOH8tWTMkTHrFfnV+Pwc+YjELfeeTscDdRDx7ZiBaaLv
	ON5z5GrOOWMUWkfjrJMi+/lRuDn+uef+8SGaX92o=
In-Reply-To:
 <CAKYAXd9EkVrdKjsmcd96OFc7pf=2WA8KMUBhRPZROkUOdkV=SA@mail.gmail.com>
References:
 <010001a1222f66ba-0c745f29-d4fe-4862-93ff-1db2055b05fc-000000@email.amazonses.com>
 <CAKYAXd9EkVrdKjsmcd96OFc7pf=2WA8KMUBhRPZROkUOdkV=SA@mail.gmail.com>
From: Nicolas Falesy <nicolas@nicolasfalesy.com>
To: linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, hch@lst.de, djwong@kernel.org, 
	nfalesy@gmail.com
Reply-To: nfalesy@gmail.com
Subject: [PATCH] exfat: clean stale bdev buffers of newly allocated
 clusters
Message-ID: <010001a1273da435-1b6e4385-3185-451f-821b-8d8723ba78d3-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 19:15:13 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.ab+1BOhI2G8lKXniYmrQtu8hqInlQv0hMf7S3fw6DdXZuhPmWRop4As2nYC+PvMCg/MeYgni+TDnIGoO6UR5+695Ups99kH4xr2cW/T33RKlxcJfmzZvDG+/D2zFM008PnQSMHraaQXnsyHltCPK4i0yAdm73tum8YqlC4670Nc=:1.us-east-1.QSNtDRXSTq9sAuvRl56h5mypgasnQ5yDLNpVzTnziu0=:AmazonSES
X-SES-Outgoing: 2026.10.10-54.240.14.58

Directory entries are read and written through buffer_heads of the
block device. Removing the entries of a directory dirties such a
buffer. If the directory is then removed and its cluster is reused for
file data before writeback, the stale buffer stays dirty in the block
device mapping, and the next flush of the block device (fsync, syncfs
or umount) writes it over the new file data. The file silently reads
back with one sector replaced by the deleted directory entries.

This was harmless while file data went through exfat_get_block(), as
__block_write_begin_int() and do_direct_IO() call clean_bdev_aliases()
for newly allocated blocks. Since data I/O moved to iomap, nothing
drops these buffers any more.

Clean the aliases in exfat_alloc_cluster(), =
once per contiguous run of
allocated clusters. Doing it at allocation time =
covers every path that
allocates clusters: buffered and direct writes, and =
also fallocate()
and an extending truncate(), which allocate clusters =
before the data is
written, so the later iomap mapping does not see them as=
 new.

Tested on the exfat dev branch in a KVM guest with a reproducer that
removes the entries of a directory, removes the directory and writes a
file over its freed cluster: buffered with and without fsync, O_DIRECT,
after fallocate(), after an extending ftruncate(), and with the freed
cluster in the middle of a fragmented allocation. Without this patch
every run corrupted the file (55/55); with it, none did (0/55). A churn
test that creates, removes, preallocates and truncates directories and
files, then runs fsck.exfat, is clean with and without the patch.

Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
Fixes: 867b9c96dc83 ("exfat: add iomap direct I/O support")
Link: https://lore.kernel.org/all/010001a1222f66ba-0c745f29-d4fe-4862-93ff-=
1db2055b05fc-000000@email.amazonses.com/
Suggested-by: Namjae Jeon =
<linkinjeon@kernel.org>
Assisted-by: Claude-Opus-5.5
Signed-off-by: Nicolas Falesy <nicolas@nicolasfalesy.com>
---
This replaces the candidate fix from my report. As Namjae suggested, the
cleanup now happens in exfat_alloc_cluster(), so clusters preallocated
by fallocate() or an extending truncate() are covered too; the old
candidate still corrupted those cases in 10/10 runs each.

Based on the exfat dev branch (513192ce3669). Not run: xfstests.

 fs/exfat/fatent.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/exfat/fatent.c =
b/fs/exfat/fatent.c
index 3c8bdc131..9f4607fce 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -418,12 +418,28 @@ int =
exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 	return 0;
 }
=20
+/*
+ * Newly allocated clusters may still have dirty buffer_heads in =
the block
+ * device mapping, e.g. the dentries of a directory that was =
just removed.
+ * File data does not go through those buffers, so drop =
them; otherwise a
+ * later flush of the block device writes them over the =
new data.
+ */
+static void exfat_clean_bdev_aliases(struct super_block *sb=
,
+				     unsigned int clu, unsigned int count)
+{
+	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
+
+	clean_bdev_aliases(sb->s_=
bdev, exfat_cluster_to_sector(sbi, clu),
+			   (sector_t)count << =
sbi->sect_per_clus_bits);
+}
+
 int exfat_alloc_cluster(struct inode *inode=
, unsigned int num_alloc,
 		struct exfat_chain *p_chain, bool sync_bmap, =
bool contig)
 {
 	int ret =3D -ENOSPC;
 	unsigned int total_cnt;
 	unsigned int hint_clu, new_clu, last_clu =3D EXFAT_EOF_CLUSTER;
+	unsigned int run_clu =3D EXFAT_EOF_CLUSTER, run_len =3D 0;
 	struct super_block *sb =3D inode->i_sb;
 	struct exfat_sb_info *sbi =3D =
EXFAT_SB(sb);
=20
@@ -514,10 +530,21 @@ int exfat_alloc_cluster(struct =
inode *inode, unsigned int num_alloc,
 		p_chain->size++;
 		sbi->used_clusters++;
=20
+		/* clean stale buffers once per contiguous =
run of clusters */
+		if (run_len && new_clu =3D=3D run_clu + run_len) {
+			run_len++;
+		} else {
+			if (run_len)
+				exfat_clean_bdev_aliases(s=
b, run_clu, run_len);
+			run_clu =3D new_clu;
+			run_len =3D 1;
+		}
+
 		last_clu =3D new_clu;
=20
 		if (p_chain->size =3D=3D num_alloc) {
 done:
+			exfat_clean_bdev_aliases(sb, run_clu, run_len);
 			sbi->clu_srch_ptr =3D hint_clu;
 			ret =3D 0;
 			goto unlock;
--=20
2.55.0

