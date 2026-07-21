Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C12480328
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630147; cv=none; b=oKm582GsO0ntCd6aagV/wkDJrKxMO4953nF2bL8Ev6nlFKM2rIVXBQpkFMbvbfeRF223pgRmgmwMWTox5lFk4f4E6bO7qEpuEdl6ZcNI3W5rlwucQvtwgvxSkyPZ0X6zZoOQZ3cxqQNDcrQy+jOplK30ihcsjq9jxRZZ7rsDoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630147; c=relaxed/simple;
	bh=ghPQ9mcgrKz3+U+ilyhGAv/Y8JcFyKgalrPrJ8yyfC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk1shZSEMofVuo/xJujrKknaQPUyNpd8ME2V8rlt50deC9J7GIZ+xyh+GXYgrFlHAByfDCGyz68108aEN6B0z3R75paHCzMWIAfsaoj5hKQB5r4R1Bl38fwQvDfIcQk2fuf9pI82HlDE+bkAbdzO5RnxZx51YwtpWbu3DkzPVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkB8WQmw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkB8WQmw"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso7103353a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630146; x=1785234946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIMbIeZnuWoiMNHS5JGYvMjDla9rmj1HSMh7d1MFhPo=;
        b=nkB8WQmwI4NdEtLik4DRFTOX639DTcsfCrMxqS6DRymg+EzjpYK7YN+psev6IMJ3Xm
         /KKktnscpcsZXRORDXxIVreMsBQug+Xq/x/SVCEf34M3tJ70ahzBJuvITQPGMt6R83VL
         N8hxr9uBybcdfbddgjicaIfu9dTJjSNCJyyIapNsJe4YawRSdiXvOVTKtxp1Q9QQyFA6
         ewvRNTmMCbT7fiQSrVKA7p8qUI+EtQyynI66IjCekpOk+V4VyGvn6qsGyDtKFYS+wnUt
         vx6cgSpxr1az8wGgwi6CGxJIdzvaWxu2zNg0PKwh5J621dHrfNmt66dDjDOT9TWj/spS
         kwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630146; x=1785234946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIMbIeZnuWoiMNHS5JGYvMjDla9rmj1HSMh7d1MFhPo=;
        b=O0aJ33k8a37u7UkrgF5vEhOFzmImMtFAMzZnB3T8sbxgglYyZXNza0/8bDtYmSwXd6
         Dnp6EU0Sq7KXvDIdIhOcLqrHM1oaBcK33zI1g0JntRXJQ07fTqvmOhCVg3cr96LJVA2p
         ARqPjFESVD1h/5JwkIb79sfuLUqUwpIoPIC4BkNalpEwcz9NVwHlDjYZ1grxliDEu7LW
         wyqKHeMs5FyBEKttHNNXjPs+24THhZTB2xH+cI2ztZk0FmT2KkmjZEoRJvS8igCdCl2F
         hz5Tkt3AXX6aju08SbiCeJiu4oKB08+m4vRwIsegPZyI0BPtIE2htv6BU4tbam5eZOmA
         ++ww==
X-Forwarded-Encrypted: i=1; AHgh+RpMwJ7TWm4xE2kfW/FT+LHQM67r+vbpBmsDF82R2PqViNck0SpN9gjJf8KLOlYKSbwj4/Fwxd3A9L3zY8ML@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqYTKlop0N+XOQLPeSoN0CR+NEQMnlKdlIhRaV8UG71pDGw86
	EQUqWHlOcTfxyGQ3r+Ks0HtKuocGhiGzOSlMaUuZs4+gdYBRs1KGcC9V
X-Gm-Gg: AfdE7cnTpfbxNdBU/W0DJPGSjCujkqD6hupI0yN0hx4ujSGZtgUIejkhiGa9CHZsr+w
	fZvA9LbPUPAe+T4/mTZpz0i3nM2HmF9+B1XL2yMHRubUI91EQAPAaenUBtJvr3fmTsnYYvet6EU
	DAQyypzFLoL6cHFhjbfOlLLj+u0PrkpqMiixDHFZBQXfA7BnSzwcn596PesWDBAsGRzZR8wkelf
	WrF185f0WWBq+U+AI6gXZm897GCvD+LCezsBUlZ5AfAV6JtetzbU795HWixnAAUitv/1hBN5qiP
	Fe9PIIVzizt4LL1wqsSWGu1TFzZolj9qF96RmxmEzcuJTU4Ve87khpKtnlNO4RqCT9sPXu9Ny4M
	sUZRRQz1SG5qcZjUpo32tIIOV3K99/EwtUaSe4u0SJZPNQ/oG//XdFHhI+LhMUga1pFJI/vJvWG
	RpZBiFfRtHmTuaz2pOJlu8/NHk3OsBLwPiLKufZSOMcp9ZhSV+5w+qLF9mL95ancrtzIRiWIy8t
	lc9pQyuR+ziJpsfLXbKvVpnAUI6nY/H1Mv/6NueYMnqDxYMcTIFuGvaZUJczV5s0dIpB/B726NV
	1CYMr7GEm3/reV0=
X-Received: by 2002:a05:6a20:a10a:b0:3c3:88a5:83db with SMTP id adf61e73a8af0-3c3ad6036b0mr19195489637.5.1784630145838;
        Tue, 21 Jul 2026 03:35:45 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (114.107.87.34.bc.googleusercontent.com. [34.87.107.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm49922929eec.29.2026.07.21.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:35:45 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v3 1/2] fs: make file_listxattr and file_removexattr helpers non-static
Date: Tue, 21 Jul 2026 10:35:13 +0000
Message-ID: <20260721103514.2716-2-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721103514.2716-1-aditya.ansh182@gmail.com>
References: <20260721103514.2716-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding IORING_OP_FREMOVEXATTR and
IORING_OP_FLISTXATTR support in io_uring, we need to invoke the VFS-layer
helpers from within io_uring.

Make the following helpers non-static and declare them in fs/internal.h:
- file_listxattr()
- file_removexattr()

No functional change is introduced.

Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/internal.h | 2 ++
 fs/xattr.c    | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 355d93f92208..ee86b24db79a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -297,6 +297,8 @@ int filename_setxattr(int dfd, struct filename *filename,
 		      unsigned int lookup_flags, struct kernel_xattr_ctx *ctx);
 int setxattr_copy(const char __user *name, struct kernel_xattr_ctx *ctx);
 int import_xattr_name(struct xattr_name *kname, const char __user *name);
+ssize_t file_listxattr(struct file *f, char __user *list, size_t size);
+int file_removexattr(struct file *f, struct xattr_name *kname);
 
 int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode);
 
diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..31b8a5eeec1e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -953,7 +953,6 @@ listxattr(struct dentry *d, char __user *list, size_t size)
 	return error;
 }
 
-static
 ssize_t file_listxattr(struct file *f, char __user *list, size_t size)
 {
 	audit_file(f);
@@ -1036,7 +1035,7 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
 	return vfs_removexattr(idmap, d, name);
 }
 
-static int file_removexattr(struct file *f, struct xattr_name *kname)
+int file_removexattr(struct file *f, struct xattr_name *kname)
 {
 	int error = mnt_want_write_file(f);
 
-- 
2.47.3

