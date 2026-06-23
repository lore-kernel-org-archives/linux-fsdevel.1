Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB533644DB;
	Tue, 23 Jun 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206166; cv=none; b=BhmdrQOvNWbXrxouZSykrY7Z5ZaTTgWBZpkhc2RBZI0Hbb7TOiGKV7Q6pkEtWY8dPhq+fX9/PBgLsq91XiqH/nMwUKEaafYeJ0/07uep9vz0462Aos04SympBfDsONLM6/cecwjJEqVA2vSDtsNNSrko/gUpyEZmYtLhbdfV5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206166; c=relaxed/simple;
	bh=Vk3YLAgdQQ3JhwKy+7LI/rSXNZ8cgsxQcGMX5eeKgbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQ2ahS2wabLnCwFmTB3CTVeEJsnA/zIiCZeNhD5dQg59ZNlCA7bXtYsE4X3EIv3zZaN7UNWxNwrbehloSTPkfKySOuAuZAaLInOnE8rchsJiG1g0IaZXM9Lc/owzUml5fv2vEqQKE6KqQPFERMXra3jwWFqOg7Wuew1mtXgv/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3SQEPFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3SQEPFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C437E1F00A3A;
	Tue, 23 Jun 2026 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206164;
	bh=Ez0VfHhGoU0GTVPOD0OStLzH0MYIign36GoetrV9P98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L3SQEPFTF3vNjO+J10+sgIzJ9wekrDd8g5HwID3AmeDou70HoQjERcpP8AJbWQAG9
	 qhP1/ZhrBUiyOcixevfQnxrW3ER4pgXqSqD1ciQLqt2YG56qizfCs0HyBeWnUtdkx6
	 8vRAY62bI1YdblBZt2jzRVCu+3TFTun9Kv2crrZ9bJfhBQdMVmbeV9scGKbveE5IzQ
	 lXJM+db570HoSws3Cq1vamJY/cRup4onr+CNz0ReZp5mZwsOm9H+xMnruMt89jdxEU
	 W8zSHpLo9TW2tXqRAKJFz9TsFsgthb1wYZzoK86WmhIe140Eg100Uhh0dJs579EOxy
	 88+FtgvrkDYyQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:46 +0200
Subject: [PATCH RFC v3 01/12] fs/configfs: rework configfs_is_root()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-1-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=1706;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=Vk3YLAgdQQ3JhwKy+7LI/rSXNZ8cgsxQcGMX5eeKgbM=;
 b=eaW5hVZUWv7ZKjXGT6NGRXmqUfDweUmp17HJ4HBHmCFWx+MsnrgZY6CD+yQ5T8Ae06ZKWfZb9
 npn6Sdq0z7EDInKkEDzEbNtQkA8H5Gb3iydogYJt2FZKvqS4ZMhBE0+
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

In preparation for making configfs namespace-aware rework
configfs_is_root() to not rely on static structures but
rather use the information in the structures themselves.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h | 2 +-
 fs/configfs/mount.c             | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index acdeea8e2d69ac9d621e1a42b039719811c31757..6261e1f3ec201a58a5d46b08dfbced8c2a44d82b 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -63,7 +63,7 @@ extern spinlock_t configfs_dirent_lock;
 
 extern struct kmem_cache *configfs_dir_cachep;
 
-extern int configfs_is_root(struct config_item *item);
+extern bool configfs_is_root(struct config_item *item);
 
 extern struct inode * configfs_new_inode(umode_t mode, struct configfs_dirent *, struct super_block *);
 extern struct inode *configfs_create(struct dentry *, umode_t mode);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 4929f343118946eaa55a539db4192e9c6621a8dc..88da7b428e52f2f4ab139ad3907101f685d617b1 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -47,9 +47,14 @@ static struct config_group configfs_root_group = {
 	},
 };
 
-int configfs_is_root(struct config_item *item)
+bool configfs_is_root(struct config_item *item)
 {
-	return item == &configfs_root_group.cg_item;
+	struct configfs_dirent *sd;
+
+	if (!item->ci_dentry)
+		return false;
+	sd = item->ci_dentry->d_fsdata;
+	return !!(sd->s_type & CONFIGFS_ROOT);
 }
 
 static struct configfs_dirent configfs_root = {

-- 
2.51.0

