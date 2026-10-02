Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718654EDCAD
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958766; cv=none; b=O9kjkKSI6VyiOOfUYi2UsOqgsJuLHJFRh5eYpwBxmPLH9kafOxOgCJZH83Vt1yczSGjj6UUjSa8BVxerJN4OEDhwAIZA8xtmSx9wdNJghEA9UmNDbKmHm8Oy0RoVO6Huc9q2GlQJ5cAzJdt+9po588Hi1Dc5IZ8gwqf/DH8ciA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958766; c=relaxed/simple;
	bh=lQpivocvX8TwoIn/ANFvEtXWnmS+qxxoOfVIvbKujMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyYuRS2iCNNfYr2LeGszt+57OYtb0GKbb6TVAgwPMROoq1AP8Pqs7dtDV+6Duhe1lUqqR7GisMEFllx4aFXmkzZ/byBVn9g7DDmzLuiHoTTPqV8BxSoMCIndKHn6A4fSrh9CQ7DVCxLSP99gJ8l5u9R19qgf2vEJoWLookIh5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scrivano.org; spf=pass smtp.mailfrom=scrivano.org; dkim=pass (2048-bit key) header.d=scrivano.org header.i=@scrivano.org header.b=PD/beOeM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k00m7no3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scrivano.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scrivano.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scrivano.org header.i=@scrivano.org header.b="PD/beOeM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k00m7no3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B94EC1D0008E
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 12:32:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 12:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scrivano.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790958763; x=
	1791045163; bh=8vp//EYtL+iFtkFUXaNxAHh7uSWfdznnpRMjVFiTc+M=; b=P
	D/beOeMJd3dCiiqwdkv2QjKfJczKKQJ9TUfOIYiTcPDlG5MX2on7f3D90k5N7z4/
	pkTPz3XKoq5R4J54SXXNyDGIFbU2l9MmQOEXPCciblnse4G9mBjM7PzTSeQv4TEU
	iPHUtIsL2IMOtoAoJnW2aSbOxg3YC347ko64t2nUzaiIfgrYyMJWMpXpoKEePM3D
	Kq2ef3NGMRu13MHY1z69h4DH0Sq3Mbu3l0e/BHuNEyJKEYO5BnnT0lCbk9hDAK8C
	fTGkN1wTa+HjOYUqpW2Uoy6o3DOifbS4YWjai6CpvkuaPQMrv+P8SZVZ8St1b8r2
	hRMxqHyMqyEyOk58FEeTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790958763; x=1791045163; bh=8
	vp//EYtL+iFtkFUXaNxAHh7uSWfdznnpRMjVFiTc+M=; b=k00m7no3wczKOklBQ
	wtJ5UQoAMksWLntrzvdAjeLmOGtmjniJD5159LNWxIQH07MZxh8pPBf6UR2fLY07
	ephOWKjgGJX320jjEsPLNyVk8wi9ONawTjcH0CWR3rzU34FOdbW1Mkmx2KzRYsTy
	5sCBs3D1LVSRttvJ7odDGu61V6QU6hY+NXyj9cwzbksPgYSO68b8YBxrZALRxjFK
	xKjA9s31RLS47XrzCLIXvJiZnPKugs/ZYsD/C12gjWTbemxTSdoSFYhezbJoVAO6
	Cs4hVX6ubGQSiQxSvln0SlRj62PYSre3bQdp3Vb+kozWrtbmzogbnfEzd8G/yY9Q
	JqdNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=scrivano.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790958763; d=scrivano.org;
	mf=PGdpdXNlcHBlQHNjcml2YW5vLm9yZz4=;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:szoKKjT07skxo8+oDsFDV0ND4yE7g15CJYEBqMLEhNXFTrc
	KbdNfOOyk6wx6WdTSMwoetblvHDWVQETs+Gdi5MyRDq/wP5NJ9pjX093a8RJVNGB
	/o4QemkP8samVyl0jrhS/pG239MyotJrbF44FCXuENRLaEsX+1mOomn98i9MqGxJ
	50urti3PtQqnJsvmkrKxpOdOvFW77+39+tXqDpsmKRVma/6Ud/7X6Aaun6V7CIAb
	0sdVo4S+P/AM4BFWDyqSv4LV6JIVBM9Pj4GJccryldwIUoJSfEwk+GMatPFrV8ZV
	knRxQfAnC4RigDdVa+Rbv0K+6a46ZhufTeXY1jg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9SqiUAun+oEWwrPyv8hamiqiDlKwuzhtXBzBd701il0=:lQpivocvX8TwoIn/ANFvEtXWnmS+qxxoOfVIvbKujMo=;
X-ME-Sender: <xms:qty_au6K39f3Bcac8Vk7_S1oZCdYZkBbgeFYwBLImAvexE-n5VayhA>
    <xme:qty_ajk0Dqzb02baS4xPgUYDxiQl7AR2MDv7q5UoB812B0P6s_16POiWnxYUF67IX
    AUjlUYYXB_R56K_SuCgHJBAkLh6MI1f__a773IKaj2pQwEYoMfkbGDk>
X-ME-Received: <xmr:qty_ap5z-MdqNGRW_fsqvINv7ifjfMiBG4QPOvaZUbzDXmX6SzUuuEQdj2mtZz8AMNnQORIlB1hb55-o4ptbPNFcSIIn>
X-ME-Proxy-Cause: dmFkZTGyqCDolNR0R7DZGwMzWNDpoJILu2jykM68ma+dDc4C112fFIur3VtfzrPwrSoPe/
    w73eKAXEp2+IXQktv6IQ+UxhEt9Szb57K8oXMVhPBJouBdWFZMV69AeCfZpfq5QRP7dsZC
    Uj/MuGmyIWY1s1nDAm8d2XRJylXM9trGrNPh0aSg/b8LjXeZoqLsS7aaLe+OzyV9npE+1x
    D7hm62C3NjWWnwp0e+o1GO5DbRrr1ZQ6z4FcBPpuMPK6lEvbImxnP1QSsEy1Lu1JbSi1a2
    aVMZfF3IUsevuSme/8yTAwynuSJhBaQHK25L0mqWcuPbJzTeUSB/HrvfyAcWZP3qYhYWBp
    DmLc7E1KpMUJxQoxXq+Ec7O7XLWPU0wxRyUjGsykn+yq2GSiETnFyhLlKXEM/Zx4YyokAf
    4t8sDHYiApsD9e5ssT+gHWSa+KRpcOsdsqUrFOn78xTgo0/Gn4/0b3NO5zXlw/lVBm5C5U
    QzSXqqPnTQ/yQtBTM/5u5ysimXsH/nb52IkPrIGXOTuizTXrVisU251rWrJTdVosYAhF8s
    XhIxZ5nxm/BGatnHAuWh6VMDJKU5FjiQ/0+XFI/WtbSTNqn+psmNWjlX+WvHaa7FrqTAIU
    +y1JSUwGaZqQBd35fXzJoIrJBfTESGIicHO2Mf9n6NMxe0ThlDD0HfkFB+Iw
X-ME-Proxy: <xmx:q9y_akQGb1LV0YLSAQ7W30i_vgUqAhplBwG7AjYcByJU30_f5AhgOA>
    <xmx:q9y_anw6mXDAFGB_x3cG5fIeEHcNrnmWY2DUoMQgjCBsOBGHUG73sw>
    <xmx:q9y_asq32aFvacRkzGWtk5z6iFVTMjEy1kMMJlyjnFy0UsNuSI-L7w>
    <xmx:q9y_aq3NfOGKUv0gOzrLgN9xa6VDNtWoN_B0OqhiXMfB44RXEtuYwA>
    <xmx:q9y_aqTcK8AH4RB0P571VOe6uEK_NpPT3Pfo-IRRqdLCuBhPRjquPzg->
Feedback-ID: i8e6e4897:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 12:32:42 -0400 (EDT)
From: Giuseppe Scrivano <giuseppe@scrivano.org>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	giuseppe@scrivano.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	hch@infradead.org
Subject: [PATCH v7 1/2] fs: rename vfs_get_super() to get_tree_super() and export it
Date: Fri,  2 Oct 2026 18:31:43 +0200
Message-ID: <20261002163225.1258203-2-giuseppe@scrivano.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002163225.1258203-1-giuseppe@scrivano.org>
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename and export it so filesystems that need a custom superblock
matching policy can reuse it directly instead of open-coding sget_fc()
+ fill_super().  No functional change.

This is a preparatory fix for the next patch.

Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>
---
 fs/super.c                 | 19 +++++++++++++++----
 include/linux/fs_context.h |  4 ++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1d5ccf540a9b..a1dc4de1b657 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1374,7 +1374,17 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
 	return 1;
 }
 
-static int vfs_get_super(struct fs_context *fc,
+/**
+ * get_tree_super - Get a superblock, optionally sharing an existing one
+ * @fc: The filesystem context holding the parameters
+ * @test: Comparison function to find a matching existing superblock, or NULL
+ * @fill_super: Helper to initialise a new superblock
+ *
+ * If @test is non-NULL and matches an existing superblock, that superblock is
+ * reused; otherwise a new anonymous superblock is created and initialised with
+ * @fill_super.  Passing NULL for @test always creates a new superblock.
+ */
+int get_tree_super(struct fs_context *fc,
 		int (*test)(struct super_block *, struct fs_context *),
 		int (*fill_super)(struct super_block *sb,
 				  struct fs_context *fc))
@@ -1401,12 +1411,13 @@ static int vfs_get_super(struct fs_context *fc,
 	deactivate_locked_super(sb);
 	return err;
 }
+EXPORT_SYMBOL_GPL(get_tree_super);
 
 int get_tree_nodev(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, NULL, fill_super);
+	return get_tree_super(fc, NULL, fill_super);
 }
 EXPORT_SYMBOL(get_tree_nodev);
 
@@ -1414,7 +1425,7 @@ int get_tree_single(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, test_single_super, fill_super);
+	return get_tree_super(fc, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single);
 
@@ -1424,7 +1435,7 @@ int get_tree_keyed(struct fs_context *fc,
 		void *key)
 {
 	fc->s_fs_info = key;
-	return vfs_get_super(fc, test_keyed_super, fill_super);
+	return get_tree_super(fc, test_keyed_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_keyed);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 0d6c8a6d7be2..d1727dffecc5 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -150,6 +150,10 @@ extern int vfs_parse_fs_param_source(struct fs_context *fc,
 				     struct fs_parameter *param);
 extern void fc_drop_locked(struct fs_context *fc);
 
+int get_tree_super(struct fs_context *fc,
+		   int (*test)(struct super_block *, struct fs_context *),
+		   int (*fill_super)(struct super_block *sb,
+				     struct fs_context *fc));
 extern int get_tree_nodev(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
-- 
2.55.0

