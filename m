Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF73F65FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676041; cv=none; b=jN+L0okCteStEZAnJ2zny8/sRlgRJH+RDzGqI8iMOxMwkQW89Inj/eprM4R8wwhTKenytql03+0a1eCR/REb2BlCaThxtvrCTgoQvYbqdIy+55FGSJovI1tqOdoBV3VKAT2v0wcUoJlyjO1igPKJ3KJaIFTvtNqWTXzOSUNhE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676041; c=relaxed/simple;
	bh=25W/cgoz/HpXh1KEXu/W3hNEhoDDwyECTUQhuRK1V1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkY2pZPqgwe+lkd50h33xjXEriYQUi3qgWgXjYSSUywIqPxa3QszjW0Nq5N3lYWGQfPmdYRtkRHWZKq6PxB4RLNlBZ7aJKIbpaCCTVM2cTALCySyA1//jIRwyAPV0XwbzA93gPjvFJcnVvdfHcbelfhW2mQixXsiQkmy5xGLNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWXqt8ow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWXqt8ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9BA1F000E9;
	Fri, 10 Jul 2026 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676039;
	bh=OccYc8NxGsDMDGI6vq4nPL3MmgM3Zh80pxvV6GiHRMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YWXqt8owcIw+8pJKVus3nEG0j5OP6I4LZuipqZ5tyTNaHu7GGGexqzuAi/09T92V0
	 UyKd7EQGcpIyfjnGX9VIoZm3ebQnIXW2CP4LEUtwqn2e9VJnmPWJEyp6Ogr32KCkNA
	 FU8W3kqvYkUsL4Rb0+hVNSIIwuZKfTOQCv7KniXWIAN20vLo1XA4SNHvP3YlijZioa
	 ER6cxEvmpvaTkzw1YXL3FFHkqnXfrWlli8hRjqnMFVK8uZYleSX1Z5BiUIoNlULzrC
	 gWvFx8s9JqO+JfIeMd2GUAaZxxujitJm9ME1ECBOMTuPGIHgS2l2nx3hxO0/dFDaWd
	 niWX4D9UIPlag==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:21 +0200
Subject: [PATCH v3 20/24] binfmt_misc: split the field parsing out of
 create_entry()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-20-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=9225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=25W/cgoz/HpXh1KEXu/W3hNEhoDDwyECTUQhuRK1V1w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Il/mDanxkT488yZ3O7vfEVXM5w6XCdj8NA31Dq6Y
 veXQxOudpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+xOG/z7c0ZpG/9bJCzS6
 C18VP6yRxJOw6UR0HEPdbeWLwjn8TowMSyULvnZWGs19HvQhvYlthfzXi68P/SrcwXp3Scij22t
 mMwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

create_entry() is a two hundred line parser with the M and E field
handling inlined as the two arms of its largest branch. Move them
into parse_magic_fields() and parse_extension_fields() which return
the new parse position or NULL so create_entry() itself reads like
the register string grammar again.

The offset parsing loses a provably dead check on the way: after
*s = '\0' and p = s the subsequent if (*p++) always reads the just
written NUL byte and can never fail, it only obscured that the code
simply advances past the delimiter.

With the field parsing gone every remaining failure unwinds the same
way, so hand the entry to __free(kfree), return errors directly and
pass ownership out via no_free_ptr() on success instead of routing
every exit through goto tails.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 225 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 108 insertions(+), 117 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 4cfd3ce5e47e..a9e1e0bbcc60 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -340,6 +340,95 @@ static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
 	}
 }
 
+/* Parse the 'offset', 'magic' and 'mask' fields of an 'M' entry. */
+static char *parse_magic_fields(struct binfmt_misc_entry *e, char *p, char del)
+{
+	char *s;
+
+	/* Parse the 'offset' field. */
+	s = strchr(p, del);
+	if (!s)
+		return NULL;
+	*s = '\0';
+	if (p != s) {
+		if (kstrtoint(p, 10, &e->offset) || e->offset < 0)
+			return NULL;
+	}
+	p = s + 1;
+	pr_debug("register: offset: %#x\n", e->offset);
+
+	/* Parse the 'magic' field. */
+	e->magic = p;
+	p = scanarg(p, del);
+	if (!p || !e->magic[0])
+		return NULL;
+	print_hex_dump_debug(
+		KBUILD_MODNAME ": register: magic[raw]: ",
+		DUMP_PREFIX_NONE, 16, 1, e->magic, p - e->magic, true);
+
+	/* Parse the 'mask' field. */
+	e->mask = p;
+	p = scanarg(p, del);
+	if (!p)
+		return NULL;
+	if (!e->mask[0]) {
+		e->mask = NULL;
+		pr_debug("register:  mask[raw]: none\n");
+	} else {
+		print_hex_dump_debug(
+			KBUILD_MODNAME ": register:  mask[raw]: ",
+			DUMP_PREFIX_NONE, 16, 1, e->mask, p - e->mask, true);
+	}
+
+	/*
+	 * Decode the magic & mask fields. Note: while we might have accepted
+	 * embedded NUL bytes from above, the unescape helpers will stop at
+	 * the first one they encounter.
+	 */
+	e->size = string_unescape_inplace(e->magic, UNESCAPE_HEX);
+	if (e->mask && string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
+		return NULL;
+	if (e->size > BINPRM_BUF_SIZE || BINPRM_BUF_SIZE - e->size < e->offset)
+		return NULL;
+	pr_debug("register: magic/mask length: %i\n", e->size);
+	print_hex_dump_debug(
+		KBUILD_MODNAME ": register: magic[decoded]: ",
+		DUMP_PREFIX_NONE, 16, 1, e->magic, e->size, true);
+	if (e->mask)
+		print_hex_dump_debug(
+			KBUILD_MODNAME ": register:  mask[decoded]: ",
+			DUMP_PREFIX_NONE, 16, 1, e->mask, e->size, true);
+	return p;
+}
+
+/* Parse the 'magic' field of an 'E' entry: the filename extension. */
+static char *parse_extension_fields(struct binfmt_misc_entry *e, char *p,
+				    char del)
+{
+	/* Skip the 'offset' field. */
+	p = strchr(p, del);
+	if (!p)
+		return NULL;
+	*p++ = '\0';
+
+	/* Parse the 'magic' field. */
+	e->magic = p;
+	p = strchr(p, del);
+	if (!p)
+		return NULL;
+	*p++ = '\0';
+	if (!e->magic[0] || strchr(e->magic, '/'))
+		return NULL;
+	pr_debug("register: extension: {%s}\n", e->magic);
+
+	/* Skip the 'mask' field. */
+	p = strchr(p, del);
+	if (!p)
+		return NULL;
+	*p++ = '\0';
+	return p;
+}
+
 /*
  * This registers a new binary format, it recognises the syntax
  * ':name:type:offset:magic:mask:interpreter:flags'
@@ -348,29 +437,26 @@ static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
 static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 					      size_t count)
 {
-	struct binfmt_misc_entry *e;
+	struct binfmt_misc_entry *e __free(kfree) = NULL;
 	char *buf, *p;
 	char del;
-	int err;
 
 	pr_debug("register: received %zu bytes\n", count);
 
 	/* some sanity checks */
-	err = -EINVAL;
 	if ((count < 11) || (count > MAX_REGISTER_LENGTH))
-		goto out;
+		return ERR_PTR(-EINVAL);
 
-	err = -ENOMEM;
 	e = kmalloc(struct_size(e, buf, count + MISC_DELIM_PAD),
 		    GFP_KERNEL_ACCOUNT);
 	if (!e)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	p = buf = e->buf;
 
 	memset(e, 0, sizeof(*e));
 	if (copy_from_user(buf, buffer, count))
-		goto efault;
+		return ERR_PTR(-EFAULT);
 
 	del = *p++;	/* delimeter */
 
@@ -378,7 +464,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 
 	/* A flag-char delimiter runs the flag scan off the buffer. */
 	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
-		goto einval;
+		return ERR_PTR(-EINVAL);
 
 	/* Pad the buffer with the delim to simplify parsing below. */
 	memset(buf + count, del, MISC_DELIM_PAD);
@@ -387,13 +473,13 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	e->name = p;
 	p = strchr(p, del);
 	if (!p)
-		goto einval;
+		return ERR_PTR(-EINVAL);
 	*p++ = '\0';
 	if (!e->name[0] ||
 	    !strcmp(e->name, ".") ||
 	    !strcmp(e->name, "..") ||
 	    strchr(e->name, '/'))
-		goto einval;
+		return ERR_PTR(-EINVAL);
 
 	pr_debug("register: name: {%s}\n", e->name);
 
@@ -408,111 +494,26 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		e->flags = BIT(MISC_FMT_ENABLED_BIT) | BIT(MISC_FMT_MAGIC_BIT);
 		break;
 	default:
-		goto einval;
+		return ERR_PTR(-EINVAL);
 	}
 	if (*p++ != del)
-		goto einval;
-
-	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
-		/* Handle the 'M' (magic) format. */
-		char *s;
-
-		/* Parse the 'offset' field. */
-		s = strchr(p, del);
-		if (!s)
-			goto einval;
-		*s = '\0';
-		if (p != s) {
-			int r = kstrtoint(p, 10, &e->offset);
-			if (r != 0 || e->offset < 0)
-				goto einval;
-		}
-		p = s;
-		if (*p++)
-			goto einval;
-		pr_debug("register: offset: %#x\n", e->offset);
-
-		/* Parse the 'magic' field. */
-		e->magic = p;
-		p = scanarg(p, del);
-		if (!p)
-			goto einval;
-		if (!e->magic[0])
-			goto einval;
-		print_hex_dump_debug(
-			KBUILD_MODNAME ": register: magic[raw]: ",
-			DUMP_PREFIX_NONE, 16, 1, e->magic, p - e->magic, true);
-
-		/* Parse the 'mask' field. */
-		e->mask = p;
-		p = scanarg(p, del);
-		if (!p)
-			goto einval;
-		if (!e->mask[0]) {
-			e->mask = NULL;
-			pr_debug("register:  mask[raw]: none\n");
-		} else {
-			print_hex_dump_debug(
-				KBUILD_MODNAME ": register:  mask[raw]: ",
-				DUMP_PREFIX_NONE, 16, 1, e->mask, p - e->mask,
-				true);
-		}
+		return ERR_PTR(-EINVAL);
 
-		/*
-		 * Decode the magic & mask fields.
-		 * Note: while we might have accepted embedded NUL bytes from
-		 * above, the unescape helpers here will stop at the first one
-		 * it encounters.
-		 */
-		e->size = string_unescape_inplace(e->magic, UNESCAPE_HEX);
-		if (e->mask &&
-		    string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
-			goto einval;
-		if (e->size > BINPRM_BUF_SIZE ||
-		    BINPRM_BUF_SIZE - e->size < e->offset)
-			goto einval;
-		pr_debug("register: magic/mask length: %i\n", e->size);
-		print_hex_dump_debug(
-			KBUILD_MODNAME ": register: magic[decoded]: ",
-			DUMP_PREFIX_NONE, 16, 1, e->magic, e->size, true);
-		if (e->mask)
-			print_hex_dump_debug(
-				KBUILD_MODNAME ": register:  mask[decoded]: ",
-				DUMP_PREFIX_NONE, 16, 1, e->mask, e->size, true);
-	} else {
-		/* Handle the 'E' (extension) format. */
-
-		/* Skip the 'offset' field. */
-		p = strchr(p, del);
-		if (!p)
-			goto einval;
-		*p++ = '\0';
-
-		/* Parse the 'magic' field. */
-		e->magic = p;
-		p = strchr(p, del);
-		if (!p)
-			goto einval;
-		*p++ = '\0';
-		if (!e->magic[0] || strchr(e->magic, '/'))
-			goto einval;
-		pr_debug("register: extension: {%s}\n", e->magic);
-
-		/* Skip the 'mask' field. */
-		p = strchr(p, del);
-		if (!p)
-			goto einval;
-		*p++ = '\0';
-	}
+	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags))
+		p = parse_magic_fields(e, p, del);
+	else
+		p = parse_extension_fields(e, p, del);
+	if (!p)
+		return ERR_PTR(-EINVAL);
 
 	/* Parse the 'interpreter' field. */
 	e->interpreter = p;
 	p = strchr(p, del);
 	if (!p)
-		goto einval;
+		return ERR_PTR(-EINVAL);
 	*p++ = '\0';
 	if (!e->interpreter[0])
-		goto einval;
+		return ERR_PTR(-EINVAL);
 	pr_debug("register: interpreter: {%s}\n", e->interpreter);
 
 	/* Parse the 'flags' field. */
@@ -520,19 +521,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	if (*p == '\n')
 		p++;
 	if (p != buf + count)
-		goto einval;
-
-	return e;
-
-out:
-	return ERR_PTR(err);
+		return ERR_PTR(-EINVAL);
 
-efault:
-	kfree(e);
-	return ERR_PTR(-EFAULT);
-einval:
-	kfree(e);
-	return ERR_PTR(-EINVAL);
+	return no_free_ptr(e);
 }
 
 /* Commands accepted by the /status and /<entry> files. */

-- 
2.53.0

