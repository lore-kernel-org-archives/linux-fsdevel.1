Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6D4749C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807349; cv=none; b=HjcoGmdja/p19Og3eHeFmavoX745c2o2emylbFG+JRkrG1Lp3TVGO/JsOSUbJe7WCqs1w3dI/670qlxl4bsedKCudQj2ir/iVOROzq1vXmX7lfM1rnucB+p2U/hDtN+v2Z+XyBoUSqAP2zVL3ET1LW3XQYVGso0IxexiYw+QxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807349; c=relaxed/simple;
	bh=x+d1jypuxETb9FgFseEPTf2up4i16XU24UDMe1Itres=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIoRfJm3qfHnuprAMt5fGXpKg/zduqLDkRWMg/1B3UeUJB+bNFQHRhOscWJynTuF8mlnxdUPYF8sT2Vko/6dxJnwg5/LFBtnk46tflGA0NznvUSPVSPjECr5LL1HXTW/1hA/vsWx5Kn1w97Grpww6/7as8Jbu6p35HpOy7vfjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkyoa6CP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkyoa6CP"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c12614b81c9so85873066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784807333; x=1785412133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WK5d6Q5O0McCeEqTCK8B2ifbG3I72Iar45UioZAgOqw=;
        b=rkyoa6CPKvaIHiYjgwY1jt2K/ET/IwoZPhafKRNSXs7vqdCqINMVMYQovBwZ63+54f
         0tzOquFSWS6vdQ9JG8lV6v2oGwfwYR6/FeFjZoTXBr9YoPPSeNpxZWdFXRIz9WYD7xSX
         oVUbUyssxT1lgwCU4oFDdnzPepYUXGKSyIFoZRp6eG4iczwg0FclW8ujaY+3QIFf4XkJ
         lai5gPmKZqGLj7DrEh7iunTignGWt63RcCBm5Yvpgjn6BJbi/0oCBQzRl6G2usjS1rHF
         q6+uXhb0sql6WhOji6ZhtFTn1UT+abBbIEY0muO7FW5r0J3+CoA29+Hzd6KIkMWCMYli
         9n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807333; x=1785412133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WK5d6Q5O0McCeEqTCK8B2ifbG3I72Iar45UioZAgOqw=;
        b=C5IcmqicogDal2w2JMbcqHDMTJR+C4Rk8NteTLunUG1BoRHRakwArg5PN7g9mPeK2I
         v0/bG3Q01XDX2W3sRxJpCSjcpOpi/q7Lg1ro2wKvHtMdK1dFU8Q81hv12CfqxBYYx3ST
         ZSnqBkOTGJu6em1RYaw181RPoi/S3mwniX9OmUBjb9dMz1x99mdVYHRPwXiklwJ0p6mJ
         HfugV6VQ1Vq8MzsddhJHYpz1kZzSYq0uF0ULbtWYDZTtxrxi7968064sAYSr7WmY6/lO
         nG+pmIT1Xk5WZBhPiJUaURbJxsMP8Kfw2guQ//ehXo5zou9xqxQkfqWFZ9mgncam/F8/
         RSKg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/xh4UBmh3vGsD6l/0K8YrrJTwxH7ryePWOuJg4SX4Vy8VQiBiwdcq7bq0J3kBiKUISOVnim6ku1c6DDFK@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZP64VOhW1LErnP1rQTtZ7gFEg7V/Br5E+6xMrknA4P5uf1ll
	bLqtk02UEc+v8ek/wy67+ulL4iK9T2cSXyHkH18LHxOU4LGnzmpCV1Ae
X-Gm-Gg: AR+sD13TtFX4pwQXnVNsS3JEpFV4DoOkKhFhVIhZz+4pa1zMAGuV9b68f3t4+393cEj
	/qdufHzTyMP0d+06+JQsB0GiW3zSka+s4FQl89AnQHoSgrj1hu19/uqE58GzzgUZUxZf4pHHu2z
	oZypf4GWoUskKKZqZwQ6DBYfFU5CmsWPKWcVvUWY6sGA6IDFnKI7uasl68foWl/iD5mly8YnJJZ
	cKpUIEIvoCbSrIRVkzalY5lRy5ci/Fbsf5p/oFkFYFTTLvfW7fONZoIyFERuUNDIHTD341P/Nn4
	lnGDXm34uOc46l+w7fFf6Txv5jpmHUjYBIn3C+D0k1/+7RXPDb+AhNER77dRYcISoKWpkAYc4Wb
	xaEnp9jwwcympdK/qaFET7HLjbK5PJKZe6GB6Im8Rm2tmU3c5LfrAHuzIvaE/eCEIPKsGOvr5Qk
	CYZWF8vYdISVhLWfDsA5QqbJWYbunh/PqVDasMPA==
X-Received: by 2002:a17:907:a609:b0:c1c:5eb7:2ff0 with SMTP id a640c23a62f3a-c1c5eb73200mr32656266b.48.1784807333131;
        Thu, 23 Jul 2026 04:48:53 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac6ff3sm219006266b.19.2026.07.23.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:48:52 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 3/5] fs: add support for copy file range to another fs
Date: Thu, 23 Jul 2026 13:48:46 +0200
Message-ID: <20260723114848.1212429-4-amir73il@gmail.com>
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

Implement copy to other fs in vfs_copy_file_range() -
vfs must call the operation on the source filesystem and the source
filesystem (e.g. overlayfs) will typically call vfs helpers to write
to the other fs, so avoid taking freeze protection and fsnotify write
hooks in vfs_copy_file_range().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 78596d9c89119..846db21ac05ca 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1478,6 +1478,7 @@ enum {
 	FS_COPY_SAME_FS = 2,
 	FS_COPY_CROSS_FS = 3,
 	FS_COPY_FROM_OTHER_FS = 4,
+	FS_COPY_TO_OTHER_FS = 5,
 };
 
 /*
@@ -1498,6 +1499,8 @@ static int copy_file_fs_cmp(struct file *f_in, struct file *f_out,
 		return FS_COPY_SAME_FS;
 	else if (f_out->f_op->fop_flags & FOP_CROSS_FS_COPY)
 		return FS_COPY_FROM_OTHER_FS;
+	else if (f_in->f_op->fop_flags & FOP_CROSS_FS_COPY)
+		return FS_COPY_TO_OTHER_FS;
 	else if (file_inode(f_in)->i_sb == file_inode(f_out)->i_sb)
 		return FS_COPY_SAME_SB;
 	else
@@ -1534,8 +1537,9 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	 */
 	if (fscmp == FS_COPY_SPLICE) {
 		/* cross sb splice is allowed */
-	} else if (fscmp == FS_COPY_FROM_OTHER_FS) {
-		/* Copy from other fs is allowed */
+	} else if (fscmp == FS_COPY_FROM_OTHER_FS ||
+		   fscmp == FS_COPY_TO_OTHER_FS) {
+		/* Copy from/to other fs is allowed */
 	} else if (file_out->f_op->copy_file_range) {
 		if (fscmp != FS_COPY_SAME_FS)
 			return -EXDEV;
@@ -1587,6 +1591,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t ret;
 	bool splice = flags & COPY_FILE_SPLICE;
 	int fscmp = copy_file_fs_cmp(file_in, file_out, flags);
+	const struct file_operations *fop =
+		(fscmp == FS_COPY_TO_OTHER_FS) ? file_in->f_op : file_out->f_op;
 
 	if (flags & ~COPY_FILE_SPLICE)
 		return -EINVAL;
@@ -1611,30 +1617,33 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * Make sure return value doesn't overflow in 32bit compat mode.  Also
 	 * limit the size for all cases except when calling ->copy_file_range().
 	 */
-	if (splice || !file_out->f_op->copy_file_range || in_compat_syscall())
+	if (splice || !fop->copy_file_range || in_compat_syscall())
 		len = min_t(size_t, MAX_RW_COUNT, len);
 
-	file_start_write(file_out);
+	if (fscmp != FS_COPY_TO_OTHER_FS)
+		file_start_write(file_out);
 
 	/*
 	 * Cloning is supported by more file systems, so we implement copy on
 	 * same sb using clone, but for filesystems where both clone and copy
 	 * are supported (e.g. nfs,cifs), we only call the copy method.
+	 * Cross-fs copy (FROM_OTHER_FS / TO_OTHER_FS) is handled by whichever
+	 * side declared FOP_CROSS_FS_COPY.
 	 */
 	switch (fscmp) {
 	case FS_COPY_SPLICE:
 		break;
 	case FS_COPY_SAME_FS:
+	case FS_COPY_TO_OTHER_FS:
 	case FS_COPY_FROM_OTHER_FS:
-		ret = file_out->f_op->copy_file_range(file_in, pos_in,
-						      file_out, pos_out,
-						      len, flags);
+		ret = fop->copy_file_range(file_in, pos_in, file_out, pos_out,
+					   len, flags);
 		break;
 	case FS_COPY_SAME_SB:
-		if (file_in->f_op->remap_file_range)
-			ret = file_in->f_op->remap_file_range(file_in, pos_in,
-							file_out, pos_out, len,
-							REMAP_FILE_CAN_SHORTEN);
+		if (fop->remap_file_range)
+			ret = fop->remap_file_range(file_in, pos_in,
+						    file_out, pos_out, len,
+						    REMAP_FILE_CAN_SHORTEN);
 		/* Fallback to splice for same sb copy for backward compat */
 		if (ret <= 0)
 			splice = true;
@@ -1645,7 +1654,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		break;
 	}
 
-	file_end_write(file_out);
+	if (fscmp != FS_COPY_TO_OTHER_FS)
+		file_end_write(file_out);
 
 	if (!splice)
 		goto done;
@@ -1676,13 +1686,16 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 			fsnotify_access(file_in);
 			add_rchar(current, ret);
 		}
-		fsnotify_modify(file_out);
-		add_wchar(current, ret);
+		if (fscmp != FS_COPY_TO_OTHER_FS) {
+			fsnotify_modify(file_out);
+			add_wchar(current, ret);
+		}
 	}
 
 	if (fscmp != FS_COPY_FROM_OTHER_FS)
 		inc_syscr(current);
-	inc_syscw(current);
+	if (fscmp != FS_COPY_TO_OTHER_FS)
+		inc_syscw(current);
 
 	return ret;
 }
-- 
2.54.0

