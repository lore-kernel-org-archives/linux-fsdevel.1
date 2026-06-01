Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B03B9D99;
	Mon,  1 Jun 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322237; cv=none; b=ff34z4pbgTQkj3LCi1wD5aLvsiSePW3+CWO7Q5rPEZUbdQ4fsI/4y3FcqN0hSfBzl0bBoNBkOafhaNilpay8xgYYQlvOrCS33nQzn2vxDw777g5+HAoWg5+FmTG4JJALmkhcBY8Wzq6gD1Lq+afSmj9Fk5KEx4lhVNnpPmVKlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322237; c=relaxed/simple;
	bh=tiQzRYTzrap/7+7fUVwKS26HiHi+4R0kpQPA215DbkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlR13+cdZUhEnt3EK+5MwIUbSMko5bgTgE+U2nBz84eVeJNsgfhUZg02y/YO/swyza6Leq922KJ1y/Nhh30O2gLGCQNCuKer06qSqcu+IRL1vaimHvpCNpZFyqHg6Vb3PnIqBiq4mvWH/nQfeyummKSfOJWoeIJzvGRdHIUXwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcTjZILA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcTjZILA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791731F00898;
	Mon,  1 Jun 2026 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322236;
	bh=ZDUB9cWFMbzzGx0q1kg2mHoWerfNpvgnOShY0yeONws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VcTjZILADWd/2SiJynkVrerv+zmRMuRM6AxUqTRB03bZRlR+MlxyODxMcQ4pLJ4l6
	 pyI6qR8nfoxFJFGmWmPVtcMDG7T84UboaZZTgdZIqnNmoJ1UOF8fFHFk9UOLs6bWNP
	 ERYbN9XnIYna/cxz/4nzPmnT5asTcZKUz0Dk2ScWrA5WOdtHDjPEPJlHGYct+20wxh
	 HT0gjxP/pW7cuOmMEjzHNlQxG+3WaG0pDRpcFQQxn1q8OXBmagcNDveINoUG+KZAJo
	 Jn6xMyv3lIZDMEONjYnzKrrVnstYLpjU3foaJA7FZdlS0F0enxz84yJSL3xUDW4A8y
	 5q8yo4AdPhEpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:42 +0200
Subject: [PATCH RFC v4 09/25] scsi: target: use scoped_with_init_fs() for
 APTPL metadata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-9-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tiQzRYTzrap/7+7fUVwKS26HiHi+4R0kpQPA215DbkI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i/zsIqX/LAxK2zLaV5pkdTLF/Ti9vW/lJNZYrf4T
 5rgr16rjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8u83wv/jTrGPRVvLigq9W
 7w7cN/2b7wmLmkDZUh/VU7O/Me9/fJrhn/qSVTnnXzzO37Po//UVLm4R93gzl/a0CHmxn3q9mXu
 1Pj8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the filp_open() call in __core_scsi3_write_aptpl_to_file() so the
path lookup happens in init's filesystem context.

__core_scsi3_write_aptpl_to_file() ← core_scsi3_update_and_write_aptpl()
← PR command handlers ← target_queued_submit_work() ← kworker

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_pr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 11790f2c5d80..cfd949e7a095 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -1969,7 +1970,8 @@ static int __core_scsi3_write_aptpl_to_file(
 	if (!path)
 		return -ENOMEM;
 
-	file = filp_open(path, flags, 0600);
+	scoped_with_init_fs()
+		file = filp_open(path, flags, 0600);
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for APTPL metadata"
 			" failed\n", path);

-- 
2.47.3

