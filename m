Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976126B08F;
	Wed, 27 May 2026 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852838; cv=none; b=Yw+vd3BVNA29lQBPD4iQ2OYdjlHDZsrv8FowlgUElsSErVNy2f5iFyDSNpfuL1PVSiAy3fpKRlhD4yERwLSIx5x14CXhJtZe7iFXDwFADMGufGxqynuOay1N849e+XVxoI1+sN8Bv5XhGa9wqEHZccE/Wz52WhI8ED7O/EwZ1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852838; c=relaxed/simple;
	bh=uUVuvf3LDJbDKjmz5mAMEAyg1jeHjgH+PFss7lhB8zU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ms90q9T7NXmbrc5xnhlfmN2tgNX+swSGY5NVpuQ9kGO9xmTgtN6MpW2mZT+M1+kSd0Lu5pUR0yQCu8x5fOc/JjI1ulwcyTv2fKT6HZW6eXIadL26M1ScmF8KydJ8RHBE8WDKhmxHGpD/ruACT0pB8yLnvZ8p/mfZUEDQ1E8+ppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JzmqN+zK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JzmqN+zK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=qySVp7X/0tLGUOnH0TYcSbLP11IQHIoW6GquRNdGB+c=;
	b=JzmqN+zK+Cc0OseDA5hBLyIKUxHfSxM8i1KRbAnRqhwd4CGiaVwrT6Avyj4KtX
	jhDwgIwKXSl27HUamyRIFPuyM1h+xTmBL4sMWAmiokd1EkzkooruTjyKEGrp8luS
	A98AYIrb49cxRKl+4kgOT01V+X1BB20a5I0iOrepxMmmg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA360N4ZRZq+ceuDg--.62176S2;
	Wed, 27 May 2026 11:31:06 +0800 (CST)
From: fffsqian@163.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH v1] fs: fix two spelling mistakes in comments
Date: Wed, 27 May 2026 11:31:02 +0800
Message-Id: <20260527033102.824028-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA360N4ZRZq+ceuDg--.62176S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry5tr1xXFW3Ww4UCFW3ZFb_yoWkKrc_Gw
	1S9a93GF4I9F1Iyr4UuFWYvr4Yqr4DAFy3Xrs3KFyavay3J3ZxJ34DJr9Yv34DWrs0yry3
	AasaqryS9FsFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LqXPUUUUU==
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbCwRqXYmoWZXoHQgAA3I

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Fix two spelling errors in fs/:
- childen  →  children
- postion → position

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index bb6fdb1f458e..f82f6dc4f773 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -637,7 +637,7 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 		pidfs_coredump(cp);
 
 		/*
-		 * Usermode helpers are childen of either
+		 * Usermode helpers are children of either
 		 * system_dfl_wq or of kthreadd. So we know that
 		 * we're starting off with a clean file descriptor
 		 * table. So we should always be able to use
@@ -1053,7 +1053,7 @@ static bool coredump_write(struct core_name *cn,
 	cn->core_dumped = binfmt->core_dump(cprm);
 	/*
 	 * Ensures that file size is big enough to contain the current
-	 * file postion. This prevents gdb from complaining about
+	 * file position. This prevents gdb from complaining about
 	 * a truncated file if the last "write" to the file was
 	 * dump_skip.
 	 */

base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.25.1

