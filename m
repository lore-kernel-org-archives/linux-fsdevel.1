Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756945;
	b=5sfzNVj65OjGBUunCZtRbZPgs7AjIHgQPwLOJ8xk1p5GHDFLLfGIxEqeGtS8lSEH1fR9
	 zjdS3TE38G61I9wYS5yev8GHhvhJ3UV+HCwomhE84+QnAspPWyB/Kc+VGgo5880MInbte
	 LVvkD7Fxi48aQzV+pvx9fuwK35KNNhZr1EklWmGhLChWTXVFF0n/ipcdpzJss/IWOp3au
	 VgsjN1zzogaiZ/R2gJSzEUzXcFREKhVGSIadD5eYrNT1dsIchKMbFg8CnlFZuQdM+i4kX
	 BObUl9DrFITVAWcr1tUAfrNDLmJivCuXyWCASgfP8F3mtWegxsqr7yoZWCM+GzmjvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756945;
	h=DMARC-Filter:Received:From:Subject:To:Cc:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:Date;
	bh=7RK5XR/M457S+yT+K41D5EZq0rrPEjENuCAa+M2OLU4=;
	b=n9y1eqC82ItfUBakLdkX0ztgSZHz/hPj/NxIbEkcQld93i5x737p4m9DYgg5HC0PM0N8
	 U+pmqxVBkrgsiKPTQOxe8vUttMG1dmXSh20Bd9j3gSeA+/KSnbSDh1PKIWIY7v+IaOW9R
	 kHCqMN8hXQS2yEY19KZ71k1NsKWYx6YVKsv9fIte4KbezF6UNR2lDQAk9yxLzNoCMXgx6
	 sNcJlNKqje/ScT+x0x0HYJOME+C1WHHAITd2DP4FTLpXH1bZ706ZxRotSlFcKuy0CwLbL
	 1fkEbMVgLt+rPKDpmXBfCsvb5RS5RJunAyZSG0Wwiy20FDMQ9uxQPCQDY8pyVHRwkPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7841A606A32E;
	Fri, 27 Nov 2026 05:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7841A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id CC358C9318; Fri, 27 Nov 2026 14:22:23 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH 1/4] ufs: clear fs_clean of a 44bsd filesystem while it is
 read-write
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    Ali Ahmet Memis <ali@iusegentoo.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Message-ID: <20261127-ufs-suj-1-v1@snowrabbit.org>
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
Date: Fri, 27 Nov 2026 14:22:23 +0900 (JST)

FreeBSD has fs_clean at 0 and NetBSD at 2 while a filesystem is mounted
read-write, and they set it to 1 at unmount, so that fsck checks it
after a crash.  ufs leaves it at 1, and after a crash of Linux
fsck_ffs -p on FreeBSD does not look at the filesystem:

  /dev/md0: FILE SYSTEM CLEAN; SKIPPING CHECKS

Set it to 0 when the filesystem becomes read-write, and to 1 when it
stops being so and the rest is on the disk, if it was 1 to begin with.
One that was not clean and was made read-write with remount stays not
clean, as it does on the BSDs.

I copied the disk under a mounted filesystem while files were created,
renamed and removed on it, and ran fsck_ffs of FreeBSD 15.0 on the copy.
The filesystems were UFS1 and UFS2 with journaled soft updates, the UFS2
with its check hashes turned off, as Linux does not keep them and fsck
stops there first.  Without the patch fsck_ffs -p skipped all eight
copies, and fsck_ffs -fn found 161 to 224 errors in each.  With it none
was skipped.  After an unmount or a remount to read-only fsck_ffs -fn
finds nothing.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ufs/super.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ufs/ufs.h   |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index ecf422e41..cbb034a87 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -599,6 +599,51 @@ static void ufs_put_cstotal(struct super_block *sb)
 	UFSD("EXIT\n");
 }
 
+/*
+ * FreeBSD keeps fs_clean at 0 and NetBSD at 2 or 0 while a filesystem is
+ * mounted read-write, and at 1 otherwise, so that their fsck checks it after
+ * a crash.  Use 0 here.
+ */
+static void ufs_44bsd_set_active(struct super_block *sb)
+{
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_super_block_first *usb1 = ubh_get_usb_first(sbi->s_uspi);
+
+	if ((sbi->s_flags & UFS_ST_MASK) != UFS_ST_44BSD)
+		return;
+	sbi->s_was_clean = usb1->fs_clean == UFS_FSCLEAN;
+	usb1->fs_clean = UFS_FSACTIVE;
+	ubh_mark_buffer_dirty(USPI_UBH(sbi->s_uspi));
+	ubh_sync_block(USPI_UBH(sbi->s_uspi));
+}
+
+/*
+ * Nothing here has repaired a filesystem that was not clean to begin with,
+ * so leave it to fsck.
+ */
+static void ufs_44bsd_set_clean(struct super_block *sb)
+{
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_super_block_first *usb1 = ubh_get_usb_first(sbi->s_uspi);
+	int err;
+
+	if ((sbi->s_flags & UFS_ST_MASK) != UFS_ST_44BSD || !sbi->s_was_clean)
+		return;
+	/* Everything else has to be on the disk before it is called clean. */
+	err = sync_blockdev(sb->s_bdev);
+	/* The error has been reported; fs_clean stays as that left it. */
+	if (sb_emergency_ro(sb))
+		return;
+	if (err) {
+		pr_err("(device %s): not marking the filesystem clean, error %d\n",
+		       sb->s_id, err);
+		return;
+	}
+	usb1->fs_clean = UFS_FSCLEAN;
+	ubh_mark_buffer_dirty(USPI_UBH(sbi->s_uspi));
+	ubh_sync_block(USPI_UBH(sbi->s_uspi));
+}
+
 /**
  * ufs_put_super_internal() - put on-disk intrenal structures
  * @sb: pointer to super_block structure
@@ -712,8 +757,10 @@ static void ufs_put_super(struct super_block *sb)
 	UFSD("ENTER\n");
 
 	/* NULL if a remount to read-only freed the cylinder groups */
-	if (sbi->s_ucg)
+	if (sbi->s_ucg) {
 		ufs_put_super_internal(sb);
+		ufs_44bsd_set_clean(sb);
+	}
 	cancel_delayed_work_sync(&sbi->sync_work);
 
 	ubh_brelse_uspi (sbi->s_uspi);
@@ -1246,6 +1293,8 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		ret = -ENOMEM;
 		goto failed_cg;
 	}
+	if (!sb_rdonly(sb))
+		ufs_44bsd_set_active(sb);
 
 	UFSD("EXIT\n");
 	return 0;
@@ -1308,6 +1357,7 @@ static int ufs_reconfigure(struct fs_context *fc)
 				ufs_set_fs_state(sb, usb1, usb3,
 					UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
 			ubh_mark_buffer_dirty (USPI_UBH(uspi));
+			ufs_44bsd_set_clean(sb);
 		}
 		sb->s_flags |= SB_RDONLY;
 	} else {
@@ -1333,6 +1383,7 @@ static int ufs_reconfigure(struct fs_context *fc)
 			mutex_unlock(&UFS_SB(sb)->s_lock);
 			return -EPERM;
 		}
+		ufs_44bsd_set_active(sb);
 		sb->s_flags &= ~SB_RDONLY;
 #endif
 	}
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 541566f5b..86e045f20 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -26,6 +26,7 @@ struct ufs_sb_info {
 	unsigned short s_cg_loaded;
 	unsigned s_flavour;
 	unsigned s_on_err;
+	bool s_was_clean;	/* 44bsd: clean when it became read-write */
 	struct super_block *sb;
 	int work_queued; /* non-zero if the delayed work is queued */
 	struct delayed_work sync_work; /* FS sync delayed work */
-- 
2.54.0 (Apple Git-157)

