Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708234;
	b=Wy8wk8fIY0MJ/p0Pp1HBo7zV69s/xpqvjUHy4zkoi8dimoDn0SO0vaNj6MVQUIDXu7yw
	 gf7BEFmnzflBpKcaiGmvquM13nyiUm3B+zvqTtuuO3HpdwlYaImHSDUrHx80kFP8gVGr/
	 dXTTniou+CBluM669xzNnLHuITb4BD8S7BNLi6CHz5q6tVV8BioHZpbtIiEsZgy6R4Ea+
	 2z/4PKEDmCJJZBtJ5A1iwfEx8yGG9vsaaGzT2LQH1gByWw0hEphrlrqQacokVRxlr9fE8
	 MoAZiPV/sr+QdS5Fe9/bOH34bFgJapUISPBJBCVbguKb6+9py9AtzRyztONQzLqt+8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708234;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:Date;
	bh=Ldk9f4ENy6ZI26hgamdhXAYUlh4Ac8KnZ+Q2k4rh0WU=;
	b=vh7gqX+sqBnfCd9COhgj1qRhTzmH/DyCB6yd+tlXDCeAs+nPtNQ/K/bXV/dsLVhZ5HYl
	 EtUNlmS6DaatZ81XWUTT8PT0EmCCkmbTqA+8uBBwcCmbhxT9WDm43foONYx61J/Zir0zH
	 YJiyWs15dNXRFs6i1Nn6BXjYONkhbNukSBn6eLKP2zMSo3X5+m3GabXfBcciTQ1E/CuLs
	 PIm323OOL4CXuLyKx9gcPqzwkfMxUdYi2FjNQGB8MsKzvKsTzglGj8cPeNxNsw/bSCcNH
	 Os49UnK8t3XNnYixRUqhQgm9E9f2JppNwMYzHva0k1Bkk6Th0LOuURf2Q7MJLx1EzcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54A606A327;
	Thu, 26 Nov 2026 15:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D54A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id D36B0C92FC; Fri, 27 Nov 2026 00:50:25 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: Namjae Jeon <linkinjeon@kernel.org>,
    Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH v2] ntfs: keep i_size of a directory equal to its index root
Message-ID: <20261127-ntfs-01-v2@snowrabbit.org>
In-Reply-To: <awePnaRhBQLahPpz@hyunchul-PC02>
References: <20261125-ntfs-01-v1@snowrabbit.org>
Date: Fri, 27 Nov 2026 00:50:25 +0900 (JST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

After mkdir, stat() gives a size of 0 for the directory until it is read
back from disk, where it gives the length of $INDEX_ROOT.
__ntfs_create() opens the index root but does not set i_size from it.

When the index root is moved out to an index block,
ntfs_ir_reparent() updates data_size but not i_size, which keeps the
length the root had before.

Set i_size in both, as ntfs_ir_truncate() does.

Without the patch a new directory was 0 bytes and became 48 after a
remount, and one with 300 files was 248 and became 56.  With it the sizes
are the same before and after.

Fixes: af0db57d4293 ("ntfs: update inode operations")
Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
v2: removed the two comments, as Hyunchul Lee asked.

 fs/ntfs/index.c | 2 ++
 fs/ntfs/namei.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index fe2a79b..73c8e6f 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1434,6 +1434,7 @@ retry:
 		icx->idx_ni->data_size = ix_root_size;
 		icx->idx_ni->initialized_size = ix_root_size;
 		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
+		i_size_write(VFS_I(icx->idx_ni), ix_root_size);
 	}
 
 	ntfs_ir_nill(ir);
@@ -1455,6 +1456,7 @@ retry:
 		icx->idx_ni->data_size = ix_root_size;
 		icx->idx_ni->initialized_size = ix_root_size;
 		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
+		i_size_write(VFS_I(icx->idx_ni), ix_root_size);
 	}
 	ntfs_ie_set_vcn(ie, new_ib_vcn);
 	goto err_out;
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 29f1bf5..e4b0fc4 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -611,6 +611,7 @@ static struct ntfs_inode *__ntfs_create(const struct mnt_idmap *idmap, struct in
 		err = ntfs_attr_open(ni, AT_INDEX_ROOT, I30, 4);
 		if (err)
 			goto err_out;
+		i_size_write(vi, ni->data_size);
 	} else {
 		/* Add DATA attribute to inode. */
 		err = ntfs_attr_add(ni, AT_DATA, AT_UNNAMED, 0, NULL, 0);
-- 
2.54.0 (Apple Git-157)

