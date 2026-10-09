Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7113F4858
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525358; cv=none; b=ey+DFz1xw2Lml+4aWDKDjq5cJNArU0HLQV7hXRKcpNLtW0QHop694xOUlFMTT/tzW+BvxUrCdRtz/xGmb3tX6k4dw/MapsTPez700VtbzM89sskXK6S9EQORgtXNEzJaNkGea8pHAGS0Hdoja/TkOKc8P1G7A5ML9tLuNsrNLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525358; c=relaxed/simple;
	bh=9emYsz15GuXjmCU4lAwqVw4KY/Rrcx/aCcY0KTAhp9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q1eM6ZSq2hzTDwUST0ieCMzeeS7nBuw+7QN2dqJVPHiUpVZhya5SObyFAl62DnPIG5I+aqGHFZ5o2fox0845d7sbcT594pd1IbjZp0zmA7XAeVk7PPP/Nq7hG13G+8rvkmKSN+foeeV/rCEtb2bs6pz7KlqSkHMmATUfzVEfNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCUisXHP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCUisXHP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c5358fc28so3772007f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 22:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791525355; x=1792130155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zp7G9mLjsHEHBJvEhOvfosmT6IrpsVXu9tMKZrIiLvQ=;
        b=oCUisXHPYXpccFMBVqueMbFFrtpmsKdjN33T8LwQPv7B4nU/y+//eCv6kh9HbVXHBx
         CGb7N0qrmLa/n1T6ftp1boCAbLPT5YqQD4BBS9XFruXkIWW4rTTEvN5s52z8N6CWnil7
         ZxI6zf/oQUuWC296K4f17zH4pYbyn4a+jw6zRowKMqBjTmHEbVZg9IxhlYqlTd3pNwMU
         MznmrJOdGPQOIccjTDzVtWF37FWzo7fpGc2A2tTvDsBNa7uehw9hiUgmvJ760JBBRJcz
         6GgyAYVCDAQtysAE8QuG7yND70zqtPC6xHWG+MBZML4FL+ywDXJu/Rb3U04Rc5TGQCkQ
         t3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525355; x=1792130155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zp7G9mLjsHEHBJvEhOvfosmT6IrpsVXu9tMKZrIiLvQ=;
        b=mH7nbhT0ZVdt2XsHV30CkMbCiB+HZivsp+f7RPIhfGV2cGYjvI/AXdTqeuKoAz+ASu
         yZe9bciWqlzpORE2OHMpitr99RPLVF/lB6lACokvuFcceR+P+PAsVNEbOEQTGApbVmR7
         VYqiFwkG1C2mpJxaU0w3uRH7mLFEA6uO7uC7BOtQFHQv4huQBCllgxiVIHVZ8EdbMcbT
         qmVXyBkZgzeS8D7aS977Wa8+bXlUYKfY083VPK/FW92Lok4oyAHImMixc6rlGhGfwB3C
         mJt+Jx33zXc1rSpgVnCmmbiu05Rte+FswxxCrcIyJXgY66TuUzfFdbL5TJurxmsEr9MI
         bQIg==
X-Forwarded-Encrypted: i=1; AKwUvBxabcCgz5SQHFvecYSed91gUPaorlqlw8BlpI8GSwhnvR4rZufF+ZpY+L2alGLel1MrbnM3sYMuN88ibv0X@vger.kernel.org
X-Gm-Message-State: AFq9FYJxcgbVriXjbNVScSXsnHkAa7CdjHZgV0GHWPMEAeqWAUSYyu1o
	ZwCQbQf/8ZbObC08cNd3y/Md7fXmaj7kjBE/FGufyZkT7DEVgP305YXo
X-Gm-Gg: AYBFou2mBWFIB4ABDjcNlA7xzvk52McuBc5/Tu9TAj17bysl1zisPBCo8IW6CiaZ0RT
	OJtWmGF3xQOpSZcHfL8WbbacUR4+xLnZSBBjTTl/eqKOHOeTLZkS48Wg/esfuTKkJKFVtrmlgWx
	biM8+3DDWsTWnZy2+h4oN7Vqbi1t/9riap0QFmoV5kjEDF1FjyV9w/SPLDApqVT+pI0REtYm5bm
	uUcBsAuGIq653df2JL6E2YWzehJGgYpcJn82EKdny7N8Qnl7wSTblvrptcLhvBBrMa7ZeSyt7Ef
	KthJU7QUPnxksF9UuMqTl/tkS72z3n6J1RxGMxXYiBVorms62S2O2D7LOtKF50heN+1xpaVfh2H
	AsTNyBkyHUHFd8/3MCbOfggXz/8KHJ74/740sFU6Biu7oM+6Sk+ot9VWcwriLPLHyrtpFY9bvEg
	xdFEtCm/DMJId5SwKY5P8qXSlb/v5JzmHphpPpP61UqdQyBmNCmHhKMom1n+o35okV2JXfbyR2p
	7qZ+DW/ECkEOBLgfCJlucpqQ3jgYNXBHHXsNfACAOnttXGKkV/SxJqiBrjiyLk3UF/bB/SNejUN
	szNHI7N02iuOkqJOgg8QAb0svLrvSP6HewND79R7MGxYuTx9OJ9b6OzgXOndfVrvsxJzjAcTUbb
	+AHuf4YgG4tAi
X-Received: by 2002:a05:6000:2503:b0:48c:7083:be67 with SMTP id ffacd0b85a97d-48dbace462emr1140675f8f.42.1791525354938;
        Thu, 08 Oct 2026 22:55:54 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm1984126f8f.49.2026.10.08.22.55.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 22:55:54 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] fs: fix ramfs_fs_info leak when rootfs is unmounted
Date: Fri,  9 Oct 2026 07:55:46 +0200
Message-Id: <20261009055546.85279-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rootfs is a ramfs, for example with root= on the command line, its
superblock carries a struct ramfs_fs_info from ramfs_init_fs_context().
ramfs_kill_sb() frees it, but rootfs_fs_type uses kill_anon_super().

Before commit 576ee5dfd459 ("fs: add immutable rootfs") rootfs could not
be unmounted. Since then prepare_namespace() pivots into the real root
and unmounts rootfs. When the superblock is destroyed, the structure is
leaked. kmemleak on an SH7785LCR board:

  unreferenced object 0x8100a720 (size 32):
    comm "swapper/0", pid 0, jiffies 4294892299
    backtrace (crc c8bfd23b):
      ...
      ramfs_init_fs_context+0x16/0x48
      rootfs_init_fs_context+0x16/0x2c
      alloc_fs_context+0x98/0x114
      fs_context_for_mount+0x16/0x24
      ...

Call ramfs_kill_sb() when rootfs is a ramfs. tmpfs frees its own data
in put_super and keeps kill_anon_super().

Fixes: 576ee5dfd459 ("fs: add immutable rootfs")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Test: kernels with DEBUG_KMEMLEAK that mount root=/dev/sda themselves,
no initramfs. kmemleak reports the object without the patch and nothing
with it, on

- the custom QEMU model of the SH7785LCR (sh for-next plus unmerged sh
  patches; 32-byte leaked allocation), and
- user-mode Linux (v7.3-rc5, um defconfig; 8-byte leaked allocation).

On the model, rootfstype=ext2,tmpfs makes rootfs a tmpfs. kmemleak
reports nothing there, with or without the patch.

The report only shows up after init reopens /dev/console. The console
that the kernel opens for init is on rootfs and keeps it alive.
---
 init/do_mounts.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 95e0b3a0f711..b088021b1546 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -503,10 +503,18 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 	return ramfs_init_fs_context(fc);
 }
 
+static void rootfs_kill_sb(struct super_block *sb)
+{
+	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
+		kill_anon_super(sb);
+	else
+		ramfs_kill_sb(sb);
+}
+
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
 	.init_fs_context = rootfs_init_fs_context,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= rootfs_kill_sb,
 };
 
 void __init init_rootfs(void)

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.53.0

