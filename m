Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A8370ADF
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406601; cv=none; b=kJlumeNKEn6RcYZqUK48BH1vkeEq6mU4Tth0Eb+s9FvfSDJQWokqSUvbQzqhv2H1Um3Wp/kI+IeDk+7N+AFHcrGT3G1v0CTaJ5g6skhhJ5zvHFb9zK+JrjLJmwRoX7adHk6azJpvC99m2O4EkRzKaEqt1kogsFkc/DlzxixUEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406601; c=relaxed/simple;
	bh=f9n7vxqegBMiJa3B9ktL1V1OhF+Wal7I2bpsCiLF8lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4b9r2XUUKKlUKOwuDyn4c5IcZlHyMatZrsARQnQYyQyzIiOQJvFImjNqyH0Iky04B7LVFo0tQHrj3l2U2MhQh7qSZI5qPhQbtJHkbPVUkjfwz6zKONVmLHJ1EKdIHsRBVX8AhGc2ZBo9JLv8DgfnHn8JQLrPy2JOHSKQyir/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mE6fl3ZX; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mE6fl3ZX"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f9n7vxqegBMiJa3B9ktL1V1OhF+Wal7I2bpsCiLF8lg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788406595; v=1; x=1789011395;
 b=mE6fl3ZXiL2QY6mleTtmWlQU0ZgG1WQqqiZJefKqWB+lqpLsCnPgpBpL4XW782TyvwQSPUnD
 8lOe0+DIaGq/3RwJmHJSSQ2pSPA4jVSqvyg4/yPUO7yhjh6QguKH1SSRb9etCSS8n7NpYlDsREy
 ZOzCb7U0hboqP+mRdXKkjK6w=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dde1976bb73c7399;
	Thu, 03 Sep 2026 03:36:35 +0000
X-Mizu-Trace-ID: dde1976bb73c7399
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	lxc-devel@lists.linuxcontainers.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] devpts: reject max=0 instead of silently lifting the limit
Date: Thu,  3 Sep 2026 11:36:25 +0800
Message-ID: <20260903033625.1042796-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

mount_opts.max == 0 is consumed as ida_alloc_max(..., max - 1), which
wraps to 0xffffffff.  The IDA layer treats a negative max as INT_MAX,
so "mount -t devpts -o max=0" does not disable ptys - it lifts the
per-instance limit entirely and only the global kernel.pty.max still
applies.

Reject the value at parse time:

  $ mount -t devpts -o max=0 pt /tmp/pt
  mount: /tmp/pt: wrong fs type, bad option, bad superblock...

No userspace relies on 0 meaning "unlimited": runc and crun never
set max=, and LXC, the only runtime that does, omits the property
entirely when the configured value is 0.

The value has never been validated since the option was introduced,
so there is no Fixes tag.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 fs/devpts/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 9844dcf354ee..bd1e8eb26edb 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -249,6 +249,8 @@ static int devpts_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_max:
 		if (result.uint_32 > NR_UNIX98_PTY_MAX)
 			return invalf(fc, "max out of range");
+		if (result.uint_32 == 0)
+			return invalf(fc, "max must be greater than 0");
 		opts->max = result.uint_32;
 		break;
 	}
-- 
2.43.0

