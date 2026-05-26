Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FA3AB27F
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826108; cv=pass; b=ZgKfOJWOcdtaudOj2qvcOl6WNrplFcLSkMWyEtXn9f6U9LJgseKR9e6kdNciGLC+jpgpxNL5PPugMmVmEk5wL6ao3K1WDjjWNgNjkGS9OK9zgjf/5vxR6M8IPsV9ESNjxMGi+NBpGI5RjTDvrIg9fBTB82a++vDgwNYri4KQyMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826108; c=relaxed/simple;
	bh=Rlp7ptvGdOPEvwH1H0sCx96syeuaJe0NnVj/weJyjpU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFH11ERhyhUKdCokac0Xh79+934buJWyCbft4Oo/XNeRQHmy1kdgELycOMkcOeTIRo9p+d4Ic/My4o8JAZlrFWImu1V9B48tnCmz6lccIoLQ37j24dFsugZ7OFZVLPgYB57BEDq4mHfSuki1MN8KGWDLyl9L8ZtjkaD72rKaHlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=I7BD/ihd; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="I7BD/ihd"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bde9d73678so112727697b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 13:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779826106; cv=none;
        d=google.com; s=arc-20240605;
        b=kOHeHOYCUi4OZ3STXed9NCqisT2qVAn0/dnEKtJGFUvjpbVvWzegcPmVghRzi0mH2y
         rl3JXsKEn7donEDTY/wNZygo+SCsKnzF2qWIkpOJ+papao4BuC42POr0Z1qmQo7UmqVd
         adxP4I9XzudeUBiq1vVRoCiCdXt9IshDn3WQyKmJj+cNfZ7utbT8WOWCee0u07PoiFNl
         2BJ9Qw/t58IYOJjPDODPDKPZo8bL5xcd/u4GRiA2MB+exdRWsP7adx7ZS03TgbQu4Rvk
         MjIVlOYxf7qGLqA87VxAL/9yWyn+jMXT/va0p8jdHu/DDVB7Xt2KysoGiRGDmxTCbABf
         6qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UAr1plF6602l9mOlJseQlxt0GW0eM2OrV/U6+hqix/0=;
        fh=WN/3YJabA9d9poNPa5axj+oIMiO4Osd+2MIx5vWkyB0=;
        b=IQ1GumVd6V1FFMRD5GT/LSO3DI51YPJWlrT8AQdA5Exc9J4iVBO+/5GhFiqcTDNhkV
         mHiIwO0cdpaEszPgkq6wZe1oB+bl/V10oRyXU4mLDlyAEkpEEsvxnZ8oHXOkyHurC365
         39manLVrG1YVXmMx/NLeMmG2Nwb11rf+a1XKzj384zC8XPIWz8jX03D7wQClM7H6OqZ0
         tMqepotY+WvdeO0IoNUxStGsNrYsPra/WPSBXtGXm80/NT4GiN2eFCXBpBsH2KgzkwaO
         +DCjSB+lZjXjh0xucvua6fgF15Krc7Q7yYc4Uzdsh6DOYMxmw7LQB+3/GDjosxdiuyXp
         F6DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1779826106; x=1780430906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UAr1plF6602l9mOlJseQlxt0GW0eM2OrV/U6+hqix/0=;
        b=I7BD/ihdFrPfk84YAHWmctOCM0s+Rag7QcZX5haRj9QhvXuxXJ/lwIIKuTSQ3ZJnzB
         HpOtobR2qs3WMDrFO4SCmxZ8742Oh2ZnQTHyTf7Fgkz9EK/Q1u4OBmOj7nOw7m7umTk7
         O/F54xrvNb3JvrqafZAr0FehwO2dEYogrzxHLBp1qdECZUQX2WfAZefwaFOTKMkruOom
         HDapWWufeTuVni8HYZ1iJG7TJgAnKCm8WHNPbq/TjYFntfOnEwgQ8c4qdCjXKlpj+Nix
         vlrOz48O+NjASMI7LJaG0eYkGzUWLX8R8hQv+EtwgrJxnhcVUqoAr/lX/Ua+t/Zd/w3x
         oy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826106; x=1780430906;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAr1plF6602l9mOlJseQlxt0GW0eM2OrV/U6+hqix/0=;
        b=P9tyA4+OKDqPIY6cc0ZsLIKtRIPYx1RGq4oAc0WrejghIjwEByQZAtuwP1htN037Rf
         eW6q91Cx/xShBWuepsSdGW+eQDb3z3/e1H2JfIPBj8Jea+mydAK8XO1LQO2xiJlspIk9
         VF6D1TQmCgs8JuIhu2LHEf2JYXlELrWcFJVypgYjRNb5qd0CDUvo9qmdMB6JzTc2stQU
         aX7BR09Y5IooL0YN/FI7zJrBQSjTbIegYOAetNJu+yufM5yQ9+Ag+zBnwfR5AR6CgfjR
         E1PLv7eYrGXB+pWoeH7cIKqQiTqLK4NqsmLhcLhQLSsvc79c/oxqxbDYPpVZp2/v0Mwa
         Liww==
X-Forwarded-Encrypted: i=1; AFNElJ+wlkJj3N6PxbM8mEdpOBH72rp2g1kh4bWEXce+X82N8v32KWnkN5dV1SGesW+XBRmoPyQAJc/Z6/66m5sd@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNZyQbPbyUKGkn4YerkYOgkwbX0boEYw06iA4VTl9vdCYGf9m
	QHRpaIYKKdfYie9iB4aRgdhEADbNJI0BGyb3Vpewq0XFQ3H8O/XjCUeOb3k8HoU3gVEGRapbZXo
	ke2gTBnDcWob58CCP0eSRgSf+907CS481NjAU78Sm
X-Gm-Gg: Acq92OG4cLAei/abNIawdT2oYQg+YOHP5GWo4XL6kWHEbm4AuOE1SbBk1s9wq2zzTrK
	rsub4wQLvv5Ag+uQwIhBIoYHtOyUzyy6kIgzF/F7qz6gnK6Lzltbi9uH6BvgBl1JujeT1y0gNsy
	vWYpj4BYCNJHY/UNyWfuG1ffYBpT+W4pz4Xy3lp1BNk7aSlG8Gd3HofJqBt1K+URWxkT1G3uesP
	QKuVg0fRBQ8ESQ7pusqvNqFO6BytOYV1Q7kdXENZ83Vp5CxmX0sl6VhifvlRoe5JbcBOyDMcaQy
	okU4pJKe7Q==
X-Received: by 2002:a05:690c:46c1:b0:79a:b49a:cb4e with SMTP id
 00721157ae682-7d355e31731mr165356687b3.6.1779826104834; Tue, 26 May 2026
 13:08:24 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 16:08:23 -0400
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 16:08:23 -0400
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+0ovCiA7huMwMxvWgC8km2P+gJwd-jax+ACo=EbGrJ6FVp55A@mail.gmail.com>
References: <CA+0ovCiA7huMwMxvWgC8km2P+gJwd-jax+ACo=EbGrJ6FVp55A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 16:08:23 -0400
X-Gm-Features: AVHnY4Lznba3h-1sWnAHg7p6Ba1LoCTNt8ov451l1mLyC8_T4wgN1wSwBMgq_fw
Message-ID: <CA+0ovCgDzWA0w83WsW0r1eUKKejt7NTHK+c-=r1GkzJD0__6sg@mail.gmail.com>
Subject: [PATCH] affs: split hash-lock subclass and reject self-referencing
 dir entry
To: David Sterba <dsterba@suse.com>
Cc: Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

affs_remove_header() acquires i_hash_lock on the parent directory at the
top of the function and again on the child inode inside the ST_USERDIR
arm, both via affs_lock_dir() which uses SINGLE_DEPTH_NESTING. Lockdep
sees two acquisitions of the same lock class in the same task at the
same subclass and warns:

  WARNING: possible recursive locking detected
  syz.2.17/3573 is trying to acquire lock:
  ffff888123db0778 (&ei->i_ext_lock/1){+.+.}-{4:4}, at: affs_lock_dir

affs_remove_header+0x72f fs/affs/amigaffs.c:296
  but task is already holding lock:
  ffff888123db0100 (&ei->i_ext_lock/1){+.+.}-{4:4}, at: affs_lock_dir

affs_remove_header+0x261 fs/affs/amigaffs.c:289
  Call Trace:
   affs_lock_dir fs/affs/affs.h:311 [inline]
   affs_remove_header+0x72f/0x1ab0 fs/affs/amigaffs.c:296
   vfs_rmdir+0x20b/0x6a0 fs/namei.c:4446
   do_rmdir+0x2ed/0x3c0 fs/namei.c:4524
   __x64_sys_unlinkat+0xf4/0x140 fs/namei.c:4692

With panic_on_warn this terminates the kernel. The two lock instances in
the report are distinct inodes (db0778 vs db0100), so what lockdep is
reporting is two acquisitions of the same lock class at the same
subclass -- a missing subclass distinction in the annotation. Trigger
requires the ability to mount a crafted image (CAP_SYS_ADMIN or
equivalent) and is reproduced by rmdir() of a subdirectory under a
crafted AFFS image.

The same locking pattern is also vulnerable to a strict self-deadlock
on a crafted image whose on-disk hash table contains an entry with i_ino
equal to its containing directory's own block number: affs_iget() would
return the same in-memory inode for both d_inode(dentry) and
d_inode(dentry->d_parent), and the two affs_lock_dir() calls would take
the same mutex twice. No lockdep distinction would prevent this since
the same lock instance is acquired twice.

Address both by:

  1. Adding affs_lock_subdir() that uses SINGLE_DEPTH_NESTING + 1, so
     lockdep can prove the nested parent->child acquisition is safe.

  2. Rejecting the case where the parsed child inode coincides with the
     parent before taking the second lock, returning -EIO under the
     existing done_unlock path so all previously-acquired locks are
     released cleanly.

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Closes: https://lore.kernel.org/lkml/CA+0ovCiA7huMwMxvWgC8km2P+gJwd-jax+ACo=EbGrJ6FVp55A@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
 fs/affs/affs.h     | 6 ++++++
 fs/affs/amigaffs.c | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index a0caf6ace860..c4af169294ed 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -313,6 +313,12 @@ affs_lock_dir(struct inode *inode)
 	mutex_lock_nested(&AFFS_I(inode)->i_hash_lock, SINGLE_DEPTH_NESTING);
 }
 static inline void
+affs_lock_subdir(struct inode *inode)
+{
+	mutex_lock_nested(&AFFS_I(inode)->i_hash_lock,
+			  SINGLE_DEPTH_NESTING + 1);
+}
+static inline void
 affs_unlock_dir(struct inode *inode)
 {
 	mutex_unlock(&AFFS_I(inode)->i_hash_lock);
diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index bed4fc805e8e..fefc2bb11d43 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -293,7 +293,11 @@ affs_remove_header(struct dentry *dentry)
 		 * i_hash_lock of the inode must only be
 		 * taken after some checks
 		 */
-		affs_lock_dir(inode);
+		if (inode == dir) {
+			retval = -EIO;
+			goto done_unlock;
+		}
+		affs_lock_subdir(inode);
 		retval = affs_empty_dir(inode);
 		affs_unlock_dir(inode);
 		if (retval)
-- 
2.43.0
