Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433716;
	b=UTnyzm4vP/QtCR7EMMbm5Yshei3c0v7nPIASyg4fw+frPxjln/XX7EEhQmdbvwjz9Ue4
	 CBiXlat93XyxbFBm9/UYeOfpsZOMmY5yBVH9JkUgUvH+CHrGiYWo9dpCtGshqqNWnBr+a
	 W4tm2REaxgxmWG98ySbJj9WCXqWcZiNWzn6EGSmWvXQFSDTu10rG091zDrko26oy9cxxx
	 VFbvfTF8FOGCH0HP1jhAqpzts1HpJoF3SMA7/ykn1MrA0KMjCnHopVpRszDTmRyNTL033
	 q2hTqONslSMKa7nlTnaXf5kuN+n6sOA2pCfo2bwBgBtfR/bI4sfX+H6PPYJAkENt5Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cBQ1e4v+PxM0RWCwPsTi8odmO3BvILm6dYR2hRcjN1o=;
	b=M9oA6ushw4Tf+xnfd/iPu8tyDOKTzC3TFrZOSfgCHhAYtRDB7sDmi0OmPlH1EuiFA1Rb
	 6P+x6Kg4Stp9VqDJs7xr5+WhMK2wMdiZhPro5u0pB/ttQ/fQ6TrW4omFFDnzKihsUWjKl
	 ++tWaVhUfrIlRg1iDfdpIm5T4mvMEeSBzlMJaOxh6ARrr7LdjVvVKcM07j+yTaPsL+A79
	 F6ABzVKHpS7xE9E0BET+qtguOIKnhIk7hztUiFiRGaGdflu0j4fWBp2OBAFilZbm2fdhb
	 26KH1eKOCJemCLDxPezlnUeLwRSPoCmGw4iuXGWxroiiaA0b+vdPG4NOvt35n06ssAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlX8c84n;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFC606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 11:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlX8c84n
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49412eb1474so1975916f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 03:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795433715; x=1796038515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBQ1e4v+PxM0RWCwPsTi8odmO3BvILm6dYR2hRcjN1o=;
        b=tlX8c84nAAvWBtxLZslesIZP8QnJSlIEXVMsN/6WU78Pn/PCxEWXlxkk6j4u8zG1sG
         mubpmD8uz0RqnccYWFmuFLBRCp6hqFxo9AfSy2JIYtwY+MOIPYQgfcUaGHvZ8l8jp/D+
         2BbbZ7tGO+JTMgPMrn3cmK10/zIPlgLif3F//PjAVDkT5lCgLxoD/9JSBWA68nyO1fVD
         BmpB3MTNXcg/hfiPNV0h1ohtqI+8MN5O7YGs86vY6LLe0HiJ2D+yW/yvXUWjhyhlVJCu
         KgxicZilAeoqkoNweY433ldnWODRRVrKi1+EEg65g266CNP01fondNYYi7/IXM1utDsd
         P8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433715; x=1796038515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBQ1e4v+PxM0RWCwPsTi8odmO3BvILm6dYR2hRcjN1o=;
        b=nSfdNqGCK35mIQaiLvHdP2dhheeYxtv47FUStsBQHfdRfWeq5CHZf8OYIhj1eaLyRD
         Lu8KaZpSRlKgyiHkq+87B/5iWLs58PNg+zpI0zYt6sfobaF+GOrle7R8i0RC5GpizzWO
         MLZF3jj6/TfqA63IGoNiPfyJCvR5yWQ5p9KBkz0QdiDaWN5r56b4Vw9AiZjlUKQAliFO
         RZJ3mwMTGfcD3CporOC8ZbOgXvRfMK/Zx9xi+8RIMGNZch53BaFgIPC5BfwctaYsmNXK
         2txpFyEhDw1FZaVGSsbdX9OZIWJw/8/JsVX9kRlMGAyiPW/c7tQNasooNgDHdurGfULw
         q8iQ==
X-Forwarded-Encrypted: i=1; AL+hErG1fbseSOMiAWyTuYlpkOuzGbfIR2ABNYezeLLJY4DUqT6gCkp5zxI3k2tySmPUCMrp0lmJLO6AfogOJBYF@vger.kernel.org
X-Gm-Message-State: APuU4Z/WDaeey7JaggdtOr8mef4cWUox4DP7UVYVF1lCsyShTcTYE0aJ
	4pRTdfusHlxBne5HF4ILxcuqGhMtr0h2jPd25UonTTumbnlwxz8GNZdm
X-Gm-Gg: AZFdTZe3XWlWCXrwLuHXSatosT2n6ClxgL1R3RFF65YZtKtuv8wI4cEDNuCQxq/3++k
	e+OsFz4nYqNpVf/4fAlkg6c3x/4+thL7GwSJrzy/p7tmeTmRS+s0fyqwzYi9Bx3GcfF5kGSZ0oI
	kXPfjGfdzq0FpBnBHNwZEZ9MhbK7lZu8ztHa4GUcOicfGBA5exu3bJXqF15yYsu9bp0W129YBYt
	VQMCMzLl5anDIc7Ry7tDBdfkJq95QkxxHPkAI+6NCEHXhVEAVSK0XzL3GSwu+gCaIDzm6qcDf3w
	IFhSp6GtKQCgxvlKqoiTBjZ1Maa6NT1l2pFaSVW0DkMmSgbK73u409zJUA8sAi7JaLa00MDDo4u
	8C9Cz+Vz7Xi1QNBmzTpRMeOmNecJVa/EioNFKA9h/s1ZpCZI2xAhVwQRpd9qXRN/B63SsomtiNm
	ESSXg9KdNNhSo4cPC4SwAZUBHxyr9T2KeY+ac3jYMCbzt3oUPviIHEjzIAL4ytPRkIJFlUwuqpP
	cc32XHuWuMCRqMiF2PyWHdaNgxGZ+zU32s5cxRJ87M1QNWTQGLQGXeI0YIjNlns/N2BFzMIDz6+
	m3pqZ+BcX3d20dT9Jfdm/E/dxeM0o5SrAOmvgL3ndx8dJnJLqddRXVxMvuajzBo8BzQqIjrmubA
	aLZFvUdEdhAmw
X-Received: by 2002:a05:600c:674b:b0:4bb:6847:791f with SMTP id 5b1f17b1804b1-4bb8880f267mr223533805e9.7.1795433714601;
        Mon, 23 Nov 2026 03:35:14 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm135211175e9.4.2026.11.23.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:35:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xattr: enforce the name and size limits for in-kernel callers
Date: Mon, 23 Nov 2026 12:35:12 +0100
Message-ID: <20261123113513.1910906-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xattr system calls refuse a name longer than XATTR_NAME_MAX and a
value larger than XATTR_SIZE_MAX, but the VFS helpers do not. An
in-kernel caller may pass a name or a size that it got from another
filesystem, such as overlayfs copy up from a lower layer.

Check both limits before calling the xattr handler of the filesystem,
and fail with the errors that the system calls return for them.

Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/xattr.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 0705801a62cc5..824e8349e8c10 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -178,6 +178,18 @@ xattr_permission(const struct mnt_idmap *idmap, struct inode *inode,
 	return inode_permission(idmap, inode, mask);
 }
 
+/*
+ * The xattr system calls refuse a name above XATTR_NAME_MAX and a value above
+ * XATTR_SIZE_MAX, but an in-kernel caller may pass a name or a size that it
+ * got from another filesystem, such as the lower layer of overlayfs.
+ */
+static int xattr_check_name(const char *name)
+{
+	if (strnlen(name, XATTR_NAME_MAX + 1) > XATTR_NAME_MAX)
+		return -ERANGE;
+	return 0;
+}
+
 /*
  * Look for any handler that deals with the specified namespace.
  */
@@ -209,10 +221,17 @@ __vfs_setxattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	       size_t size, int flags)
 {
 	const struct xattr_handler *handler;
+	int error;
 
 	if (is_posix_acl_xattr(name))
 		return -EOPNOTSUPP;
 
+	error = xattr_check_name(name);
+	if (error)
+		return error;
+	if (size > XATTR_SIZE_MAX)
+		return -E2BIG;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -416,6 +435,8 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap, struct dentry *dentry,
 	error = handler->get(handler, dentry, inode, name, NULL, 0);
 	if (error < 0)
 		return error;
+	if (error > XATTR_SIZE_MAX)
+		return -E2BIG;
 
 	if (!value || (error > xattr_size)) {
 		value = krealloc(*xattr_value, error + 1, flags);
@@ -434,16 +455,24 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       void *value, size_t size)
 {
 	const struct xattr_handler *handler;
+	ssize_t ret;
 
 	if (is_posix_acl_xattr(name))
 		return -EOPNOTSUPP;
 
+	ret = xattr_check_name(name);
+	if (ret)
+		return ret;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
 	if (!handler->get)
 		return -EOPNOTSUPP;
-	return handler->get(handler, dentry, inode, name, value, size);
+	ret = handler->get(handler, dentry, inode, name, value, size);
+	if (ret > XATTR_SIZE_MAX)
+		return -E2BIG;
+	return ret;
 }
 EXPORT_SYMBOL(__vfs_getxattr);
 
-- 
2.56.1

