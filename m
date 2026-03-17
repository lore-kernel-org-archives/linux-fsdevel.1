Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE3346AC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715121; cv=none; b=gzadQe22ajFR9YbbNGQk2hBD0QHFdnLM3PXIWCzzhLQOO8vqwsGFg6H5Vlg6ooyZ2jzcTRJfxPlkz1jFOSDNBcypniKj9mziywVtacN8RtGlgSlUpuDtduuwdvfTZFdTWcPpoKzvdibztuFuYrmJLWtAEN5cjliGVeLj429K8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715121; c=relaxed/simple;
	bh=gvkTN0Io/ZHlfAu049yjcIUWjlsAueujlT2SKUPrFZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l6rYiIeojzj+pG0ZACWxuh4psgxc4imkzdY8G+EL2ZtuSD9UE/COlCWa6AHkJ/5ikr5W8H+Avpf9K7bCaSFdveobKwQLj8fZ/Uj/MY8xoBaIuqrKvKU6FhdtL/d5fvFx1XBVHpjaFoP7DpGChvsQpitAtS7/JXCku4w9PFSsWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Xk+FDwDr; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Xk+FDwDr"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad46a44easo5025664d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773715119; x=1774319919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjI5Sf85AGG/BWekd0QHD1ezj9wn3KJ74ppogqf/Zgk=;
        b=Xk+FDwDrIisOkjCb6NZyg3sg9oByXgV+ZmgtPs2tkkuObtR8H4bbmmp6fzRAf6dl0c
         cp+cgRPxAGebWXAYeS4pgW/GDENazbvlhH6zXhZmpwsXBPkIsXWGLuKxoxdzwr92eved
         gB67Z4/ch5dhI5kD24y+gPYzJ4pT22eXYPglXqU2iDIUZQzfBUQIGKxAuGV/kb0KIsen
         QqMtaCZSFg7B93k0q0+x2TJoI68oSf3X993Ej9yE2eB8QDrGd29viZo3t9tjV8kJGOZV
         CQF2gAquzfI4Mdmko8GaFLYHHpGe5XGgcywiraUieQO0Wtqy0m+HBzgdhtToVPY6M1A9
         W8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773715119; x=1774319919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjI5Sf85AGG/BWekd0QHD1ezj9wn3KJ74ppogqf/Zgk=;
        b=IIMXlwXscuwCFZ/2IDfkjUK5YAON6xl8cV9XY+/3a+VmiMtf/VUgCyyxb//YikoYo6
         6Z9p86w53vm3VgOtZp7QrWODPzteTPiLid/SC1v4SRYrWkFxZVF28nVMMIQax3krkaF1
         8SZSkWtuTSoAnaGv7wKDQmA9pK4f+YuTMkOGurKR8XQYuL0749W2hhp+jfc5k3DeZwce
         +e4XPBl8FyYp7RHfpr9dsT9djR4+bsQK9I+dO4LbhroScsDQJx15ljwXyjgyv/zJ8KRY
         b85WFqUlTfAsKaO8W1fWdZG/HEa64ZBjpIxVcgUBbNwJVhQ4o8+mGvFpJQlalBtbQzUx
         o4DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNbn2kuhw5DQMVbRXZUZ5me0lbWsJZ26uKlKGjM+C+UFQeTMYnDNO0o+UJe/m8GusWYX8ruZk87jMojxEn@vger.kernel.org
X-Gm-Message-State: AOJu0YyNx9Nd7d5TJbw3pou5Ub40OJpso4GYWMoeo21pL0sotjIsTnzc
	j+rzpEkEfGfmnl5TE1B2+Wg8Y5OXyitJZRocWKuRKmju4R2uikfYrz33FMQF63mOhdy+HACwgM3
	DmXZf
X-Gm-Gg: ATEYQzxr2n3BB/6zxMEZaYLN1WHBBAlQnTWxQIyLNjVVwq78igcA4jng1va4muxXhtl
	jtkrrupx/owoYh/f4K2iNVjxWX9Xr+tj62EdUef9uqf8ngV3/VZER8RIr+YTyGruUUoBrCXsktd
	rSdREZSO0kg5kWbv779MKkLmxCUYxks7/ga2jkGIjaHKy55GQ3VwS+Wnu39xAAtgmYOTZnDq5SN
	3HkQ9pGJ5UXeXt/tdf2GoH2HmabRZpOKEzJ/a7Q59WUzerHXsoXqwFtJuuDrCFQ1euB3gaWarGg
	HbnARircGdbQn8U2Lb/SBgwj/456oiIIm1M96s8C/dvgTTGYzznR0s3VsuPaJwVv7JSJfaOWwOY
	SgkH0p2Ej8hQ5siFpqZnMSxNa95aZa3qAw84qwpBgBGOUfqPqEXdRAYbdt0LvqF1O1GuMnizT7P
	VC8QmgiFdfYSYqYOYbKw1OwwglIUI9wb6RUP9Y5O7tOhjB48JELc9pS4spxfEqr4VJFGYu3p3z6
	czgzZ30D0rSdPM7kTnE3A7aT+75DETU/dclA3K/Ix7G7d0s1b4qeM7u/875
X-Received: by 2002:a53:e1f9:0:b0:64c:f90c:743b with SMTP id 956f58d0204a3-64e630479a8mr11940326d50.41.1773715118626;
        Mon, 16 Mar 2026 19:38:38 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b636d3sm6651543d50.17.2026.03.16.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 19:38:38 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [RFC] liveupdate: prevent double preservation
Date: Mon, 16 Mar 2026 22:38:34 -0400
Message-ID: <20260317023834.487682-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, LUO does not prevent the same file from being preserved twice
across different active sessions.

Add a new i_state flag I_LUO_PRESERVED and update luo_preserve_file()
to check and set this flag when a file is preserved, and clear it in
luo_file_unpreserve_files() when it is released. This ensures that the
same file (inode) cannot be preserved by multiple sessions. If another
session attempts to preserve an already preserved file, it will now
fail with -EBUSY.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---

Background:
Because LUO preserves files of absolutely different types: memfd, and
upcoming  vfiofd [1], iommufd [2], guestmefd (and possible kvmfd/cpufd).
There is no common private data or guarantee on how to prevent that the
same file is not preserved twice beside using inode or some slower and
expensive method like hashtables.

[1] https://lore.kernel.org/all/20260129212510.967611-1-dmatlack@google.com
[2] https://lore.kernel.org/all/20260203220948.2176157-1-skhawaja@google.com

 include/linux/fs.h           |  5 ++++-
 kernel/liveupdate/luo_file.c | 19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23f36a2613a3..029257ee7e0a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -712,6 +712,8 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
+ * I_LUO_PRESERVED	Inode is being preserved by a live update session.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -744,7 +746,8 @@ enum inode_state_flags_enum {
 	I_CREATING		= (1U << 15),
 	I_DONTCACHE		= (1U << 16),
 	I_SYNC_QUEUED		= (1U << 17),
-	I_PINNING_NETFS_WB	= (1U << 18)
+	I_PINNING_NETFS_WB	= (1U << 18),
+	I_LUO_PRESERVED		= (1U << 19)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 5acee4174bf0..38df09d89433 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -248,6 +248,7 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  * Context: Can be called from an ioctl handler during normal system operation.
  * Return: 0 on success. Returns a negative errno on failure:
  *         -EEXIST if the token is already used.
+ *         -EBUSY if the file descriptor is already preserved by another session.
  *         -EBADF if the file descriptor is invalid.
  *         -ENOSPC if the file_set is full.
  *         -ENOENT if no compatible handler is found.
@@ -276,6 +277,14 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (err)
 		goto  err_fput;
 
+	scoped_guard(spinlock, &file_inode(file)->i_lock) {
+		if (inode_state_read(file_inode(file)) & I_LUO_PRESERVED) {
+			err = -EBUSY;
+			goto err_free_files_mem;
+		}
+		inode_state_set(file_inode(file), I_LUO_PRESERVED);
+	}
+
 	err = -ENOENT;
 	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
 		if (fh->ops->can_preserve(fh, file)) {
@@ -286,11 +295,11 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 
 	/* err is still -ENOENT if no handler was found */
 	if (err)
-		goto err_free_files_mem;
+		goto err_unpreserve_inode;
 
 	err = luo_flb_file_preserve(fh);
 	if (err)
-		goto err_free_files_mem;
+		goto err_unpreserve_inode;
 
 	luo_file = kzalloc_obj(*luo_file);
 	if (!luo_file) {
@@ -320,6 +329,9 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	kfree(luo_file);
 err_flb_unpreserve:
 	luo_flb_file_unpreserve(fh);
+err_unpreserve_inode:
+	scoped_guard(spinlock, &file_inode(file)->i_lock)
+		inode_state_clear(file_inode(file), I_LUO_PRESERVED);
 err_free_files_mem:
 	luo_free_files_mem(file_set);
 err_fput:
@@ -363,6 +375,9 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
+		scoped_guard(spinlock, &file_inode(luo_file->file)->i_lock)
+			inode_state_clear(file_inode(luo_file->file), I_LUO_PRESERVED);
+
 		list_del(&luo_file->list);
 		file_set->count--;
 
-- 
2.53.0.851.ga537e3e6e9-goog

