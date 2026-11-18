Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021420;
	b=SGyJXMaAKazbRj3Npd70y7HNlS7NmXyOb445+e/mqESu7bk5Tj7jYfyBWwbAx4L0mNad
	 GIlsoZZrn5YLKast69YvljiHjISdnb0CMyXK0Z/h8Pz5CC4QfZY5syJyrI7iz46coyYQL
	 lFBe7qrJ4Xq9C8771d2lONXlOXxV2V5uBo3ydeGynrRMU2OAA3IOsZ8u2wnpKEfsGvYib
	 M99JqiqOrFwDcnyAeFBZKkzOmlqSKwBfZw7voR7uMnftdyWOAUat9JHEdpLmMIFadNWFb
	 81CrjccnzTo31kSQJv6omFPDVmge3072j1BXAatKI4VTyQmkVKsm/qU0/m7JcekRibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=M6gwJXb2gxib6r9BoJFITNoCXtYKADtb0yPwtxpwaOo=;
	b=bW5ROxTb9oyWLrgdWCqDQT2sCucsUNkEUfOlcXYo8ohzFzjEDn20PXzZejOrYfNMMF9D
	 WtelqpWRIy2CqEuL9DXjL2F/Cu8uGujgfXbetxISFcRaoTRhZmi3NNZb/uCILb9qpyCKS
	 +Edm1UGgI/zE3s2FXx7b1KKacIs2XkHAvDgxc1RQ6ifkBKbyDkTJ2qztDqfj+NuVw8Z1W
	 jj0E+BsEcKselsehmGBe92WghuYuip+QPxNCCm7TVHOHbkDskUUqsM6tCQB7jPGGsOpDA
	 ylLzHZxeG2N/OkYmi7xZ2uhpsz9aVmdXSStvpuF8NEygCBVCG72+E2rBMzwrBtd2Gkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=h5wwtyx9;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05B60A2618
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 17:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB05B60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=h5wwtyx9
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-92116a3ef3cso616956d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795021419; x=1795626219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6gwJXb2gxib6r9BoJFITNoCXtYKADtb0yPwtxpwaOo=;
        b=h5wwtyx983KqxvtzYtyCP4Jlk50BvZnUZzdAgv9BdQ6nie5VPNi/h09I+8TpOGvzNs
         qOYJ51QcwElFNZvVu3Wt2ycNChH3o+eCxP1MrgLSVruh0VKLQe+P0SFFuND1fLCrTeRk
         E6L3QyDghF2m9Fl68ZdU+N2pdvgmEdTtJ6xs8pq+Eyz0wtezENllQGj9cI+yslFmtUzW
         Jj1rCmmY8+GO0LECNn0WhrruaAiWUyabvTb/UX5k3wVhFRSBtF3l87vA1WCyvX4THSui
         j1kFei1I1g2Ri1BR+iUtmoAZFfttYZEQSmk0bEzDMmy3Yb5o/PXBS/Q+DMEut2by/f9q
         npqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021419; x=1795626219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M6gwJXb2gxib6r9BoJFITNoCXtYKADtb0yPwtxpwaOo=;
        b=j4xKY204RezcsyqLhPAj9nZaTvanrWLXM2Rav+9G7qBMFS3ApO79aT563ogXfFjSOZ
         JTMcmU22w5kjz1NWLNDM5BJyywExL0nD2Vd/VG7yWCCRt5OXCuq+68xugzdEBqaLyzOk
         H7pdZc1t7LUqXdOfIcC6LIrM5z9XfLaZfxU8NYHK5TuNi1GXJv+/S5N0sSAQqYcogSXD
         l8kKCWqFDyptQ8g9p765mpiPNqme+otUfkcCNaIWBeAwZ/Kc92ol5pHqyv1OFNyFFrkG
         +/TbBxkMuxFCfWnrnvijK4kqs3ah0FxwW/VpMIV6k5viCsLAItvRehrhOaC66+zDfRRm
         50FQ==
X-Forwarded-Encrypted: i=1; AL+hErGvMkmQTLURE41xBRGhX508rg6d89B5u9AkGPr4Tephmpb//2oxDMNCbx6sSdJzioibYGi+8OnYEi23c6pB@vger.kernel.org
X-Gm-Message-State: APuU4Z+sZoRJzLuLXjCHNys5riNX3PdcbEt8/P9LnNTSXOkbrmr+NTx2
	M+ULlxyFhOi6zvm+ZfLIslGXdNLfyKhNvn1dmg5A3ftoNeFfS/HQWiBaV4dA+jdtHiY=
X-Gm-Gg: AZFdTZfRGa3G8SNaSbkQaOIigcdI0zxFoQABo8b19H/IlLtI5lU//kGAKkwD/ohHWbi
	Q4kX0qnc+UdJSu2rmDEdlT01Mrms6vifLieZb7iDbRlQKLYeK6EWEi1mSCuLyzb6VCywJgU7/wv
	WVffhP4aTe6uxq3K8dwyyFpqtrgcqXiojLFVXxpEaXv4PB0qUN4nCMRYlfmSqKhRMG/eJ6U6PSn
	7xWid9stY04s17ERlEhdPepmOleHpbbwK92diGIGWS3OUHfLxYDMjM6WoH/6O8yau31s0XcYNG4
	KupJNgErTqRMdnt7NSl3pstj9xg+YORfz9IYwjQtE61TpEpBWRE/IM673mgTPw8at8nqMcQRtYw
	EmYld2GJ8YDPTrvdlX34XcNMDotGhVnAA3nT3rpiA7RUrILfAQfScdtMm8R7S0ofLvndt5CwJnk
	5rPQGd6+2Lpt/yYp5eqRHAMjyihIKxLsCUVu2KsMCnWM2yd1hPHFSSehwLH6TwKOWncOJgRzgSh
	3j1WjTa+DIgwkEZ3L65PAWAOEwEkaKh0HRjPsamfkZtSoCcYIeQPLogjARAonkDh7MAyGaNEyAw
	yIvpWjKocDGMcoImdEP6fnIsm6gLGUIn6TRt6cw8Np2QdrQ=
X-Received: by 2002:a05:6214:3283:b0:91e:f506:5dd6 with SMTP id 6a1803df08f44-9212431c63cmr1633126d6.25.1795021418473;
        Wed, 18 Nov 2026 09:03:38 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d5558bsm26530406d6.23.2026.11.18.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:03:37 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 18 Nov 2026 17:03:26 +0000
Subject: [PATCH v7 3/7] fs: add sync_fs_and_bdev()
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
Message-Id: <20261118-b4-ovl-containerized-sync-v7-3-54f45743fe55@toxicpanda.com>
References: <20261118-b4-ovl-containerized-sync-v7-0-54f45743fe55@toxicpanda.com>
In-Reply-To: <20261118-b4-ovl-containerized-sync-v7-0-54f45743fe55@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795021413; l=3528;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VgFAjK6/pmygZeLoXZRAr4NOxj7vW3wdwgCAbaJfu4g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIKPEs2/oj58xMvoTPppV9N6Jkq6vIHs5zmNVB7xMWWJ0Q7qr1VkLk2vBWBFUueDe5HlROQC77L
 cZ6B/xDA7oAk=
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

Nothing calls the exported function yet, no functional change intended.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/sync.c          | 52 +++++++++++++++++++++++++++++++++++++++-------------
 include/linux/fs.h |  1 +
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4a84dd837b86..9adc7076c24d 100644
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
+ * sync_fs_and_bdev - finish a sync whose inodes the caller has written
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
index 99caef43ff3c..2b016d9dfb88 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2619,6 +2619,7 @@ extern void __init vfs_caches_init(void);
 
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
+int sync_fs_and_bdev(struct super_block *sb, bool wait);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
 

-- 
2.55.0

