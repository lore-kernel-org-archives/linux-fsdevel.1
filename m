Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877694;
	b=0L/5a2bafKbwpCPKj9TT5RLezGuPDQBBaZ+Y1EZwakC7VzC+3foNTNAOz/JO4jRpJ0D6
	 3bvViGrDTVUW+KSfCUGV1eLx9DeSU8zasqUT6ZhH/fMFc6RAPPYskKvufz7QfXSsY3u+Z
	 70ODz9hc+v4pMjfevMJsD+F+wuyv/BByghMAjyEdTDI3r76nfmIAv3CQ8WpMxMF5RUBke
	 pySGmP1fuZROhL5tJvKFvnQ09q9OdP0KRDBfU8bIBzUPSkkB4ajLURDSjxIAigwfK6D7r
	 2OSzNQAp4modMDOMLXRSBIYyuiO/Q7Tr1BZFFeVg6LmRqokFrJkYKd7cR7Z1XVwPIBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877694;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TDM77Uvsqi9lGq3Txa4WanQbWP9nhgjKgg2QdnI4jYw=;
	b=1hNFCTsBfYbMl2698odEr96NbAPeQ+q7IOQQMi6PVclmIarpqc5xnu6DB2jrUKCD2h9u
	 4DHUzGPanniuehTLUu5/W8cfPP4Tl0Sqf6mBUKm9YounWKsPa1JYLhfomvjL370GeGEk1
	 Q0MC8xyw+Nhciy1cEPvqNDWRgPV18a5/evKmmf8IQdFygQHN7a6PdPQIihz8Y8qLggM2f
	 XTj22/1kgj9mglpJcQTFwowK/HBi5IhLyhQ2efMpduWlevUhWojzcGO28X5pkDJ56nbPW
	 q3aNcXDnrir5SVK3TsXTRg+jDG/iNC77461azfFEhMbUKR/YE59QQ8JOIwN89Ds4mYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=mh0Cq1+y;
	arc=none smtp.remote-ip=195.121.94.185
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14073606A32A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14073606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=mh0Cq1+y
X-KPN-MessageId: bdcc2577-cff2-11f1-9136-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bdcc2577-cff2-11f1-9136-005056999439;
	Sat, 24 Oct 2026 23:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TDM77Uvsqi9lGq3Txa4WanQbWP9nhgjKgg2QdnI4jYw=;
	b=mh0Cq1+ylQ0eUc2lqTjqPMbN42tSro7KUqpTUuJFfvv9Kk2sEuvsUlTmw1Ep5ch1r219E0BcdqAVl
	 IhAE0pmoSIPnMxQvFmM1Qv+nnYQHuHIdluMQrXLlH0vSN45LKCxWcJeGdgDW1uEy3Y6MuGJCYsi02z
	 ofBVkvM020Gml9eWgygquMt2aSazBy095hnpqIWgGYucnI8cFfwOhl+8z7Vg/ILvGr1cX7IOgJPO3+
	 nERlACqk6/k2J5zIhsPFxvz61/prsSgR//OThNjCkJBd9sLP57DD4piE48+OyIX8kyW5i6DwAceoZl
	 /vSFoEwd9RIU8HRONRvrPoWdWtLysTQ==
X-KPN-MID: 33|7/nNbwfXNxGsBHVYNGbEBwdFxwlkBTUUPZZE2JI3qQcz2MGaDwXd2fP+/IKHlso
 sB6+c5tYtbV5+cRo4FWllbtbBY54UgHp5SJ+eG7CcVto=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|b3t4Q+QythbRqIsUjTdzxknBifyN0rKiB9GPmiga5fR3f5OGegWCnED62B3FtP5
 CTUNEfHjeyWHd/DyiLmEaPg==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id bd90b82b-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 11/12] vfs: change ->create/->mkdir operations unavailable errno
Date: Sat, 24 Oct 2026 23:35:38 +0200
Message-ID: <20261024213539.1307600-12-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
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

Currently filesystems return -EACCES for missing ->create and -EPERM for
missing ->mkdir in vfs_create/vfs_mkdir. Instead of duplicating these
dubious and inconsistent error codes to lookup_open(), change all to
-EOPNOTSUPP.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 arch/alpha/include/uapi/asm/errno.h  |  2 +-
 arch/mips/include/uapi/asm/errno.h   |  2 +-
 arch/parisc/include/uapi/asm/errno.h |  2 +-
 arch/sparc/include/uapi/asm/errno.h  |  2 +-
 fs/kernfs/dir.c                      |  2 +-
 fs/namei.c                           | 14 +++++---------
 include/uapi/asm-generic/errno.h     |  2 +-
 7 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 1a99f38813c7..0384f6998974 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -19,7 +19,7 @@
 #define	ENOPROTOOPT	42	/* Protocol not available */
 #define	EPROTONOSUPPORT	43	/* Protocol not supported */
 #define	ESOCKTNOSUPPORT	44	/* Socket type not supported */
-#define	EOPNOTSUPP	45	/* Operation not supported on transport endpoint */
+#define	EOPNOTSUPP	45	/* Operation not supported */
 #define	EPFNOSUPPORT	46	/* Protocol family not supported */
 #define	EAFNOSUPPORT	47	/* Address family not supported by protocol */
 #define	EADDRINUSE	48	/* Address already in use */
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index 1835a50b69ce..2b6813715d1e 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -75,7 +75,7 @@
 #define ENOPROTOOPT	99	/* Protocol not available */
 #define EPROTONOSUPPORT 120	/* Protocol not supported */
 #define ESOCKTNOSUPPORT 121	/* Socket type not supported */
-#define EOPNOTSUPP	122	/* Operation not supported on transport endpoint */
+#define EOPNOTSUPP	122	/* Operation not supported */
 #define EPFNOSUPPORT	123	/* Protocol family not supported */
 #define EAFNOSUPPORT	124	/* Address family not supported by protocol */
 #define EADDRINUSE	125	/* Address already in use */
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 93194fbb0a80..74bd65d79145 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -84,7 +84,7 @@
 #define	ENOPROTOOPT	220	/* Protocol not available */
 #define	EPROTONOSUPPORT	221	/* Protocol not supported */
 #define	ESOCKTNOSUPPORT	222	/* Socket type not supported */
-#define	EOPNOTSUPP	223	/* Operation not supported on transport endpoint */
+#define	EOPNOTSUPP	223	/* Operation not supported */
 #define	EPFNOSUPPORT	224	/* Protocol family not supported */
 #define	EAFNOSUPPORT	225	/* Address family not supported by protocol */
 #define	EADDRINUSE	226	/* Address already in use */
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 71940ec9130b..699f648e1a35 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -16,7 +16,7 @@
 #define	ENOPROTOOPT	42	/* Protocol not available */
 #define	EPROTONOSUPPORT	43	/* Protocol not supported */
 #define	ESOCKTNOSUPPORT	44	/* Socket type not supported */
-#define	EOPNOTSUPP	45	/* Op not supported on transport endpoint */
+#define	EOPNOTSUPP	45	/* Operation not supported */
 #define	EPFNOSUPPORT	46	/* Protocol family not supported */
 #define	EAFNOSUPPORT	47	/* Address family not supported by protocol */
 #define	EADDRINUSE	48	/* Address already in use */
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b98114454112..abb6b0d21214 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1297,7 +1297,7 @@ static struct dentry *kernfs_iop_mkdir(const struct mnt_idmap *idmap,
 	struct inode *inode;
 
 	if (!scops || !scops->mkdir)
-		return ERR_PTR(-EPERM);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
diff --git a/fs/namei.c b/fs/namei.c
index 5c157554d677..7365975a0a32 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4225,7 +4225,7 @@ int vfs_create(const struct mnt_idmap *idmap, struct dentry *dentry, umode_t mod
 		return error;
 
 	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
+		return -EOPNOTSUPP;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(idmap, dir, dentry, mode);
@@ -4624,13 +4624,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
-	if (create_dir && !dir_inode->i_op->mkdir) {
-		error = -EPERM;
-		goto out_dput;
-	}
-	if (!create_dir && !dir_inode->i_op->create) {
-		error = -EACCES;
+	if ((create_dir && !dir_inode->i_op->mkdir)
+		|| (!create_dir && !dir_inode->i_op->create)) {
+		error = -EOPNOTSUPP;
 		goto out_dput;
 	}
 
@@ -5500,7 +5496,7 @@ struct dentry *vfs_mkdir(const struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EPERM;
+	error = -EOPNOTSUPP;
 	if (!dir->i_op->mkdir)
 		goto err;
 
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index bd78e69e0a43..c84ebf89c8b6 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -76,7 +76,7 @@
 #define	ENOPROTOOPT	92	/* Protocol not available */
 #define	EPROTONOSUPPORT	93	/* Protocol not supported */
 #define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
-#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
+#define	EOPNOTSUPP	95	/* Operation not supported */
 #define	EPFNOSUPPORT	96	/* Protocol family not supported */
 #define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
 #define	EADDRINUSE	98	/* Address already in use */
-- 
2.56.0

