Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E621C9EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284568; cv=none; b=uWdQu7pYpbI5QgC0ETKYaIj/gxZCYH4/FY1ktzB9I8gagymkY65O0ko3xkxcabnMWFozVUiPQfBQg0jGzQufQ+zYUkakdUJcL6Ixl0S6dEFDRUVS+Hp5AIRPcoKzjEL9xRUEVfAwdA4Z+0uiQd+Bk4IpiQucwe7HfIe3JVIWmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284568; c=relaxed/simple;
	bh=lVgoOXhWjH6Mday8chaIt6qfzRi9SX7tNnJmLoviCQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HEcC3rQXUdFpm28QgshIP8qPa9oOhallyiYEO/nGq9Lv8BapntpQ45bZfgs28HoffcS3Am/zUXlKz6c/ZPnlWTbOb/lcyKRVrcV/fsk1sfuTcamAHkG+TpSyMZ/0JBGHdfkUikUMd68bp8+fXAfwITkqBw7a3A5c4d5HA5waEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L7wxkZfH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L7wxkZfH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780284565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qUwK/evFOV3E2+dfmPSL8FiGs8kF3vHIuP+lxCXArNQ=;
	b=L7wxkZfHOcupGthiyTO3d6wj3U57LCSRgvQi/uyVcaojnCn11IdofzNv6HVZXjlb910wn6
	IGkO8yEKxLuGp/8bHcntr/kyrG/COi7nPvL0cTc1WVULbmUs+iICGrEoR0iiYEXO4c88N3
	al9yqEoxm30+mgM5lhrEtoe109R9wfM=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v2] fs/namespace: notify pollers of legacy propagation changes
Date: Mon,  1 Jun 2026 11:29:11 +0800
Message-ID: <20260601032911.940507-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

Changing mount propagation through the legacy mount API changes
user-visible mountinfo contents, including the shared: and master:
optional fields.

The mount_setattr() path already touches the mount namespace after
change_mnt_propagation(), so pollers of /proc/<pid>/mountinfo are woken
when the namespace event changes.

The legacy mount --make-* path also changes propagation through
change_mnt_propagation(), and MOVE_MOUNT_SET_GROUP updates the
propagation relationship of the target mount. Both paths currently
return without touching the affected mount namespace.

As a result, userspace polling /proc/<pid>/mountinfo can miss these
propagation-only changes even though mountinfo has changed.

A simple reproducer that polls /proc/self/mountinfo while changing
propagation shows the inconsistency.

Before this change:

  legacy MS_SHARED: poll ret=0 revents=0x0
  mount_setattr MS_SHARED: poll ret=1 revents=0xa

After this change:

  legacy MS_SHARED: poll ret=1 revents=0xa
  mount_setattr MS_SHARED: poll ret=1 revents=0xa

Fix this by touching the affected mount namespace after successful
propagation changes in do_change_type() and do_set_group().

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
Changes in v2:
- Use guard(mount_locked_reader)() instead of lock_mount_hash() around
  touch_mnt_namespace(), as suggested by Christian, to avoid forcing
  seqcount readers to retry for propagation-only changes.

v1:
https://lore.kernel.org/all/20260529095441.1744006-1-guopeng.zhang@linux.dev/

 fs/namespace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9a66a806a9b8..f01d4b9cf65d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2908,6 +2908,9 @@ static int do_change_type(const struct path *path, int ms_flags)
 	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
 		change_mnt_propagation(m, type);
 
+	guard(mount_locked_reader)();
+	touch_mnt_namespace(mnt->mnt_ns);
+
 	return 0;
 }
 
@@ -3479,6 +3482,10 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
 		list_add(&to->mnt_share, &from->mnt_share);
 		set_mnt_shared(to);
 	}
+
+	guard(mount_locked_reader)();
+	touch_mnt_namespace(to->mnt_ns);
+
 	return 0;
 }
 
-- 
2.43.0
