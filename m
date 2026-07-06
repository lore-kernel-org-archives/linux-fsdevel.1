Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C2437848
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362180; cv=none; b=RGnbEtoFZ27JlUM60cmq9JV9IiB0QGA1uxS8ol/ctT3ExfTtCu+RaDFcOvYd1zypRrzQDeXADHHX5oN4xudGzdUDgSXEzLCua/f2QzwtB6XcBhe3rPSSRKgyWNGCyhEyOw4SxVOkBdGed4MmrBwNL11tF20JUFKrAzYv8HZN2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362180; c=relaxed/simple;
	bh=RdWF90BX9xb4zylu5tEjy0IlcZeHBvXmpg6leRW7Whk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd9PiAnKJLLck4VroTub43a7zWnqJOfncamLCJ3Vjh/dc2ZlXF9DSw7hAOeAJHwYOqAUPBACojUuxDK58j8j1evnuG+F2J/Rd0N0lfIlZeBaY+Nw6rByOuMkgPM2tbMPv+X+ApqPhd+lbCbgHpOqlPUUgo10L40eoBD4vnCCjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffspohrF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffspohrF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3578675a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783362176; x=1783966976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CswQuIBE063T4skhHwF0cyRKDPNNtYcirO22wWu67N8=;
        b=ffspohrFweoSdhkz8z1TJUtWxpq1wxEbo2p4dNuWazoGHrXqUR0NZ4KM3QZqrm1HxI
         6ijTNaVQSVzso83q16eKdrwnk10SlRssD+YCOYIn6wpxKnj5A43O71enBYPxZ7KUjeXB
         HW4p6uSvq9fK4qoJMJjTNoGHx6Pcg6UvBUlRRkTeYfUXECGeXcTH2lHzwStXZP2WAWzX
         TPoYHa0KRf7Z2ZYeKOjySLc9md+3hQ+hayolg3ZaV5eOcoPjHPZT9UR05IcvWW97JSac
         W58Ud1ZK8spyY0oqwosWCZuBFOMDzfccJysU6ecDc/JAK49ZDQhua6WKqrgsfx9tNz0m
         Ri/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362176; x=1783966976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CswQuIBE063T4skhHwF0cyRKDPNNtYcirO22wWu67N8=;
        b=QS6kFUMbM67k8Srp9D7TzanQ3N6+vH4Nk6rtsbrBJjcmTQWvE39VVK0CNT7laYMzI4
         /UyjqAPKPx7PrcGHL+2UZrQVub1iiuC9yZDCj3XyvuzFtTbi55aV48gO5UuIkiyxBRCo
         42E5YD9LkUR1xoWPPhtQQaM2Syi1KkU44rjlvSV3GFd7qPa9PJmbNb7f0UUw0nHOBnEH
         mmoePKPmzvs43jCjzW/mYHZHj+qLBeHn2FBTk29R86kkI3Kv4zCy7/0fNIGbltfKTECj
         IoG4HprhH8mctnbR7i8CiJ3DQxiUu9NSuind7QQ3TkifFLpln51lHr/UNv0yiS6GrD7b
         P/dQ==
X-Gm-Message-State: AOJu0Yyw9NR+a/UN6XfwFVg1jBrDkJag9/xeshGsnOeLpyvCINSWf67i
	6QF1rx6Nmft2J4zcRxolOdx6tpRxy8borSNz6l3rLC/kC7Qt0I9jV0m72rwXKg==
X-Gm-Gg: AfdE7ck7N497QFAw6eFpWnoejz/cBS+0enQRkVuAphFrvxnVnlv+5sdGrT29zATzvHF
	dc8G24PN2IPTL6cX3r23trFuplgOYq4NBs1iuLMjiM/jNQwmolLGFeGfzht9U+HFFp6pg4XiiTp
	8vFq7Glm+mcS+Q9VuMqHVATVF4xYX5Z8+Y4aiCekSGnMdhaBE7iA/xRD5/4CcBKCXqiKz8mskXo
	eW0O4ng9ygBTFXZnIQPmW/jVy+4zf6eNvA6pTQETjFTGXhoYVhxXUOxD6b6CI0Jk2RHtRfowX5r
	Cm04+57M9a0AXlhfqSVDChcOacu1eQJYQ/AKb86A5TBkv6o5fevPki6iHrTbcU2TTbtzLhCyBOT
	HeTONJeZj29StrYPg8JMuGSX+Ar3wgz+hGtnnCGSQ3He7SL1fdVOxWwszl3sGie0=
X-Received: by 2002:a17:90b:1ccf:b0:383:5a16:bd79 with SMTP id 98e67ed59e1d1-38758a361cbmr1662472a91.22.1783362175541;
        Mon, 06 Jul 2026 11:22:55 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387a83fb23csm21238a91.0.2026.07.06.11.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:22:55 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 1/2] minix: define constants for dirsize and namelen
Date: Mon,  6 Jul 2026 11:22:43 -0700
Message-ID: <7d62598a8be99c6218d05bfca56bc37f1e634a49.1783360491.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783360491.git.jbingham@gmail.com>
References: <cover.1783360491.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The different versions of the minix fs have different values for
directory size and name length. Versions 1 and 2 each have two possible
values for each of those, while version 3 has one set of values for
each. Add defines for all of these to minix.h so we don't need to set
those values as magic numbers in minix_fill_super() in inode.c

Before:
	sbi->s_dirsize = 16;
After:
	sbi->s_dirsize = MINIX_V1_DIRSIZE;

There are no functional changes with this patch.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/inode.c | 20 ++++++++++----------
 fs/minix/minix.h | 23 ++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index c30cc590698d..95fa8371e4ea 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -258,25 +258,25 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_magic = ms->s_magic;
 	if (s->s_magic == MINIX_SUPER_MAGIC) {
 		sbi->s_version = MINIX_V1;
-		sbi->s_dirsize = 16;
-		sbi->s_namelen = 14;
+		sbi->s_dirsize = MINIX_V1_DIRSIZE;
+		sbi->s_namelen = MINIX_V1_NAMELEN;
 		s->s_max_links = MINIX_LINK_MAX;
 	} else if (s->s_magic == MINIX_SUPER_MAGIC2) {
 		sbi->s_version = MINIX_V1;
-		sbi->s_dirsize = 32;
-		sbi->s_namelen = 30;
+		sbi->s_dirsize = MINIX_V1_DIRSIZE2;
+		sbi->s_namelen = MINIX_V1_NAMELEN2;
 		s->s_max_links = MINIX_LINK_MAX;
 	} else if (s->s_magic == MINIX2_SUPER_MAGIC) {
 		sbi->s_version = MINIX_V2;
 		sbi->s_nzones = ms->s_zones;
-		sbi->s_dirsize = 16;
-		sbi->s_namelen = 14;
+		sbi->s_dirsize = MINIX_V2_DIRSIZE;
+		sbi->s_namelen = MINIX_V2_NAMELEN;
 		s->s_max_links = MINIX2_LINK_MAX;
 	} else if (s->s_magic == MINIX2_SUPER_MAGIC2) {
 		sbi->s_version = MINIX_V2;
 		sbi->s_nzones = ms->s_zones;
-		sbi->s_dirsize = 32;
-		sbi->s_namelen = 30;
+		sbi->s_dirsize = MINIX_V2_DIRSIZE2;
+		sbi->s_namelen = MINIX_V2_NAMELEN2;
 		s->s_max_links = MINIX2_LINK_MAX;
 	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
 		m3s = (struct minix3_super_block *) bh->b_data;
@@ -288,8 +288,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 		s->s_maxbytes = m3s->s_max_size;
 		sbi->s_ninodes = m3s->s_ninodes;
 		sbi->s_nzones = m3s->s_zones;
-		sbi->s_dirsize = 64;
-		sbi->s_namelen = 60;
+		sbi->s_dirsize = MINIX_V3_DIRSIZE;
+		sbi->s_namelen = MINIX_V3_NAMELEN;
 		sbi->s_version = MINIX_V3;
 		sbi->s_mount_state = MINIX_VALID_FS;
 		if (!sb_set_blocksize(s, m3s->s_blocksize))
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f2025c9b5825..972a71c5b481 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -11,6 +11,27 @@
 #define MINIX_V2		0x0002		/* minix V2 fs */
 #define MINIX_V3		0x0003		/* minix V3 fs */
 
+/* Define version and sub-version specific values for dirsize and name length.
+ * These are not as clear-cut as having different values for versions 1, 2, and
+ * 3, unfortunately, but rather there two possible values for each for versions
+ * 1 and 2 and one possible set of values for version 3.
+ *
+ * These have separate defines for each subversion value for versions 1 and 2,
+ * though; even though they duplicate each other, it will be more clear to have
+ * them separate than trying to come up with a name that encompasses both
+ * versions yet not be totally confusing.
+ */
+#define MINIX_V1_DIRSIZE	16
+#define MINIX_V1_NAMELEN	14
+#define MINIX_V1_DIRSIZE2	32
+#define MINIX_V1_NAMELEN2	30
+#define MINIX_V2_DIRSIZE	16
+#define MINIX_V2_NAMELEN	14
+#define MINIX_V2_DIRSIZE2	32
+#define MINIX_V2_NAMELEN2	30
+#define MINIX_V3_DIRSIZE	64
+#define MINIX_V3_NAMELEN	60
+
 /*
  * minix fs inode data in memory
  */
-- 
2.47.3

