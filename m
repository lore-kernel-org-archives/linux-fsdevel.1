Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768937C90F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354256; cv=none; b=F+4iUc024VhdSrsrT84W5iLo57czbl/9VPZ+WzuvC5byvEbUOTtWWjW00CDRot0CkY5QGNoe5BzmsCwoLZNllbLeL5Kzipe7/rG/shw/jpHTVkuhAt81wUWiMBkFOvBJsYTU8hiyCQYByjIUluLiFucxG5FWP3roK8wSS+oFVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354256; c=relaxed/simple;
	bh=H5yUNGmr3Aofw0RsQ85oedlEqimTgluIr9D9n1UacwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmU76q3JQg67f5WuzpQl40qzEeI3Y9Id5wagoeKvz9K6t5genPa8SGlAJaJzObB9++4WB9Ztq2xo7gRLuAtPsX5JdRkHb6Pe4O3RMrkNdtdzJQCB1onZa9PHJBOtIC7G7ICd7O7WO0uo8FVgIIb/5/7Tcq17sdbDB+DugC0kXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCamS0oh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCamS0oh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d560775ca2so8463425ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791354253; x=1791959053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eldn3SZXEz251aQtu8wp0lwT440swzXtTcbwTv8zgRM=;
        b=tCamS0oh8c+NVn4PVl/SLc8wWBt5hfxZ35TujCOeZ6ecW8xHqkjx/lvr7yf9zqW0KM
         GzsyHjU5iLQlcTSW/EfO1dZAAQvWJv6V0fAzsLbpvesxxJU+ItyfNa9dQFnYusRLQs29
         js5fgzPHYLDessrpHg8sgrdtotfQsh1gCEFLDVKwahK1TjM6Iptd5nH849rm+Z2OlYds
         yPNOWg37Qi2tEhmgFDhsCMrYyb75Ajvgcw9y/N3aS+qooB5MH17sLLrawIHLQPCgx/C4
         F1q64SPYByQS0Of9HGR3U/HJgOyX+arfmz/hqwjNTTfvxrbHVZkdM7zzUkSXdnovt8oN
         JH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791354253; x=1791959053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eldn3SZXEz251aQtu8wp0lwT440swzXtTcbwTv8zgRM=;
        b=BN2hS+1VOb7wCPQRRtqQtdLZqmJtyCLHsBec5voqpwm60NRYmtYhRcj1Ti4WMxIHdh
         PAYcwnNaF7CLbiJU8+FtPMLU6WgENQlWb2uUKwrUSf2hc73Jr0+NLpDUbXtFCpz7MPlv
         QK+Hc9RIQa9hbYMYNjSIKPTp8D3F68L2pr3xqBxm+LDoAC/O3TX6ymOG003f+6V23+JZ
         kGoHagXJrVYisIXXlQ0xBnIGA5zgCu17+l2JyJp7GmjVXTudsRoaULV9cDAuU1zwj72D
         Nud6O0cal0q/LWscPDnCo9It26gHHCTe7e7UTnLUtDFL1LvgzM/np9JnxAXdlBqSMOG5
         Pkzw==
X-Forwarded-Encrypted: i=1; AKwUvBxuFyizXb8u5tWf58989FPX4cHze6PJ9B+VTS2g/fYPUvoIDVllXRovFKNggGkNmXkkoytSTzwd7RRBS3rM@vger.kernel.org
X-Gm-Message-State: AFq9FYL6mWr60bQ1jBQKolCdz45JzVG3LDwnBVmbT48GDNj8PCq4QX8E
	TR9OSqG8OgFnIsbv2WuOqPWuFSJTin4MG1UyyA5BJtWQiRkYyybl+kIK
X-Gm-Gg: AYBFou0+fbqkWAqPKKeyszbztH773P2QbQscX9TyuNdE3z3ccjkPzcpY4L88qIQyyzM
	tbXW0SdVP+1k4F5Wch+PWPctf6C89JRf7mUiAIISdBXlRL45uvjaWpScntzP9CmGvrjiE8lvmc0
	r9bVXQM0GCJKh+YziWaI+vxtgzM2+SdXR06GUYaSjPAFuxjSwSZkW3j/Wgk9geUcM3gT9fO2zWo
	ThCy8ZtGjdglrimIKa+oDIB/bB/W7F0tEMP2O5DevXMrmLIcT/k6Uww19ITEn8+OFURyLwk5ONn
	F9bgIzlz79y1p51dTWmDWR0jAb1D+zlytxlhbeind0ubCbc6896pKMh9YnrML5wDZ3y2vtXpnGf
	VNfqCgGXAGQnPQHqa2iuI96QGmFCklghUh77nB1sMBZuaDrsUjNkdBAzJCdKVvPAqeb6H60g2jg
	zbKMCwk6wJePEtxydNxIvYKGC/rQFCGihKp6L+0Y1ODK76DFUV3JmIf1RoCUdQgxQlEZDc4A==
X-Received: by 2002:a17:903:1ae6:b0:2dd:c100:4b87 with SMTP id d9443c01a7336-2e600580aeemr13377715ad.62.1791354252844;
        Tue, 06 Oct 2026 23:24:12 -0700 (PDT)
Received: from [10.1.2.130] ([67.185.120.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482ccb3sm5303515ad.51.2026.10.06.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:24:12 -0700 (PDT)
From: Kir Kolyshkin <kolyshkin@gmail.com>
Date: Tue, 06 Oct 2026 23:23:56 -0700
Subject: [PATCH v3 1/2] mount: add OPEN_TREE_DROP_MNTNS_MOUNTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nsfs-prune-rfc-v3-1-adb97ea52868@gmail.com>
References: <20261006-nsfs-prune-rfc-v3-0-adb97ea52868@gmail.com>
In-Reply-To: <20261006-nsfs-prune-rfc-v3-0-adb97ea52868@gmail.com>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 "Eric W . Biederman" <ebiederm@xmission.com>, 
 David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Andrei Vagin <avagin@google.com>, Shuah Khan <shuah@kernel.org>, 
 Giuseppe Scrivano <giuseppe@scrivano.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 containers@lists.linux.dev, Kir Kolyshkin <kolyshkin@gmail.com>
X-Mailer: b4 0.14.3

A recursive open_tree(OPEN_TREE_CLONE) copies the nsfs mounts of any
mount namespaces pinned below the source.  When the clone is attached
inside a mount namespace younger than a pinned one, move_mount(2) fails
with ELOOP from check_for_nsfs_mounts(), per the rule from commit
8823c079ba71 ("vfs: Add setns support for the mount namespace") that
prevents mount namespace reference loops.

This breaks container runtimes that use OPEN_TREE_NAMESPACE, such as
crun [1].  The new namespace is younger than everything else, so bind
mounting e.g. the host root fails on any host that pins a mount namespace
(snapd does, under /run/snapd/ns).  By the time it fails, setns() has
already run and userspace cannot recover: the host tree is out of reach,
and the offending mounts cannot be unmounted from the detached copy.

copy_mnt_ns() and create_new_namespace() already leave these mounts
behind; only get_detached_copy() copies them.  Add an open_tree() flag to
drop them from the clone, as suggested by Aleksa [2].  Locked nsfs mounts
are dropped the same way copy_mnt_ns() does it, so nothing new is exposed.

Keep it opt-in: open_tree(OPEN_TREE_CLONE) plus move_mount(2) is how
mount --rbind works through a file descriptor, and in the caller's own
or an older namespace such mounts remain usable.

The flag requires AT_RECURSIVE, since a non-recursive clone has no
submounts to drop, and OPEN_TREE_CLONE or OPEN_TREE_NAMESPACE.  With the
latter it is a no-op, so a runtime can pass it with any recursive
open_tree() call.

Link: https://github.com/containers/crun/issues/2262 [1]
Link: https://lore.kernel.org/all/2026-01-07-oldest-grim-captions-spills-ywC2O3@cyphar.com/ [2]
Assisted-by: Claude:claude-opus-5
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 fs/namespace.c             | 16 ++++++++++++++--
 include/uapi/linux/mount.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ae5dc64f8b45..bb776622a4aa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3062,7 +3062,8 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, unsigned
 			ns->seq_origin = src_mnt_ns->ns.ns_id;
 	}
 
-	mnt = __do_loopback(path, (flags & AT_RECURSIVE), CL_COPY_MNT_NS_FILE);
+	mnt = __do_loopback(path, (flags & AT_RECURSIVE),
+			    (flags & OPEN_TREE_DROP_MNTNS_MOUNTS) ? 0 : CL_COPY_MNT_NS_FILE);
 	if (IS_ERR(mnt)) {
 		emptied_ns = ns;
 		return ERR_CAST(mnt);
@@ -3204,7 +3205,18 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
 		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
-		      OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE))
+		      OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE |
+		      OPEN_TREE_DROP_MNTNS_MOUNTS))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Only meaningful when a tree is copied recursively: a non-recursive
+	 * clone has no submounts to drop.  OPEN_TREE_NAMESPACE never copies
+	 * pinned mount namespaces, so there the flag is a no-op.
+	 */
+	if ((flags & OPEN_TREE_DROP_MNTNS_MOUNTS) &&
+	    (!(flags & AT_RECURSIVE) ||
+	     !(flags & (OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE))))
 		return ERR_PTR(-EINVAL);
 
 	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE)) ==
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2204708dbf7a..ac865edac517 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -63,6 +63,7 @@
  */
 #define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
 #define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
+#define OPEN_TREE_DROP_MNTNS_MOUNTS	(1 << 2)	/* Drop mntns mounts from the clone */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*

-- 
2.55.0

