Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445672F8EA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983456; cv=none; b=NHPseMr+ECkSRy3t1cnJsZKVvvSEgptn3nuWLVQHuFXn2OoUBN4Uz650QueiySeSr6y6InmpNfiGcDI3Os/OH4+zRIUhQzn6eYkpx6fI0311s6Br/kF19RGDyehD9Y8gUf83AHcFgAmrUioBS5gGDvWIQqjTJ+aNkykxCusQ1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983456; c=relaxed/simple;
	bh=I48LyXxTdxXxQ1cyphtRSI0QVP19kxuOc3W7VYOK1lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTZf9L/pe5D1vtqabumIGy+ANRVOvtJ/gnwZufs2TtQzk4XfFiT+yDbw4CMTghvafJUmzw18W7WjPua8K1dXdceRpcQCGO3oAxCXKW3kBDPuCAOA8aD1+mTYNqnqjhQLog74tm0bJu+CAi3hf6lUIiBj0u3ct5rxBnaLhct16G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpoHSi73; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpoHSi73"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so25590595e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786983452; x=1787588252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o6/t8/4N3XQWXCm14IpoEgljHMU303esyG3KYaRnKWg=;
        b=dpoHSi73iwBZvlJY2UbLVl4ycLfJiYp8/0ecTQMsFMQjKd8r4FfeIoR3CKUf2gPE8f
         SP9YnOQ3NZUAdL1+rNODsmL9wk5NsHVlSpAzMAqocz1S9jZUFwh/62QNj5hiOvfrWZGl
         BrKYUExA8MetQ008sy4pg9WL32yrdt3w6+WKScpwv6NWEaBYcb8CaJLi+JcozsKL4MNs
         gqjUHigF23TOETcAM2dHwEuHPtUBNlUvrmVlA8PIvn9Io5r6UZaKmmPPND0e8hvReygb
         Spua+dyJHutk3fsHICXGyH6Bdx7xU+LdUk9Aw75Lll8ByZqnH9TdHU0zse9yeDuejMGe
         yFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983452; x=1787588252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o6/t8/4N3XQWXCm14IpoEgljHMU303esyG3KYaRnKWg=;
        b=bvQoXWIFmOT1Wy0IfVzP/X4vUNMJSnwXqXE774z6/TDrvtAalXdK3hho8TsuTRIhP+
         jTWmdDfWgnwFFHHVW+VwlgQsppxaEzhZxXm3sJ3WiMydqS8eVGiwgb8hapwck9nScHtQ
         66xIJxQjgmWCRtjswK9QzUHfWKG9Mbpo2X6O7+8+bQUkM36mPTM3/y5/AUSe1GaCAQL5
         o3q2M8V6caFTPHkr+EfWU2ZCCxsaEoNbbceWob7T9moidx41YZAYnDi7I0JxBk2nqISx
         HNyb8DfqO8SGbgmcNspoJQImkHGnMM9ZHmTrzXZUtDnOuZY8BD3knWxMy+FslZtXyS8I
         rROg==
X-Forwarded-Encrypted: i=1; AHgh+Rqo9iqSgZ627X9VZuVo3TVSkfrNHLAea5EIx5TOFjEt/9PhVHkm35Hj+Zo3q+n/EZrQ4ugd6v+VU4MW7CZe@vger.kernel.org
X-Gm-Message-State: AOJu0YySQe6t+ombsjC4UhnTJF4j0xf7DVgeEW5rNc2LvJ24M/U93j33
	eGqGDfDAjT895n9BbTvo409aoSZ+nJoarEvJWnpDP0HZGUyZALLhSI72
X-Gm-Gg: AR+sD11r7Q7EcQy2iJv+2OZ1GpTCBywWRUVUHpbJMG93DWsqdGFfrlzn2vmJ167uPeP
	axdtdhbmSLOZ9lJtA4+5EbM1npISroFYwS4JQYtBhZcbwztZ5r7Z1R2ZtbCyuVCnKz3LC5T6lYz
	m16gJIoHXHsJgj60FWRAwLZzw2YYvd9RY59jbDWRkk/SyzD8RgVYTA0w3cTTMAEgfANDG1mWJtT
	G0RK0UuPg+bz/TG7JaRD0TUOUl80zozi6MFRrZ9b0vPAY4gyzbH0s/XtbZVUJFwzOJcSPO+pjOA
	VZYY/faRCB6tlPQHCX3WKrRYEgXkL0iKHfGGPsK1yk1zx3WJt+pVhYG0Snj6uiCTLf/umzItCNa
	pBDodUv62pThyyzh4pZrk6lzKaljUk4Ipi2FgnD6OHlVyHL0DR6iIAjKCeS/4NPECRyAKuawkVx
	DHMxulFdA9W0mNjdu6vvZ2saLpNDlqvefgseeFYUSHIO2+
X-Received: by 2002:a05:600c:358a:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-4999fb940c5mr20370285e9.14.1786983452156;
        Mon, 17 Aug 2026 09:17:32 -0700 (PDT)
Received: from c.. ([213.165.253.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm355538945e9.13.2026.08.17.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:17:31 -0700 (PDT)
From: Narek Jilavyan <njilav@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Narek Jilavyan <njilav@gmail.com>
Subject: [PATCH v2] fs: do not cache a symlink length that disagrees with the string
Date: Mon, 17 Aug 2026 16:17:30 +0000
Message-ID: <20260817161730.699293-1-njilav@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817081756.4176757-1-njilav@gmail.com>
References: <20260817081756.4176757-1-njilav@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode_set_cached_link() stores a caller-supplied length in i_linklen and
sets IOP_CACHED_LINK.  vfs_readlink() then uses that length directly:

	if (inode->i_opflags & IOP_CACHED_LINK)
		return readlink_copy(buffer, buflen, inode->i_link,
				     inode->i_linklen);

and readlink_copy() clamps only against the user buffer, not against
the string, so a length larger than the symlink body becomes a
copy_to_user() of adjacent kernel memory - reachable by any process
calling readlink() on such a symlink.

The only thing standing behind the invariant is

	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);

which expands to BUILD_BUG_ON_INVALID() unless CONFIG_DEBUG_VFS is set.
On a production kernel it type-checks the expression and evaluates
nothing, so the value is stored unvalidated.

All four in-tree callers are correct today.  This makes the helper
enforce its own contract rather than leaving it to the next caller.

Validate unconditionally and fail safe: if the length disagrees, warn
with the disparity and leave IOP_CACHED_LINK clear.  i_linklen has
exactly one reader in the tree and it is gated on that flag, and
vfs_readlink() falls back to i_link with a strlen() of its own, so the
inode degrades to the behaviour that predates the cached length rather
than disclosing memory.  That fallback state is not exotic: 19 other
filesystems set i_link directly and never set IOP_CACHED_LINK, so it is
exercised routinely.

The check runs once per symlink inode setup, not once per readlink(),
which is what the cache was for.

Tested on 7.2 with CONFIG_DEBUG_VFS=n by handing a 3-byte allocation
holding "AB" to inode_set_cached_link() with a declared length of 64:

  before: readlink() returns 64, copying 62 bytes of adjacent kernel
          heap to userspace
  after:  bad length passed for symlink [AB] (got 64, expected 2)
          readlink() returns 2

Fixes: ea3821990719 ("vfs: support caching symlink lengths in inodes")
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Narek Jilavyan <njilav@gmail.com>
---
v2:
 - warn with the actual length disparity instead of a bare WARN_ON_ONCE,
   as suggested by Mateusz Guzik.
 - the filesystem name is not included.  struct file_system_type is not
   complete where inode_set_cached_link() is defined (the helper is at
   include/linux/fs.h:947, the struct at :2280), and dump_inode() is
   declared and defined inside #ifdef CONFIG_DEBUG_VFS so it does not
   exist on the kernels this patch is about.  Both established by
   compiler error rather than assumption.  If the fs name is wanted I
   can move the warn out of line into fs/inode.c, though that needs an
   EXPORT_SYMBOL since ext4 and erofs can be built as modules.
 - still refrains from caching on a mismatch rather than fixing the
   length up, so a buggy caller is reported rather than silently
   corrected.

 include/linux/fs.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 50ce731a2b..c7051cfc6b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -946,9 +946,25 @@ static inline void inode_state_replace(struct inode *inode,
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
-	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
+	int testlen;
+
 	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
 	inode->i_link = link;
+
+	/*
+	 * i_linklen is used as a copy_to_user() length by vfs_readlink(), so it
+	 * must not be taken on trust. If it disagrees with the string, leave
+	 * IOP_CACHED_LINK clear: vfs_readlink() then falls back to i_link and
+	 * recomputes the length with strlen(), which is what it did before the
+	 * cached length was introduced.
+	 */
+	testlen = strlen(link);
+	if (testlen != linklen) {
+		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
+			  link, linklen, testlen);
+		return;
+	}
+
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
 }
-- 
2.43.0

