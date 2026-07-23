Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B04749D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807338; cv=none; b=lWOl3rILTfDDVc3NQIjsitzoe+pObqLmIeKxcGu0BgSVzj318CLpEDtEGcJcLFkFyPj2LPbF02g3P5dQm7n+ZYWW+FdLcFl8gNY9MX7y79TJYzAEhC5DkjPzeoluAglxzFW14vuxre32UlW+0y4qcxVpGCHoyJ0+NFbcv2yDfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807338; c=relaxed/simple;
	bh=Kt1hCqrqQM/bckgN4lFfrytum0aHe7wnFG6iCEtQeXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdRB6sQS9l/TTXsmrcYyBz+PdFwuawZvx7f//1IlEzMA/U65h/xgulV0Zin43Ux2rI2twuAQ9e4OYF29/M5ENvN9WL2vrKuwdtbKje2oO6pGbK86DU4iRkYEMcxbI9QZ7Xuqw3dflDjTSdJv5fDNSqHbROK/SISHjx569PyuGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7crwoQg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7crwoQg"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so857064a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784807331; x=1785412131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/MQeRks0wSOXitJI8AnJaZEFhJZHq3MAOM6m19ooxw=;
        b=k7crwoQgCQuKVrxKBOtS5hTFrJme7toQL5gXZF7GSo+IHwvDkK98yQ32EBN/SoiSbj
         iGJbG30381M7hgycL056rIxVpmhC3vKojj+3G7WKin6HZXrO8h6yWTJR93jMqk0a6fyk
         9jRzNnE7T0yoZ7dwGmoDpa99Ia4DWvx03gf51jZczvGP0vUF4m3auprfEGMxroiHHrUp
         fL4uxBZQsBChJ8xy1gvLZ34FQHT8WK2gHpB2CF7nx/WbEElaRut3NP74h7CY8uYsv5W2
         D5WaV8lZeuJhbZJnbV8hmw/ugpGvnfLopSbkx7TVtlRDBFmnGiFJoUPXt5xSjG1YK/1/
         4XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807331; x=1785412131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/MQeRks0wSOXitJI8AnJaZEFhJZHq3MAOM6m19ooxw=;
        b=R1pTJVpRxwCYxiGuxjLPMh3wCMz0YOTLxq9DIwKBGIR6zZBv0HTNZ0FQqJpJKWXuxt
         MrcdiVJcAKgF9eAWNZztkOz3YEzPH0BVpZniUGAzJp/e5kT5mYEstxJubgFuFXB27b7K
         6zGNX8tIiK7/+2lwhRRipZzQ7UYzZNOo+07do4E24EwBimjzmCkGdLLZCiyPr1fbaLr6
         tdFAfMXghqAnDo7cxs+A2JIrsdN8VwzpK8Z3lGoN7JLZMdYlZSwO+8On7eAGcf31wIKP
         pss+guHFzte90n4HWOG1/C7ZDejSn/4aU1ytzEQN3nTjSfrSwJsvtZP5f37jkzgL25cd
         4qOg==
X-Forwarded-Encrypted: i=1; AHgh+RqqNR0T+OcqBkBziDwkD4KosL6+MQSGWKjfhK+qvMvOkPbr957+5srp++mM0u7+HLTfrO2mGtNZg8EhVrIj@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMsskMbYe/mhFSt8PR3EVMgVrAj7eUuqB3mL1wsbi6U+RJNZz
	HGJAiZjE84H86L2DtMlPnLuhYucLdu9g2suKVHod6ihskHL50ZuVy743
X-Gm-Gg: AR+sD10ueeRvCQ9NN0uWfjw7b/AVBXaD1eeAd4g9CGF3akVPGfCGGA4Cd4XlpcfP1p9
	LOb7+sExuY0gFFTXkoC62sBwAHV1nCp5e570jEt0t9DeoIX8HczanUxT9vdNC4jC0jXasF4qtKs
	dFC/CXDpBwK6Le0orREug9ep3Xtox7MLouyrjmgchfhiwbbzRZNPxhGSVWOHpRzYTBYIl/WEdoY
	7Kf/Mj1UO5v4oPqsPOnixQqhDHNNRk25yHWWU8+zWxSBEgCt8/tHJCCdNC2ljeXo/i6WADCEvOP
	v8n57/2LVV7aYXSbS2rikBHqAPp3bCobpy9IXobrVNBCwKxe3oV97LUv+wkSG1YgHsYRe/WfmCl
	RrpdeVHdLiG/psiJM58sWmeMmEQ4o4Yer50lLeInUvcGTILmoMJfxEIn0/Z5UwmOBVPlY4MI/y4
	ZldAdNJjURvpGzpvHmYmrZZXFm0gM=
X-Received: by 2002:a05:6402:21da:b0:698:52b4:c2c9 with SMTP id 4fb4d7f45d1cf-69f6ab2452bmr1012692a12.31.1784807330916;
        Thu, 23 Jul 2026 04:48:50 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f35039aa1sm1956131a12.30.2026.07.23.04.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:48:50 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 1/5] fs: clarify cross-sb copy_file_range() code
Date: Thu, 23 Jul 2026 13:48:44 +0200
Message-ID: <20260723114848.1212429-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723114848.1212429-1-amir73il@gmail.com>
References: <20260723114848.1212429-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cross-sb copy file range code is a bit complicated and spreads across
two different functions.

Use a helper copy_file_fs_cmp() an enum and switch statement to clarify
the mutual exclusive types of copy.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 70 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e8c14e2760b20..d1565a56d089d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1472,6 +1472,35 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
+enum {
+	FS_COPY_SPLICE = 0,
+	FS_COPY_SAME_SB = 1,
+	FS_COPY_SAME_FS = 2,
+	FS_COPY_CROSS_FS = 3,
+};
+
+/*
+ * Check if src and dst file are on the same filesystem.
+ * nfs and cifs define several different file_system_type structures
+ * and several different sets of file_operations, but they all end up
+ * using the same ->copy_file_range() function pointer.
+ * COPY_FILE_SPLICE is an opt-in flag for cross-fs copy (e.g. from nfsd),
+ * so do not compare src<->dst filesystems in this case.
+ */
+static int copy_file_fs_cmp(struct file *f_in, struct file *f_out,
+			    unsigned int flags)
+{
+	if (flags & COPY_FILE_SPLICE)
+		return FS_COPY_SPLICE;
+	else if (f_out->f_op->copy_file_range &&
+		 f_out->f_op->copy_file_range == f_in->f_op->copy_file_range)
+		return FS_COPY_SAME_FS;
+	else if (file_inode(f_in)->i_sb == file_inode(f_out)->i_sb)
+		return FS_COPY_SAME_SB;
+	else
+		return FS_COPY_CROSS_FS;
+}
+
 /*
  * Performs necessary checks before doing a file copy
  *
@@ -1481,7 +1510,7 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
  */
 static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
-				    size_t *req_count, unsigned int flags)
+				    size_t *req_count, int fscmp)
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
@@ -1498,18 +1527,13 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	 * a file of the wrong filesystem type to filesystem driver can result
 	 * in an attempt to dereference the wrong type of ->private_data, so
 	 * avoid doing that until we really have a good reason.
-	 *
-	 * nfs and cifs define several different file_system_type structures
-	 * and several different sets of file_operations, but they all end up
-	 * using the same ->copy_file_range() function pointer.
 	 */
-	if (flags & COPY_FILE_SPLICE) {
+	if (fscmp == FS_COPY_SPLICE) {
 		/* cross sb splice is allowed */
 	} else if (file_out->f_op->copy_file_range) {
-		if (file_in->f_op->copy_file_range !=
-		    file_out->f_op->copy_file_range)
+		if (fscmp != FS_COPY_SAME_FS)
 			return -EXDEV;
-	} else if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb) {
+	} else if (fscmp != FS_COPY_SAME_SB) {
 		return -EXDEV;
 	}
 
@@ -1556,13 +1580,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 {
 	ssize_t ret;
 	bool splice = flags & COPY_FILE_SPLICE;
-	bool samesb = file_inode(file_in)->i_sb == file_inode(file_out)->i_sb;
+	int fscmp = copy_file_fs_cmp(file_in, file_out, flags);
 
 	if (flags & ~COPY_FILE_SPLICE)
 		return -EINVAL;
 
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
-				       flags);
+				       fscmp);
 	if (unlikely(ret))
 		return ret;
 
@@ -1591,19 +1615,27 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * same sb using clone, but for filesystems where both clone and copy
 	 * are supported (e.g. nfs,cifs), we only call the copy method.
 	 */
-	if (!splice && file_out->f_op->copy_file_range) {
+	switch (fscmp) {
+	case FS_COPY_SPLICE:
+		break;
+	case FS_COPY_SAME_FS:
 		ret = file_out->f_op->copy_file_range(file_in, pos_in,
 						      file_out, pos_out,
 						      len, flags);
-	} else if (!splice && file_in->f_op->remap_file_range && samesb) {
-		ret = file_in->f_op->remap_file_range(file_in, pos_in,
-				file_out, pos_out, len, REMAP_FILE_CAN_SHORTEN);
-		/* fallback to splice */
+		break;
+	case FS_COPY_SAME_SB:
+		if (file_in->f_op->remap_file_range)
+			ret = file_in->f_op->remap_file_range(file_in, pos_in,
+							file_out, pos_out, len,
+							REMAP_FILE_CAN_SHORTEN);
+		/* Fallback to splice for same sb copy for backward compat */
 		if (ret <= 0)
 			splice = true;
-	} else if (samesb) {
-		/* Fallback to splice for same sb copy for backward compat */
-		splice = true;
+		break;
+	case FS_COPY_CROSS_FS:
+		/* This should have failed in generic_copy_file_checks() */
+		ret = -EXDEV;
+		break;
 	}
 
 	file_end_write(file_out);
-- 
2.54.0

