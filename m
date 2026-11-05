Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892170;
	b=DPpQmWtGOo8mC2A8DRkDD6GHfsqjdmdDORU8MkM3Ig7Km+xp0GLC61FTfRzkIbnoVvC3
	 fQMyTjuYpD8WUW5DvzdR+Kr0uFdoDYdw5NPdH2sqWrU9LDkVKCDFKJirpWnSqDFf2Aag9
	 r1/b334FnJn58xigmFQsecyfDZc1GBmQPuge+yxiQR1O3wcDzTDqS2ktOomyaE9pzqQxD
	 p4ndWolRxQe7aDSI+VbSEtXAA0euPG0URs9tyJgMmHB0SpBCL7dleGObAwwlyoKzlQLUK
	 PoB21EqL21MYT37AkhJyNgcdG4dIdwkkiCLe8qG1EdQsAvgbTuMeeJTpl71/kpDtB/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xJYfi5g2zuSnSXCCV+vaULGoe+tZgbf+KcLjRuVRvl0=;
	b=X4rI5PHnMULR+9louVxShALuV6tJwNy8A6LYHDLeG+RreN0gjg37MV9Qy6ugFKmBkZmF
	 +OeaA9tKmZm9Lxg141kYLyU/1sid3jyunQaWFr0D3HGs72wdn1M7PxyO65YNOXEsIsinM
	 gjrmQcqNJO47fhOv0BuyfLwDnbLjOozKlF89GcXHibOe3aYE7XiP8BBuwDh/fBacyhQ5O
	 zWKlfLzQeDdZElbq4fsk/yqy07jPNytRHf4lxhkbg9i0R3dsKusrKn/+GOlmSW3u1acSU
	 EMrLWcY8VQDGN7ejqFRocDNt4ujjsPTZLyNKAEA2qzRDP6PEirvh1gXGqVyGKOhYn+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="X/dPG5lH";
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD84606A32E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD84606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=X/dPG5lH
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f079a63b8so190605985a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892169; x=1794496969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJYfi5g2zuSnSXCCV+vaULGoe+tZgbf+KcLjRuVRvl0=;
        b=X/dPG5lHSuvt6yi6rtg1orMQuOPGrHGThAsuGl10prX4ljoFpTACCJzvzyQ17gPgzv
         Z0ccOPXiB7o8j0O+uMo6Rl5ow7e0CDu+UAhFtJS/Xi8ogWHTKE0JeKwypDtSXgEIg1iO
         +3SRNVkJ9a11P1C6Fjvf3p9j717Xe/qoLZo64i9pbJTwZsrka2mZxX44jgmTwRgctJZg
         p03Pp2iRTGk0b49neBvC4H5hqDyVj9bNyZqr/efTi+5a6ARXPsM24h6rk90IIsTmQb0w
         p4tXBcaZuDsGXWgWSH6EQM5V7oGB1IeOAl7Z0DXnL9MTDssLVKVXy5KuVw6KkI0vKJjW
         3X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892169; x=1794496969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJYfi5g2zuSnSXCCV+vaULGoe+tZgbf+KcLjRuVRvl0=;
        b=PT+XIhrTv7BfyhGv0wZxmoyE+krDGpCkhleV8fE7zM5UvU0C7qiQfRtXjapiEHlRj0
         wz3CyXAkKeqTAjUgB4/X6PiizREk6AwtEL57EB5IWqDvZu1RpG8AwJ3HT94bG+263D0V
         LpR6c6h5Uvh/6kjlxiKF6juw8+8ZJ77oVQ7NQotpt1KX3XoxiifHtqUr+rd71bMtm7+w
         Idfq/woS4fZPA14RHFSkGbqXiqfdnzOpqLapWNg/vF7TxcxlsIGmZHAt+v7PxiAfefkQ
         vzav3VAMHdaYAyhw/pErVqiv3MqgQ+qb7X/6n0Xmz7EscEKW9iSNgLr8SXrjO2sj35Ut
         I5FA==
X-Gm-Message-State: APuU4Z9fWjD/6fw3Fl3s0jeLnd3K3vhvZOURlxzAeb8wtAfahcBY4+tp
	f+Sde0b0Z5D4feHbbAlnzP6fHNLTpDeNRyvi70rev8zUvnqFykJwzYdkiGJphwDHnQRncujQ8A2
	xaCAU2PQ=
X-Gm-Gg: AYBFou2gbLZwijhhiKI9RUgg9czMcMo9fFrlpJQ43aM2i9w5baGqslnCchDntTmwnLE
	SsO5K7fZADV6sKv4JvdZSAqrUQuNwcJEmgAB7Ulg6vnA2W55r88QvQ+z42Wj3YgjpqPqyI6tE1/
	0S626AXrDmdM86QRrdr8XPX3VpS3rn6zeZJceGZ8tkY8EyyPeR5SZJM6vDyo7Z9SzF3/xk9idzG
	mAiAupiB6K3tXPIN9kiW4QdxVq1VvHoNE/G8NbrF3qvyaI3Zkmik5ZPd0vW+ZRKDDCtnD2Gj7sb
	0NNfK7Jyvni5upL77Dg9DupLqzFyj0d2mypt4oJCK9kWo1hHUYm0Ee2BvRA9Q0IXKJ1caqW705n
	FqWVWUBREkHj5xJXh/ZXjUr4kIUqTaMSj8/JXuSZXCEMdAoSAjzqjfmIOKiX+z46XzuII/INE2+
	iW5ofbr1xSUlfR9Wr++PGQFsQCUxQSpy+bOcB8qV0nw7nF2w9CGgDVD4ZyKhBpJKBA7rXTxgfXZ
	nbgFccTjayPG5kZtFoCyjPGD3a7avSb8uHmwPLqFI09cgI3MCZTuvCUoidjdFthuGD2hBE9+T8G
	94MuOMe3xCoh8phqGwLPCDiDTSiQ38G5vfc8N9C7RK5k
X-Received: by 2002:a05:620a:28c6:b0:945:df59:e62c with SMTP id af79cd13be357-945df59ea90mr616362985a.61.1793892169185;
        Thu, 05 Nov 2026 07:22:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9a5d0656sm16382296d6.16.2026.11.05.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:22:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:53 +0000
Subject: [PATCH RFC v3 61/90] fs: accept a cellfd for MOUNT_ATTR_IDMAP
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
Message-Id: <20261105-b4-cells-v3-61-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=3291;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=pj31SOm7YhN2z/Z+1E3HdN5yhsS7Wipq66JFp95Wo/0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMZwjK0FbnpD+vbAPIynxe0pA6geEdHqcn0vbeS6RE+ART3eHfqSZcVz2It7s/NbKFeTyZq8WCN
 n2uuh799BDQU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The builder of a cell has to idmap the mounts that it puts into the tree
of the cell. But it cannot name the ids that the kernel chose for the
cell.

Accept a cellfd in mount_attr.userns_fd. It means "idmap this mount for
the cell": on-disk ids from 0 upwards map to the ids of the cell. This
works while the cell is being built, once its ids have been set.

mount_setattr() normally requires CAP_SYS_ADMIN over the user namespace.
That check stops a caller from mapping file ownership to ids that it does
not control. Here the ids belong to the cell and nobody else can hold
them, so the check is not needed. The checks that can_idmap_mount() makes
on the filesystem are unchanged.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c         | 13 +++++++++++++
 include/linux/cell.h   |  7 +++++++
 kernel/cell/boundary.c | 25 +++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 30167f8863bf..e2406d7f7bcc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5207,6 +5207,19 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	if (fd_empty(f))
 		return -EBADF;
 
+	/*
+	 * "For this cell." The ids on the caller's side of the mapping are
+	 * the cell's own, so there is nobody to ask about them. What is asked
+	 * about the filesystem is the same as ever.
+	 */
+	mnt_userns = cell_idmap_userns(fd_file(f));
+	if (mnt_userns) {
+		if (IS_ERR(mnt_userns))
+			return PTR_ERR(mnt_userns);
+		kattr->mnt_userns = mnt_userns;
+		return 0;
+	}
+
 	if (!proc_ns_file(fd_file(f)))
 		return -EINVAL;
 
diff --git a/include/linux/cell.h b/include/linux/cell.h
index 2107cd3c994b..f204c47ee783 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -249,4 +249,11 @@ bool cell_may_change_cgroup(struct cgroup *cgrp);
 static inline bool cell_may_change_cgroup(struct cgroup *cgrp) { return true; }
 #endif
 
+/* A mount is idmapped for a cell. */
+#ifdef CONFIG_CELLS
+struct user_namespace *cell_idmap_userns(const struct file *file);
+#else
+static inline struct user_namespace *cell_idmap_userns(const struct file *f) { return NULL; }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/kernel/cell/boundary.c b/kernel/cell/boundary.c
index 3f5cc898dc48..3891dfe899f2 100644
--- a/kernel/cell/boundary.c
+++ b/kernel/cell/boundary.c
@@ -8,6 +8,31 @@
 
 #include "internal.h"
 
+/**
+ * cell_idmap_userns - the user namespace to idmap a mount with, by cellfd
+ * @file: what was passed in mount_attr.userns_fd
+ *
+ * A cellfd there means "for this cell". It works while the cell is being built
+ * and once its ids have been set.
+ *
+ * Return: the user namespace of the cell with a reference, NULL if @file is no
+ * cellfd, or an ERR_PTR().
+ */
+struct user_namespace *cell_idmap_userns(const struct file *file)
+{
+	struct cell *cell = cell_from_file(file);
+
+	if (!cell)
+		return NULL;
+
+	guard(mutex)(&cell->lock);
+	if (cell->state != CELL_BUILDING)
+		return ERR_PTR(-EBUSY);
+	if (!cell->ids_count)
+		return ERR_PTR(-EINVAL);
+	return get_user_ns(cell->user_ns);
+}
+
 /**
  * cell_may_migrate - may a task be moved to a cgroup?
  * @task: the task

-- 
2.55.0

