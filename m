Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116127;
	b=Fxt9eEcPlCA1CLmlkr648InBqMN2IP5PqslnrsGQYiEJTibfDsnXlTF25+P2jfkNtixo
	 BBYPVp7EqMbCCytnjedVXxuC1VpQRrRYNqursYRU8oYZ28AMRowuHsWBGhUoKEuMbMUtZ
	 xcz0PojqSzmWyd3Fhd59LDmCmY6U/fyMyglmT5aUsjtD8pnJfqn0Xd1HpG72YkGMf+RrB
	 +h8Cxsf6/T0AOUu+Zw2edf+QDabQppG+76UYavYf7IVXOTcBFXlcKsiB6SnRdHRixiSic
	 LVe3unHXI4q26lJBr5z2d4Ryx1MwiT1SD4HUbiBwyg5d2uB2cUYIDmwyxsJx8qhU/4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=sKSxpidMSdQT3UMbZpQN/WSw4DkHB/UKT0GZsfYkc1s=;
	b=lOarc60qS17d0CTJCFLJfgLSFk5kILJFC+lnsRGXq8iikyn7t6F6A6HO2qY9KBvGLDCB
	 prruzbi/Hl5FZcrtlQFkwaAoGt2IwLRZEoGTTfySSJ0oUUHNi5UmPANhtuzyKU+dF/b/k
	 GR+EfrD9QAJ490fPX3SD948+ZhSGU9JYDViCxWl4Lc1C8NMiZTgypcTekj730pwMpeSmp
	 +ERsC1xBBcJkRoY+BM3XSHwyoagKn+aqtx/4e0wRe5ReCGElZeNBzaN8RnqLQ4Wcoq3XX
	 G/9yT8kRUFXBWcIPUd5YG/D+ck4SJO7bQPzsY40KVwAf6N6lU7Y1Ns/dQDUUbOAWeMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HivBriA6;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F5606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 774F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HivBriA6
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so31736f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116126; x=1795720926; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKSxpidMSdQT3UMbZpQN/WSw4DkHB/UKT0GZsfYkc1s=;
        b=HivBriA6GBsT+51URSA4GEW6rY7T0KnjjOLeWNtV+hlmGVieqsoSSHasfrldZl10wO
         cxx5tofhOpJkbfpsLYbX1Aw3KIi2Wf4LbIYBNvGJopxjFMHSF4KRKOw22Ts1LvttegHW
         31YrllRhqLC/w++eJQUBKxFfgjq/CPexjeugmtGgMFfUjQUVvGFuVSBzw2R4UaAx72+G
         cNGi3oi3hAHT7/07J1nepLIxNla3Gx/wb4K5lq/erCVgHPCVO5GqG1VcDnxlX6sVaWNR
         J3bbeHQpDpWjvUB4/gK5mF28Gc0guUOR6nEpqhJ7cazQNbmo1z2BgLZpnxY1rV25kVV8
         anPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116126; x=1795720926;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKSxpidMSdQT3UMbZpQN/WSw4DkHB/UKT0GZsfYkc1s=;
        b=HLI0Wjr2bPpdUKmGpe9w3Tvu9Vj2vSYHt0dVkDyYwJB4qFgusY5KT/JF5JvQPsFyPE
         qvWs83ppONkb68g2RHpxWtP0P/44K2o0TTkKEeZ5vJKkhCkZ7qLljREhPDbenOy4CsK5
         44H4QS9g546WZoThmi2DbEuj2WkuXtAbQk37e1V/Z5d4Mmyhgov1aKY3/A6GtHLm74Nm
         85l4wDJGfDz3uHriJFzNWGNbb8vlqjzNxKfjiJh3Y7WK3912J5rkD6y8h9d4vmj0OH8X
         5JwI155jb2CaguB/9sVLp1bkJ+Me30EYqNCPFPX5iprHeqh+1fAKuUuFptP9Gdu6xIJY
         LxSQ==
X-Forwarded-Encrypted: i=1; AL+hErEZ/r1e6P9XJ6GiG8QiiNAR5OcEa2lLvccNsgmIhvWwZMso3gJE8UybUlC1v38BlJ9XLyCkcYCL/BE+LUsI@vger.kernel.org
X-Gm-Message-State: APuU4Z9RZQudKzBZO0OyBR9LB79dJI21DcqQdkNSGuiU13GTMN6TezPQ
	4vKZHs2SwAn53hXOhNCH6IxM7BjlXU2AS8qlDqVjjnCkuljBXPZzYR2w1ZO9eX+AyKwcBGpPhQ=
	=
X-Received: from wrrf12.prod.google.com ([2002:adf:f98c:0:b0:4a3:f307:7cdd])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:428a:b0:4a9:dcdb:2e11
 with SMTP id ffacd0b85a97d-4abb8406ea4mr760517f8f.41.1795116125671; Thu, 19
 Nov 2026 11:22:05 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:04 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192204.2648126-1-dmnk@google.com>
Subject: [PATCH] xattr: require inode owner or CAP_FOWNER to write user.*
 xattrs on sockets
From: Dominik Maier <dmnk@google.com>
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	dmnk+artist@google.com, Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit dc0876b9846d ("xattr: support extended attributes on sockets")
enabled user.* extended attributes on S_IFSOCK inodes so services can
publish protocol discovery metadata (such as user.varlink=1 or /dev/log
structured logging support) on bound UNIX domain sockets.

However, connecting to a path-based AF_UNIX socket requires MAY_WRITE on
the socket inode, so public system daemon sockets in /run and /dev are
routinely created with mode 0666. Because xattr_permission() allows
S_IFSOCK writes without checking inode_owner_or_capable(), any
unprivileged local user who can connect to a 0666 socket can also call
setxattr() or removexattr() to overwrite or delete the daemon's user.*
attributes. Moreover, on tmpfs mounts such as /run (where unprivileged
users normally cannot create files), shmem_xattr_handler_set() uses
simple_xattr_set() and charges each attribute against the superblock's
sbinfo->free_ispace pool, allowing an unprivileged user to exhaust /run
inode space via a 0666 socket and cause -ENOSPC for privileged daemons.

Require inode_owner_or_capable(idmap, inode) when mask & MAY_WRITE is
requested for user.* extended attributes on S_IFSOCK inodes, matching
sticky directories while keeping unprivileged MAY_READ discovery intact.

This issue was discovered with an AI-assisted code review tool (ARTIST)
and reproduced in QEMU/KVM on an unmodified v7.4-rc3 kernel without
kernel modifications or error injection; a standalone reproducer is
available upon maintainers' request. The fix was compile-tested with
-Werror and checked with checkpatch.pl --strict; an equivalent fix was
verified against the reproducer in QEMU/KVM.

Fixes: dc0876b9846d ("xattr: support extended attributes on sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 fs/xattr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 0705801..0acea1a 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -152,9 +152,9 @@ xattr_permission(const struct mnt_idmap *idmap, struct inode *inode,
 	}
 
 	/*
-	 * In the user.* namespace, only regular files and directories can have
-	 * extended attributes. For sticky directories, only the owner and
-	 * privileged users can write attributes.
+	 * In the user.* namespace, only regular files, directories, and
+	 * sockets can have extended attributes. For sticky directories and
+	 * sockets, only the owner and privileged users can write attributes.
 	 */
 	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
 		switch (inode->i_mode & S_IFMT) {
@@ -163,13 +163,13 @@ xattr_permission(const struct mnt_idmap *idmap, struct inode *inode,
 		case S_IFDIR:
 			if (!(inode->i_mode & S_ISVTX))
 				break;
+			fallthrough;
+		case S_IFSOCK:
 			if (!(mask & MAY_WRITE))
 				break;
 			if (inode_owner_or_capable(idmap, inode))
 				break;
 			return -EPERM;
-		case S_IFSOCK:
-			break;
 		default:
 			return xattr_permission_error(mask);
 		}
-- 
2.56.1.750.gf70dc682cf-goog

