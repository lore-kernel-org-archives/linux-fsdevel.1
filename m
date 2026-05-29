Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF423504B
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048511; cv=none; b=KqUjG7TAA5H+n6CUCKf02HAfYktvpGQ4zhkssdR5K+gVXSl2/P+hehTMezfh8KPnpRyf+P12gyTTQo3Od+N8GQO/4gNPGqpjD/WoIGHrn9p4rqJ84yILHo6aRFvwh89C/iy7SSZExxO9gfvfCvFrEqiSeNocgaEcri7lbq4lYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048511; c=relaxed/simple;
	bh=dJg9bIeT2YRl5P1C+hiKUh2tgUgnSLSppchcQHqK2Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1BMK7BcjzPGpp/oJGrYh3TwlVrbsiY9nXnwPka4sjRA0TUWOYw8jqvEWHGPBWTnyQ7XSVDNZr9SLQFJxlnzhkyqUfXn65ZLHo7wxjG0dX0x4/O/c1f3wSZV2zXyjWlCkS2/1/NFjSHLpMatiE1rFMERGEMQBXwIOj/q5+NwnsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q31krKlZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q31krKlZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780048498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f4mO7zh2OYfYFujcbkhj/OStXm55oARYSUbui2B5HyE=;
	b=Q31krKlZX5C3DKx46Q+ShVyS2qfwxshsVuLaVkEnOoN6qb/DOiaYOXo1e+fxzsGLEjZH+b
	BAoTTvOIBBMWQ62nYGEEfoncKFeUYDAyuGuAAz0aYlNmZ/a2g6pFU26rpOljCwCWpQj1RL
	rLGO3crz+jqgRT0eiXrWZPIPXsxko6Y=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] fs/namespace: notify pollers of legacy propagation changes
Date: Fri, 29 May 2026 17:54:41 +0800
Message-ID: <20260529095441.1744006-1-guopeng.zhang@linux.dev>
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

Touch the affected mount namespace after successfully changing
propagation state in do_change_type() and do_set_group(). Take the
vfsmount lock for write around touch_mnt_namespace(), as required by
its locking rules.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 fs/namespace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9a66a806a9b8..f871c7bf3bc8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2908,6 +2908,10 @@ static int do_change_type(const struct path *path, int ms_flags)
 	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
 		change_mnt_propagation(m, type);
 
+	lock_mount_hash();
+	touch_mnt_namespace(mnt->mnt_ns);
+	unlock_mount_hash();
+
 	return 0;
 }
 
@@ -3479,6 +3483,11 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
 		list_add(&to->mnt_share, &from->mnt_share);
 		set_mnt_shared(to);
 	}
+
+	lock_mount_hash();
+	touch_mnt_namespace(to->mnt_ns);
+	unlock_mount_hash();
+
 	return 0;
 }
 
-- 
2.43.0

