Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010068;
	b=Nyjz5pL+skZHV3nN44ZUdCbbXh3JliP4lPFs2SIJp/q6+oZkWD0RzjYaxy5Se0J+N4nZ
	 71A/zpzRGnEv5sEHKrQZpG+SYndtjfyq5LrxrwU8SQKM8xvNqRZGh46E7M9X9POQtYFPw
	 m9t9ZXvhXXPSGEAmJNHiF0Y7K83KnVc/GVvi1VQGIkzTTKlWjTdgCfRF5ynkW1NePKd/X
	 uLTMVKcuMSwtnjzdG6cnicAfmgjHnsmlzahfDworUEDn/6EUSlfgJngpqPL86uXqi+h/V
	 8WwT43O3yuhTErTpIov9dLI9aBCKSDk5cB4WBBvDpObsEshcl/CmqntochIsl7bY5cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aH6msihzS4+D+b6XyXRPlbUTTs0aOKCq5Tr3aXC1BvU=;
	b=Wo9CTVqiNfNKr3kphMIkJRcdELHYro9Otx8PjggxJ2NBLbXRRuz5ou49gLx9XBffOr+W
	 Nn3ljKREUYM46ZlULDAduiEfZtovCEsX/w7tAozGnkt29f1cy69DeELyTeKNwJMh0K3vV
	 jfp1XUw+4ZtWIgiTwSjq4AO2zAaDdsPF5DoHT0GgwH+tNtexQ33ZKidNDEJzf/zH2or/W
	 CaacamGYJrMs5oOl6yr0o+TCEip4pbQ/qUViWNXBIWSB0kTmZUa/zjtuVC5KNYlJQoslY
	 3jLJXT1w2HE33JbWxeLc8c0/H5CKto76ply4H/+6EwdrdpOoEXaHGchpM0PIdW4X6hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtcPgidh;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7156606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7156606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtcPgidh
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so10515135e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010066; x=1795614866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aH6msihzS4+D+b6XyXRPlbUTTs0aOKCq5Tr3aXC1BvU=;
        b=MtcPgidhBljncvF99yopIprwzxnse1fQCgyXl5WWgfCBF6+aRRyk8crE0PLeuJN7xV
         +kPq8tM0YWYinYjUCVafXYEowe8F2BaCSISU+cYm6GWwVN1/skKfumK7tzfWDXZAFbHI
         GtHjx7lNC/YDfVVEfJ7dUurlbZDhhtEsGSNDaiMVytouHgdvHgLXKL0XhzhUdcEgGsWP
         UmXiZlWn/F1vv/KTOB8t/O5ocM8NQ8hoY1xLOIcCCeo9tdKwjkqCV4eM8xkkG3Awpo8S
         eB0LjR4/WgbUbVIMrFDFL7SpLzl3TTzdraO8K/H40mkXFHiJMmOibQTJrbkZyzAB2QMS
         otAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010066; x=1795614866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aH6msihzS4+D+b6XyXRPlbUTTs0aOKCq5Tr3aXC1BvU=;
        b=oQUtzTYUFVttVe7GtoiCti6pBQ63sOFxArJVzBqWgWzimDdIP7IYKp9nan8Z0d7AJD
         1wB0qbfMdexZ+V+92ZHZLqlnHS/mChPmz8tU35MLyjj8lmayprfPNEBLWgq4f8gyEPoN
         snvfNMXdHpbieNGDamsKBgultA2gy3RK/JhioaO1YMgBLYm37SQvrdXopGwKqX62ii0a
         ntDhFa3NOg+zA0XwQDcL8goKA/JFcs7Y2vtD3AlfsVOKVWUoOO4XIOhOskPShqY/1fYr
         Ln1JArAmTjWZjAKiRh454yXcm27KEGLue2udpWwhIMk4wrvj9gPUkDLTv6l2OrLLuLAq
         nFJA==
X-Gm-Message-State: APuU4Z+MvC1jNx+02GaU6mWbipuXyTJ3uPy4UR5fw6MK6QaA6pSbnpY8
	cXhW4citSEQ8swy29uU930Wk6T2nObQ/YNVEKuKH5fiE2+r6aS6Ilmw4
X-Gm-Gg: AYBFou28L/91YJldbmC0d9v1kfeNFzDbTgP/Z9Wb8P0Waxc2SwwsiquZba7wVthIX0L
	28tTkXPCLR/2TxAsVfij0HttyCsp0r8zRVMFMvXr8+4as8pMiuS/md5Vb6wDCovc5wWQ86o6Kdl
	6RS3r5meo1Sidyl0JbqPK0/V8jZgfpg7ha0O6/ELWhBMQTtTmNC2xdIhM4dC9yovXwwAD/5Jlee
	qKWvyJrPUcOaROSBahEavPuFoKnZccAnomNepfkLas3f+3eH1bxLBiQB4dqGQGXhtDCFEdXLDvI
	sBE+VLaqquLUEoKGCiQUpXJKxlakpE0hXZ1SXO68gIvmwBs4sHooOarnkmeHF+AiHNDhH7fjkh1
	rJOPF6aI8z5crQxFiXgZTxvyR7JrgKCGy8F2Ow5C9hCowhE/UmFyj4hYv5VfqvzdgBBi5hDtvOh
	gk4+9PRTCqm1GgNh7gZgIJSN0+HbwW8o4GAN5hRIkhnJrnp5gKphHT4V5KIlEetI8DbBz975FJJ
	oL/6oNyLI5pyXQ4OCy6jlHVQ7FSVwGSAkxeoBO2w0L/3C9OCb3eWDdaKyFhjrCG8Jadr1wv/LnV
	rSclMLcttPKxatimZMB4Q+ZWql/49o8T3LL2p/SHNHDpCXM31y8maXkKQT+A6RIqFX1IICkHGU8
	1VNmZtt0Gnvezq1dVv6zmXmB+Hg==
X-Received: by 2002:a05:600c:e556:20b0:4bb:7347:d5df with SMTP id 5b1f17b1804b1-4bb7dca65aamr30532225e9.13.1795010066068;
        Wed, 18 Nov 2026 05:54:26 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d28ec3asm74615325e9.0.2026.11.18.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:54:25 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH] fuse: stop stealing pipe pages into the page cache
Date: Wed, 18 Nov 2026 16:53:58 +0300
Message-ID: <20261118135359.6256-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPLICE_F_MOVE path in fuse_dev_splice_write() allows a FUSE server to
move arbitrary pages from a splice pipe into the FUSE file's page cache.
Those pipe pages can be page-cache folios of a different file, pages
written by userspace, or gifted anonymous pages. Replacing a FUSE cache
folio with such a page breaks page-cache aliasing, refcounting, dirty
tracking and writeback, and can be used to corrupt or disclose data from
other files.

The checks in fuse_check_folio() are racy and cannot make this safe.
Remove page stealing entirely: always copy the data into the FUSE page
cache folio, and drop the move_folios/page_replace plumbing.
FUSE_SPLICE_MOVE remains advertised for compatibility.

Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
diff --git a/fs/fuse/args.h b/fs/fuse/args.h
index 5173264a1261b..36ef0c6d59998 100644
--- a/fs/fuse/args.h
+++ b/fs/fuse/args.h
@@ -36,7 +36,6 @@ struct fuse_args {
 	bool user_pages:1;
 	bool out_argvar:1;
 	bool page_zeroing:1;
-	bool page_replace:1;
 	bool may_block:1;
 	bool is_ext:1;
 	bool is_pinned:1;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3641abb90d6bb..e7238eed21fb8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1099,128 +1099,6 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 	return ncpy;
 }
 
-static int fuse_check_folio(struct folio *folio)
-{
-	if (folio_mapped(folio) ||
-	    folio->mapping != NULL ||
-	    (folio->flags.f & PAGE_FLAGS_CHECK_AT_PREP &
-	     ~(1 << PG_locked |
-	       1 << PG_referenced |
-	       1 << PG_lru |
-	       1 << PG_active |
-	       1 << PG_workingset |
-	       1 << PG_reclaim |
-	       1 << PG_waiters |
-	       LRU_GEN_MASK | LRU_REFS_MASK))) {
-		dump_page(&folio->page, "fuse: trying to steal weird page");
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * Attempt to steal a page from the splice() pipe and move it into the
- * pagecache. If successful, the pointer in @pagep will be updated. The
- * folio that was originally in @pagep will lose a reference and the new
- * folio returned in @pagep will carry a reference.
- */
-static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop)
-{
-	int err;
-	struct folio *oldfolio = *foliop;
-	struct folio *newfolio;
-	struct pipe_buffer *buf = cs->pipebufs;
-
-	folio_get(oldfolio);
-	err = unlock_request(cs->req);
-	if (err)
-		goto out_put_old;
-
-	fuse_copy_finish(cs);
-
-	err = pipe_buf_confirm(cs->pipe, buf);
-	if (err)
-		goto out_put_old;
-
-	BUG_ON(!cs->nr_segs);
-	cs->currbuf = buf;
-	cs->len = buf->len;
-	cs->pipebufs++;
-	cs->nr_segs--;
-
-	if (cs->len != folio_size(oldfolio))
-		goto out_fallback;
-
-	newfolio = page_folio(buf->page);
-
-	if (folio_test_large(newfolio))
-		goto out_fallback;
-
-	/*
-	 * This is a new and locked page, it shouldn't be mapped or
-	 * have any special flags on it
-	 */
-	if (WARN_ON(folio_mapped(oldfolio)))
-		goto out_fallback;
-	if (WARN_ON(folio_has_private(oldfolio)))
-		goto out_fallback;
-	if (WARN_ON(folio_test_dirty(oldfolio) ||
-				folio_test_writeback(oldfolio)))
-		goto out_fallback;
-	if (WARN_ON(folio_test_mlocked(oldfolio)))
-		goto out_fallback;
-
-	if (!pipe_buf_try_steal(cs->pipe, buf))
-		goto out_fallback;
-
-	folio_clear_uptodate(newfolio);
-	folio_clear_mappedtodisk(newfolio);
-
-	if (fuse_check_folio(newfolio) != 0)
-		goto out_fallback_unlock;
-
-	err = lock_request(cs->req);
-	if (err)
-		goto out_fallback_unlock;
-
-	replace_page_cache_folio(oldfolio, newfolio);
-
-	folio_get(newfolio);
-
-	if (!(buf->flags & PIPE_BUF_FLAG_LRU))
-		folio_add_lru(newfolio);
-
-	/*
-	 * Release while we have extra ref on stolen page.  Otherwise
-	 * anon_pipe_buf_release() might think the page can be reused.
-	 */
-	pipe_buf_release(cs->pipe, buf);
-
-	*foliop = newfolio;
-	folio_unlock(oldfolio);
-	/* Drop ref for ap->pages[] array */
-	folio_put(oldfolio);
-	cs->len = 0;
-
-	err = 0;
-out_put_old:
-	/* Drop ref obtained in this function */
-	folio_put(oldfolio);
-	return err;
-
-out_fallback_unlock:
-	folio_unlock(newfolio);
-out_fallback:
-	cs->pg = buf->page;
-	cs->offset = buf->offset;
-
-	err = lock_request(cs->req);
-	if (!err)
-		err = 1;
-
-	goto out_put_old;
-}
-
 static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
 			  unsigned offset, unsigned count)
 {
@@ -1275,16 +1153,9 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 				return fuse_ref_folio(cs, folio, offset, count);
 			}
 		} else if (!cs->len) {
-			if (cs->move_folios && folio &&
-			    offset == 0 && count == folio_size(folio)) {
-				err = fuse_try_move_folio(cs, foliop);
-				if (err <= 0)
-					return err;
-			} else {
-				err = fuse_copy_fill(cs);
-				if (err)
-					return err;
-			}
+			err = fuse_copy_fill(cs);
+			if (err)
+				return err;
 		}
 		if (folio) {
 			void *mapaddr = kmap_local_folio(folio, offset);
@@ -1920,9 +1791,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		if (!smp_load_acquire(&fch->initialized) || !fch->connected)
 			goto copy_finish;
 
-		/* Don't try to move folios (yet) */
-		cs->move_folios = false;
-
 		err = fuse_notify(fch->conn, oh.error, nbytes - sizeof(oh), cs);
 		goto copy_finish;
 	}
@@ -1966,8 +1834,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	set_bit(FR_LOCKED, &req->flags);
 	spin_unlock(&fpq->lock);
 	cs->req = req;
-	if (!req->args->page_replace)
-		cs->move_folios = false;
 
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
@@ -2068,7 +1934,6 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				goto out_free;
 
 			*obuf = *ibuf;
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->len = rem;
 			ibuf->offset += obuf->len;
 			ibuf->len -= obuf->len;
@@ -2083,9 +1948,6 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	cs.nr_segs = nbuf;
 	cs.pipe = pipe;
 
-	if (flags & SPLICE_F_MOVE)
-		cs.move_folios = true;
-
 	ret = fuse_dev_do_write(fud, &cs, len);
 
 	pipe_lock(pipe);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d5e1cb53d86a6..ab955e4c3e5d7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1096,7 +1096,6 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 
 	ap->args.out_pages = true;
 	ap->args.page_zeroing = true;
-	ap->args.page_replace = true;
 
 	/*
 	 * Don't overflow end offset.
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 4b412a76225f8..a90ce26ded319 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -326,7 +326,6 @@ struct fuse_copy_state {
 	unsigned int len;
 	unsigned int offset;
 	bool write:1;
-	bool move_folios:1;
 	bool is_uring:1;
 	/* set when the payload is zero-copied. folios are filled in place */
 	bool skip_folio_copy:1;
