Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825128;
	b=Tw6Bx1Q6D88s7somBzn+hDTkin7dHxkqkR/SBHNAyQRGj/JGB7LKZLHtzwiOYpZL1WNE
	 15fN1uymKidB8apwcPzGYl9zAPvHEs0EGCX0thIwnnv6DAimfpwmsccyeyoAlJRzRIKoA
	 XhsEMf2XrGh5V8mxvHNX63HWm3O2ZExokJ7As1Y+/7pFK+3n/MPxC/2ogJispOC9HoQP2
	 8WjKZDgUSzl34xz+t+Pa4pDqkSUxflK0cKsl/J1OEEhS2MqTbKX24/KUZJdZ8UbMcrjax
	 3gu0BBOB1Oty8YA5qjIf80HJnsF6bvIZeQp9JRhd4IZvmIIiC3sdavvIRxsAAuOnbtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IQCqC3TLeL02VDFjH3mD9dON8rmBDZRabQkbx5KrQXU=;
	b=kcS/8LJ3eAauFQ7YKtvR2JCjEI0Ncw4d+BErsfzTpb5W/hxPA2mZfmeUILO0itPVQFut
	 hOrmCyjSS1XitSecXMhO0CCb47m2T1bgXiihtEx82kqDthtrMrpXUI4JBLOonjByw8T0s
	 TGCvBlgmEqSZY1/FlVY7kyeRtzl1Cc05cvqV1j/PTy32vuMLFbA1UJBNa77IZ7qJLrZcW
	 DYU/XTzVpnlqAlY/ud7bD3Sf39+TB7DFBUh2lI9Ol7eYx3ooNpsNRNjcWRhBRFOPvKTnt
	 N3yxVn6MO+mActXNvfZKwr46ncg4Xfmzlslkmv/0uu83D+2lPYl+rlpk12ICBRC0X4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qDPpCZaI;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B3608F131
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 20:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824B3608F131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qDPpCZaI
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso8272046d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825127; x=1794429927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQCqC3TLeL02VDFjH3mD9dON8rmBDZRabQkbx5KrQXU=;
        b=qDPpCZaIbabkpd4vbUKZ4St0U/NNp3Tfr0JIs2VXPLZALAoFRPeyHEjzKnpzRW0Jcm
         Q6aiIOMF5R1mR66meWgdGUidmIriNA/GbKiVhPnq/DuI2LVRLGtOudamBXHcJ6HS02hx
         drRCXws/lwu/eZo7GcrB3GUZoFgSqN0eVYjneIkhFXE+vXNEvy/IsFQ0kpZgFKLhZxGW
         vUxrIhAn/agNe58t+NYeL6xEUTp7Na10xLXT4r+X/PRHMzcnTFbARUTJZSHkeyYX0b7/
         Uao8v2qoJpCTgwL9D3H/Aq3Dvk88xXa4R+4xXT5WuiI6wu5Bp+JNcGz0eBXwGplx1rX1
         IMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825127; x=1794429927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQCqC3TLeL02VDFjH3mD9dON8rmBDZRabQkbx5KrQXU=;
        b=DbgxW0KUgKd52kdvHwFogmmhkYaJ8gtc+TBZvRXbzHhCjeuQSZ0KlmJvpSMo3W7eIu
         MIgTD9t2UK1GX95l38GcJV4L6+DiwZz5KEDRPOoIbTYjew3gWySlVxtYFPaT9sRYZu5C
         KXwx4ExwEthQsvt2oHTkquLEimHa0NRUfxZapbuScNU3Gw1Pz1VG+flk2CAo/Q7UlfrW
         LAVQK52hd7gC7UHgGFr1FteZN0/80bckt9GpNncreZFVfimHZPdj35bZerpXx9huc4j4
         dnL33eSkpqpVoimo14NVbc5xJSPJQOsi1rBfZ3s6ZzX0FyzDZKYpJEjr+ep06i/C8mmb
         8ziQ==
X-Forwarded-Encrypted: i=1; AKwUvBybYTaniJMkPFI5kXfSyKmTvwwNO5aZYsfYV1osgvOtv6cKcIh04H08cg4XaBIjOoRXIvVuMXaEDnHu3Sky@vger.kernel.org
X-Gm-Message-State: APuU4Z8fys1Li47vmKSa2jZeuS2/W4fjZfSY/T8fyhFEL8GSxQsETFgC
	ON+iYQtvYGUpdl3Nf21ovagTtLHcvngG2RHQSyDaSoNsmhHxEJoTT2HIqQX0hTgeP+Y=
X-Gm-Gg: AYBFou2WvBnwmzfaOoM09LRJnVQCJ2jYcyisNLk37ueOSR4qH7A0f2VLMiq54CYYTxh
	LsKawGqxCyYZ/jx9SMUHdRQ0s8+Hg/I/8tDA9Swg0APAZfVEotjEgDvB1zYtFXkz0o5B1+SY6h2
	R37mWMA7eDKwQIuQKl6sRIbnjQcsXKr2cSmuzGgfYOAEIDK4qncv8Hr2j6AaFoPkpCB+n/i/dh5
	1b9ocRmtkQ23IsB5DiBwVuJE6iByIgLy5lyfgx1/BOEYCSsuyisNiznTC3m3vYqN4s8FR44g4Tu
	HkcdLi2T0COjJ2yYJYgshzWy22TbzCKlNQ/kuA+x1x9m6h4XZPAJUMUCP3t6bx40R2ma1VeGPJd
	F7GO18AezJZxHVqgKEQJ5MM8rmFIc5U4fdOviRW+4tPWcYAkL5n+IY4p/zb9vK6+BxgYklJ00GH
	nWQnQCogiG34l9q/3r5V01NE9VMlfsg1XYPYZC7dArvDKbHfVsQa1MA99PTBcZKZ992h6sPAy7p
	baF1JiL5vWYgjISofVGwZ6sV178z3VwH6j1E5472aGhDRvJH5xfjxhn02JImzPt1QAIULoBmydU
	t2Q1z8n/p0+ZT2kFtrzXbfQqUIjqWqgXctDK1JGg2gLpnA==
X-Received: by 2002:a05:6214:5713:b0:91e:9664:4e2b with SMTP id 6a1803df08f44-91e96644e5emr5054396d6.7.1793825127263;
        Wed, 04 Nov 2026 12:45:27 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7007b8sm28468956d6.31.2026.11.04.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:45:26 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:45:05 +0000
Subject: [PATCH v3 8/8] ovl: implement containerized syncfs for overlayfs
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-ovl-containerized-sync-v3-8-8daa20144f53@toxicpanda.com>
References: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
In-Reply-To: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825112; l=4901;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=MKPmKkGGnOmeHx5YNfIfpl3k0pTt4XfySqQ9xSBxDBY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEyIzVjiSk3MJ4NnRKejvYouvYgMx9tjZnawlJuMt59RJY3L/LFPsdUWc8qUUK4dtCWk5m9KQQw
 lAgjiJC0BBwo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Now overlayfs can only sync own dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file system.

Do that with fsync=relaxed only.  Call ->sync_fs() and write the block
device of the upper filesystem instead, which is what sync_filesystem()
does after it has written the inodes.  Do the same for a read-only
remount.

Upper inodes that have no overlay inode, like whiteouts and the work
directories, are not tracked.  It is up to ->sync_fs() and the block device
to get them to disk.  ext4, xfs and btrfs log all metadata, and ext4
without a journal keeps it in the buffers of the block device.

With many containers on one upper filesystem, stopping one of them no
longer writes out the dirty data of all the others.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: everything after the first paragraph, no wait_sb_inodes() on the
 upper filesystem]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/overlayfs.rst |  2 +-
 fs/overlayfs/params.c                   | 14 +++--------
 fs/overlayfs/super.c                    | 41 ++++++++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 092806c620b6..9a7d9aab30e7 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -830,7 +830,7 @@ Traditionally, syncfs(2) and unmount of an overlay sync the entire upper
 filesystem, including the dirty data of other overlays that share it.
 Overlayfs can be told to only write back the files that were modified
 through the overlay, and then ask the upper filesystem to commit its
-metadata.
+metadata and write its block device.
 
 On traditional local filesystems with a single journal (e.g. ext4, xfs),
 fsync on a file also persists the parent directory changes, because they
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 9ff266c38cd5..7293bf4004f7 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -774,22 +774,14 @@ static int ovl_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
-	struct super_block *upper_sb;
-	int ret = 0;
 
 	if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
 		return -EROFS;
 
-	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
-		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
-		if (ovl_should_sync(ofs)) {
-			down_read(&upper_sb->s_umount);
-			ret = sync_filesystem(upper_sb);
-			up_read(&upper_sb->s_umount);
-		}
-	}
+	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb) && ovl_should_sync(ofs))
+		return sync_filesystem(sb);
 
-	return ret;
+	return 0;
 }
 
 static const struct fs_context_operations ovl_context_ops = {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 420cd166748a..21d70d5ab282 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/blkdev.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/file.h>
@@ -269,18 +270,42 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
-	 *
-	 * If this is a syncfs(2) call, then we do need to call
-	 * sync_filesystem() on upper_sb, but enough if we do it when being
-	 * called with wait == 1.
 	 */
-	if (!wait)
-		return 0;
-
 	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
 
+	if (ovl_should_sync_upper_fs(ofs)) {
+		/* Enough if we do it when being called with wait == 1 */
+		if (!wait)
+			return 0;
+
+		down_read(&upper_sb->s_umount);
+		ret = sync_filesystem(upper_sb);
+		up_read(&upper_sb->s_umount);
+
+		return ret;
+	}
+
+	/*
+	 * sync_filesystem() has already written the dirty inodes of this
+	 * overlay through ovl_write_inode().  What is left are the last two
+	 * steps of sync_filesystem() on the upper filesystem.  They have to
+	 * take care of the upper inodes that have no overlay inode, like
+	 * whiteouts and the work directories.  Do not write the inodes that
+	 * others have dirtied on the upper filesystem.
+	 */
 	down_read(&upper_sb->s_umount);
-	ret = sync_filesystem(upper_sb);
+	/* Like sync_filesystem(), do not call ->sync_fs() on a read-only sb */
+	ret = 0;
+	if (sb_rdonly(upper_sb))
+		goto out;
+
+	if (upper_sb->s_op->sync_fs)
+		ret = upper_sb->s_op->sync_fs(upper_sb, wait);
+	if (!ret && wait)
+		ret = sync_blockdev(upper_sb->s_bdev);
+	else if (!ret)
+		ret = sync_blockdev_nowait(upper_sb->s_bdev);
+out:
 	up_read(&upper_sb->s_umount);
 
 	return ret;

-- 
2.55.0

