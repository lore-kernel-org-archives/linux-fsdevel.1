Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6374D954B;
	Fri,  2 Oct 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949260; cv=none; b=QVwek4mmZXSjjgLKY8D+B6tJKKMVveCMpz/pVcIYWvWzhMt4dvOWykwczb50mTVSmApvSsaFyEDYQCa+pysIH+0bGs2vDy7Hm/WkAruubxTFqoS+3hRTxTdJFhaKKevjRrQJScN88/6NsBt5OeVSPZd66wKBT2q5ytEUDNpWM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949260; c=relaxed/simple;
	bh=VhUfKYEE5tIQ3lZ5knfcUcRBqNc7iJusBxsT7KRGzo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1oUDhwzyh+6BHcy2LxGT1h+u2clg+qSmCwk9rvZr1VizhWA8ath1RD0BKx/XlLsJ6aq48WusFRjQ0CHhQA8YVUFiH2oIGXGJllDCdI4iR0CsjvJSrs3fOg8UclLwz8K55oXQKNQKpbjAI94L9Yl3O+mcq8YmcGl2JA2HSy9/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFNBunQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFNBunQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8092E1F00893;
	Fri,  2 Oct 2026 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949259;
	bh=akx12u4olvOyt0Z+niTnBR6QvS754PdQFL6qEzfyQZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MFNBunQUprd+oxyaaSRzYj7SK9pc0i2Muw8xHujFSwKIs2wPU6cuboCKDFCUVV8w1
	 OrAdEN+hrQQKHOOZwZZwKCf75DXYGnyu/3ueCmhKst7gMEjFUwqcGvRbbIQTu0/heY
	 tzhws+G65PmcMYOEGLsfno/tPVTg5yklqnezAc4o08rkiF3ixblnsDPm/Avcdd/lYk
	 NoxJz0JbJAqiqC+JhCcZWc58XCId2d7+xB5FjewPS5MkLM7mbaYUfQCadQHSBkCKD/
	 9g/6zKu5tnO95mDCfNrewMD4A37cMmJq3sFew1Au/VkSqdwNLVh8+yFaMExCr3u+Ad
	 Q9mcpJR2r9MmA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:49 +0200
Subject: [PATCH 18/21] nullfs: refuse leases and delegations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-18-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VhUfKYEE5tIQ3lZ5knfcUcRBqNc7iJusBxsT7KRGzo4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x7lO0nh7cuFWVds0yce6Kxg3M3+Y3mlaDn76u+rv
 cNZcjKYO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSJM/I8PzvMZu2RRVFZycf
 y/z498vuZbpJIutelbbZCjwoFJ18wZbhf83KZZdnnHreVnfxpuGVRq6aW/9DzPze6XIszf//+28
 +IwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Refuse leases and delegations on nullfs as well. generic_setlease()
grants read leases and directory delegations on directories, so the
owner of the shared inode, or anyone with CAP_LEASE, could put one on
the directory that stands in for every unmounted mount and F_GETLEASE
and F_GETDELEG would show it to every other holder. Nothing on nullfs
ever changes, so a lease on it would never be broken and never tell
anyone anything.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nullfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index d90c71f5eece..f76b87cf1841 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -28,6 +28,13 @@ static int nullfs_nolock(struct file *file, int cmd, struct file_lock *fl)
 	return -ENOLCK;
 }
 
+/* and no leases or delegations */
+static int nullfs_nolease(struct file *file, int arg, struct file_lease **flp,
+			  void **priv)
+{
+	return -EINVAL;
+}
+
 /* what libfs gives an empty directory, plus the refusal of file locks */
 static const struct file_operations nullfs_dir_operations = {
 	.llseek		= nullfs_dir_llseek,
@@ -36,6 +43,7 @@ static const struct file_operations nullfs_dir_operations = {
 	.fsync		= noop_fsync,
 	.lock		= nullfs_nolock,
 	.flock		= nullfs_nolock,
+	.setlease	= nullfs_nolease,
 };
 
 static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)

-- 
2.53.0

