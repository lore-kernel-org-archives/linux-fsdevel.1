Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0F1E1A3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701725; cv=none; b=Jm2WFRw/2i8t6t+kWV8qpjnPHUHvn59EfIX0BZqSCiaNqWUlYF4dGBSLd5gWrvjdv/tdHiB3RQ1CNa7S1LT4qAGnxohBi1re7ux8igl1pFgTvNBBlWzSNfSomRmnHzy76A6+HS8Ol4x/qVDxmicMPazVRbtMmEHjQCGhq4y5k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701725; c=relaxed/simple;
	bh=X/kXAetW2sPVYfXhfYTYqrxjj0S3DACiT8zM2IYPlxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFlVRhPysRY/Kh89jpkfaw6k78htzXhYkLbzucfsidR+T3a+FCmGKsQezXAiu+05/6OF/Lklg30KpbNp659/wwjmBo0ZpKw25TJH/mNIt+BVoVl0VFifwMV5ymrQsebAJ+KSVx9MiVfB5w2rJfGDMYWzOQ9d1YREBvkiA/XgeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UxMsSInU; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UxMsSInU"
X-KPN-MessageId: 41911e9f-7c7e-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 41911e9f-7c7e-11f1-83b1-005056ab378f;
	Fri, 10 Jul 2026 18:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=EaS0+HBaDnj4tkmHVi48ZsTwA3AYyy9jlZrZreHsuSk=;
	b=UxMsSInUFHQCRWfuJBdUaaFHYOsp69sEQyhtWsmehz1MX/Sqre4p9z5t/Bkx8PkbvTyqRNa29WvYS
	 Vd4uf/LYpGI5Vl7ITa8LQDMMUQAaWhSRc/vzIMKaZfeh1O7chPsY9cnUQc1jZkXAUxSd5yTk3PEsei
	 JsQ2BNRJcByahyKeO1hD4un3b+tS3oJQ1+Ghw5SNeDWTUbgHFCTyYeGLuVKCDwRvueEt1fdfneqjIR
	 lqFKvkxrXwYonwwOzm4NMBbl7/b0PtBpgUlNaIG1vPgjH0u6XaM0NBIEolGt9Nq4A+QTSdt7XKSlH3
	 cGoQz+3GZZ62u7wNPvJCdnrz+b9WY6Q==
X-KPN-MID: 33|ElAlLdLVWS3/cD0+SN9fIexGI2It/EhztNKB+HSJsja6xPUP4btPFvkXIKek4m4
 XBinfvqBsJWpg2jSK84wWeBL+otkIPryXpnKkpjCEfAs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Fa8Mq6V4joKmX+J4Mu8wSeW9/PWOJcAKWwzYgUG/DWA0mi35Pk0tXnSGXW6aZK1
 NKAns7lAhcH3+pGCmVbZLEw==
Received: from daedalus.home (unknown [178.229.235.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4154fdea-7c7e-11f1-91ec-005056ab1411;
	Fri, 10 Jul 2026 18:41:53 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 3/3] fs/namei.c: update kerneldoc of atomic_open()
Date: Fri, 10 Jul 2026 18:42:33 +0200
Message-ID: <20260710164233.827744-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710164233.827744-1-jkoolstra@xs4all.nl>
References: <20260710164233.827744-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments above atomic_open() contain several errors:

  - atomic_open() does not return 0 if successful
  - @path is not updated

Fix those and be more explicit about when FMODE_OPENED and FMODE_CREATED
are set. Change to a full kerneldoc.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index fe5d59c6f925..2eef2a49d3f4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4336,18 +4336,26 @@ static int may_o_create(struct mnt_idmap *idmap,
 	return security_inode_create(dir->dentry->d_inode, dentry, mode);
 }
 
-/*
- * Attempt to atomically look up, create and open a file from a negative
- * dentry.
- *
- * Returns 0 if successful.  The file will have been created and attached to
- * @file by the filesystem calling finish_open().
- *
- * If the file was looked up only or didn't need creating, FMODE_OPENED won't
- * be set.  The caller will need to perform the open themselves.  @path will
- * have been updated to point to the new dentry.  This may be negative.
- *
- * Returns an error code otherwise.
+/**
+ * atomic_open() - attempt to atomically look up, create and open a file
+ * from a negative dentry.
+ * @path:          parent directory path
+ * @dentry:        child to ->atomic_open()
+ * @file:          file to attach child to
+ * @open_flag:     open flags
+ * @mode:          create mode
+ * @create_error:  return value from may_o_create()
+ *
+ * If a non-error dentry is returned then: when FMODE_OPENED is set,
+ * the file will have been attached to @file by the filesystem calling
+ * finish_open(). If FMODE_OPENED isn't set, the filesystem instead called
+ * finish_no_open() and the caller will need to perform the open themselves.
+ *
+ * FMODE_CREATED is set when the call to ->atomic_open() actually created
+ * the file.
+ *
+ * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failure.
+ * On error, atomic_open() consumes @dentry.
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
-- 
2.55.0

