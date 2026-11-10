Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320705;
	b=AckJS9S+0vXHmpeoar9nwLm7XXNGYHGAfnUkonil/rF/4Iko6uJTtlWX9MoXlh1ISSoE
	 AzeydktE0nAvzK2txiSuDcKaJChKOjl6MtXdBWSW0IX4FLTlaIP5Lsm176Coni1rk1hIU
	 t6wMRMPNnME5oIH8Lt80LGWPnAyR/tbkseRsPk78gPQfDtycHuUBETHHJoKtHTwcm87GJ
	 po9CgBg7X7g5aysyPIj775RyLprQM0xB7KVm7YO3fKH9Gn5zI1GTayMeeUE869z+2oR6t
	 iPSgUAScebk7eVZPh6j7tnRdYw4fiwGKyB9Kh7mMJipruROLwajg0lUIMj0oldMyPbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AECngfj1kAfXiTFqlbWklHQFFBTR9hHj+ExNCNNt7RY=;
	b=wCSr6cQqfZ+LLDgZTKprxL1UBFoj6hXYcB7CBAZRmrNZnXS3qGZ/PBtK3uyr1I3Jo439
	 mfjHqbad48zjeZNoskA6xXHtuP8pRrkRvMV6YmTuNvyktUejbwTTwsCiWOUcVsSXzeyh7
	 zFwLJ0AU1Nl3k3RqbUYv3VwFvGGJTczsKoGvXRcn3HS2ThNNPQP8iqKcbRbfJQ9v4xV3o
	 mPui+UPYIQOndbEE6TmV78YmRrXV+vnTJ9NwVXYfCikIBswB5/sdzZLtSPP8pmJELxo3r
	 zHuAE4PDY8ezcf6CJ0+veL5d9Icl+oGIDmGeyB0OdW1ZCNDNvsk0jov5XPBhRFX282Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hRBR0pqS;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAD60A2600
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFAD60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hRBR0pqS
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5364042eecfso25708891cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320703; x=1794925503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AECngfj1kAfXiTFqlbWklHQFFBTR9hHj+ExNCNNt7RY=;
        b=hRBR0pqSkrnFTH4GqUj4zzmhaASAKnAa1PUmTZzju/+YyUBw+UAreKVFSnRRHt35jr
         NaoYDzyrc70DgK8aa2l9XtSHuebxWl//C76ZtGTGsrHAuCCW+BgqlpaNrhow/PqpR1ky
         kQw2X9JPjWwbG8Vsf81+EfSK/wX7rTvCQ1wtNEaNzgRsYzRVnI221q07YpGPc52Ky0w/
         fuYjbroMkFdnAV5BvyPBqzhVFpvuUcvKxiuY1bWSSvnQTA8rgpUdFxT73dAMhsHZxfq1
         a1jildRfxReUl9kz6N7Y6aZgRMhbPcA1n3UMaBtRpvV729G0kfX07LmgoXjJq6yVj30b
         64Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320703; x=1794925503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AECngfj1kAfXiTFqlbWklHQFFBTR9hHj+ExNCNNt7RY=;
        b=SOtqikDW5uxjCEeJrWueqKkYfvSmI9Ck+mLFdBWZzvkamgRL3X4LpM2Y8WoNvPqQja
         g/jlnc1Qb4Ivxa59jzg2Nrz8n361myMy3xzS1LkmTGUpEamH8tJ6ax0KS1pNZbt90OaN
         1OMMPZ5OP9NH31S1hY1NrYZbuqDJ5QLkM6VSUod97P6eFmlChC3t3cmrptYhXoZQsq9n
         sq0R/1tSa2XrKsNltu3d9g/Bn04KWfpgBYGrUeE/zXfdf/5vTTxTNy2SggBQEMPJgZqD
         phdS57ZkoqcfLrzL2d9YNH231cbdrJIa540JiUnd7gN5Qp2CuU6mEpivwondl/xolip/
         amqw==
X-Forwarded-Encrypted: i=1; AL+hErGm2tvcYShC20SCO6wSqS06YFNzCfyRF1nDuSw8P6QMJ/qZXIMfZMD95Nab62eaQFtT0MJzARlOMWSLm/ML@vger.kernel.org
X-Gm-Message-State: APuU4Z82yoCYFjZ2pF6aKJKTj1ebTVb2+bWrGNila4SaOnQvS3rLWG6W
	Q0oR4aQ3jVJQazBXMP115/71S1jeOQKX+xnvfwuCrTi7Bo4fmScIl2GXpXPEn0UkH4o=
X-Gm-Gg: AYBFou2r6hDIdWWhWX1loTR9y/bQc9V8Q+3RYgjQfYtC4+npYnV6b93P2qyYm9dIIjN
	enc9P+/O/6h4bHL49okgFuVwI4TiB21rSS17bUzUJDDzbCwqdTha/B+yJLhxoVehSVAS+oE8Lyc
	C5v21oHVgrEkzAUy8ylf6ObkMGnuqmHXj4r6zGg2x5RF/oUC7WPxwQVjmBL+GgJCZdQTDVQI25a
	mWzotbbIA/hET6gI96mkHjN4XeJ2CMnLCEMmYr+dp3I6Pk6ckhYDaQgrgpo18oyrxKIzYP1DiKX
	d95sm1ttqFS9kIynWpO7A78I3KCcuy7c/Lm+FErbF1OWlZORQcGG4wxgSlY7s3+FIa90nOZtDTK
	NbsW8XFPhezTaZGW3dA2xKSZz17mYn+wB1KHYhSNT+oWNlKMLDFDokksi0VYGXN8apJa0lyrOLW
	0Y+sk0eMEVmUEIXh8uKrf1Rz2yZT1+MOENMiveRhoJtqrjcw0DUPr4NHlVGD3qVzORnXrPsrh+x
	YU2x+Vx43XquThsc7tUYMGxTarnEYKA4jfqWhTXKuSpBQiV4pMNIIJGQf7H02sZbL3O5Bp6ztHK
	1I/z1QB/KxoN7I2MMxhQ2aW+R1DXaLMxzL9c6HHg215Q/A==
X-Received: by 2002:a05:622a:653:b0:535:15a9:2516 with SMTP id d75a77b69052e-555291c2894mr41649641cf.53.1794320703461;
        Tue, 10 Nov 2026 06:25:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550c21e1fbsm24834331cf.27.2026.11.10.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Nov 2026 14:24:50 +0000
Subject: [PATCH v6 2/9] fs: add sync_fs_and_bdev()
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
Message-Id: <20261110-b4-ovl-containerized-sync-v6-2-43d1be16a4d6@toxicpanda.com>
References: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
In-Reply-To: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=3481;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cFXSmoX1EdwKarrdrXPJnOWTPV4jjSodNuQRhzCnuDg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ7Xh6/QCyzvojjwCLy3DO4GMiUz+R8OGkR0vYdjGesZqw+SMpDnXvivajMC5tvY86ahnHIHU3e
 WVsd64FGGzgY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

sync_filesystem() writes the inodes, calls ->sync_fs() and writes the block
device, first without waiting and then with.

overlayfs is about to write the inodes of its upper filesystem by itself,
only those that were modified through the overlay, and needs the other two
steps as they are.  Move them to a helper so that overlayfs does not have
to know what they are.

sync_filesystem() calls the inner helper, so it still tests for a read-only
filesystem and for s_umount once.  The exported function does both tests
for its callers.

No functional change intended.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/sync.c          | 52 +++++++++++++++++++++++++++++++++++++++-------------
 include/linux/fs.h |  1 +
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 0681bfcb2da6..c5e49914918a 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -22,6 +22,42 @@
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
 			SYNC_FILE_RANGE_WAIT_AFTER)
 
+static int __sync_fs_and_bdev(struct super_block *sb, bool wait)
+{
+	int ret;
+
+	if (sb->s_op->sync_fs) {
+		ret = sb->s_op->sync_fs(sb, wait);
+		if (ret)
+			return ret;
+	}
+	if (!wait)
+		return sync_blockdev_nowait(sb->s_bdev);
+	return sync_blockdev(sb->s_bdev);
+}
+
+/**
+ * sync_fs_and_bdev - call ->sync_fs() and write the block device
+ * @sb: the superblock, the caller holds s_umount
+ * @wait: wait for the I/O to complete
+ *
+ * These are the steps of sync_filesystem() that follow the writing of the
+ * inodes.  This is for a caller that has already written the inodes it cares
+ * about.  Like sync_filesystem() it does nothing on a read-only filesystem.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int sync_fs_and_bdev(struct super_block *sb, bool wait)
+{
+	WARN_ON(!rwsem_is_locked(&sb->s_umount));
+
+	if (sb_rdonly(sb))
+		return 0;
+
+	return __sync_fs_and_bdev(sb, wait);
+}
+EXPORT_SYMBOL_GPL(sync_fs_and_bdev);
+
 /*
  * Write out and wait upon all dirty data associated with this
  * superblock.  Filesystem data as well as the underlying block
@@ -29,7 +65,7 @@
  */
 int sync_filesystem(struct super_block *sb)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * We need to be protected against the filesystem going from
@@ -52,22 +88,12 @@ int sync_filesystem(struct super_block *sb)
 	 * at a time.
 	 */
 	writeback_inodes_sb(sb, WB_REASON_SYNC);
-	if (sb->s_op->sync_fs) {
-		ret = sb->s_op->sync_fs(sb, 0);
-		if (ret)
-			return ret;
-	}
-	ret = sync_blockdev_nowait(sb->s_bdev);
+	ret = __sync_fs_and_bdev(sb, false);
 	if (ret)
 		return ret;
 
 	sync_inodes_sb(sb);
-	if (sb->s_op->sync_fs) {
-		ret = sb->s_op->sync_fs(sb, 1);
-		if (ret)
-			return ret;
-	}
-	return sync_blockdev(sb->s_bdev);
+	return __sync_fs_and_bdev(sb, true);
 }
 EXPORT_SYMBOL(sync_filesystem);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b5485f2c1f2b..094a4be6828c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2617,6 +2617,7 @@ extern void __init vfs_caches_init(void);
 
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
+int sync_fs_and_bdev(struct super_block *sb, bool wait);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
 

-- 
2.55.0

