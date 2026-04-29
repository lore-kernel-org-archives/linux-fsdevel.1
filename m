Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE3378D74;
	Wed, 29 Apr 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473279; cv=none; b=He6s3p+8lwip0NQF7Nvh+SSSQC+/5XdX7CJqSWIcKZZnEbTr32de0PyCm1TbVXtHpB3ECNNPkG9eYJeFpzoyP/BPDmg8kNA7OR8Pzx0w0YWzgydU8BrjOZgSSOIs7+u/+rx6lFqJ3l/1JBDV06Q51p6g/BHq98Yeonh80ja3C/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473279; c=relaxed/simple;
	bh=vVvSMyMRCvVs+sLH80p/HpgTudAsyqqUjKlVPeklRDw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AI06JellZ1ypN/Q7No4xmkU8BlzTxmRF1LLW6LztM/eATYHw81vxPsyeeO+O1TMzgLzAHeL7PHjh++9/PbJQ/grXVz5ZRF179YZbzPXDHiGAzPGx5y35tRw1qICUFJBb2buO32T6N13SMWdo4NR1lGBiLN5YrYinE2jmhGQ+cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJEW4ePw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJEW4ePw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43375C2BCC7;
	Wed, 29 Apr 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473279;
	bh=vVvSMyMRCvVs+sLH80p/HpgTudAsyqqUjKlVPeklRDw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VJEW4ePwo3oQXszBtf0IcFwYj8NgfPksZCJ9+bnm1eiNYh76zx/91J6apJAgA8mhH
	 kmqwamnSlS012/GJTzPdnBVqNYAds/Z5Y4IVYiC+hkaNpeYjVa3IEjYT/UFQ9/WpZf
	 938g/iGIl5q64iwExHv5edaNtUJTuj1KKm+aFI3WisY6T0BoIo8SaF0sqMV13EqWO2
	 nZAw5uJXl9XXg8lXjMtPCJJuZyVnFQzL7Qr9EeX89boo4TqGwPtDV5Iur0fl5VIC8P
	 1CCau3ONv/ieTy+nVeXVaE7L4vKH+83cziB/2xFOrJp7SmTR+hAxk4S63UUF0bZ9W8
	 7/2W7RgKU/CzA==
Date: Wed, 29 Apr 2026 07:34:38 -0700
Subject: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206617.4103309.9491664333731079107.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Let the kernel handle killing the suid/sgid bits because the
write/falloc/truncate/chown code already does this, and we don't have to
worry about external modifications that are only visible to the fuse
server (i.e. we're not a cluster fs).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 61015e83888ee4..e664a60200ee26 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2477,6 +2477,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	struct inode *inode = d_inode(entry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -2485,15 +2486,19 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
-	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
+	if (!is_iomap &&
+	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
 				    ATTR_MODE);
 
 		/*
 		 * The only sane way to reliably kill suid/sgid is to do it in
-		 * the userspace filesystem
+		 * the userspace filesystem if this isn't an iomap file.  For
+		 * iomap filesystems we let the kernel kill the setuid/setgid
+		 * bits.
 		 *
-		 * This should be done on write(), truncate() and chown().
+		 * This should be done on write(), truncate(), chown(), and
+		 * fallocate().
 		 */
 		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
 			/*

