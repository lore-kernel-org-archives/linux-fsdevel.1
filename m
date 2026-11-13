Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552821;
	b=a6wZrMxM4zpefFGxj3kgfCRCiHWstvCpA2woY9VAOvmF28IDBUZAofK9M7/08ztO8FKK
	 CwOKOpLvayNv9gKQTvl/QgM9EFRJk0dhn3+huQ/qZLnLMtEMVKXkBlQb5ShW7+DRK2oj6
	 +bd6VCqUS6a5+atd4NGTSrUWOC6eFeXPvix9yLSA0IG4oSuvmCBCqS0nDpwufz3omVlp9
	 EXOT2TaEHU9j8UF+qdCoWu5xMM9RAUlJZZgbiemeIr0pPrcvm1AkeP+Qt/uwZ/fWe5Jld
	 hHpfjMa52rsovo0sJb6OQEPWid0qFMNYyxxIKdQHby52t/9Yd/AjvIQhjsY+uZoi/MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=;
	b=uXNDJ+nny3tqJQqHPKG96U/Kn8izcB918H10qe1p28s3hmwkkMk0wDMPo1dnd3SHUm4C
	 IkPwkRxxcHgMdWydo4CcWpW9jgB9YYaG9VQhLQTH0Pg1SaKDTYBiYtUxAI6RBOGp3OBBp
	 k0f883OHbzaDlu5cUtIvhWgWRmB08q9qPdvHU3TuOPGxpXR0NEQMjRR9jsIItHLiSygHU
	 q35L2GT8W8FNQwiFeSbpVNMpDikZpPnJqiohfr/rAVI+ihvUOHLy1izzmBVQyycl0PaFL
	 U4+iWMDuQZ38hA0rtzgpqeuoT3LIEUVpoRHzYHSfnWTm2bVxdlI21cAqj3OXF7ijCpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="fLT/mju8";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF5606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 06:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCF5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fLT/mju8
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so933742eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794552821; x=1795157621; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=;
        b=fLT/mju85eYKEUfFdmTx0l+yDJBeLhsZrB0BgQcZDYREdLBxANpYfqgBbkRqE/+OEI
         7Zw7zvgVOb1UU4H0aCEWxG/tMn0T28mpPryeiGNoq3LxCA4sn9HKpfUsKqx4rHDH2L94
         lSgmyhHzYNJ+WKcV2QaJNthyNWxkKBResUzLfP7fCX1v87zgSWQSBMyTTMj1AQszBN+h
         U6oV/jKnj91tqkW3Q8MA70cmQ2iYNhR8QLLTB5WG+SQqRHWUmYhIfxkmmofS3gL4NG0D
         lnSbtK833Lag7hqRfDHNKSMVwXIrkY/DlboIN0JxcgIWu99CULyCWIHsnRM0RvTRqJTp
         uwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552821; x=1795157621;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=;
        b=URORwo+3OdthfQgv5X4GP89l4NWbNTy+1v/vWjZuKbPjmApr5hdORkCWWBGVaHsDlE
         NSmOUTaTfJc+oZ2meqvv6JSUF2h5Nhflj4gGa/Ce9gqZ5l0YnKyVNmxOenn/bcNYFJRc
         HGC+nYmDTJ4uDdJmx7oxiY2ZUP9rps8TsLbDwZy6usMJLPz1s57VT6hQT7WKcu4dSNo9
         eY3WfpfZeg/u69LUtHsqM1Kby0JHt+2DPupohwEEGpXj38LtT3V2if1s591t7J8ax+Ei
         lmzQ1GH3OQGPZdWOUuytLZYPSF2gu8YnsjF/bk4TZWvGrAMc8bHFWIc7Z2De6eBQECaI
         Jdhw==
X-Forwarded-Encrypted: i=1; AL+hErGQcqbK7I5AxZKTgIfxQGg9GYwsArw3U7JIvkC4EbF8y5WBEJj6iybqSNM5yXo19YdQrphQtp9LPewjvEzA@vger.kernel.org
X-Gm-Message-State: APuU4Z+zTbwnxubuqPU1wiypIfU8eQL30IzVSc1bLGKYftt6M5MbF+LU
	s7Q8YhufqAAlmVzR+SdGeKXBBuRatDsdnr43ZRWoArxVylcaFQ8Q7RBqTOwujfbvxRqWPUAWh6T
	fKvJj/0LffKuj4wfmUKnV6Wj1xRIi6uRGodHV7w==
X-Received: from dycmq8.prod.google.com ([2002:a05:7301:788:b0:369:fbca:f649])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:6185:20b0:379:3c04:2cdd with SMTP id 5a478bee46e88-379686a7f3amr1357207eec.31.1794552820371;
 Thu, 12 Nov 2026 22:53:40 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:30 -0800
In-Reply-To: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-2-sarthakkukreti@google.com>
Subject: [PATCH 1/3] libfs: reject casefolded names that fold to ".", "..", or empty
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, Eric Biggers <ebiggers@google.com>, 
	Dmitry Torokhov <dtor@google.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"

Unicode normalization and casefolding (utf8_casefold()) strips code
points with the Default_Ignorable_Code_Point property, such as U+202E
(RIGHT-TO-LEFT OVERRIDE) or U+200B (ZERO WIDTH SPACE). As a result:

1. A filename consisting of "." or ".." followed by ignorable characters
   (e.g. ".\xe2\x80\xae" or "..\xe2\x80\xae") bypasses VFS special-entry
   handling during path walk, but casefolds to "." or "..".
2. A filename consisting solely of ignorable characters (e.g.
   "\xe2\x80\xae") casefolds to the empty string "" (length 0), causing
   any two distinct ignorable-only filenames to compare and hash as
   equal.

Update generic_ci_d_hash(), generic_ci_d_compare(), generic_ci_match(),
and generic_ci_validate_strict_name() to reject case-insensitive
hashing, matching, and creation of filenames that casefold to "", ".",
or "..", while preserving exact byte-equality matches (such as NFS
export lookups of literal ".."). Using a 3-byte stack buffer with
utf8_casefold() detects all three cases in O(1) space without heap
allocations.

Fixes: c843843e714c ("fs: Add standard casefolding support")
Co-developed-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/libfs.c         | 50 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h | 31 ++++++++++++++++------------
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 27d7dc16fcb0..54296dfb8444 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1801,8 +1801,11 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 {
 	const struct dentry *parent;
 	const struct inode *dir;
+	const struct unicode_map *um;
 	union shortname_store strbuf;
+	unsigned char buf[3];
 	struct qstr qstr;
+	int cf_len;
 
 	/*
 	 * Attempt a case-sensitive match first. It is cheaper and
@@ -1821,6 +1824,19 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	if (!dir || !IS_CASEFOLDED(dir))
 		return 1;
 
+	if (name_is_dot_dotdot(str, len) ||
+	    name_is_dot_dotdot(name->name, name->len))
+		return 1;
+
+	/*
+	 * utf8_strncasecmp() only matches if both names casefold to the same
+	 * byte sequence, so checking @name covers @qstr as well.
+	 */
+	um = dentry->d_sb->s_encoding;
+	cf_len = utf8_casefold(um, name, buf, sizeof(buf));
+	if (cf_len == 0 || (cf_len > 0 && name_is_dot_dotdot(buf, cf_len)))
+		return 1;
+
 	qstr.len = len;
 	qstr.name = str;
 	/*
@@ -1839,7 +1855,7 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 		barrier();
 	}
 
-	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
+	return utf8_strncasecmp(um, name, &qstr);
 }
 EXPORT_SYMBOL(generic_ci_d_compare);
 
@@ -1855,13 +1871,21 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	unsigned char buf[3];
 	int ret;
 
 	if (!dir || !IS_CASEFOLDED(dir))
 		return 0;
 
 	ret = utf8_casefold_hash(um, dentry, str);
-	if (ret < 0 && sb_has_strict_encoding(sb))
+	if (ret < 0) {
+		if (sb_has_strict_encoding(sb))
+			return -EINVAL;
+		return 0;
+	}
+
+	ret = utf8_casefold(um, str, buf, sizeof(buf));
+	if (ret == 0 || (ret > 0 && name_is_dot_dotdot(buf, ret)))
 		return -EINVAL;
 	return 0;
 }
@@ -1934,10 +1958,28 @@ int generic_ci_match(const struct inode *parent,
 	    !memcmp(name->name, dirent.name, dirent.len))
 		goto out;
 
-	if (folded_name->name)
+	if (name_is_dot_dotdot(dirent.name, dirent.len) ||
+	    name_is_dot_dotdot(name->name, name->len) ||
+	    (folded_name->name &&
+	     (!folded_name->len ||
+	      name_is_dot_dotdot(folded_name->name, folded_name->len)))) {
+		res = 1;
+		goto out;
+	}
+
+	if (folded_name->name) {
 		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
-	else
+	} else {
+		unsigned char buf[3];
+		int cf_len = utf8_casefold(um, name, buf, sizeof(buf));
+
+		if (cf_len == 0 ||
+		    (cf_len > 0 && name_is_dot_dotdot(buf, cf_len))) {
+			res = 1;
+			goto out;
+		}
 		res = utf8_strncasecmp(um, name, &dirent);
+	}
 
 out:
 	kfree(decrypted_name.name);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..84f5ce2bb9ad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3356,28 +3356,26 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  * generic_ci_validate_strict_name - Check if a given name is suitable
  * for a directory
  *
- * This functions checks if the proposed filename is valid for the
- * parent directory. That means that only valid UTF-8 filenames will be
- * accepted for casefold directories from filesystems created with the
- * strict encoding flag.  That also means that any name will be
- * accepted for directories that doesn't have casefold enabled, or
- * aren't being strict with the encoding.
+ * This function checks if the proposed filename is valid for the
+ * parent directory. Names that casefold to "", ".", or ".." are
+ * rejected for all casefolded directories. When the filesystem is
+ * created with the strict encoding flag, only valid UTF-8 filenames
+ * are accepted for casefolded directories.
  *
  * @dir: inode of the directory where the new file will be created
  * @name: name of the new file
  *
  * Return:
- * * True: if the filename is suitable for this directory. It can be
- *   true if a given name is not suitable for a strict encoding
- *   directory, but the directory being used isn't strict
- * * False if the filename isn't suitable for this directory. This only
- *   happens when a directory is casefolded and the filesystem is strict
- *   about its encoding.
+ * * True: if the filename is suitable for this directory.
+ * * False: if the filename isn't suitable for this directory.
  */
 static inline bool generic_ci_validate_strict_name(struct inode *dir,
 						   const struct qstr *name)
 {
-	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
+	unsigned char buf[3];
+	int len;
+
+	if (!IS_CASEFOLDED(dir))
 		return true;
 
 	/*
@@ -3387,6 +3385,13 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir,
 	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
 		return true;
 
+	len = utf8_casefold(dir->i_sb->s_encoding, name, buf, sizeof(buf));
+	if (len == 0 || (len > 0 && name_is_dot_dotdot(buf, len)))
+		return false;
+
+	if (!sb_has_strict_encoding(dir->i_sb))
+		return true;
+
 	return !utf8_validate(dir->i_sb->s_encoding, name);
 }
 #else
-- 
2.56.0.611.g1030f0b940-goog

