Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85A2FD696;
	Wed, 29 Apr 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473921; cv=none; b=clKfxkYpS9IHsH4yNTIFVXtoa/COugvxdnAlkgBbMIVR2A6CR3wmwRzTyu7dAFN5j1Xyi2QmYbV+xu1zk6Atymz7g/SYeS6oVsyCEBJbMZs7G3DnqiYVbSquIhQO4LWTORf3G13ujF+icOUXN4TqWFPAVgrMvNjnC8ucuNQUfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473921; c=relaxed/simple;
	bh=/H3ANPRVEyub7H1k4ivlFHexARrRlz1Jbdm6kHAHTZQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+eXaFi2EKRjHWBMrmVezUC9l1VJi2BC2VDXTXw6pIpYZkOjp0G4GH+3aqPjPzHOBtcWW74zAbM6kaBNKHBakmtrwMz0RO5oEz83fr1pbDLG5MD7xUQsoZgo9fNJwgkMG1wI+0yDyXCiH4DqllCY4/OAM6ylixwKiypK64IaEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aND3BVhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aND3BVhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EC1C19425;
	Wed, 29 Apr 2026 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473921;
	bh=/H3ANPRVEyub7H1k4ivlFHexARrRlz1Jbdm6kHAHTZQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aND3BVhFlAuzI1/8aIpbgf0b5KPBtdYddVHtTjkMPDkjZAN3k7BEgLw7pbavFKKOB
	 SVyxKfcPecZq3W97Dkbq7GRfbLPPdIVSLlLQtkjtvdBrOvoThJjO2Mj65IKeAu4kjS
	 8n3X9BgdXgRVltq0FNfPjEKpdxWBziN1zu+4m5XOWz7apIRpre4o988PYsM6ygSTKZ
	 SYLxod77A+EUvLrbZNOh7xSVQALjsHHdg+fRUsnXojvR2VhHSb1DU18NVIdVjUWo5b
	 VNBQKZCxnMGeJ3QXIfd/STUfbrm9NCP8Vte09BdA0FTZaOVerQTKxhNWssJwulhgAJ
	 j3uaFRihpYYQg==
Date: Wed, 29 Apr 2026 07:45:20 -0700
Subject: [PATCH 24/25] libfuse: add lower-level filesystem freeze, thaw,
 and shutdown requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211997.4104686.4153206543454693365.stgit@frogsfrogsfrogs>
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

Pass the kernel's filesystem freeze, thaw, and shutdown requests through
to low level fuse servers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |   12 +++++++++
 include/fuse_lowlevel.h |   35 +++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 0779e3917a1e8f..ff21973e1c88f7 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -682,6 +682,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_FREEZE_FS		= 4089,
+	FUSE_UNFREEZE_FS	= 4090,
+	FUSE_SHUTDOWN_FS	= 4091,
+
 	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
@@ -1238,6 +1242,14 @@ struct fuse_syncfs_in {
 	uint64_t	padding;
 };
 
+struct fuse_freezefs_in {
+	uint64_t	unlinked;
+};
+
+struct fuse_shutdownfs_in {
+	uint64_t	flags;
+};
+
 /*
  * For each security context, send fuse_secctx with size of security context
  * fuse_secctx will be followed by security context name and this in turn
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index bc720564d828cd..bac627bb9038c6 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1440,6 +1440,41 @@ struct fuse_lowlevel_ops {
 	void (*iomap_config)(fuse_req_t req,
 			     const struct fuse_iomap_config_params *p,
 			     size_t psize);
+
+	/**
+	 * Freeze the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 * @param unlinked count of open unlinked inodes
+	 */
+	void (*freezefs)(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked);
+
+	/**
+	 * Thaw the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 */
+	void (*unfreezefs)(fuse_req_t req, fuse_ino_t ino);
+
+	/**
+	 * Shut down the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 * @param flags zero, currently
+	 */
+	void (*shutdownfs)(fuse_req_t req, fuse_ino_t ino, uint64_t flags);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index e4b9ce2e4d2f08..9aa7730db39ac6 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2919,6 +2919,60 @@ static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_config(req, nodeid, inarg, NULL);
 }
 
+static void _do_freezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	const struct fuse_freezefs_in *inarg = op_in;
+	(void)in_payload;
+
+	if (req->se->op.freezefs)
+		req->se->op.freezefs(req, nodeid, inarg->unlinked);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_freezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_freezefs(req, nodeid, inarg, NULL);
+}
+
+static void _do_unfreezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	(void)op_in;
+	(void)in_payload;
+
+	if (req->se->op.unfreezefs)
+		req->se->op.unfreezefs(req, nodeid);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_unfreezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_unfreezefs(req, nodeid, inarg, NULL);
+}
+
+static void _do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	const struct fuse_shutdownfs_in *inarg = op_in;
+	(void)in_payload;
+
+	if (req->se->op.shutdownfs)
+		req->se->op.shutdownfs(req, nodeid, inarg->flags);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_shutdownfs(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3934,6 +3988,9 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_SYNCFS]	   = { do_syncfs,      "SYNCFS"      },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_FREEZE_FS]   = { do_freezefs,	"FREEZE"     },
+	[FUSE_UNFREEZE_FS] = { do_unfreezefs,	"UNFREEZE"   },
+	[FUSE_SHUTDOWN_FS] = { do_shutdownfs,	"SHUTDOWN"   },
 	[FUSE_IOMAP_CONFIG] = { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3995,6 +4052,9 @@ static struct {
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_FREEZE_FS]	= { _do_freezefs,	"FREEZE" },
+	[FUSE_UNFREEZE_FS]	= { _do_unfreezefs,	"UNFREEZE" },
+	[FUSE_SHUTDOWN_FS]	= { _do_shutdownfs,	"SHUTDOWN" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },

