Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98419D093;
	Wed, 29 Apr 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473592; cv=none; b=KnZXSzc0JAV7PVSSVZZk/gfCcJyGEcRQN971lV555f/LQ7UvzwyvKUKJFstwpBoEkIwhTOyrMzlsWn6GeIV/C3iPvDzPbWJa3dYg5S8IK2fvQfGczhcY70RqsDUKqmIPc4TBsFrDko55nDl2JMzRSyWDXTjv6Yd6Zpco9/kFYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473592; c=relaxed/simple;
	bh=BIIP+3NyYirNbnHRMMvoLC/q+6gP5Lz6fdxlrvmS4V8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hglRxwHMV4z+CC4Wzdt4HQ2pnOT64xidm9Hxdfh5Y/AFM5ptVTC5ey5iC/GaWQThKWJ46x8Bfn3jAYwtJPOQ4SrRN1y9yIi0Q2YDOZy4Hj15mrqdRAAleZhT4wTNOACOpsOTX00/LaWSAHw30pzcpULEVDeIIUZ25tlmimJR39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFA8FeO5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFA8FeO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C495C19425;
	Wed, 29 Apr 2026 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473592;
	bh=BIIP+3NyYirNbnHRMMvoLC/q+6gP5Lz6fdxlrvmS4V8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HFA8FeO5lihjxK2JZncxI9O5nqz1LFb2PD5lDXdlHjm+4OTf/ZkX4sVsYak5m8GAh
	 I4P9Ac6kLIW+oAD6ZIaefJy+SHogf58m65YpVmJ5EVdhRo9wWkxSlPNe/Zv4j0asK8
	 oRpQJ6at8fPez/VKWuCHwfeytaAopsKEIK/qcBSbn0lERKLNZFLmb6EMONZwOJU7wT
	 pF2/AztqCP4Vv2uGm/4jg/h4ln7wQmnj0yLH3bbTIJCYC0YE5dvEN8XZ90UbWPuafB
	 4tVJ5c3o6NQKOa9tSuL2tpHtrJWQIX592bcCPP+ezF2cR+Y55Y3vxw7voAeX3yymI+
	 gLJATXGRFlYeg==
Date: Wed, 29 Apr 2026 07:39:51 -0700
Subject: [PATCH 03/25] libfuse: add kernel gates for FUSE_IOMAP
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211620.4104686.8299644270901023513.stgit@frogsfrogsfrogs>
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

Add some flags to query and request kernel support for filesystem iomap
for regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 include/fuse_kernel.h |    3 +++
 example/printcap.c    |    1 +
 lib/fuse_lowlevel.c   |   11 +++++++++++
 4 files changed, 20 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 6680fdb17d2e6b..23712fed8d64c2 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -517,6 +517,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_ALLOW_IDMAP (1ULL << 32)
 
+/*
+ * Client supports using iomap for regular file operations
+ */
+#define FUSE_CAP_IOMAP (1ULL << 33)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 842cc08a083a6f..354a6da01c2ecc 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -243,6 +243,7 @@
  *
  *  7.99
  *  - XXX magic minor revision to make experimental code really obvious
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  */
 
 #ifndef _LINUX_FUSE_H
@@ -451,6 +452,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for regular file operations
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -498,6 +500,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/example/printcap.c b/example/printcap.c
index e88ce1399ed18c..001922e0d74004 100644
--- a/example/printcap.c
+++ b/example/printcap.c
@@ -67,6 +67,7 @@ static const struct cap_info capabilities[] = {
 	{ FUSE_CAP_PASSTHROUGH,			"FUSE_CAP_PASSTHROUGH"},
 	{ FUSE_CAP_OVER_IO_URING,		"FUSE_CAP_OVER_IO_URING"},
 	{ FUSE_CAP_ALLOW_IDMAP,			"FUSE_CAP_ALLOW_IDMAP"},
+	{ FUSE_CAP_IOMAP,			"FUSE_CAP_IOMAP"},
 	// Add any new capabilities here
 	{ 0, NULL} // Sentinel to mark the end of the array
 };
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 487fd72420cdf1..b8700cd786a034 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2818,6 +2818,10 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_ALLOW_IDMAP)
 			se->conn.capable_ext |= FUSE_CAP_ALLOW_IDMAP;
+		if (inargflags & FUSE_IOMAP)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP;
+		/* Don't let anyone touch iomap until the end of the patchset. */
+		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 
 	} else {
 		se->conn.max_readahead = 0;
@@ -2864,6 +2868,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2983,6 +2990,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	outarg.max_readahead = se->conn.max_readahead;
 	outarg.max_write = se->conn.max_write;
@@ -3017,6 +3026,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		if (se->conn.want_ext & FUSE_CAP_PASSTHROUGH)
 			fuse_log(FUSE_LOG_DEBUG, "   max_stack_depth=%u\n",
 				outarg.max_stack_depth);
+		if (se->conn.want_ext & FUSE_CAP_IOMAP)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;

