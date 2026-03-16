Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162E32F75B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627608; cv=none; b=jcpaOI90txUEEqRyGmZ7nMM86kiU1EJoWoG/DGPzoEq6GUi8FO6XbWLyr//oFN5sNRjsflezqxtZ0S+RCzxzT5j/fvngP2JfOSXeH4lyDzBWjTjXcHj8QhVAC8IeT9EzpBIk3i+Vv8fFrD2G5k58nC6YybnCdSGWf9XMc4Uwzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627608; c=relaxed/simple;
	bh=BFn12q/PcX5u1Q/BEibtNFjMfcCylyZOmErLOd263kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drnyKdaEDztAggpauUUyRAAPwLZNKdrh2F30diDTcjh2W/vpyeMXO6+L1J8ukB/PgJmBdNh6T5EJvOnZmvuTV321Jbr7CRX4ZGPtq1XXz5klVimrjhE24sqIprZugrAMvWIeAQ3iCYbZiiL5Dwb3Xe4HlfqNLik0mCPDriQjpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2aANASEp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2aANASEp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a1e732e5eso13773787b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627603; x=1774232403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlvZCBfynoVe43rwQGevgcjJtoImZGbtB3B9yX9dzgM=;
        b=2aANASEpXGQgbSKlJLR2ty4KIyNL9sFoIiTesSL+axIribR4GWBvoghgEbEKIIePKL
         Q1zpLynaXSAy2Sae5FJlkhGhBx8HTD5XJkpPAgMh7bbOqYavBBLhnj3nyvUhsHW9w8p7
         dR11a5ocV06ovbybO5HoU2vTOPS4sWUxA4iSj9AHheywstz31EOaaXpMpdvxXyfokcKH
         39v8hOso13DM6gbSXQ0sPksFhiprGev8AkA+mBuHyr8d/Ajlb8pUJC2RwtB5PwaBv1jk
         Ia7I3ZRXMqCAq5vFDPp1dsQnF+U6LqWrJaIYaPm4JQdIqVuBAsIZPTA8U5tbnBdf4hs1
         22wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627603; x=1774232403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlvZCBfynoVe43rwQGevgcjJtoImZGbtB3B9yX9dzgM=;
        b=BUnSInaPm/s6gecqoz/k6J4rQICSS2q47pbgelFwyGIO8+LoN8TcmBPy16t4jS3ens
         aYIzAK1yn1RqfWGuQsRJH+fQeiDyHzjO3tA+OvEanXz0kgMXHPGMk/UnIoHUenr4C8VF
         AfE5yUBxme2gpf5iRzyAWLvAiUiLIRTo30S7Kj2a73+CAc74Rs0KofiQ4QQWzG6XNQMB
         RmI2HpmF0suqr+k4vNtZEtJbRzBd1/5dh5A6VTdn1xmS2fJl4Olt7u7L/PW+5wS21spW
         /o4eOjr6tHCjdit37SZZiUx8x0sWBMdvrALu9r3YkH5JMx/tpvv2mfciWSIMgPmtCDqy
         XNvw==
X-Gm-Message-State: AOJu0YzC7svZuobpCDTJ+2TLHalFo7sdsFBG77X4NuWjv/urOqtMqMi1
	1tGVW5u+39/k0LWVDGZxHtLCFLbPH/Z0+q8CkSORjMZHRI8QKgX6NX7wNwYNmX7Vj/DVcD+PouU
	6+Bqt
X-Gm-Gg: ATEYQzwzDTfUK7juDYS+lmQQvEaj7qq2c6W1s+Qat5dMJuB3yAr5WgtukgbT5FhZvWE
	2flcRvI9qXRsF0U6c+20Lnd4pXXJOenNu/5F3YdHPXCa3HmawUJ2A6Mz7huh37HR0jKR69FmqOR
	0z3kR5RqMQvILXlLtLU3uZArIfDX5TXIThhYJLoOAszTTdhF34MsUR7J7KfNVTIXbskkuYapI3r
	ZFQ8rRr+jLvddLlW6ve6J5jX95wSicwrv/nlEdtw/jNpW7VDjGMYUNj6jKdIsk7qdLcqfRvS2Qq
	fgah9vPPB3dxN+ayBezjbU2j4pB58az20sJeji1G3K6yoe4Cu5PMSSGvsk2kceX7r5sl3uLyvTB
	JyFPrN+fFTLbYFuXcto+TmY7Qns+Tm/VGGfk1Dc2gTt563VdKkzqbIFmlAqma7Spph+IdX8JobO
	5U7woSwj1jAUvGDZ2y0nAh9KF+cIE7CxHgB0LD7eXeVZEC/nApsTqodv7UpS7MeOZdmULe5bmWx
	XyBbgPAOdUNoYTtvIRwYXba
X-Received: by 2002:a05:690c:102:b0:796:360f:e1d4 with SMTP id 00721157ae682-79a1c1ddd04mr118221157b3.55.1773627602667;
        Sun, 15 Mar 2026 19:20:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:20:02 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 71/79] ssdfs: implement IOCTL operations
Date: Sun, 15 Mar 2026 19:17:57 -0700
Message-ID: <20260316021800.1694650-31-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316021800.1694650-1-slava@dubeyko.com>
References: <20260316021800.1694650-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete patchset is available here:
https://github.com/dubeyko/ssdfs-driver/tree/master/patchset/linux-kernel-6.18.0

This patch implements IOCTL operations.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/ioctl.c | 453 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/ioctl.h |  58 ++++++
 2 files changed, 511 insertions(+)
 create mode 100644 fs/ssdfs/ioctl.c
 create mode 100644 fs/ssdfs/ioctl.h

diff --git a/fs/ssdfs/ioctl.c b/fs/ssdfs/ioctl.c
new file mode 100644
index 000000000000..c02f81d16d90
--- /dev/null
+++ b/fs/ssdfs/ioctl.c
@@ -0,0 +1,453 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ioctl.c - IOCTL operations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/kernel.h>
+#include <linux/rwsem.h>
+#include <linux/pagevec.h>
+#include <linux/mount.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "folio_vector.h"
+#include "ssdfs.h"
+#include "testing.h"
+#include "ioctl.h"
+
+static int ssdfs_ioctl_getflags(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	unsigned int flags;
+
+	flags = ii->flags & SSDFS_FL_USER_VISIBLE;
+	return put_user(flags, (int __user *) arg);
+}
+
+static int ssdfs_ioctl_setflags(struct file *file, void __user *arg)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct inode *inode = file_inode(file);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	unsigned int flags, oldflags;
+	int err = 0;
+
+	err = mnt_want_write_file(file);
+	if (err)
+		return err;
+
+	if (!inode_owner_or_capable(idmap, inode))
+		return -EACCES;
+
+	if (get_user(flags, (int __user *)arg))
+		return -EFAULT;
+
+	flags = ssdfs_mask_flags(inode->i_mode, flags);
+
+	inode_lock(inode);
+	down_write(&ii->lock);
+
+	oldflags = ii->flags;
+
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by the
+	 * relevant capability.
+	 */
+	if ((flags ^ oldflags) & (SSDFS_APPEND_FL | SSDFS_IMMUTABLE_FL)) {
+		if (!capable(CAP_LINUX_IMMUTABLE)) {
+			err = -EPERM;
+			goto out_unlock_inode;
+		}
+	}
+
+	flags = flags & SSDFS_FL_USER_MODIFIABLE;
+	flags |= oldflags & ~SSDFS_FL_USER_MODIFIABLE;
+	ii->flags = flags;
+
+	ssdfs_set_inode_flags(inode);
+	inode_set_ctime_to_ts(inode, current_time(inode));
+	mark_inode_dirty(inode);
+
+out_unlock_inode:
+	up_write(&ii->lock);
+	inode_unlock(inode);
+	mnt_drop_write_file(file);
+	return err;
+}
+
+static int ssdfs_ioctl_do_testing(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_testing_environment env;
+
+	if (copy_from_user(&env, arg, sizeof(env)))
+		return -EFAULT;
+
+	return ssdfs_do_testing(fsi, &env);
+}
+
+static int ssdfs_ioctl_create_snapshot(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_CREATE_SNAPSHOT;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		ssdfs_snapshot_request_free(snr);
+		goto finish_create_snapshot;
+	}
+
+	ssdfs_snapshot_reqs_queue_add_tail(&fsi->snapshots.reqs_queue, snr);
+
+finish_create_snapshot:
+	return err;
+}
+
+static int ssdfs_ioctl_list_snapshots(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_LIST_SNAPSHOTS;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		goto finish_list_snapshots;
+	}
+
+	err = ssdfs_execute_list_snapshots_request(&fsi->snapshots, snr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get the snapshots list: "
+			  "err %d\n", err);
+		goto finish_list_snapshots;
+	}
+
+	if (copy_to_user((struct ssdfs_snapshot_info __user *)arg,
+			 &snr->info, info_size)) {
+		err = -EFAULT;
+		goto finish_list_snapshots;
+	}
+
+finish_list_snapshots:
+	if (!snr)
+		ssdfs_snapshot_request_free(snr);
+
+	return err;
+}
+
+static int ssdfs_ioctl_modify_snapshot(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_MODIFY_SNAPSHOT;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		goto finish_modify_snapshot;
+	}
+
+	err = ssdfs_execute_modify_snapshot_request(fsi, snr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to modify snapshot: "
+			  "err %d\n", err);
+		goto finish_modify_snapshot;
+	}
+
+finish_modify_snapshot:
+	if (!snr)
+		ssdfs_snapshot_request_free(snr);
+
+	return err;
+}
+
+static int ssdfs_ioctl_remove_snapshot(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_REMOVE_SNAPSHOT;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		goto finish_remove_snapshot;
+	}
+
+	err = ssdfs_execute_remove_snapshot_request(&fsi->snapshots, snr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete snapshot: "
+			  "err %d\n", err);
+		goto finish_remove_snapshot;
+	}
+
+finish_remove_snapshot:
+	if (!snr)
+		ssdfs_snapshot_request_free(snr);
+
+	return err;
+}
+
+static int ssdfs_ioctl_remove_range(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_REMOVE_RANGE;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		goto finish_remove_range;
+	}
+
+	err = ssdfs_execute_remove_range_request(&fsi->snapshots, snr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to remove range of snapshots: "
+			  "err %d\n", err);
+		goto finish_remove_range;
+	}
+
+finish_remove_range:
+	if (!snr)
+		ssdfs_snapshot_request_free(snr);
+
+	return err;
+}
+
+static int ssdfs_ioctl_show_snapshot_details(struct file *file,
+					     void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_SHOW_SNAPSHOT_DETAILS;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		goto finish_show_snapshot_details;
+	}
+
+	err = ssdfs_execute_show_details_request(&fsi->snapshots, snr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to show snapshot's details: "
+			  "err %d\n", err);
+		goto finish_show_snapshot_details;
+	}
+
+	if (copy_to_user((struct ssdfs_snapshot_info __user *)arg,
+			 &snr->info, info_size)) {
+		err = -EFAULT;
+		goto finish_show_snapshot_details;
+	}
+
+finish_show_snapshot_details:
+	if (!snr)
+		ssdfs_snapshot_request_free(snr);
+
+	return err;
+}
+
+static int ssdfs_ioctl_list_snapshot_rules(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_snapshot_request *snr = NULL;
+	size_t info_size = sizeof(struct ssdfs_snapshot_info);
+	int err = 0;
+
+	snr = ssdfs_snapshot_request_alloc();
+	if (!snr) {
+		SSDFS_ERR("fail to allocate snaphot request\n");
+		return -ENOMEM;
+	}
+
+	snr->operation = SSDFS_LIST_SNAPSHOT_RULES;
+	snr->ino = inode->i_ino;
+
+	if (copy_from_user(&snr->info, arg, info_size)) {
+		err = -EFAULT;
+		goto finish_list_snapshot_rules;
+	}
+
+	err = ssdfs_execute_list_snapshot_rules_request(fsi, snr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get the snapshot rules list: "
+			  "err %d\n", err);
+		goto finish_list_snapshot_rules;
+	}
+
+	if (copy_to_user((struct ssdfs_snapshot_info __user *)arg,
+			 &snr->info, info_size)) {
+		err = -EFAULT;
+		goto finish_list_snapshot_rules;
+	}
+
+finish_list_snapshot_rules:
+	if (!snr)
+		ssdfs_snapshot_request_free(snr);
+
+	return err;
+}
+
+static int ssdfs_ioctl_tunefs_get_fs_config(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_tunefs_options config;
+	size_t options_size = sizeof(struct ssdfs_tunefs_options);
+
+	memset(&config, 0, options_size);
+
+	ssdfs_tunefs_get_current_volume_config(fsi, &config.old_config);
+	ssdfs_tunefs_get_new_config_request(fsi, &config.new_config);
+
+	if (copy_to_user((struct ssdfs_tunefs_options __user *)arg,
+			 &config, options_size)) {
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int ssdfs_ioctl_tunefs_set_fs_config(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_tunefs_options config;
+	size_t options_size = sizeof(struct ssdfs_tunefs_options);
+	int err = 0;
+
+	if (copy_from_user(&config, arg, options_size)) {
+		return -EFAULT;
+	}
+
+	ssdfs_tunefs_get_current_volume_config(fsi, &config.old_config);
+
+	err = ssdfs_tunefs_check_requested_volume_config(fsi, &config);
+	if (!err)
+		ssdfs_tunefs_save_new_config_request(fsi, &config);
+
+	if (copy_to_user((struct ssdfs_tunefs_options __user *)arg,
+			 &config, options_size)) {
+		return -EFAULT;
+	}
+
+	return err;
+}
+
+/*
+ * The ssdfs_ioctl() is called by the ioctl(2) system call.
+ */
+long ssdfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case FS_IOC_GETFLAGS:
+		return ssdfs_ioctl_getflags(file, argp);
+	case FS_IOC_SETFLAGS:
+		return ssdfs_ioctl_setflags(file, argp);
+	case SSDFS_IOC_DO_TESTING:
+		return ssdfs_ioctl_do_testing(file, argp);
+	case SSDFS_IOC_CREATE_SNAPSHOT:
+		return ssdfs_ioctl_create_snapshot(file, argp);
+	case SSDFS_IOC_LIST_SNAPSHOTS:
+		return ssdfs_ioctl_list_snapshots(file, argp);
+	case SSDFS_IOC_MODIFY_SNAPSHOT:
+		return ssdfs_ioctl_modify_snapshot(file, argp);
+	case SSDFS_IOC_REMOVE_SNAPSHOT:
+		return ssdfs_ioctl_remove_snapshot(file, argp);
+	case SSDFS_IOC_REMOVE_RANGE:
+		return ssdfs_ioctl_remove_range(file, argp);
+	case SSDFS_IOC_SHOW_DETAILS:
+		return ssdfs_ioctl_show_snapshot_details(file, argp);
+	case SSDFS_IOC_LIST_SNAPSHOT_RULES:
+		return ssdfs_ioctl_list_snapshot_rules(file, argp);
+	case SSDFS_IOC_TUNEFS_GET_CONFIG:
+		return ssdfs_ioctl_tunefs_get_fs_config(file, argp);
+	case SSDFS_IOC_TUNEFS_SET_CONFIG:
+		return ssdfs_ioctl_tunefs_set_fs_config(file, argp);
+	}
+
+	return -ENOTTY;
+}
diff --git a/fs/ssdfs/ioctl.h b/fs/ssdfs/ioctl.h
new file mode 100644
index 000000000000..405e85a5f528
--- /dev/null
+++ b/fs/ssdfs/ioctl.h
@@ -0,0 +1,58 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ioctl.h - IOCTL related declaration.
+ *
+ * Copyright (c) 2019-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_IOCTL_H
+#define _SSDFS_IOCTL_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#include "testing.h"
+#include "snapshot.h"
+
+#define SSDFS_IOCTL_MAGIC 0xdf
+
+/*
+ * SSDFS_IOC_DO_TESTING - run internal testing
+ */
+#define SSDFS_IOC_DO_TESTING _IOW(SSDFS_IOCTL_MAGIC, 1, \
+				  struct ssdfs_testing_environment)
+
+/*
+ * Snapshot related IOCTLs
+ */
+#define SSDFS_IOC_CREATE_SNAPSHOT	_IOW(SSDFS_IOCTL_MAGIC, 2, \
+					     struct ssdfs_snapshot_info)
+#define SSDFS_IOC_LIST_SNAPSHOTS	_IOWR(SSDFS_IOCTL_MAGIC, 3, \
+					     struct ssdfs_snapshot_info)
+#define SSDFS_IOC_MODIFY_SNAPSHOT	_IOW(SSDFS_IOCTL_MAGIC, 4, \
+					     struct ssdfs_snapshot_info)
+#define SSDFS_IOC_REMOVE_SNAPSHOT	_IOW(SSDFS_IOCTL_MAGIC, 5, \
+					     struct ssdfs_snapshot_info)
+#define SSDFS_IOC_REMOVE_RANGE		_IOW(SSDFS_IOCTL_MAGIC, 6, \
+					     struct ssdfs_snapshot_info)
+#define SSDFS_IOC_SHOW_DETAILS		_IOWR(SSDFS_IOCTL_MAGIC, 7, \
+					     struct ssdfs_snapshot_info)
+#define SSDFS_IOC_LIST_SNAPSHOT_RULES	_IOWR(SSDFS_IOCTL_MAGIC, 8, \
+					     struct ssdfs_snapshot_info)
+
+/*
+ * The tunefs related IOCTLs
+ */
+#define SSDFS_IOC_TUNEFS_GET_CONFIG	_IOR(SSDFS_IOCTL_MAGIC, 9, \
+					     struct ssdfs_tunefs_options)
+#define SSDFS_IOC_TUNEFS_SET_CONFIG	_IOWR(SSDFS_IOCTL_MAGIC, 10, \
+					     struct ssdfs_tunefs_options)
+
+#endif /* _SSDFS_IOCTL_H */
-- 
2.34.1

