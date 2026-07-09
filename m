Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AA3B14BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636253; cv=none; b=jZfbjmWEL17gwc1QWPZ+nvi467jp7ETC2fEvnZjQpSpuHbGWu0vhohnB+bcRIRbBWl0dtqa0Lf0XsBr3I+jxKf09Z4HBN/ffNKsQzvNxMGKLuBhWVqQFEgdoDnOyvq3M5Q7J6edMFVurTbA8g2l5rs5wqMzV/xky3P3MBCUstHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636253; c=relaxed/simple;
	bh=gAz94TTaskV/1L0+/Cg5xweBbJSb5hGJ0x6PTB2vSzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pc92FMod23PmhjfbQy88GV0OplPxvG7ypJ7kBGw9h3aHMAz67J/bxunEy8GtfQzzJlE6XJZ00DdMNYv/TOKOXYJpIjTDcg2TxFSAQO87tSf9MWa1V6CGmBsKAhyxEYro9tlopQZEX8nU7JN5gOasv5dHS7ZInoHxWU2RdWNPEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N20eoL1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N20eoL1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9480C1F00A3A;
	Thu,  9 Jul 2026 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636252;
	bh=0DueEMP2twKq63WtPK0VR5mbp235DC8FOqpNTN5vTvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N20eoL1Jsgw5XjfuLI6ZsoOwg9eChhiIgsCcJTqwwHOYufH6Vm2Iacejx7KD+UhJM
	 hp+jY9uvpH78UD+qN/dq2USZK1tcDkia2izNK7k7iHmCW5loorNNO4SRy5llLN+3Ss
	 k78JqOEnQowNxoXfxaN0E1HyVUysDSKDexIjKrgyPNet3RQ7YL3JJ4qTRcaF4sOPGv
	 xGAzyM2C1kt/uRVL7jx7bHHgt+l/6s/6SzvmN9Klj5ytai1z5Mm0T6OTuTUWLK93xJ
	 juuS4p6fjIXUy2GpTFGrF/r8hzCXGU3TVuvWuAuLyjo3+GfrlxzpomIMxzTfUkpufw
	 xgwag8HbvHC6Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:13 +0200
Subject: [PATCH v2 18/23] binfmt_misc: use a flexible array member for the
 register string
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-18-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gAz94TTaskV/1L0+/Cg5xweBbJSb5hGJ0x6PTB2vSzs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHx7d2lufmHJzjVTOPenMlpP/KIw9aA9U8W3uZ9aC
 yxLZ2590FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR5dcM/6t+rVi3b4vTv/Nf
 d5qnM4fsVwur4vRYspHzdkPf6UVqRnYM/7NcNbMObtyx0inmzNm9brHHrrpvDVjq/vLvtcMq2oq
 qxawA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

create_entry() allocates the entry and the register string it parses
into in one chunk and finds the string part again through manual
pointer arithmetic behind a cast. Make the layout explicit with a
flexible array member and struct_size(), and give the magic pad of
trailing delimiters a name while at it.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 1536e398aa67..c7435d103629 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -59,6 +59,7 @@ struct binfmt_misc_entry {
 	struct file *interp_file;
 	refcount_t users;		/* sync removal with load_misc_binary() */
 	struct rcu_head rcu;
+	char buf[];			/* register string, fields point in here */
 };
 
 static struct file_system_type bm_fs_type;
@@ -78,6 +79,9 @@ static struct file_system_type bm_fs_type;
  */
 #define MAX_REGISTER_LENGTH 1920
 
+/* Trailing delimiter pad so field parsing always terminates at a delimiter. */
+#define MISC_DELIM_PAD 8
+
 /* Check if @e's magic matches @bprm's buffer, applying the mask if set. */
 static bool entry_matches_magic(const struct binfmt_misc_entry *e,
 				const struct linux_binprm *bprm)
@@ -345,9 +349,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 					      size_t count)
 {
 	struct binfmt_misc_entry *e;
-	int memsize, err;
 	char *buf, *p;
 	char del;
+	int err;
 
 	pr_debug("register: received %zu bytes\n", count);
 
@@ -357,12 +361,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		goto out;
 
 	err = -ENOMEM;
-	memsize = sizeof(*e) + count + 8;
-	e = kmalloc(memsize, GFP_KERNEL_ACCOUNT);
+	e = kmalloc(struct_size(e, buf, count + MISC_DELIM_PAD),
+		    GFP_KERNEL_ACCOUNT);
 	if (!e)
 		goto out;
 
-	p = buf = (char *)e + sizeof(*e);
+	p = buf = e->buf;
 
 	memset(e, 0, sizeof(*e));
 	if (copy_from_user(buf, buffer, count))
@@ -373,7 +377,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	pr_debug("register: delim: %#x {%c}\n", del, del);
 
 	/* Pad the buffer with the delim to simplify parsing below. */
-	memset(buf + count, del, 8);
+	memset(buf + count, del, MISC_DELIM_PAD);
 
 	/* Parse the 'name' field. */
 	e->name = p;

-- 
2.53.0

