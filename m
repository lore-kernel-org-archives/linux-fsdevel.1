Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7EA3E9C36
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755736; cv=none; b=lU+hlTJcqaGhhuHAnB9np26ssC3VR6NvWY5zSYuwC/InvJQJTzhVyTlaGrH1t7U95iwMU110nD6Pvj7ALXg2brh61O2EOp3tsoDU6/ERjtKMDBTOy6QRy6IaTdrtav/6sc2hTLhhckZpfY1sCNY8x+FUxFdNuG3Hsw2ngS5Yi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755736; c=relaxed/simple;
	bh=Iqj6oPbgV3K4z4iMJ6xkTWP4KmRB34Sc09PDX1epHZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ahy3LDhbVjdfWZJFLvQTiHsHP3x1fluzvFJX/lnZJ1ecqNK+5iNrDBnrsXC/ayCN9RKEcI02kSLegGwvzgihsApCCYoIt0UmEmWMIfbYoj9rg+NjatA/cEJ6goRFkSztz/jQ5D4DHjUmTk6NtFoyIHB8UlW9V1/HNgW+wDbFvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tOhKVMGI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOhKVMGI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495437bb891so15984925e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785755733; x=1786360533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pgP5KTUbnDtL+9NzoxDA4NbkaUK1pK4XxPjHL/tVDEc=;
        b=tOhKVMGIvGfeFMwR7OzZMFyu85HHbAET9a+Y+feI+11o/FpgiSB5kFIkQjzNn6nPee
         0O1+gJWY7ZxbGHKApjan3ATqCwyUWQOAK7/O4GQnOVFD0yz63ogUaLOHJbjRvuGBwwBB
         7EPSxtUaxoIOLV5ZYNZfa4F0eNV0+ARQBn/L+LIvxzsYpl6CC8WO/1No4DT+fid7r1YF
         A5t0ycMxmy7huU2B+91BRc6OAtOK1w9IonAwAPGrBTm97KsIvOG0Hfw8m7XKP+IPJuYQ
         ZMDpRAgOCbpAi19M9Sw0kwSB9ODwkpea/EWCWfwDGh0weMIWJzT1t7/d61OtDz2aMe1z
         XJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785755733; x=1786360533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgP5KTUbnDtL+9NzoxDA4NbkaUK1pK4XxPjHL/tVDEc=;
        b=VzNPvcILVR7QRIqnvg4ZBX6iAKTMTXkobKjV2ZHOcpBJ8vFQzBzPcZygsh4cDjF0EP
         oaJZqQ0PkJcPX+5bWY1r+GwD1SgBiQE9aLI+M+KscQJHxI1P5lmVnqJrrVUrlPyEzYw4
         ayLE869W4cFjPL4A8J8uuNNZgGiejjHmA1RczMEsXQimQbyAuhhUAuGGHeRU+t+89pMh
         TlBbzCZqaHLblJt9tOEZdxv20/bxbtK381Tbwnt8cVssThtZG/pjx3SUjI7uawi6MC4a
         hxVdMN3Wi4TrSj6Wshhb4RD2ZfI/invO3PMLuOGe00IZHOrM8JXmF13eBlR7g7KMew96
         frxw==
X-Forwarded-Encrypted: i=1; AHgh+RoRZf5XJaFJFTPocCrCZErp6WokMNEqJB3dFwZnLdlCptNjU/Jh7qubKutsdMqGPHf6wb4ZEGkOCSO6DGfy@vger.kernel.org
X-Gm-Message-State: AOJu0YwdY7ONhoqRF4tKPYKwE2Xo8DMcaTOHwc0kgNAazWeQCFysxfoi
	1jwhETPokvIhbpuwQzZxlhcmVlekaTG9ncUAcMUxVdBhsC7ou6eoLwSf
X-Gm-Gg: AR+sD10rrD0Bl5YwuNy3+zw30ZbckTCHf0+DPgrjFXGLXkavGjur9hE9V9Hshqlb4oK
	rcDGemgXt53BNTyX5/9qPGki5Y7+TGXOyrPvOfUTH6LEnY/bfA5sKx/6yrygpZUPzMvA6//WeQG
	w5OMndBLmui1lPY7GxVw2Tfbn4RyY1NTAeoPC6ArPbnbsy2gV++Y1MyqkXT6SkjEUg2FY/Z7hue
	Px6ndo7Tkud2SIRuFfTWa+6btyo2uVBv6wuqk7uREaZyH4gWRwqSvelX1YLB6zilI9gmN0pCgjO
	iRDNB5B4gkCRX5Foj+ufCzXZW22cw04bfSj5rBTT1xiNjJcwcfgZ8aoIO6uQz3pIlGSZ/1qeHIY
	C5XRMLEuNoupiqqZIe3bEl/QXl6z2lO7ZBjItQYhnv4s0AILr0RW2Lod/JpOoM+mGzXVloL0c9Y
	c8aKkez8xvn+IuJpj7AfkVKLgM+/ryY46ezZpg6GrROktNkp0m8KJRyoif+1Mk0Ehn0iHnvgvMI
	LbD6VFKY8RtPA0WCRbAtE0z6UVx5wtqvILXfvo=
X-Received: by 2002:a05:600c:4708:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4980eb4e95dmr157839335e9.0.1785755732832;
        Mon, 03 Aug 2026 04:15:32 -0700 (PDT)
Received: from f.. (cst-prg-94-167.cust.vodafone.cz. [46.135.94.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a5csm317489835e9.4.2026.08.03.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:15:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4] fs: avoid spurious dentry ref/unref cycle on open
Date: Mon,  3 Aug 2026 13:15:26 +0200
Message-ID: <20260803111527.1922776-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening a file grabs a reference on the terminal dentry in
__legitimize_path(), then another one in do_dentry_open() and finally
drops the initial reference in terminate_walk().

That's 2 modifications which don't need to be there -- do_dentry_open()
can consume the already held reference instead.

When benchmarking on a 20-core vm using will-it-scale to open the same
file read-only, the results are (ops/s):
before:	4043375
after:	5629378 (+39%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The spurious ref cycle remains an issue and it is trivially avoidable,
for the most common case anyway.

Al Viro had a more involved patchset which got stalled, see:
https://lore.kernel.org/linux-fsdevel/20240822003359.GO504335@ZenIV/

I already pointed this out over a year ago when sending v3.

Given lack of traffic on the more involved variant, the nice win from my
simple patch and its overall triviality, I think it should go in. Worst
case, if the more involved work ever gets off the ground it can be
trivially reverted later.

bench is:
$ cat tests/openro3.c

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>

static char tmpfile[] = "/tmp/willitscale.XXXXXX";

char *testcase_description = "Same file open/close read-only";

void testcase_prepare(unsigned long nr_tasks)
{
	int fd = mkstemp(tmpfile);

	assert(fd >= 0);
	close(fd);
}

void testcase(unsigned long long *iterations, unsigned long nr)
{
	while (1) {
		int fd = open(tmpfile, O_RDONLY);
		assert(fd >= 0);
		close(fd);

		(*iterations)++;
	}
}

void testcase_cleanup(void)
{
	unlink(tmpfile);
}

v4:
- rebase
- don't grab the extra ref on mnt for truncate
- bench opening things r/o. note perf improved from last year thanks to
  other changes

 fs/internal.h |  1 +
 fs/namei.c    | 13 ++++++++++---
 fs/open.c     | 27 ++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..9632239036ac 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -205,6 +205,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 int chown_common(const struct path *path, uid_t user, gid_t group);
 extern int vfs_open(const struct path *, struct file *);
+int vfs_open_consume(struct path *, struct file *);
 
 /*
  * inode.c
diff --git a/fs/namei.c b/fs/namei.c
index 3f9bf103ba12..cf79ecedf288 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4789,6 +4789,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct vfsmount *mnt;
 	struct mnt_idmap *idmap;
 	int open_flag = op->open_flag;
 	bool do_truncate;
@@ -4827,14 +4828,20 @@ static int do_open(struct nameidata *nd,
 		open_flag &= ~O_TRUNC;
 		acc_mode = 0;
 	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
-		error = mnt_want_write(nd->path.mnt);
+		/*
+		 * Stash the mount point before vfs_open_consume() whacks nd->path.
+		 * It is safely accessible because the file obj using it is guaranteed
+		 * to not disappear while we execute.
+		 */
+		mnt = nd->path.mnt;
+		error = mnt_want_write(mnt);
 		if (error)
 			return error;
 		do_truncate = true;
 	}
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
-		error = vfs_open(&nd->path, file);
+		error = vfs_open_consume(&nd->path, file);
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
 	if (!error && do_truncate)
@@ -4844,7 +4851,7 @@ static int do_open(struct nameidata *nd,
 		error = -EINVAL;
 	}
 	if (do_truncate)
-		mnt_drop_write(nd->path.mnt);
+		mnt_drop_write(mnt);
 	return error;
 }
 
diff --git a/fs/open.c b/fs/open.c
index 6b1c14e684a9..2a7697cee00b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -931,6 +931,11 @@ static inline int file_get_write_access(struct file *f)
 	return error;
 }
 
+/*
+ * Populate struct file
+ *
+ * NOTE: it assumes f_path is populated and consumes the caller's reference.
+ */
 static int do_dentry_open(struct file *f,
 			  int (*open)(struct inode *, struct file *))
 {
@@ -938,7 +943,6 @@ static int do_dentry_open(struct file *f,
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
-	path_get(&f->f_path);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
@@ -1055,6 +1059,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->__f_path.dentry = dentry;
+	path_get(&file->f_path);
 	return do_dentry_open(file, open);
 }
 EXPORT_SYMBOL(finish_open);
@@ -1098,6 +1103,7 @@ int vfs_open(const struct path *path, struct file *file)
 	int ret;
 
 	file->__f_path = *path;
+	path_get(&file->f_path);
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		/*
@@ -1110,6 +1116,25 @@ int vfs_open(const struct path *path, struct file *file)
 	return ret;
 }
 
+/**
+ * vfs_open_consume - open the file at the given path and consume the reference
+ * @path: path to open
+ * @file: newly allocated file with f_flag initialized
+ */
+int vfs_open_consume(struct path *path, struct file *file)
+{
+	int ret;
+
+	file->__f_path = *path;
+	path->mnt = NULL;
+	path->dentry = NULL;
+	ret = do_dentry_open(file, NULL);
+	if (!ret) {
+		fsnotify_open(file);
+	}
+	return ret;
+}
+
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *cred)
 {
-- 
2.53.0

