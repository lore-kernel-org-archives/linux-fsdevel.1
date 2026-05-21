Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05C376BD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357775; cv=none; b=CUpKJPzvrn/A+DfKjnlIxvgKQlmA/ESrULV625Ab2DnH/8EH0IVwFZzjQOlFRnFulFCnG+6Hze7Ja6x1IBfzlGe6wqDE6nRTpWQ02EtGZxHNtyuUVXz3S07y37z3UcGp9ydIT42qUm6izuCwZijC1aPpOVWOltJYhJgD/uYzVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357775; c=relaxed/simple;
	bh=AAN255HdM3uZ4+It0uI52zgspk3PlnjRuFJ5Vkbr2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbI4w498NmalRMRtS1Ozv85rKhjPs6WEyRpHy2/MibGVMXm/EjvcSyMkUcXGseGHwtL5dLImEN5un0/omqYV3cF6CrPGDDDsWubU1MYwAZBIR6/xwGG1uaUxI/BnZULqAJRFvOZ8Hnf68IM442B0hDevsNylyC+jg11aLt68UMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=PBRMy5Wv; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="PBRMy5Wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779357756; h=from : subject
 : to : message-id : date;
 bh=Hc1ZS8wBS8cUwmC29S6NYs+RegvTzxi9h3if/SxiDqk=;
 b=PBRMy5WvVPuq5T9Ptz7Jtm5ribXW00zL8HSdQOY33h+l3P6F7LA2CH0oquThtBwn3owXs
 pIn3mm7UCWpNIGUMd0O7SVzNlmBL5O/dIZ5fMAFu4T45iLOPoj3dKlqMWiK2bK8I58yqS8p
 rWeoePdZ+h0STm/6/aJGML5kfqSzF0YSy0LFT6xLGPp/JJTQrXL/IvlEBN/Hj0SO5FG5pSY
 aY4XgNkwcVkFuPCh0vMVIUmWuAHaG+q9sip4+Hi6wvf6DPsw3Z71x37wfskq76dzelEpo37
 ZWE2n5r8azX01oM8xiw7XVJj0n9+/25vo1/5SIIXdgUnhsDsq3NAWiKk46ow==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wQ0Eo-4o5NDgrsjmH-pCbW;
	Thu, 21 May 2026 10:02:46 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v7 2/4] 9p: Add mount option for negative dentry cache retention
Date: Thu, 21 May 2026 11:40:30 +0200
Message-ID: <b2d66500aa5a2f6540347c4aa46a4be10dd01bc6.1779355927.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779355927.git.repk@triplefau.lt>
References: <cover.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s3Pls6ELvV
X-smtpcorp-track: 9ds-iBwUz2X1.29uRzCPhWvIw.gYjyFQGqqrS

Introduce a new mount option, negtimeout, for v9fs that allows users
to specify how long negative dentries are retained in the cache. The
retention time can be set in milliseconds (e.g. negtimeout=10000 for
a 10secs retention time) or a negative value (e.g. negtimeout=-1) to
keep negative entries until the buffer cache management removes them.

For consistency reasons, this option should only be used in exclusive
or read-only mount scenarios, aligning with the cache=loose usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 Documentation/filesystems/9p.rst |  5 +++++
 fs/9p/v9fs.c                     | 16 +++++++++++++++-
 fs/9p/v9fs.h                     | 23 +++++++++++++----------
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index be3504ca034a..b014c7aabba4 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -238,6 +238,11 @@ Options
   cachetag	cache tag to use the specified persistent cache.
 		cache tags for existing cache sessions can be listed at
 		/sys/fs/9p/caches. (applies only to cache=fscache)
+
+  negtimeout    the duration (in milliseconds) that negative dentries (paths
+                that do not actually exist) are retained in the cache. If
+                set to a negative value, those entries are kept indefinitely
+                until evicted by the buffer cache management system
   ============= ===============================================================
 
 Behavior
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index be83744b75b2..3e758b66fefa 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -39,7 +39,7 @@ enum {
 	 * source if we rejected it as EINVAL */
 	Opt_source,
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_negtimeout,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	fsparam_string	("access",	Opt_access),
 	fsparam_flag	("posixacl",	Opt_posixacl),
 	fsparam_u32	("locktimeout",	Opt_locktimeout),
+	fsparam_s32	("negtimeout",	Opt_negtimeout),
 
 	/* client options */
 	fsparam_u32	("msize",	Opt_msize),
@@ -159,6 +160,9 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->flags & V9FS_NDENTRY_TIMEOUT_SET)
+		seq_printf(m, ",negtimeout=%d",
+			   (int)v9ses->ndentry_timeout_ms);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -337,6 +341,16 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		session_opts->session_lock_timeout = (long)result.uint_32 * HZ;
 		break;
 
+	case Opt_negtimeout:
+		session_opts->flags |= V9FS_NDENTRY_TIMEOUT_SET;
+		if (result.int_32 < 0) {
+			session_opts->ndentry_timeout_ms =
+				NDENTRY_TIMEOUT_NEVER;
+		} else {
+			session_opts->ndentry_timeout_ms = result.int_32;
+		}
+		break;
+
 	/* Options for client */
 	case Opt_msize:
 		if (result.uint_32 < 4096) {
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index e630c5111d74..a462bcbfc7da 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -24,6 +24,8 @@
  * @V9FS_ACCESS_ANY: use a single attach for all users
  * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
  * @V9FS_POSIX_ACL: POSIX ACLs are enforced
+ * @V9FS_NDENTRY_TIMEOUT_SET: Has negative dentry timeout retention time been
+ *                            overridden by negtimeout mount option
  *
  * Session flags reflect options selected by users at mount time
  */
@@ -34,16 +36,17 @@
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
 enum p9_session_flags {
-	V9FS_PROTO_2000U    = 0x01,
-	V9FS_PROTO_2000L    = 0x02,
-	V9FS_ACCESS_SINGLE  = 0x04,
-	V9FS_ACCESS_USER    = 0x08,
-	V9FS_ACCESS_CLIENT  = 0x10,
-	V9FS_POSIX_ACL      = 0x20,
-	V9FS_NO_XATTR       = 0x40,
-	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
-	V9FS_DIRECT_IO      = 0x100,
-	V9FS_SYNC           = 0x200
+	V9FS_PROTO_2000U         = 0x01,
+	V9FS_PROTO_2000L         = 0x02,
+	V9FS_ACCESS_SINGLE       = 0x04,
+	V9FS_ACCESS_USER         = 0x08,
+	V9FS_ACCESS_CLIENT       = 0x10,
+	V9FS_POSIX_ACL           = 0x20,
+	V9FS_NO_XATTR            = 0x40,
+	V9FS_IGNORE_QV           = 0x80, /* ignore qid.version for cache hints */
+	V9FS_DIRECT_IO           = 0x100,
+	V9FS_SYNC                = 0x200,
+	V9FS_NDENTRY_TIMEOUT_SET = 0x400,
 };
 
 /**
-- 
2.52.0

