Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898E377A80;
	Fri, 16 Oct 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160894; cv=none; b=ZOZ4tZm9Fwz1BsfP/X1YpDQ4aRzysygRavDg3bWRYccOvhTaMAgMgsU+YA7bnmfcJjOpzAu2VWYmbe/e26klQae6r+X3QqOhOf9WWIK17P0m0HC2mbkDX33S9HWlx0pxoXlnBcTNZp3ax5dYBtIH8X6u8N33w/tcAPYdZS1zKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160894; c=relaxed/simple;
	bh=kVyx/+Bh2SFTIx1Ta0Uqf9Fq/v7iXSp1BkyJr8yCWHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZnjibVncZg22/XvGoZTe4eZU0ZpUWbdx/G7/riv8tb/IUGJxRpCwVm9F1wt7/5TjeL5TXcH8feExyt5opnIEZHQfS3nBK6Fwpp/aTM2UcOxL8/PmzakMVseHQiOIT+llFFhhkBvwW07Ef/WN852GqeFvoW5odg2+7no8UV07KVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Pg/4cYhx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Pg/4cYhx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=xfVgpkKhA8IGQwvRbtPLD/w1VN4ZPrmkO+OUdeP8qGU=; b=Pg/4cYhxCrWkjlt+4wGME3yARL
	yUyJHPawCMnF33N5DP/njQrHMEzsiWLZUKn05xM8VTjE0Ds6ySWfPfU3H63Fpt8qws6GkkoNTyUg9
	GfahqO2uyfW3a7PdXUV6TEDDb6shi38CndIGp73ZN+DBmBcAv8XpBFlwBXEssrEkRQp6LSfB2qBA/
	i/lL1TW4adPgcHPLrXt9AhXOvJTm9ZkCFz/xxgocBO+V5aFLdKs2UG7cN/LgfhEKFhtr6Tg5cbLGY
	pwOlKf/8Mol0DPegxtMZNxLjdSDDyLTZGsqJMh8DQPxEL3Iv5kh92Ik5w/tIUT8jWVZYgks8Gw0cm
	Rx7qa3pQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHiuh-0061vO-2m;
	Fri, 16 Oct 2026 14:28:04 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 16 Oct 2026 07:27:58 -0700
Subject: [PATCH] init: do_mounts: free the ramfs info of the boot rootfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-rootfs-kill-sb-v1-1-7631af3ba35f@debian.org>
X-B4-Tracking: v=1; b=H4sIAG400moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mz3aL8/JK0Yt3szJwc3eIkXZM0wyRTS/OUxCQjEyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgBCawqQcgAAAA==
X-Change-ID: 20261016-rootfs-kill-sb-4f1b597dab24
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 catalin.marinas@arm.com, linux-kselftest@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=leitao@debian.org;
 h=from:subject:message-id; bh=kVyx/+Bh2SFTIx1Ta0Uqf9Fq/v7iXSp1BkyJr8yCWHM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0jRwJ+ECn+ZMqUHjGx71LeWT36HyEyPiU58cE
 UKp92v8xwaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatI0cAAKCRA1o5Of/Hh3
 bREgEACn1dErxZ5ZyIqIE+DfVl8L3mZpBMkH8ojYr99RXRd1Rwm6ogub3CYYEFPeiwFx0MIHAqD
 KG+9lLZ/eWwsRnhfNLSWNu/C5q3Mf9N5sYPiksnr1iSHeZ4givovY2cKb1SFMGxeH9paFZ2ySPk
 qr3DhsXB1+h9wz7Ezn/ELbRSvchkKZmB0sDufWtRiKF6hFM1NsfAfB3vf/QFbZvOVsvbqJryxni
 N9LTUeCvTHLz+fg98gmNDjFgH+1TgG51T6z77AI676VqNvuXqaN6ShPL64Sq3+sh1s078JrIxpr
 cM1LSsRR3oAoH/9V63v4fq0CYv4oauERqeOnmxhTJB/8OatuWnunWOCGSOgt3Hrli2fUMTtviOj
 jjKDziX0P3cYaGJofFS7Rf2CD4nJLFkhwcgAkqEQ4zYkxxkgWpYtOv/MwUW266RSZylgXF/DVxr
 aQf/8DJPU9Rh6N6mbA7EtfBji3e9Bg9Z2AVmgAM+fIgmm+Kxd/yZsl/XsDxtJmmLUg0ue8YTpR7
 uhqNNN1SpbtLckkC/s3yXTBHCipjgFOHOeupwDu6vaOY0t4+j/qgpYMmc2CohblToxqyDXOXLd1
 UAeceeDtw0yYIHOeKNcwgT0DSi8RkylgdYjs+p+ddZb4A+AFaCqmdcpyqsnXtDd61ncvaPQTyi0
 uhwydr8arU5sS3w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Kmemleak is reporting the following leak in ramfs_init_fs_context:

  unreferenced object 0xffff000080302480 (size 8):
    comm "swapper/0", pid 0, jiffies 4294667306
    hex dump (first 8 bytes):
      ed 01 00 00 00 00 00 00                          ........
    backtrace (crc bea23b04):
      __kmalloc_cache_noprof+0x28c/0x5a0
      ramfs_init_fs_context+0x5c/0xf8
      rootfs_init_fs_context+0x30/0x40
      alloc_fs_context+0x4c0/0x6a8
      fs_context_for_mount+0x28/0x40
      vfs_kern_mount+0x40/0x220
      init_mount_tree+0x80/0x440
      mnt_init+0x138/0x170
      vfs_caches_init+0x2c/0x48
      start_kernel+0x350/0x3f8

When init pivot_root()s away from a ramfs-backed boot rootfs and
unmounts it, the rootfs superblock is killed with kill_anon_super() and
the struct ramfs_fs_info allocated by ramfs_init_fs_context() is never
freed.

Kill a ramfs-backed rootfs with ramfs_kill_sb(). A tmpfs-backed one keeps
kill_anon_super(), as shmem frees its info in ->put_super.

Fixes: 576ee5dfd459 ("fs: add immutable rootfs")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 init/do_mounts.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 95e0b3a0f711bd..b088021b1546d8 100644
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

---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261016-rootfs-kill-sb-4f1b597dab24

Best regards,
--  
Breno Leitao <leitao@debian.org>

