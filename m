Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81713FEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675304; cv=none; b=kjoh/AeMyky4D4qNs9zsttyR1a+aUTG1S/kCmwnDWLyKeKrV+GZogPzRAQd2NYnfnSEBXW7jzSzUBa2kJLjrCRCMLZbo8MYzYVukoFde09AmJI/GfzQN1R4hO7THyfLcEoEXthHaTB2N0/DYki+itlffQf3vrHE9JnpoIBiQtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675304; c=relaxed/simple;
	bh=kb8hjY/3GbCIKHPmXiRjeyjyJtS8xD8BUXG7R2aM3sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3h9V83Xyd7OhEHpe7W1TP0BkHb+wTdEI2wBwJgwtp0Kgwi/DbY7RsDnUteXlH1twgJ+GRnFIJaduVXTzdcIr7dc0M0Zbt/69Xxw0zRyLeL/hGZnQGJpF63iZxB6UiJWZrU9l8SHtjOfqYNgRHr4VSHRssjyeWg4rdRb1xAb9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9fDjAYD; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9fDjAYD"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34ac03639e7so630167eec.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675302; x=1791280102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hd2pDaQuHkOifvuoX51kyffsT4qd3/Uun46tkq8lzb8=;
        b=T9fDjAYDs/3PAClv3G8qeBFrijeSUvX7d5d3aLtMX97NghYY3mbhnLPnPLQxHbVpH/
         dE3lx+KXGxCDqb+9FuB+x/0w97QQixM9U2SOCFCc/jcxhYQc6e8H1FXC4S3E9daB1vU0
         8YMRFSYPDmz6XVjeB3KarnDetJjeltCz9/I8C/Q8rWOvx97une483VNtmE3DKOAcq3/n
         U2U8ykwtXFXgQA5j8ltETNSX6rHo5VYWq1nX1643al0xmlY8Go/PZyad+TxE7x5LQl6g
         sMnOqGLikLSLJrTqT6HIXE7E7f84UpZOaGJ1jVw2Kz1jUksH3EO7njLaCb05WTZ85rB/
         h6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675302; x=1791280102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hd2pDaQuHkOifvuoX51kyffsT4qd3/Uun46tkq8lzb8=;
        b=poSAcCWw8cSUHmI4vvX5tMtlv+bpINmewhxhtnT+/P+fsVEhupfqxxa7mAzHZSckbC
         pOZujXHGbV4bXeyzmbV9hL36RnLomXERWw1A/NFrNekXQq6rR8jIWCX4Chvz3o0010T1
         19DJe19MYe7T83Ca2pzNLooMZfrEXQru9Uekwaywqayu8SbYkpqJSr8oItdWuqc4r5ir
         FkqdBe8/aAvgZSbhluTiOjFhywMhHesRWRjDEIMFpNC2Yo7IfUyBWM8EcRA6A/o0YIgH
         lgYXoN50XElVy9smYKRpwJicYmf//BjWj+TjqO3C9ZzpaTNkUbeoKvA3oRYr3L1kyqzF
         9rog==
X-Forwarded-Encrypted: i=1; AKwUvBxNBqXHMCjIdkL187iIzg0Q8Z67EPIxVgJy1CbM3FsIi37fk8FCBiRPnH5SBEGdvIAuOd9ZkReUyfbGN8BB@vger.kernel.org
X-Gm-Message-State: AFq9FYIxR6hYpFZRzQZvfc/JWtg3iVS0MoKun3AqsK7JHKL42T9XtuvX
	+JLcc3+NIVx2pjD8euwmmqCjLLCm/Z5+z6FI83m4VDge8ySN9D0POjke
X-Gm-Gg: AYBFou0TiaQJsYrns9WmVjqK0LWi6tnV1y+Tz8/J7mwiRUffcO+Izb6cpHjnltAmh9H
	JrPF7xCs/+NKo4G6+2yik9eXP8PloQ2Ge3JWDxs1/QaQS52O4NRiqNwnjQunB3WM1kpApXTlkNZ
	2sxGsB4m3DIjAFGC+9qiilbuU/GB/FO8TyTQp0ZtZf4oKjp+9o7UtIQpI1Wz6O3U7VgLkvU6Ae9
	pLh/lwP6p4jrXAXUnDov0uqiQNNy90i9bzTqyNcmlDpLRoWnwUvDUsxmCSgbPpE0TRbwbuWuFoY
	TBhb8PwAmaE8DDS1nqumI5d7ELNVxkRmnVZWTKQ8kRi+mtZxdXOw8QR0bm4a288d8kAcDNyUA5R
	Vg44AZZc2FOn8X7wvfjzPL18nkM8dwzrPvPq3ZPdgf18sFRMeL0qoKDFofyihnbbYq6vEWjw1K/
	wh4dE9ZHOthkEKWG/mjxeEUR2SbjnxJgrSCRZA697hq9YgCtSbUDA3/E0mNTC9hMdPvu6oc8Svf
	jzoj8Xe8Vr+HT9JG45JeeNwJ64U8SbjqtEklN2L964Zk1dMjaP6AQUBXJevhmLF96+dHqnIfuKH
	nDNW
X-Received: by 2002:a05:7300:cc1b:b0:327:e68e:3230 with SMTP id 5a478bee46e88-342702c203bmr16200118eec.10.1790675302090;
        Tue, 29 Sep 2026 02:48:22 -0700 (PDT)
Received: from Mac ([2401:4900:88cd:edb4:3499:f422:21b4:55c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm31447320eec.10.2026.09.29.02.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 02:48:21 -0700 (PDT)
From: Tarun Khandelwal <tkhandelwal32@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	virtualization@lists.linux.dev,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Tarun Khandelwal <tarun@supabase.io>
Subject: [PATCH] fuse: propagate SB_POSIXACL to submounts
Date: Tue, 29 Sep 2026 15:18:12 +0530
Message-ID: <20260929094812.93374-1-tkhandelwal32@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tarun Khandelwal <tarun@supabase.io>

fuse_fill_super_common() always sets SB_POSIXACL on the superblock, but
fuse_fill_super_submount() never does. Submount superblocks are created
from an fs_context with no sb_flags, so the superblock of an automounted
FUSE_ATTR_SUBMOUNT directory (e.g. a virtiofs export containing another
host mount) lacks SB_POSIXACL, even though it shares the fuse_conn, and
thus fc->posix_acl, with its parent.

Since IS_POSIXACL() is false on such a submount, the VFS:

 - fails setting POSIX ACLs with -EOPNOTSUPP and hides existing ACLs,
   without sending any request to the server;
 - applies the umask itself on create, so default ACLs on the server are
   not honoured for new files;
 - skips ACL checks in acl_permission_check(), so with
   default_permissions (implied by FUSE_POSIX_ACL) access is decided by
   the mode bits alone and restrictive ACL entries are not enforced.

Copy SB_POSIXACL from the parent superblock, as is already done for the
other superblock fields inherited from it. It cannot be set in
fuse_sb_defaults(), because fuse_fill_super_common() checks whether the
flag was passed at mount time to decide fc->dont_mask before setting it.

Reproducer, with virtiofsd 1.10.0 started with --posix-acl and an export
containing a nested mount:

  host# mount -t tmpfs none /srv/share
  host# mkdir /srv/share/child
  host# mount -t tmpfs none /srv/share/child
  host# touch /srv/share/rootfile /srv/share/child/childfile
  guest# mount -t virtiofs <tag> /mnt
  guest# setfacl -m u:12345:rw /mnt/rootfile           # works
  guest# setfacl -m u:12345:rw /mnt/child/childfile
  setfacl: /mnt/child/childfile: Operation not supported

With this patch the second setfacl succeeds, ACLs set on the host are
reported by getfacl on the submount, and default ACLs and ACL-based
access checks behave the same as on the root mount. Tested on v7.3-rc5
in a QEMU guest.

Signed-off-by: Tarun Khandelwal <tarun@supabase.io>
---
I wasn't sure whether leaving SB_POSIXACL off submount superblocks was
intentional. I would have opened an issue first, but since the fix is a
one-liner I'm sending the patch directly. If there is a reason for the
current behaviour, I'm happy to rework this or drop it.

 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9552be36..ef3c7fac4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1629,6 +1629,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	WARN_ON(sb->s_bdi != &noop_backing_dev_info);
 	sb->s_bdi = bdi_get(parent_sb->s_bdi);
 
+	sb->s_flags |= parent_sb->s_flags & SB_POSIXACL;
+
 	sb->s_xattr = parent_sb->s_xattr;
 	sb->s_export_op = parent_sb->s_export_op;
 	sb->s_time_gran = parent_sb->s_time_gran;
-- 
2.43.0

