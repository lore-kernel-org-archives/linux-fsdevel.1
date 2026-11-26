Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710710;
	b=jqWyzoQJl/bkAGFGFTwNW8c93aKVjCdK4uLqAqEwmep6Oq9quva38yePXcGW/NLx/4oO
	 bCMpmr5ltgfulc+Acn/Pm6SBNvkg6S7qKIap1G97d8BiRKqZbt0QTvF+3znNdx4ZQ9wYk
	 9B/CdqbEedDTU4YNYvdVyws1Q/Z3lQlWMxRYnICofi58EsErMEJ/6zuX8Ch0173oih7cB
	 si9W9VT2fX+JTpspsrl77Cg2zjbZ91UtCGw9s5XIcwV+wtPtSLpACD07Uw/9nBLKkatuQ
	 66e5QkBjC686vi4IrZRuB79eUZ95AwByOqMdFmUuCkzcmZ8U0Vw6D/iNCZnnADhvuDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6DGKGHZD1sWqO2WRSY4U0udOhpGKQXiV3WJqb4Fx1ZI=;
	b=rf91DT7gYxJa4dhKAXxJPqeXR4G5obDuQMTJ/iCeBwRy1j2mGmyMeORm0ylgWbNE63GP
	 zBZeQ1Nk5kTi8ezPfJzedv2CakOLpEmeItDak7pliw6fG32TTp6zeceKY3B8JUg82HoWZ
	 iqOn+YBomF/bsTpYqg1p0otsEiOcEeORvJZK2wzH/4WfL3P8om8YNnGPaQvuN2f4GHX6M
	 Qr/v58w+P+kGXI+P2XxoR3s919eKPRYLPhAsGwNuoMZRcW6bmmCGe3AovwkSDtTTOwCr0
	 K9Mendfi9tmZrWTJzUmtfr/hfqeNikhLCj+Jq9avhHRyncfc3pY7XRwCfZG/y8m0hFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgzesBph;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52C606A6A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E52C606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgzesBph
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso72619955e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 08:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710708; x=1796315508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DGKGHZD1sWqO2WRSY4U0udOhpGKQXiV3WJqb4Fx1ZI=;
        b=NgzesBpha5/UiuwtyApe4LBXa4J/ZEE9RKL51o52cHEQZvDJx1Io0LkMX9T4hggZMH
         yMa0nLXZDeXh3OTT5Dceu8BR+qdcmeSaC9RWK6GGdpgvq67OWwu0N8mw3xfC+ykgxBkA
         yEoRN9ICF95EXoJwq1ROoEh5ttxJozEqUgS4kFy2WgRT3O8gDHMMShxwnJZV/bfNq8gV
         94Ff+uDAmyBMb5RFFUJa2wayxciw/19DqrWBprAc5PQ2xTH4mJm64KnLuI4iptKk72YS
         FGHpM0M/l0unSVUyE9VXt42T1xN0phYdlNSwj0GuBcjfL5tAcfYo3HAercHmLDLsdKJ/
         INoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710708; x=1796315508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DGKGHZD1sWqO2WRSY4U0udOhpGKQXiV3WJqb4Fx1ZI=;
        b=Ig3QytR47YmFR2OvBMuZNo6YDbEZ9k0W5xzaLhIThNrOZM3odubFLE/5XY1HLyQtr1
         ShyrRSxPDzIzyMggCRu0Df5GvYSfirPgkp1TE9yFelJsL470G1lk2o6bwG/megWlsG+M
         H0zFl1Yb+cxuTbHl8vYttsszPuGE1I0BoUGvI2MwhEynhnHxLOcqxc43Nj3D931o9hcl
         bcP5c/qx+CkAnZ5iMutWXL6IMJBf4vpGByipxZ+ezpjJRQ5167Sy2scYif/ijC2AhtWb
         /mfAyoNh2O9vN7YCH+38SmhLVIaoGJvOyiRfdx+aDcriufRhGj3mLpHunwCtSs4zIp+9
         I1dw==
X-Forwarded-Encrypted: i=1; AL+hErGIOw2i3w/htxvBnGptVmI3JIKxZUbDrd0CLRSj2BmLh5Xr42LKIGogm4ind8yz+gyy2cLpZu/W8EbGi619@vger.kernel.org
X-Gm-Message-State: APuU4Z93vFaFHB7wyaG6lW9aI9o4l+/7owvZ6YKplpHx/RyUE3/pw7st
	5VU6BSiVn/GSMwQBQusMmmDtaYrB58vpf1UW8wHBnf2l97S1MLhq0wPm
X-Gm-Gg: AZFdTZdVtq8jjlgAY9zLDJhXerK+eiIQBt8SHg4UwxuyBIlHaT5tfjgixlnF/Nnoi3n
	NhcivqEIdUFcTP6tADS9Y4vOhQHrQ2ddmKRSLqDaV8bt2Kfn1zO2YzF/8GIVfcnCw+m1ASyZ5BD
	FWiICOFAfZq0ijjZs6OzFjjT/YdABIDGSL+6vAiX0MU94jldHD/QM5rhlFP6rE6Wt2DDjIjFfjG
	mEZ0tCHtt34BOil0zs5JXH5fAe5bE6nkjMWzvzPEddhqGBbyr/MdvmuhGGH2vpQcfz0j7yIKQ6n
	/jTDB90UR5Y/EExVxHwzPSYhBRNLwHtrLFHVumSh+u06xai8CUwyU5pWjR7Rr0hxI/H06s6oV8R
	nKIhOZqb4QZMiOHF9vp062OSwW8AQDoWqTOak4jvOphR44hacjdyTyHFLm2Ri6i+fRYDO7k1J9Y
	nv7m5TMPjZTDJTe7ylQ9l0psH91h1xzAZdvfuv9A5sveGtznOp72GaWBgzj/ghrpIjVtW+w+dHV
	xtK3eYdkE1oEVj/6c6W+Qx1oZpPyS0ajl5cNrKxzncFqWbUOLK4UOIva4EyYs93AhorWvtedJRw
	3aXZOBbmAbfhZuni4kzH4pBw
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb88822242mr502582645e9.28.1795710708243;
        Thu, 26 Nov 2026 08:31:48 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm721964995e9.11.2026.11.26.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:31:47 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lauri Gates <lauri.gates@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <dgc@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH v2 2/4] fscrypt: update fscrypt_prepare_setflags() to use xflags
Date: Thu, 26 Nov 2026 17:31:12 +0100
Message-ID: <20261126163114.403846-3-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126163114.403846-1-koray.fra@gmail.com>
References: <20261126163114.403846-1-koray.fra@gmail.com>
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

Update fscrypt_prepare_setflags() to use FS_XFLAG_* xflags instead of
legacy FS_*_FL flags.

Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/crypto/hooks.c       | 10 +++++-----
 fs/file_attr.c          |  2 +-
 include/linux/fscrypt.h |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 149498bdab94..52d6a33fc9e9 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -182,10 +182,10 @@ int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr *attr)
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
 
 /**
- * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_SETFLAGS
+ * fscrypt_prepare_setflags() - prepare to change xflags
  * @inode: the inode on which flags are being changed
- * @oldflags: the old flags
- * @flags: the new flags
+ * @oldxflags: the old xflags
+ * @xflags: the new xflags
  *
  * The caller should be holding i_rwsem for write.
  *
@@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
  *	   another error occurs.
  */
 int fscrypt_prepare_setflags(struct inode *inode,
-			     unsigned int oldflags, unsigned int flags)
+			     unsigned int oldxflags, unsigned int xflags)
 {
 	struct fscrypt_inode_info *ci;
 	struct fscrypt_master_key *mk;
@@ -204,7 +204,7 @@ int fscrypt_prepare_setflags(struct inode *inode,
 	 * derive the secret key needed for the dirhash.  This is only possible
 	 * if the directory uses a v2 encryption policy.
 	 */
-	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
+	if (IS_ENCRYPTED(inode) && (xflags & ~oldxflags & FS_XFLAG_CASEFOLD)) {
 		err = fscrypt_require_key(inode);
 		if (err)
 			return err;
diff --git a/fs/file_attr.c b/fs/file_attr.c
index 40d6518f1d8e..1687891c526c 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -195,7 +195,7 @@ static int fileattr_set_prepare(struct inode *inode,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
-	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
+	err = fscrypt_prepare_setflags(inode, old_ma->fsx_xflags, fa->fsx_xflags);
 	if (err)
 		return err;
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 28f2108e29f3..68d0983385d0 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -461,7 +461,7 @@ int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry);
 int __fscrypt_prepare_readdir(struct inode *dir);
 int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 int fscrypt_prepare_setflags(struct inode *inode,
-			     unsigned int oldflags, unsigned int flags);
+			     unsigned int oldxflags, unsigned int xflags);
 int fscrypt_prepare_symlink(struct inode *dir, const char *target,
 			    unsigned int len, unsigned int max_len,
 			    struct fscrypt_str *disk_link);
@@ -784,8 +784,8 @@ static inline int __fscrypt_prepare_setattr(struct dentry *dentry,
 }
 
 static inline int fscrypt_prepare_setflags(struct inode *inode,
-					   unsigned int oldflags,
-					   unsigned int flags)
+					   unsigned int oldxflags,
+					   unsigned int xflags)
 {
 	return 0;
 }
-- 
2.56.0

