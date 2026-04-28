Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFC1A3172
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404088; cv=none; b=mTVcHQnZnR97vRpGx2d23wzGMLm0vvqgl+sKjYvzvOm6B9CYQ1y9OYCkyFHsDxCuMZWtFvud4eH0EmCRYcQaQudcpTfMuKWRxv5Tv1aM931JJJfL+SHq3d9/cWSQju7HHv0hHolIZyrJokI5sC/9Yt794LIcgQKN3NRmVsL8bEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404088; c=relaxed/simple;
	bh=rADsMyQZW7KYZ4YfdbvpqFxHzHaQXlVKJ1dK2uBWxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+5uN+70FZ4np4rUIjkKMxl8qglo5ElbiSTm+tOHzdLaUQpfWq8ZpnIoYRibEmAw/786ZJo+VX4VOvJNjCEZDbDsUNkZAIWgF4OMMGDUhoe5zDL3tnOeVTLE2Xn9mCZ5/QxN9gNq8LrXNV6QzOsTWupxExXtTeFme9ElkCVBzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P6hJ34xS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P6hJ34xS"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8eb5ad01402so1055867085a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777404086; x=1778008886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HsRQzwddKIQadLpTvf+1Rg5IrK/BcQTm8bGEwPFxUs=;
        b=P6hJ34xS9RtMEn9R1iM5+zcrHVvgKhY6p/g+iBcB41iqtjuQ0mouqIDMqiuQT7Kw1v
         WFJzyhodIjsk4rY69CB5sGqImiLdeBi9Bbd5QSLqh9Gm9/k87vKoe5HkBIMT5d26PEet
         8msmqDnZcvHzHq2B70bXooqqysMb75CHI/sozliPHEe5xdw30/A+qexUGhBROmyOIHG2
         adORnVekUgp2z4E467TpYJzkim+UEV1iifDQJ9qYww60r/2OEyiPXAvX8y9maCOUqYfl
         toECcCzt95FknGuI0KyR6c2iL44DSzT+5YjisB8nNIusANbEeCUwxtajMWHAnvOaK62T
         gDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404086; x=1778008886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7HsRQzwddKIQadLpTvf+1Rg5IrK/BcQTm8bGEwPFxUs=;
        b=IFg5N6oDuc3vQtiV4aWBVJZGJCBV4vvioU/LgFhpmfjEFIdx0WceN8A3SUomaiUYcB
         +Ykvi1/dcZgzo7xMqO+53Y3eugdfD62kNQn07vlyhmwklRX6n0jGYLv+516MUm3PE1bl
         2+f+OGEin1ieInowS06JUGiDgpop+KYAXZThm5FoJEsvPrd7fPBsZUQcZ73IGdCCAIgj
         7OoFvJ/wv1jUVJQQxnulsur5kv1o1H1K3V0IQz9otoIY4WTJe0AcfD0xOwnQJu4Qxh1l
         RCEGyB+iiW2anFWNz9VlLSg85syJF0vIgezv2O8EXXSOo/Xi0Q132XzuioZocXX1E3SL
         5qRg==
X-Forwarded-Encrypted: i=1; AFNElJ9mgH0h1CR7DOFLAZixjQcAjHccqvSYWBoOLbKdgVWaXZ7ha7WS4J9irAZEI2kiOOoPF3pGpvPOavqJcR6P@vger.kernel.org
X-Gm-Message-State: AOJu0YzonUH3UVzDGk+TG3CQwxJdqhXV/TdzKoDOymVDg/MfIJ1OHIZv
	Blt26wv4SefoHmh1atT80PsgIjCVCQWwAN+IEcgwRhmFrKV8Fo80qxQbLgZDgv8p4w==
X-Gm-Gg: AeBDietvEGnI5tJTe+k+0Gs+SZkMzbgEsCGT1FD0/qafCNq8wNtO4Nm3UaugfsuN/IK
	/x1/aG+PQenXfFZ/AIpm7sePosmv6D6Wyv7n4F1S7AiNhxNjFyM4cLG+LvYYHXUQHow9aehTHcx
	pihjgsHJLX8l1XCPEjiMQChVSjMEQA2A/G6Zj21COKdmIXGWwljAxn1IdNyIEHYQM02erC2a3wX
	TSDiDayTwtS86gjTA2AjhUoBSOO7v7AAX59VDMJVsmMp7AzqxG9RN9GvQfSD6TT29LADhnaNRLF
	LpqTIzIm0e0Lg3+QTojW7dmtQNMtLObOWsjHG/4QQL0Hj9k2Im2xPbCTdWMDvGrOXsxz6c5bi3w
	aYfbFyxKWeLrG09JL+X6NDbjKyw02Ef0K6f8aku1JEtwXYx6RrkLkEK3syuaK1TcOH8tCpsN4Od
	TmkNV9OEd+ro2bJfkayAtJAjzS3Cblf4R4KS0dr6z68D+6JWb1CNlaSsmJZkwvG5AgvQEq1UVDX
	Knpve4=
X-Received: by 2002:a05:620a:4456:b0:8d6:bd01:a67a with SMTP id af79cd13be357-8f7d7e171a8mr634934685a.26.1777404084901;
        Tue, 28 Apr 2026 12:21:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c84b1d92sm263877485a.38.2026.04.28.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:21:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Subject: [PATCH ported/repost v2] security,fs,nfs,net: update security_inode_listsecurity() interface
Date: Tue, 28 Apr 2026 15:21:20 -0400
Message-ID: <20260428192119.226244-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7674; i=paul@paul-moore.com; h=from:subject; bh=TIBYVxpxKKE5XNqm2t5t5Zkc1qweb5gcM/rYatRhygg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBp8Qivtdaz8kIJzR5ih/0JRGEl15mQnHjbbXmKU Vd1awybi5uJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCafEIrwAKCRDqIPLalzeJ c39KD/0QmxerRTCNDDzPUzdXuWLg0P0l7CVvmGWX5e/vy0NKGMNoVoY0Bk7iW9cGIjR7xjQH40h oAvirMrk2niZSjVWCjT88PyzeIZxkbKM4eVBA2swvkssSdKC53MPMS/eJTpVIA17X+23Z+Vi8LM 4/neLwI3AYZgDxdGP1E0UQ0ZlWzzode+fR6qOEzWvTLMmtfn9Nd/RB/5tKxno9uC5k83lfP+SZD ptADRIgGSQsiqOUtbCjkAAOyUG4u83Xb545DVQtdYP/ULVwkAgsDxCbfvCY6CJumTCgiZSUnHTS uoAACC/zM5m/ikPD3sQCj60R0zNQPKCNs5TZ2uqEJmD1m5NoJ+8uOKRqZyTOtnBaOSKWGcrPZ/U NbfLLcN62Jcgom4ac9vtnfBZmv8LhrI3DzlHSMPmrSEyfZidxVqcXPG3Ger0sTQLVUPxGfHxp0u Ed4GeJeuN9vipb6pVf6mXueJaVp50sZWE+9CIW5InxEsW5ZohGrjsl2zLn1cpW3Iur4F/YkAQul wfffjgvcZQkcfXo6dUpCPQPyNx6/BcimCZV5tUGiYFWyn10JlaRQ0YEIJUVFaO6c522I6UpydDF n0ccg2sBWPlVrv++GSjfWp1Ss/DumQDrUBsWzkX/dqSI02nRNuA7Fk5VJ/gM/5nwDILWvHMOXAW BLtroLvFvBsoslQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Update the security_inode_listsecurity() interface to allow
use of the xattr_list_one() helper and update the hook
implementations.

Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: forward porting to bring this patch up to v7.1-rc1+]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/nfs/nfs4proc.c             |  7 ++-----
 fs/xattr.c                    | 11 +++++++----
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      |  5 +++--
 security/security.c           | 16 ++++++++--------
 security/selinux/hooks.c      | 10 +++-------
 security/smack/smack_lsm.c    | 13 ++++---------
 7 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a9b8d482d289..a16342056ae5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10562,13 +10562,10 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		left -= error;
 	}
 
-	error2 = security_inode_listsecurity(d_inode(dentry), list, left);
+	error2 = security_inode_listsecurity(d_inode(dentry), &list, &left);
 	if (error2 < 0)
 		return error2;
-	if (list) {
-		list += error2;
-		left -= error2;
-	}
+	error2 = size - error - left;
 
 	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
diff --git a/fs/xattr.c b/fs/xattr.c
index 09ecbaaa1660..0bc3b47e6936 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -510,9 +510,12 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
-		error = security_inode_listsecurity(inode, list, size);
-		if (size && error > size)
-			error = -ERANGE;
+		ssize_t remaining = size;
+
+		error = security_inode_listsecurity(inode, &list, &remaining);
+		if (error)
+			return error;
+		error = size - remaining;
 	}
 	return error;
 }
@@ -1540,7 +1543,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	if (err)
 		return err;
 
-	err = security_inode_listsecurity(inode, buffer, remaining_size);
+	err = security_inode_listsecurity(inode, &buffer, &remaining_size);
 	if (err < 0)
 		return err;
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..65c9609ec207 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -176,8 +176,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
 	 struct inode *inode, const char *name, void **buffer, bool alloc)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
-	 size_t buffer_size)
+LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffer,
+	 ssize_t *remaining_size)
 LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
 	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
diff --git a/include/linux/security.h b/include/linux/security.h
index 41d7367cf403..153e9043058f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -459,7 +459,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
-int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
+int security_inode_listsecurity(struct inode *inode, char **buffer, ssize_t *remaining_size);
 void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
@@ -1097,7 +1097,8 @@ static inline int security_inode_setsecurity(struct inode *inode, const char *na
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static inline int security_inode_listsecurity(struct inode *inode,
+					char **buffer, ssize_t *remaining_size)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 4e999f023651..71aea8fdf014 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2258,22 +2258,22 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 /**
  * security_inode_listsecurity() - List the xattr security label names
  * @inode: inode
- * @buffer: buffer
- * @buffer_size: size of buffer
+ * @buffer: pointer to buffer
+ * @remaining_size: pointer to remaining size of buffer
  *
  * Copy the extended attribute names for the security labels associated with
- * @inode into @buffer.  The maximum size of @buffer is specified by
- * @buffer_size.  @buffer may be NULL to request the size of the buffer
- * required.
+ * @inode into *(@buffer).  The remaining size of @buffer is specified by
+ * *(@remaining_size).  *(@buffer) may be NULL to request the size of the
+ * buffer required. Updates *(@buffer) and *(@remaining_size).
  *
- * Return: Returns number of bytes used/required on success.
+ * Return: Returns 0 on success, or -errno on failure.
  */
 int security_inode_listsecurity(struct inode *inode,
-				char *buffer, size_t buffer_size)
+				char **buffer, ssize_t *remaining_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, remaining_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..4ae736755557 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3684,16 +3684,12 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	return 0;
 }
 
-static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static int selinux_inode_listsecurity(struct inode *inode, char **buffer,
+				ssize_t *remaining_size)
 {
-	const int len = sizeof(XATTR_NAME_SELINUX);
-
 	if (!selinux_initialized())
 		return 0;
-
-	if (buffer && len <= buffer_size)
-		memcpy(buffer, XATTR_NAME_SELINUX, len);
-	return len;
+	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SELINUX);
 }
 
 static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3f9ae05039a2..ff115068c5c0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1665,17 +1665,12 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
  * smack_inode_listsecurity - list the Smack attributes
  * @inode: the object
  * @buffer: where they go
- * @buffer_size: size of buffer
+ * @remaining_size: size of buffer
  */
-static int smack_inode_listsecurity(struct inode *inode, char *buffer,
-				    size_t buffer_size)
+static int smack_inode_listsecurity(struct inode *inode, char **buffer,
+				    ssize_t *remaining_size)
 {
-	int len = sizeof(XATTR_NAME_SMACK);
-
-	if (buffer != NULL && len <= buffer_size)
-		memcpy(buffer, XATTR_NAME_SMACK, len);
-
-	return len;
+	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SMACK);
 }
 
 /**
-- 
2.54.0

