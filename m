Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC33F7A92
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676027; cv=none; b=P1jHFzJbQPcosBpgdeMxLj1qh68LPuFxzgX0ILnUMidu9QoZyFc2rj0pFdKly3PiYV6+yqPqzlib+frH+OSDd+/Li1r4+Ck1994xLpqpcGbMz8dv8TtGFokGJzNKRs0OrhaG3r/it7zRBNY9AXLtRHeDFjdPImVvLcwt/pFEhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676027; c=relaxed/simple;
	bh=ZJseZyXlJQP1+LLvZEEAv5492/nOY49aeOFV4Zt+Z7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zlj8vsaJPG2P2sPttMTskF9ap9EbjQLtAbcBdQdaB0N+IGy2xv7Kc9csuP5HWEvX8pGyBIW5dnNjb43t+Moqh68A1C8zfhdJYpJRtv6qthwzX1Uu3sh7uAEtoP3XrIhYVjUB2s5WAtiICdF6AOKUuyS3m/mMnsM3XAxUlyTKiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6ta/uOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6ta/uOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5741F00A3D;
	Fri, 10 Jul 2026 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676026;
	bh=CzdK5DKU6+BMRq52S8bVlI48gl9R/8/1tCY8E7Nw34A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J6ta/uODDijWPnjCfZTHjGhlpURPdKwlSyhurPZRKs8AJqzI6CX8MKCflYZYUiCtQ
	 EWg0uqC2uUfEfkXJxRrMj83u1rDOpeI+kApEXh8DaL4rOGx1cd/Ko5eiGXTFDQVj87
	 j2sKFAhxrT4q3KspBdHfkfa39Tzdnm/U9mPh6kcOujxURzrkjpmCJbZR3RR4On75Rd
	 R+toGr1GvxrM84BAeiGitOa13QEPgd2xzoAKFI8LOqgVBD0gB+24vFm5a4TrjLjwRN
	 JN9tdQxl5+beYSAcn38gegKaiIIWntSg22rPN/qn1jNn0K0h/5zkbGf/BDFZxQb4z6
	 Coiq/VsZSnGBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:14 +0200
Subject: [PATCH v3 13/24] binfmt_misc: factor out the entry matching
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-13-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZJseZyXlJQP1+LLvZEEAv5492/nOY49aeOFV4Zt+Z7o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7InbbOdkoVX25Nuav40TJtx0ef1Kd4/MOXbmayuTz
 htz688V7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI4wSG/64SIWu7O1df1Gxg
 17VlMJxz42igQ5KZx7rJXYFHlorOUWb4Z3xVfQendlNTwHSOZ5o1GwVvhqh8vOjpIKNmsiJAYdN
 lHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

search_binfmt_handler() open-codes both match types in one loop body
with the maskless magic comparison spelled as a manual xor loop that
is just memcmp() in disguise. Move the extension and magic checks
into helpers so the walk reads as policy - skip disabled entries,
match by entry type - and the maskless case actually uses memcmp().

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 23a2020d9266..6a56f40f23ae 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -78,6 +78,29 @@ static struct file_system_type bm_fs_type;
  */
 #define MAX_REGISTER_LENGTH 1920
 
+/* Check if @e's magic matches @bprm's buffer, applying the mask if set. */
+static bool entry_matches_magic(const struct binfmt_misc_entry *e,
+				const struct linux_binprm *bprm)
+{
+	const char *s = bprm->buf + e->offset;
+	int i;
+
+	if (!e->mask)
+		return !memcmp(s, e->magic, e->size);
+
+	for (i = 0; i < e->size; i++)
+		if ((s[i] ^ e->magic[i]) & e->mask[i])
+			return false;
+	return true;
+}
+
+/* Check if @e's registered extension matches @ext, NULL if there is none. */
+static bool entry_matches_extension(const struct binfmt_misc_entry *e,
+				    const char *ext)
+{
+	return ext && !strcmp(e->magic, ext);
+}
+
 /**
  * search_binfmt_handler - search for a binary handler for @bprm
  * @misc: handle to binfmt_misc instance
@@ -93,38 +116,23 @@ static struct file_system_type bm_fs_type;
 static struct binfmt_misc_entry *
 search_binfmt_handler(struct binfmt_misc *misc, struct linux_binprm *bprm)
 {
-	char *p = strrchr(bprm->interp, '.');
+	char *dot = strrchr(bprm->interp, '.');
+	const char *ext = dot ? dot + 1 : NULL;
 	struct binfmt_misc_entry *e;
 
 	/* Walk all the registered handlers. */
 	hlist_for_each_entry_rcu(e, &misc->entries, node) {
-		char *s;
-		int j;
-
 		/* Make sure this one is currently enabled. */
 		if (!test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 			continue;
 
-		/* Do matching based on extension if applicable. */
-		if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
-			if (p && !strcmp(e->magic, p + 1))
+		if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
+			if (entry_matches_magic(e, bprm))
 				return e;
-			continue;
-		}
-
-		/* Do matching based on magic & mask. */
-		s = bprm->buf + e->offset;
-		if (e->mask) {
-			for (j = 0; j < e->size; j++)
-				if ((*s++ ^ e->magic[j]) & e->mask[j])
-					break;
 		} else {
-			for (j = 0; j < e->size; j++)
-				if ((*s++ ^ e->magic[j]))
-					break;
+			if (entry_matches_extension(e, ext))
+				return e;
 		}
-		if (j == e->size)
-			return e;
 	}
 
 	return NULL;

-- 
2.53.0

