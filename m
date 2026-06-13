Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707834753A
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349290; cv=none; b=ALRXwmJlZwUtlfVNqzX7TnmTO0SSjZdXnDS+9eDfe+dRI1a13Ck0AIIa1yLOJR8lC0AVDDZq9fbEeihUnGiFydJ7Ae1HRXC96W7ET8Wtz6ewkji4XFS8k2MLnR//jAd+zhuckByztanRvR7fKibj3n6Qxe4DVrVJk6Wu1pJmeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349290; c=relaxed/simple;
	bh=buiDjEjJTNCbwBH38wTQ+0mHiWWmJv5dfe8MCzMXTyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS9JT3H9wuLlivpu2Y8+zPp4Y6X2t+FIrN82rRLjPI2V8XLxlB/q4g54VyBeXH96fmMMR40qfij8CfJmbqWMgZpGS7uRXiUcuqC5vaUqWxMnSEZmyUEGj/yEIRV1gQ4OrZ2GzArpsNk1iaWYqDR5cFpcM+jxu6Ol7qQcduPcJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3XL1fyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3XL1fyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300B1F00A3A;
	Sat, 13 Jun 2026 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349288;
	bh=rAbvIUWiFDMirl0Us4mmXPOFTeBDDg/l/sWK35AjUMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3XL1fyhrftVFOLPF84Df+TTb73VAzcQvlCy01QFpNnNLR+lrQy3Wp3ANOp7bGdBc
	 SNfiIoLHPFP7Z5nIf9ngsTVNRUx1jlViV5CPl8ZwctmYskVewSN5OD8KEYti8BxQp/
	 EJTRlNMX5ImixUfWTASm241+ePdMSM13FArgc9oCj/fS+9JOdl9ezSyof4Y5JOWtDC
	 BauN0oWNazApx5hpcA7CtcHr6a1ynu6VdxIjhXwvRHDhBpAuN15HD6VLpWuihbDD0E
	 cidzlg2yrkOJOWoTPCaDoW3aW0vYqRwSSe2F2d8vsjPxkV9om6pe2DMI4WIBx64u2P
	 KKVkGj/tHu9JQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/8] fs/configfs: rework configfs_is_root()
Date: Sat, 13 Jun 2026 13:14:30 +0200
Message-ID: <20260613111437.101763-2-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

configfs_is_root() should not check for static structures, but
use the information in the structure itself.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/mount.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 4929f3431189..e5c01d5e4d2d 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -49,7 +49,9 @@ static struct config_group configfs_root_group = {
 
 int configfs_is_root(struct config_item *item)
 {
-	return item == &configfs_root_group.cg_item;
+	struct configfs_dirent *sd =
+		item->ci_dentry->d_fsdata;
+	return sd->s_type == CONFIGFS_ROOT;
 }
 
 static struct configfs_dirent configfs_root = {
-- 
2.51.0

