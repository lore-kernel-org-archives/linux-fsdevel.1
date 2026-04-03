Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7B347FC4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185750; cv=none; b=LaQxAzoAcbSKVuS3muG53X/l4QUsnLyz1v9D63CHKFAZ74q6SFT4zewdYRN/cf38WfzG8vrN7GEMlbxy5N7zjfqD+YlUdk/W7zRr+km8/Q26FnS0sfnLo2ZiaCEDJoZDgIfh3Iaf8ytTb5jvsyWEaNJFqHX+MkIMItIPNF/t1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185750; c=relaxed/simple;
	bh=ubOzRRsA1zJd3i8a+Cuu7Mz/w23nuUBsWygkMvjVXm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJUZDApzohdyd8gh0StDVCHq5xtbKAwmfBnKhmGvkD3dAgVL4fJpYoUsYqifCgxRIbqHnPlSPvcRsS5xpFSB2ch8Yng6IYB72c8ydehe0pIBZ0n2EMWks/U51q5PzxRZ76/9MGaZjsn36z1YmEZ4bT/4SjYRgfm1312pbLilqX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EueiloQr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EueiloQr"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50b392f1846so16641591cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 20:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775185748; x=1775790548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8u86zVn3x5mfnTbqvKyzgu+ADF1ErhB2fVGX96rkGw=;
        b=EueiloQrO3mgJOBwjhqtGbQC/0qf+nDR7qWzm+FKV0I/Wobb/xR2Bu7C914FR9eO64
         VzhvL3VmfT2rgPA2nh6glqRLG1/Fw8XHKZDuqHwjkHMup2OF4IWywMDdJ1LYIQ049CBr
         pw+N6Byck5qP7o+uIaoNqIV8l1O/oIDj3pHh+W31sON3Vy8NzaOlDtSjNHoYwxb0fX9N
         mNBodeqOOi6z4xyZlO6rkSzrMfI7jd0JGo/zH17wQQbu2CM1FlF4+U1qzwQK7X6ZsYEj
         MOj/TgSquGMibCv2Fq1mAOzb9XGKF1cMs2JdjpfOlu4cDQ437Y9UpfdVwLqinem5fvWT
         CmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185748; x=1775790548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8u86zVn3x5mfnTbqvKyzgu+ADF1ErhB2fVGX96rkGw=;
        b=dxGDk1ofrhAmg4PXj2f4wrfEWdBT3IwcV7OA/QLTH+8J55V+qh5zZmTzl4KzaFWe/T
         KY/dJmXrLF02vXn4dIIheXXjfdLgR7ksYp32NH3KuJgsBQsBqFuhtBTm4TIbwZNSczK5
         Cv5X60RGlU700uwDt+LKulqpt0Xhb4lKdDm36vHR6hr+PGryokHhwKBBGAvFeAKH1ppx
         3QAhhuE2RRedSy5rQaSYQ3KVdrI021DNMTz7dI+spugTeW9gVQ+YW0q3r4oB3yATIUxY
         YKbr/wMTHDtINBkbhOs7/UWIkz1Xrp5FD19I4Lr1d6gP7vyQMOuYSER+RaoHAsfpwgxx
         4Xrg==
X-Forwarded-Encrypted: i=1; AJvYcCWX8JKLoloUbJ77lcZnOmrY1oRnrszXjVSJpvci/D24BDkJK9f3heq9zva7hmT7GYkyE65E3hcwf0FE3Mh7@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqQnceT4fCZ3u/JrHqwUMfeXT3EXe0u+sopy/pFxkzJE4ejDJ
	Xfq9wCtK7qAstOFNIJrndLQTE6uvcWVy3+A/tgm8ZxKA9cCgue4WVsACvv7qwWFTag==
X-Gm-Gg: ATEYQzz1hLGuNxBSxDeaECWSwywLrJ8FFeYeBOCUDhMJJEX30Co+M+b+aPNJcRla8iK
	yll0jHhsvpu76WKlHhheNuWAsuEOGkvZwKCoAMijpkn6+GvQ9aYFOGelEayQXl06wE3xsmfLJzg
	kAdPb0BYupAeTet+3sWSgrFT0Miqsqjml+YgXt/XscixyeYVKvto28xYBXrxo0uJ0Dni3yvAdj3
	84ftVRQrY3CNuAyqRk5D8/jzejV9mflSNwlW4U+hwA1qzPmK5BP+iZHGNmyCvgtee3t+xOmoxiw
	Ix2nGsVoAxkWM7yAdiVcL43TmHrt1GkARVzLvWzjvgSbkvct7J1IpWVGugsZlqdoxotILagFBT5
	Exh20/23trGL9W50bCt5WB4qdXPPA/LIwVlkG6iJ+z7t/hOaUkf6OcySCji73QC6q3B/w1oNE0s
	SYY/uavX6nKXctPIsBn4XEnOKmhPgiNacA4DhcwuR6cHLhF8PsU218gfWTYDOAn+iRWD1m
X-Received: by 2002:a05:622a:15:b0:509:1cf9:ea0e with SMTP id d75a77b69052e-50d62a80ddcmr26975991cf.41.1775185748160;
        Thu, 02 Apr 2026 20:09:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593ded920sm37724896d6.21.2026.04.02.20.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:09:06 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 1/3] fs: prepare for adding LSM blob to backing_file
Date: Thu,  2 Apr 2026 23:08:33 -0400
Message-ID: <20260403030848.731867-6-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403030848.731867-5-paul@paul-moore.com>
References: <20260403030848.731867-5-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=paul@paul-moore.com; h=from:subject; bh=vO4j5WeMDF8uCaEs+Rdi7vAE5nsJDGp7MtIwbA6jMDM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpzy9ABnm7o+Z/R7KK/xs51rLx8PxwZiwo+kbgY FAsqRG/RIeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCac8vQAAKCRDqIPLalzeJ c0/iD/9AMU4LuXIflLPn+lMMYMXL4wz9r6vZ2+IPv39vdupeEEtbP25ysV3gOBT/AMCJr0YZsyJ nAA+n8pMAjlgBtJIk4TWLq7fpPB0T8u9E0JMzT9gZnOCHnqlqc4ydP0gySv8oT5rkfdlOaWBbpA gZe1wqNYP2HK1Kad7uVTVFets5abIwjgXwzPdXgMV9b/PFeXrp8fedOIAR8WBdlAD1I41BW6IDh HakWAR9mdWgZ3pLFsxddxWCu3jcTQnJ5dbOjjZ5//cWmwt+PKcBsu9PlkjfOPkzaMeJf6BfgLAW 5QukV/rYK3H1Dc+TeuDdbT7HI1cFzi7Xpz5LeW1IFzYyFByGryq3ug1tpSpmMQLUOZzDWARemhj gcqAU8aaBhMkclqN5XrJRdOdkxQJQyXgu4FyOsQ88DCAc6iqS9pTaXO7MXzRFf+Dy65Ue+LfpII d0ryWB+t6fWIUFbpD6lBPVhQGtjc/NI/u1jplqW58aA1T5vqMzmjEMatMUBcG/l5OyspEAsIlka caOfuNSjXvwX1j5JCPbkF1G+yT7fdc9g2D2pu0mIfxcJrUmy7Ti6uxndL6rt/qFXk/gFcbBpaVK p0Ow1dUry8bLwkwqcLWs6Q0F2SR4JIX8e/mNA5jb4FpnBSDrrD5V0+4H20fVhTMfuNcKYskg+Rp pRUE5uqRW8k9irA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[PM: use the term "LSM blob", fix comment style to match file]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/file_table.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e..3b3792903185 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -66,6 +66,12 @@ void backing_file_set_user_path(struct file *f, const struct path *path)
 }
 EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
+static inline void backing_file_free(struct backing_file *ff)
+{
+	path_put(&ff->user_path);
+	kmem_cache_free(bfilp_cachep, ff);
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -73,8 +79,7 @@ static inline void file_free(struct file *f)
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kmem_cache_free(bfilp_cachep, backing_file(f));
+		backing_file_free(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -283,6 +288,12 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	return f;
 }
 
+static int init_backing_file(struct backing_file *ff)
+{
+	memset(&ff->user_path, 0, sizeof(ff->user_path));
+	return 0;
+}
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -305,7 +316,14 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 		return ERR_PTR(error);
 	}
 
+	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = init_backing_file(ff);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
+
 	return &ff->file;
 }
 EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
-- 
2.53.0

