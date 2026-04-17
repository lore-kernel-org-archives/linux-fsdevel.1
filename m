Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541273A4F20
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419007; cv=none; b=jrw9aNkdKjDMfIhH05AiSRCyqhsYTfxrZqb+yd/3ssZPfLFpeSPpuNTCHe9KFAcjM2I2y/56KScUchMubZzk7wBVITWlS0637GbJT1OZYI/E2sVrH2lydgQyjoI8e9Iaayk1fAj9QDRdAAObs7nXTmGQNS+C1hJbkS8hrQjXq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419007; c=relaxed/simple;
	bh=q9KcB0Uy8JGV1LbiEUMInoLiBAuOysu+6swjA3zeq0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9IaUr+9a7TdLRmW5EMhm4h/bnH0oZeBzlohMaz+lGm8HRltQ/59mlzkGCEIaRQbIikGQWiPc91LiGmtCyQ04KGOEOs8k2zQf3Zf2npM3XYVZEjTMLTmI5g5/DxOothL2bLPzwISl0+ozasQJWLYnzxKetZCBn43eadySZud6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dx2b9O0P; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dx2b9O0P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776419003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xRccNVm5iXUQ7MuRJQJ6cTe2QjHqq6YXhq0GkmucxPA=;
	b=dx2b9O0PPAVsqEZw8X/CGhoX6orRK/UoqMFa8CrDe3gV9rh2wEsg1oVOu91Tsfh3Fs0vwU
	syUHQ13nw6nSdbZFqjfjcM8MBzuBrlv3Qo7d97mxqbAki9zXSmIdG+gMmmvJ/0fF8pJhik
	1E7C8uUJ6K1GE2B61hmLvvnKO0jI7+o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dcache: use kmalloc_flex() in __d_alloc
Date: Fri, 17 Apr 2026 11:42:40 +0200
Message-ID: <20260417094238.551114-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=thorsten.blum@linux.dev; h=from:subject; bh=q9KcB0Uy8JGV1LbiEUMInoLiBAuOysu+6swjA3zeq0c=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmPGPrMLBNDd1qsuXMmxmjr4ZCT4v+1JB/KqvVoTJ4/L /if+Kv4jlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIwQWMDLN02tqdo+M1br1s yC/NzmsJXvnvxErWal/X3a/n9K1z2MHwi0l7x/EJ6a9nW85o/KnBbFBxdLamaWZ9qZbZyofHEvl CeQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kmalloc_flex() when allocating a new 'struct external_name' in
__d_alloc() to replace offsetof() and the open-coded size arithmetic,
and to keep the size type-safe.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/dcache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index dbcbd0affb26..4568f9530166 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1753,10 +1753,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		name = &slash_name;
 		dname = dentry->d_shortname.string;
 	} else if (name->len > DNAME_INLINE_LEN-1) {
-		size_t size = offsetof(struct external_name, name[1]);
-		struct external_name *p = kmalloc(size + name->len,
-						  GFP_KERNEL_ACCOUNT |
-						  __GFP_RECLAIMABLE);
+		struct external_name *p;
+
+		p = kmalloc_flex(*p, name, name->len + 1,
+				 GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 		if (!p) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
