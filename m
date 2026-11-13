Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552824;
	b=GHH76e9/nH2w4WQm8OO9sVOKIcmsGZEuapz8vJpPGmiDoxlPeAzOYms0GafroI1cPTgB
	 8kEuciphWJMsKYcd1yZ+XU48M1lLIC778fRwHAXNpB6/nNAMlx0yvK9EJLdZ6PzhoKRyf
	 mLP39PztWBNjn+Ie5HH0GotmJuenAhZ3ONWMpGSap4mGSZku1SRDNoyN2PJOyJ4WPnx+Y
	 xHnFX8SEHAmLlI9CxOXEhJDLbZdjqVSqZFirkzCv5ATzoVtGs8IbBLdyhM0guCBuo/DMM
	 QS/yLkqSyLEYHkndme9GAhUFyP3DKGTsqk+lkv1wGa+uky5ZAbex0zw99Zi41Ow7rBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=;
	b=v9tAovT/OBgG0ht3kn/C+q/3vm8wAzDfzPM54tA8GQYuN3DiGUW9NYILHqZ1ESkanorM
	 oZNmEOZtMJakF3wpN3l4H/4GZYbdJ7IdYC14mFyJRaHbMaL5Vq61QEi7+V79aSlFqwbQ0
	 LwDt6cx49I6kantEY5MFagFqKqYi1oq/0prvEH/22rn/DONb6AqKRPCKnf3hafyq4gLs4
	 kbk/kOJlK0Crok3lzzynMVRbtru+7NAEZ41rm63qx3zrZ0PD+WuUikyRs4slixkSRF/EY
	 Xs395pol8DWSWYBHBYC37f6FlPrwoJWLZWx73FBh0sfmy2DXSjhTZtk/XBEmowRXPKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=puR8RExC;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCB606A890
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 06:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BCB606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=puR8RExC
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso653270eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794552823; x=1795157623; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=;
        b=puR8RExCfWpsSrtlzQgscyAHr42VjngI1jUKat4N0EXiaNr5o3suIcmS6Suse73Kky
         WGrp3p15oHj417hYAbWAE9w+qYMp7Kfbwc+D2qAg8+J4DE7c60mvTtVGWtAbU6rJYbKL
         oFCJPWfx3aNOgtv8ubQ+iWNhgcYidNAgmCd0BCdryRuFOXLgRvO6JvX7WTDE1rVS41BA
         QCYJAw0z55YSHa11pdGyKIU2IJS5ttde8BPZkVAoqTvw/3Ck2bWI8ttYdUORTMGhqRxg
         0UXcaaleJ8NbpnRZfliF/SloGNj7FBrXiy8TeQWv8ax8gLmPBmhxbW6eE2D0LU4CgT3i
         R9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552823; x=1795157623;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=;
        b=0z7MX4yuaUmmUhId6Dhx1CXb3NuKgGLdyNq/Hxvp3X6BgvtKwmtwxBXNklVgF0gpLn
         XBHkTvag0feaCb2v14fzKlN6EOCGwH+33e+94AvFIDfUn0TJIQm8RIZBNR1d4OvSrCyI
         QsbBsCnyMgOYSBLK44dBEgYEU/qbAJBt+8zEcwLX6/hvYfYYgxR5LOOf6tC/Paf0yerK
         o47AIZmkQfKzjXzou6FDU5eHicgFfFraVLB9opttUp6U2tEw10VoDfUNYfXA6N2wdwPv
         uRqKSCjCTglfNpwkRctXt0+0NR3mn0yIiOsE34UC59rf1z7RABTu8ZF/D9hf+T5FfdTo
         N1cA==
X-Forwarded-Encrypted: i=1; AL+hErHZFJTRVRlLsJG//dw46WxMQVCWTG0dC2qpaZ1qoXg0MQcT44at0bAjSUaqtBT2j72toXUD8X3kBnR/YDF2@vger.kernel.org
X-Gm-Message-State: APuU4Z+gpxHawKLql1VdqKgW+3/OLoY8Hjnwon/NWCXUOQ3Ic3EIHc/W
	ZnRKrV6DIYddyRxkTiAtq2GCq0NB33hjiOYmOGUF4CabsVr2PuqJiSxUrqWfcg8blRUrd8+cfzK
	PAq6azXYOX5/4tbOITfZai1006y65bCFvUhSjlw==
X-Received: from dyp12.prod.google.com ([2002:a05:693c:65cc:b0:36c:9b55:8436])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1a05:b0:369:f035:661 with SMTP id 5a478bee46e88-37967315a1emr1295500eec.15.1794552822463;
 Thu, 12 Nov 2026 22:53:42 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:31 -0800
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
Message-ID: <20261113065332.929085-3-sarthakkukreti@google.com>
Subject: [PATCH 2/3] ext4: reject casefolded names that fold to ".", "..", or empty
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, Eric Biggers <ebiggers@google.com>, 
	Dmitry Torokhov <dtor@google.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"

Filenames consisting solely of ignorable Unicode characters fold to
empty strings, while names with leading dots and ignorable characters
fold to "." or "..". Allowing such names to be created or looked up in
casefolded directories collides with on-disk "." and ".." entries (which
triggers EXT4_ERROR_INODE in ext4_lookup()) and introduces duplicate
entries that e2fsck flags as corruption.

Skip casefolding when the lookup name is literally "." or "..", reject
any non-dot names that fold to "", ".", or ".." in
ext4_fname_setup_ci_filename(), and fall back to opaque byte hashing in
ext4fs_dirhash() when utf8_casefold() yields "", ".", or "..".

Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Co-developed-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/ext4/hash-test.c | 14 ++++++++++++++
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     |  9 +++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/hash-test.c b/fs/ext4/hash-test.c
index 49b0d874c833..a8b206a6d751 100644
--- a/fs/ext4/hash-test.c
+++ b/fs/ext4/hash-test.c
@@ -541,6 +541,20 @@ static void test_ext4fs_dirhash_casefold_fallback(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret_plain, 0);
 	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
 	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
+
+	ret_cf = ext4fs_dirhash(&ei->vfs_inode, ".\xe2\x80\xae", 4, &folded_dir);
+	ret_plain = ext4fs_dirhash(plain_dir, ".\xe2\x80\xae", 4, &plain);
+	KUNIT_ASSERT_EQ(test, ret_cf, 0);
+	KUNIT_ASSERT_EQ(test, ret_plain, 0);
+	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
+	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
+
+	ret_cf = ext4fs_dirhash(&ei->vfs_inode, "\xe2\x80\xae", 3, &folded_dir);
+	ret_plain = ext4fs_dirhash(plain_dir, "\xe2\x80\xae", 3, &plain);
+	KUNIT_ASSERT_EQ(test, ret_cf, 0);
+	KUNIT_ASSERT_EQ(test, ret_plain, 0);
+	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
+	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
 }
 #endif
 
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 978bd92da0ad..65019de4af93 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -327,7 +327,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			return -ENOMEM;
 
 		dlen = utf8_casefold(um, &qstr, buff, PATH_MAX);
-		if (dlen < 0) {
+		if (dlen <= 0 || name_is_dot_dotdot(buff, dlen)) {
 			kfree(buff);
 			goto opaque_seq;
 		}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a6386c1d237f..096f78ea5df4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1368,7 +1368,8 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	int len;
 
 	if (!IS_CASEFOLDED(dir) ||
-	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
+	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir)) ||
+	    name_is_dot_dotdot(iname->name, iname->len)) {
 		cf_name->name = NULL;
 		return 0;
 	}
@@ -1378,9 +1379,13 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		return -ENOMEM;
 
 	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
-	if (len <= 0) {
+	if (len < 0) {
 		kfree(buf);
 		buf = NULL;
+	} else if (len == 0 || name_is_dot_dotdot(buf, len)) {
+		kfree(buf);
+		cf_name->name = NULL;
+		return -EINVAL;
 	}
 	cf_name->name = buf;
 	cf_name->len = (unsigned) len;
-- 
2.56.0.611.g1030f0b940-goog

