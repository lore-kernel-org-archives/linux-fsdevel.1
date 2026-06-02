Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB428C854
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376033; cv=none; b=SulrxvYgS8PGH92Uiyfj4J+kcsfD7pxBcvAyZnKh7Pzg/l+ohftLEy87pQYwmMeLhSVrj5/nAJyWRuGnJZ41UI7pG4VJpGKu9hCxltFxusb1dUEJWjpvidYO1V37NOqI4hdq2Zxjleq8AhRwetkvH4tx5+zYviVbpEYaOgrDgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376033; c=relaxed/simple;
	bh=De5Qct0iEAS2GOuoTujA9XT9eX4PKykAs+ktejEC76o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fRBudIV+Rb23NASpJQPJwBYYthXrwPnz+ObGKsgcPJhDl82K0Tp7maHREY2tQvnTOCKr74UhiqAuACi7Zx29BXo4EFBIRdHxxHX2Yok8iTfCTjAg9EkJSN3D6B45IsfJ/JY97xfGus6RoYjtnfvptdJXfW1yrYT9KvsZkBvDsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMo5Nli0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMo5Nli0"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85c9e8b7e4so243060a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376030; x=1780980830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDlCsvyvcMRxiWfdmipSr5G4n6G3wuZ81jm/gyeSk7g=;
        b=fMo5Nli0x467CSE9sy9KQBgBowNKdHJrwMh9DElPjT2kZcl6Ihr/2vtVyFpliEggFw
         V1sgTkeHaQaDM5Hb6QxDyTL/Bs7817F1br/8IoKpzGdTk6AcTvYKDg2hAJERVLHU1zkC
         6tn3ut52tk+9lHKAGHxhytFj7HpMM5zOFJYw9Qn4p8JqwbuVGsIYHcr4fL4TcZN+82Q7
         tc+z8uJXUL7+M6Hm+1izQ5VSxz8V+bynXL7lrySGk606j1kr5moXDtsXMxwr6gIkA1Ev
         WEV9q9l8zRhNx9f+W/1S2RKyvjhNe6Tws/Z+wAaatY/rkciMu+gLyBWpGcjfaHHoaOmS
         llYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376030; x=1780980830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDlCsvyvcMRxiWfdmipSr5G4n6G3wuZ81jm/gyeSk7g=;
        b=rDeYkoFktWku2Xr3jKSEOdL03BS5arDe7FYZZ4mBWPUhyworWJP2ia6gTXJ27ogim7
         UQJ/Lkj7zV5P4gJMHdGyvDk+k/V5SKizlU/MEJorzk8OQ2tWfgViq+5ZXS1OnCLU3Mxa
         P6GyFgj9usrfhTUB15xNHNOuoIWShT58uvi/t0Pm72Hf5T+UTqsVJ2YPx5W6uw25h9oL
         IgkLM8keI2O3szKwlADHBZyduPPgyylDtJgdrMQ8Y5dGfct6PzHO9R/Cd6fnahrAVupA
         rhP1pqm5Ehh8u93d13EIcctbjp0LzJbLwiVnEbMqgw/9cdEa9zdUTQ6AJM2+4W/gljcN
         8XDA==
X-Forwarded-Encrypted: i=1; AFNElJ9uy0J7Cq+/8yqo9EHu6ELZS7j5bVZB6V8Eky7STBeKGhfG4LJxZQrlMC8udR+FBQidBGwb7MDWVcFRK2iB@vger.kernel.org
X-Gm-Message-State: AOJu0YzTutjJ7AohzH7n/YOfzRQL8U/HKSm8RmbBGdb1HzAQBYGDckqt
	7D0iMameBO/57FISs505wJNRehU3s6MqAuLV8U/NRDQYQi4rawgik7lw
X-Gm-Gg: Acq92OHue5e420DnfyQwygKjSUEn80JZwfZRdl/I6cryUY4Akvozw/zU7SGW8qDO2oj
	5Ots8pNVOJqJkGv31q2iGcwE7Q/Gu/1QJOu1W50dySKW7gMrT+IU8dJTl7/ikvwJ5RqRfukQqa8
	IURbomFXzgsgT6op7Bz8MhWoRkYj1TlkIhhLMkLxoqzk+L4HatzsN3GjtlEITBQmL/okGWbONHI
	zGyuE78Yvah3xLjS/mkCjLV6zbX++s6zYT/HMVUwHqxym+ZzvBQprZgPBHLsDGBuJuw6BUEhq7m
	bwdZuVzyju4MsHD/QYEtwgN43AGTInCLqhB7fTdnjHRXY8dNrGdQt0zLsDvHuIiaQHDCqZco3FD
	KDdZUzPEN7RJyRz5KR1SNSqfBUE0zeQOEiE9iTDQHounGj2SU5m30snAH/+w5dVsMcPmCUXxy9Z
	9/eYrzESCiAkHwCmFJb+9vZbGzyRPw1PepGK5fqvet
X-Received: by 2002:a05:6a21:4593:b0:3b3:c7e:fda4 with SMTP id adf61e73a8af0-3b4282f7e34mr15886899637.47.1780376030018;
        Mon, 01 Jun 2026 21:53:50 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422e712309sm8865701b3a.59.2026.06.01.21.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:53:49 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: serialize volume label accesses
Date: Tue,  2 Jun 2026 13:53:24 +0900
Message-ID: <20260602-t-serialize-label-v1-1-a7f753bd3c79@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3390; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=De5Qct0iEAS2GOuoTujA9XT9eX4PKykAs+ktejEC76o=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqHmGtrdQIXyFoRJ7ONwW8WZW57XVPMDuqMBxU/
 aAXLh4AccaJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCah5hrQAKCRA08jD6945I
 0wrrD/93wjAYLIn9kaMKnblUpvRAvH/ox2NeK2r7HomcFvJVjmgJV4bf4hpo3hp4FJiwDSQxe4Y
 pnfw1EDggpJMvOUtSO1Krrrbx1/UAQcRRn9GKBX/wmlZ4fvH2CBhIhLJF5vQejmJgvOa6QrCurh
 bQsrYFM/mYMy5lWXT20BzgdY7ttfPUz5nkcF1pgXHibqv4TEB3fZ92FrxqrmPW7+NDOuh+Jy47L
 qeq44Z77TrGs4zKH5VpOC4lwiH/+rUefaY1+SeMGtjXrvAq44fwGTwmjudASTfStZT/V1VKtXhF
 40p+pTw2/hassh9cPIcpl1oNyD70dWnAqZBJAbAL349hrANuOUbe3JwzELIIB50hpoS127L8uDs
 43qUKXJAHBiE5LswOgMSqTCyTXpyIVqyhpEIxOKNaiDKzTxCeHgXvxO9vDY1OAiJvwz4evk92mz
 uRDZz19iXKH+GS5L133ent2+RabIHifYuhywz3nZwO95dxAWRXGnPbktM1NG9HoH96Px3/aBePY
 NH2eWCfaB83Z4QF+9GmvSw24qurOGbKWerkYL0Dwwl+B9Qw1kLs/h6HN4Bws2gBI6OXnV3011q/
 iUGV3OREANo7dFzZrSQ+e0d2w6NT5z8SScbfTQjpFcH6mjgMBT97WHscOZWjpodYgulARyZZHck BLMkz8jE2kPY9rQ==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Protect vol->volume_label with a mutex and snaphost the label before
copy_to_user. This prevent a use-after-free when FS_IOC_SETFSLABEL
replaces the vol->volume_label and FS_IOC_GETTSLABEL reads it
concurrently.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/file.c   | 17 +++++++++++++----
 fs/ntfs/super.c  | 19 +++++++++++++------
 fs/ntfs/volume.h |  2 ++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e8bea22b81a7..264cf8404385 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -707,12 +707,21 @@ static int ntfs_ioctl_get_volume_label(struct file *filp, unsigned long arg)
 {
 	struct ntfs_volume *vol = NTFS_SB(file_inode(filp)->i_sb);
 	char __user *buf = (char __user *)arg;
+	char label[FSLABEL_MAX];
+	ssize_t len;
 
+	mutex_lock(&vol->volume_label_lock);
 	if (!vol->volume_label) {
-		if (copy_to_user(buf, "", 1))
-			return -EFAULT;
-	} else if (copy_to_user(buf, vol->volume_label,
-				MIN(FSLABEL_MAX, strlen(vol->volume_label) + 1)))
+		label[0] = '\0';
+		len = 0;
+	} else {
+		len = strscpy(label, vol->volume_label, sizeof(label));
+		if (len == -E2BIG)
+			len = FSLABEL_MAX - 1;
+	}
+	mutex_unlock(&vol->volume_label_lock);
+
+	if (copy_to_user(buf, label, len + 1))
 		return -EFAULT;
 	return 0;
 }
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 2a5ad7d56bc2..045656fa44f8 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -452,17 +452,23 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 	ret = ntfs_resident_attr_record_add(vol_ni, AT_VOLUME_NAME, AT_UNNAMED, 0,
 					    (u8 *)uname, uname_len * sizeof(__le16), 0);
 out:
-	mutex_unlock(&vol_ni->mrec_lock);
-	kvfree(uname);
-
 	if (ret >= 0) {
-		kfree(vol->volume_label);
+		char *old_label;
+
+		mutex_lock(&vol->volume_label_lock);
+		old_label = vol->volume_label;
 		vol->volume_label = new_label;
+		mutex_unlock(&vol->volume_label_lock);
+
+		kfree(old_label);
 		mark_inode_dirty_sync(vol->vol_ino);
 		ret = 0;
-	} else {
-		kfree(new_label);
 	}
+	mutex_unlock(&vol_ni->mrec_lock);
+	kvfree(uname);
+
+	if (ret < 0)
+		kfree(new_label);
 	return ret;
 }
 
@@ -2508,6 +2514,7 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 	NVolSetCaseSensitive(vol);
 	init_rwsem(&vol->mftbmp_lock);
 	init_rwsem(&vol->lcnbmp_lock);
+	mutex_init(&vol->volume_label_lock);
 
 	fc->s_fs_info = vol;
 	fc->ops = &ntfs_context_ops;
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index e13e1423b2a9..3348394dbc0d 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -72,6 +72,7 @@
  * @vol_flags: Volume flags.
  * @major_ver: Ntfs major version of volume.
  * @minor_ver: Ntfs minor version of volume.
+ * @volume_label_lock: protects @volume_label.
  * @volume_label: volume label.
  * @root_ino: The VFS inode of the root directory.
  * @secure_ino: The VFS inode of $Secure (NTFS3.0+ only, otherwise NULL).
@@ -131,6 +132,7 @@ struct ntfs_volume {
 	struct inode *logfile_ino;
 	struct inode *lcnbmp_ino;
 	struct rw_semaphore lcnbmp_lock;
+	struct mutex volume_label_lock;
 	struct inode *vol_ino;
 	__le16 vol_flags;
 	u8 major_ver;

---
base-commit: 990319fe6bfbd0e3da3a777052a48f8f22636404
change-id: 20260602-t-serialize-label-e63b90a1c201

Best regards,
-- 
Thanks,
Hyunchul

