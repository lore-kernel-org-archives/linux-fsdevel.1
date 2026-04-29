Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74948361DAE;
	Wed, 29 Apr 2026 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473811; cv=none; b=N5/mxOv4xHryVGUfo8Fbv41sudFRc0n1jz1lrQMRZ4d1julK/IG45v/TKv5t4E4tx6MB7m+34OTCX71tjv8L2DKxhIUOApUUfZJBvCfoeFrT8df7+WemNPCL60DP4+WrfmL8oK+20FmCrAPuTrugQqoLypkGFg+ezK8iEYG4+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473811; c=relaxed/simple;
	bh=hZU6YzNmKjRnz41+UhCqg8WXlw/uUU3DdP7ojmLZnDg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSNE0KJOeb086FTob/J2wia0HvEBShRJlC04qeUxyN38Ne8r+57s01586PSlBqBK5uWF1qhBy0x1vOV38GgkD2aOFY2Z13kylEs6S2qdOt8JONA+HjjXhyNjyreE4hTAUWNo4vXSwIW2vZ0F7sjm66mmD9YBfI6LhymKkDS1qjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLrlvKyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLrlvKyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E48C2BCF4;
	Wed, 29 Apr 2026 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473811;
	bh=hZU6YzNmKjRnz41+UhCqg8WXlw/uUU3DdP7ojmLZnDg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FLrlvKyFMrmZ0Sfn9UkNrTj/k/ky9UvVJkRn27pGAToKLzrtUk4h012tOljL7lDq4
	 DYaBHjzTceLiqfep0p5vJTeh9gMD7EdFsbdoaCqpwnYXIZqoZRdBqY8m8L3vVQNsJb
	 Z1o/4lU4OW2CYxLA0Yhep4Ys3zQt/fKW6rfKfcIz0vyclh4abyn/J5j1cmtFmY330m
	 ReExi1fpM/ZALxAMdnUSarJfjNWQ40zCd9zs6BnZUCqxJLiBHUWK11CzEVYhOYRYpd
	 QdyZMGIkNRAy6Qqfb6atS6Ys4SuIDZfIUUKd39istj8gCvvepbS7F7/I93mMQqpSfs
	 LwtVShsNn+4xg==
Date: Wed, 29 Apr 2026 07:43:30 -0700
Subject: [PATCH 17/25] libfuse: add upper level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211872.4104686.15469141752613975275.stgit@frogsfrogsfrogs>
In-Reply-To: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add FUSE_IOMAP_CONFIG helpers to the upper level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 +++++++
 lib/fuse.c     |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index e2099ebc8ac7a1..8b6cd7e3cf9f84 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -918,6 +918,13 @@ struct fuse_operations {
 	 */
 	int (*getattr_iflags)(const char *path, struct stat *statbuf,
 			      unsigned int *iflags, struct fuse_file_info *fi);
+
+	/**
+	 * Configure the filesystem geometry that will be used by iomap
+	 * files.
+	 */
+	int (*iomap_config)(const struct fuse_iomap_config_params *p,
+			    size_t psize, struct fuse_iomap_config *cfg);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 35ba13271d0b9c..2d9a49c16c25ff 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2963,6 +2963,23 @@ static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 				  ioendflags, error, dev, new_addr, newsize);
 }
 
+static int fuse_fs_iomap_config(struct fuse_fs *fs,
+				const struct fuse_iomap_config_params *p,
+				size_t psize, struct fuse_iomap_config *cfg)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_config)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_config flags 0x%llx maxbytes %lld\n",
+			 (unsigned long long)p->flags, (long long)p->maxbytes);
+	}
+
+	return fs->op.iomap_config(p, psize, cfg);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4841,6 +4858,26 @@ static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
 	fuse_reply_iomap_ioend(req, newsize);
 }
 
+static void fuse_lib_iomap_config(fuse_req_t req,
+				  const struct fuse_iomap_config_params *p,
+				  size_t psize)
+{
+	struct fuse_iomap_config cfg = { };
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	int err;
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_config(f->fs, p, psize, &cfg);
+	fuse_finish_interrupt(f, req, &d);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_config(req, &cfg);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4946,6 +4983,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,
+	.iomap_config = fuse_lib_iomap_config,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)

