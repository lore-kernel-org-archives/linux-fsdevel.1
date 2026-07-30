Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6630423782
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415296; cv=none; b=acaF48ThUs79dljagyFclruKmfxs27BPT2vguOVmcDPwyWhO6punu/KQHJ22sE6n9OlpEWG1njI5Mm3geaKwXFreVFs7fQP2hIzaTqxkMg/eTm8/JQXjlAsUR1sDzj3iCM5w345wNsPQ9l4XhfPRVebbtPFz98aLJIbczHY6GbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415296; c=relaxed/simple;
	bh=DnUV6L5Mq9oZ4NYWunxmXTca0xmkCvzFGw4mbc2FZ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjEeMmGltJKTtn1GTIt9D9IbElQgy7XVcrYuMTwjdtmb0BvN9Ur8eU8D7kmaA1MrkUaT0VuRTeELYBqsq9BDlqJj9Cwopnv5+N7GFjV0w//DMeuoyxpFNw3+5wkEwReEwr0LUrREN/2jaTVE+/+XqhgB1a5soawYPLBw9swPDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvzf0vxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvzf0vxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785415293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C470IBkrBMSkvZtZkZP2F7MQt7QNXNuLiygMFAS4EjU=;
	b=Mvzf0vxGJAxtROGHy3avfCB1m9W3SLdoQSVr7UIjWPyHF88lIwMqqPzbgFRYTDXYzH2Y/8
	/4V6Ze/7Cd2bCrg3/S6FMufTM85mpAI5Br6Qao/BHcNng6jzfZU4fKtBZtzbxl80T18CYr
	3HHe1OwFyTAInkiDBKMBj217/3GyLU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-k-gOyz8VMGmYj2RFqCSbDg-1; Thu,
 30 Jul 2026 08:41:31 -0400
X-MC-Unique: k-gOyz8VMGmYj2RFqCSbDg-1
X-Mimecast-MFC-AGG-ID: k-gOyz8VMGmYj2RFqCSbDg_1785415290
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12A6E19560AE;
	Thu, 30 Jul 2026 12:41:30 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.49.125])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5874C1800480;
	Thu, 30 Jul 2026 12:41:28 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	gscrivan@redhat.com
Subject: [PATCH] erofs: reuse superblock for file-backed mounts
Date: Thu, 30 Jul 2026 14:41:20 +0200
Message-ID: <20260730124120.1501126-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When the same file is mounted multiple times (via path or fd), reuse
the existing superblock instead of creating a new one.  This allows
multiple mounts of the same image to share in-kernel data structures
more efficiently.

The backing file is identified by its inode and fsoffset.  If mount
options conflict, a separate superblock is created transparently as
a fallback.

Tested by mounting a 177M Fedora EROFS image 20 times with full
traversal:

```
\#!/bin/sh
IMG=${1:-/root/fedora.erofs}
N=20
DIR=$(mktemp -d)
trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT

sync; echo 3 > /proc/sys/vm/drop_caches
INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')

for i in $(seq 1 $N); do mkdir $DIR/m$i && mount -t erofs "$IMG" $DIR/m$i && find $DIR/m$i > /dev/null; done

echo "Superblocks: $(grep $DIR /proc/self/mountinfo | awk '{print $3}' | sort -u | wc -l)"
echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | awk '{print $2}') - INODES_BEFORE ))"
echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | awk '{print $2}') - MEM_BEFORE )) kB"
```

unpatched kernel:

Superblocks: 20
erofs_inode delta: +46368
Slab delta: +39952 kB
0.08user 0.82system 0:00.98elapsed 93%CPU (0avgtext+0avgdata 4796maxresident)k
19168inputs+10304outputs (24major+16672minor)pagefaults 0swaps

patched kernel:

Superblocks: 1
erofs_inode delta: +2044
Slab delta: +1088 kB
0.07user 0.21system 0:00.31elapsed 91%CPU (0avgtext+0avgdata 4848maxresident)k
19024inputs+6784outputs (25major+16810minor)pagefaults 0swaps

The time difference shows that sharing the superblock also benefits
the page cache and inode cache, as subsequent mounts of the same image
avoid re-reading the backing file.  This is particularly useful for
container hosts running multiple containers from the same base image.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 Documentation/filesystems/erofs.rst |  4 +++
 fs/erofs/super.c                    | 44 +++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 774e8b236d09..ef6785035b26 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -154,6 +154,10 @@ Only regular files are accepted as backing files; to mount an image that
 resides on a block device, use the traditional block device mount path
 instead.
 
+When the same backing file is mounted more than once with compatible
+mount options, the kernel reuses the existing superblock.  If mount
+options conflict, a separate superblock is created transparently.
+
 Sysfs Entries
 =============
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 558041011398..cbd76727f0d3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -788,6 +788,46 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+static int erofs_fc_test_file_super(struct super_block *sb,
+				    struct fs_context *fc)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_sb_info *new_sbi = fc->s_fs_info;
+
+	if (sb->s_iflags & SB_I_RETIRED)
+		return 0;
+	if (!sbi->dif0.file || !new_sbi->dif0.file)
+		return 0;
+	return file_inode(sbi->dif0.file) == file_inode(new_sbi->dif0.file) &&
+	       sbi->dif0.fsoff == new_sbi->dif0.fsoff &&
+	       sbi->opt.mount_opt == new_sbi->opt.mount_opt &&
+	       sbi->opt.cache_strategy == new_sbi->opt.cache_strategy;
+}
+
+static int erofs_fc_get_tree_file(struct fs_context *fc)
+{
+	struct super_block *sb;
+	int err;
+
+	sb = sget_fc(fc, erofs_fc_test_file_super, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		err = erofs_fc_fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+		sb->s_flags |= SB_ACTIVE;
+	} else {
+		erofs_info(sb, "sharing superblock for the same backing file");
+	}
+
+	fc->root = dget(sb->s_root);
+	return 0;
+}
+
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
@@ -803,7 +843,7 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 			errorfc(fc, "source is unsupported");
 			return -EINVAL;
 		}
-		return get_tree_nodev(fc, erofs_fc_fill_super);
+		return erofs_fc_get_tree_file(fc);
 	}
 
 	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
@@ -821,7 +861,7 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 
 		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
 		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
+			return erofs_fc_get_tree_file(fc);
 	}
 	return ret;
 }
-- 
2.55.0

