Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C33148D2;
	Wed, 29 Apr 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472528; cv=none; b=pUTinK6YnTvkQL7xTZW0b9S+lj8e6JymsG7eqFiDV+7uSfuoC5puP4oSLieivntGwXcTWY8mlrbJxNZsmIWHVgCTF15PudQJQm5szVDYl85f206xlkqCdDiUgVXBRLD53Jy1vog1TDXiuM6ClImSUH7jlICthQf+1Jwc3gKQUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472528; c=relaxed/simple;
	bh=9jtBS8CXvHaFbfP5UuRRYl8IEFEBKYq+HvyPZkUOsuo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njkaCsk0azuJq74KxQqTY65mTIPoGXTJrvWvReY63ymWqpGHFb54iKddo9xKzMoAoLFp+UvY/PpYLsse/UXsbQnHOdRGiVkoI3fstaKa6b9aeLWPTeQ2CCe68zyy6z1dX69dLTPyW3jE8WHUH3OkHPMG0zLhQE6HA6sR2NvZDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8DRqkA6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8DRqkA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FAFC19425;
	Wed, 29 Apr 2026 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472528;
	bh=9jtBS8CXvHaFbfP5UuRRYl8IEFEBKYq+HvyPZkUOsuo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E8DRqkA6JD0KdAfv7k5UG3x2b14+4hZbWxt5ql60hqSe5YKvccxwKQqp3RiAyKXJv
	 B9jATBhK5QBdSHkJLr9CHVtHmMmQ2ujI4PX0doXZhy0+/9DulByQaX+EBZrg9owmTw
	 WJzPjGAYKh1MiLgjttyxywLEpgGMUofv86HUT0JMQZfpMJsUlTSgj7ML31rUtIzUO4
	 iqW+fzlV09FpefDGf6n699YMq3uIPil/AJargVXv5duRdr2JnsKs95LnYLVtNmdlnj
	 Xy/QKJqgUcn5bHzayV52afIhl9c38TiZkVY2tdzUXXBU3dhA+50Tq8Yld8wU+h1ts8
	 sYCPeBhD8B+NA==
Date: Wed, 29 Apr 2026 07:22:07 -0700
Subject: [PATCH 2/4] fuse: implement file attributes mask for statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747204030.4101397.6386153472001458944.stgit@frogsfrogsfrogs>
In-Reply-To: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Actually copy the attributes/attributes_mask from userspace.  Ignore
file attributes bits that the VFS sets (or doesn't set) on its own.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h |   37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c    |    4 ++++
 fs/fuse/inode.c  |    4 ++++
 3 files changed, 45 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f83bd090ca28ea..4c135a7edf54ac 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -147,6 +147,10 @@ struct fuse_inode {
 	/** Version of last attribute change */
 	u64 attr_version;
 
+	/** statx file attributes */
+	u64 statx_attributes;
+	u64 statx_attributes_mask;
+
 	union {
 		/* read/write io cache (regular file only) */
 		struct {
@@ -1235,6 +1239,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask,
 				   u64 evict_ctr);
 
+/*
+ * These statx attribute flags are set by the VFS so mask them out of replies
+ * from the fuse server for local filesystems.  Nonlocal filesystems are
+ * responsible for enforcing and advertising these flags themselves.
+ */
+#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
+					 STATX_ATTR_APPEND)
+
+/*
+ * These statx attribute flags are set by the VFS so mask them out of replies
+ * from the fuse server.
+ */
+#define FUSE_STATX_VFS_ATTRIBUTES (STATX_ATTR_AUTOMOUNT | STATX_ATTR_DAX | \
+				   STATX_ATTR_MOUNT_ROOT)
+
+static inline u64 fuse_statx_attributes_mask(const struct inode *inode,
+					     const struct fuse_statx *sx)
+{
+	if (fuse_inode_is_exclusive(inode))
+		return sx->attributes_mask & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					       FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes_mask & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
+static inline u64 fuse_statx_attributes(const struct inode *inode,
+					const struct fuse_statx *sx)
+{
+	if (fuse_inode_is_exclusive(inode))
+		return sx->attributes & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					  FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
 u32 fuse_get_cache_mask(struct inode *inode);
 
 /**
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b658b6baf72fe9..5d9466c7fd464e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1468,6 +1468,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+		stat->attributes |= fuse_statx_attributes(inode, sx);
+		stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1572,6 +1574,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
 		}
+		stat->attributes |= fi->statx_attributes;
+		stat->attributes_mask |= fi->statx_attributes_mask;
 	}
 
 	return err;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 21e55080faee2d..b43e4bf4a1c117 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -286,6 +286,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 			fi->i_btime.tv_sec = sx->btime.tv_sec;
 			fi->i_btime.tv_nsec = sx->btime.tv_nsec;
 		}
+
+		fi->statx_attributes = fuse_statx_attributes(inode, sx);
+		fi->statx_attributes_mask = fuse_statx_attributes_mask(inode,
+								       sx);
 	}
 
 	if (attr->blksize)

