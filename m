Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9D3B0ACE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636241; cv=none; b=WSkoHhTaHjpfsl9WzZIZ7cefY4n5uyEGGQILVuSeu+nZYzeWGPDo+hEuRAFXJAVmJtE1ZsHb/uJICwcqU03DGmyAzXc22vMQg08qib8nkST0d8f5/s9mBwvfvoQM08qZ5hmFLc3dMUGCOu7CSce4h+VP5oBKoNkqNQKEaDzb7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636241; c=relaxed/simple;
	bh=TkHS8svwwTJ1Obe3L+vKAPhau92Mc/d3NI+a2XNdFBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiy7NMr6pM0fva8frSonM7mnCDri/hdH42lnCriKxdHT/si6C8fetK1Cy4M3KjOqAYKixyN7eCDvRXQFIIlZDhCz+oPkrBQZAOssJEDAlsSH6zSKpMmhwa49G9l/zHrATGK0ZmA+gs0Yfj1/WNsEy3GmuHlqzG4hzignVTfvQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhE3Qxq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhE3Qxq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E195F1F00A3A;
	Thu,  9 Jul 2026 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636240;
	bh=FYhRSL4gTThOEjvt0X6PZN1r/pK2hkBS6685XeAfpIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AhE3Qxq35L6o9awQ642HN5onsUC7XKfku9a31vElmqwPl5ylZlBgYVwkg1/TFqn4w
	 M/xNQgNe257Bc1ODRe6eFtVyI7yGI19XIgoOCfdnO72id63LZ8Y7gYz2aGSKJQwcPg
	 qtz7CyY8FVBjSWFvJWM+nvtKCPf41cwjAvYQXm+0YDB64KeC+T9w0t8G1Y8BxoxWTZ
	 1azM1bei2mDBi9i6Pwk+dXNo6pIrF8YH0uv7yABhPVPfD9aY79K46ndDPSe3wUOSC2
	 m6Ua+aMxk9wATGtodHkplXu15Ik+0CMJCtp4Ur8OuI4WagfepNsdEdSml/vKchN/FO
	 F2r9k4Uw2h6vA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:07 +0200
Subject: [PATCH v2 12/23] binfmt_misc: factor out the entry matching
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-12-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TkHS8svwwTJ1Obe3L+vKAPhau92Mc/d3NI+a2XNdFBw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHz9zSBwZ9tNxdnXPknenJQazpht3vtmJ5ffn0fdZ
 gzb56Uld5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE0p2R4f5tsY6ae//Osyvt
 6vq24/bNeQfDnPMWzjKrfv/3y01zhRUMfyUyBbM36yyJdp2gsvroX2+Pk1s3HZl4l+mOzG2Vc64
 S/3gA
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
index dac2b423280c..688554caef3a 100644
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

