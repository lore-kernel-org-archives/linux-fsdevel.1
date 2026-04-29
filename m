Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE073328FA;
	Wed, 29 Apr 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472825; cv=none; b=opTdlKIStgjXbxDCJZGk2hI3JiViLhPAVaoeWtEeThSbCMMg6UJKA9qQaGdUa1iGinrQLkPNx/EORj8c9dGucEoBAp1FB/w4GpFke5jzfMJB22qB5Wbrt4S9aWbU7SJNmwC59Mf5qAVCA9AYkjkgKRVR/ziJLX6Bj69RtbW8fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472825; c=relaxed/simple;
	bh=aoAVzwqJBSEZZkD3iyaUdNDfhY+4PgASCD+pmjVEzYs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlha0DXLewZvnq6Qb975ZCVCdaqx/rVHyTZ1Wi9/dWruSY6S+/LA0+OqrbO0HQcHM3tDle/tf18ZesLaSmBvE0BpuxznglQkA9TgRTYe1aIJSpgadzpN9ukVbb7XtwSd6Oi4Q/rraiRGbhkgP9vGD9hTBDBD3E7f8MRzeHQfK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVrt07XC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVrt07XC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9CEC2BCB8;
	Wed, 29 Apr 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472825;
	bh=aoAVzwqJBSEZZkD3iyaUdNDfhY+4PgASCD+pmjVEzYs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nVrt07XC2+3exZhYJEs6Q8AyJH3Oq6XAGO1V7GGNsfY6yTZ9UDRm8gRi78CDCEKjK
	 APfyoOd/v4O1+l3QxCs3ISnVvtPwNP6FUinZqFzBO1FX4QcobNpHzffGyoRmxHyUwq
	 H6Ea6/A3faxAQSm0iZV6fKE76v1MdekJrb8yMI8BqYhpZ2QRXJ30aZcUQo1UsVBo8/
	 DaoeMHZvCe+eDW6NbSTnWjsAY+B+mhN/yS5dUrFg5yjTnJ2760m6ImuKjRcIQFKa2E
	 sQhKDa+bDzC9qXGLRm64ESnkwX2Cs1DmJe3JhTCvaVOoSWtKyxAeM3OT5EDDTV/ccD
	 YcpYtKwV53trg==
Date: Wed, 29 Apr 2026 07:27:04 -0700
Subject: [PATCH 13/33] fuse_trace: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205429.4101881.6022385132839033542.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    4 ++++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index fac981e2a30df0..730ab8bce44450 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -532,6 +532,52 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+
+TRACE_EVENT(fuse_iomap_fiemap,
+	TP_PROTO(const struct inode *inode, u64 start, u64 count,
+		unsigned int flags),
+
+	TP_ARGS(inode, start, count, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	start;
+		__entry->length		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT("fiemap") " flags 0x%x",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->flags)
+);
+
+TRACE_EVENT(fuse_iomap_lseek,
+	TP_PROTO(const struct inode *inode, loff_t offset, int whence),
+
+	TP_ARGS(inode, offset, whence),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(loff_t,			offset)
+		__field(int,			whence)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->whence		=	whence;
+	),
+
+	TP_printk(FUSE_INODE_FMT " offset 0x%llx whence %d",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->offset,
+		  __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 32ddf2fa6bdf78..be922888ae9e8a 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -693,6 +693,8 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_fiemap(inode, start, count, fieinfo->fi_flags);
+
 	inode_lock_shared(inode);
 	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
@@ -720,6 +722,8 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_lseek(inode, offset, whence);
+
 	switch (whence) {
 	case SEEK_HOLE:
 		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);

