Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8737C0F9;
	Wed,  8 Apr 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661822; cv=none; b=RnJnwYklt8dAF4RwvLe6cRce/DdavgEDlRQDJOwylXnlrIsxCpbxnCC769nOfp7pKcLx/GdfXZb563/LisYaG9Onj0wsiBks6rSav9XySft7M+xyqhZkYRcVe7o4oG2dnWMUS+FUFnnWRL0dNxoTQdbLSE8QrXY+zqxU5xFx4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661822; c=relaxed/simple;
	bh=xy2wTzXh3oJ06N9hNsWTCm7gzKhOvMebokWJWOugQTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=io3iXwYnw7+ICliNYlVq5tEp6G4f1ir+c7oKf68NsA5anWsZUaiWoXoqfqFWrS5E+DTOoxVsuy0iPyQMDVu+tuFKY4pQRgOaCdaM5TALOdQdY4OcEWscM8dFM9K0fVb0YRSfbSGpy9BbeLt0V32EYjWqDfnNiHu7IKrIZ2R3S40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTOXOO49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTOXOO49"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38B06C2BC87;
	Wed,  8 Apr 2026 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775661822;
	bh=xy2wTzXh3oJ06N9hNsWTCm7gzKhOvMebokWJWOugQTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UTOXOO49luheuly8E3TpkfDK9w3e3F95JIZ2I2R7besK2uRFjB+SPI4OPM7PgD+GI
	 JYtG3dlYq5nsfiNa81jf8IUoydrdzZxvWduZlZZVXlCl0V6F3MzluMSoY46USUHwwZ
	 ZkXU4CMzAYCXZJJUaZ4ZDkcYEVNCYjzUxl+kN3MIA9AoA4WElarHzac7S+n+5fLm8l
	 SqPPCMI4scX3sQMqwubx8VxukKwhZ5bXqfGgPolZ/LQL8S/45DH2G4xxqEgodgxOGA
	 g09HOurOd6TP2PGC6+29JoQ0EfJDDoCy+he7iVtOxXQaBKMA0831dt3NqSW39kx8K/
	 99K+EA47dqikQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4210F994F;
	Wed,  8 Apr 2026 15:23:42 +0000 (UTC)
From: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>
Date: Wed, 08 Apr 2026 17:23:40 +0200
Subject: [PATCH 1/2] fuse: fix device node leak in
 cuse_process_init_reply()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-wip-cuse-leak-fix-v1-1-1c028d575e97@redhat.com>
References: <20260408-wip-cuse-leak-fix-v1-0-1c028d575e97@redhat.com>
In-Reply-To: <20260408-wip-cuse-leak-fix-v1-0-1c028d575e97@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Alberto Ruiz <aruiz@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661821; l=2016;
 i=aruiz@redhat.com; s=20260408; h=from:subject:message-id;
 bh=FFr25cv2qmdGgRJVSTfidJQebQx41SqD8R/u4bhxMxY=;
 b=6xlTlB+2IVAzx1rejwjK5k5wUp0x1dIltBb9ymPiEaWSaoXWs9X/D8pXbOqQqnTCaJ+eQCKCV
 C51YT2d1/04BUzCgSE2dOzMaZ2x4Hx1ZrByqauumjuSkgMK4rl8BeQO
X-Developer-Key: i=aruiz@redhat.com; a=ed25519;
 pk=ZJyUFl31NDNjeRWoQa/6I6bV5lb8axrDvpj9uGd+NvU=
X-Endpoint-Received: by B4 Relay for aruiz@redhat.com/20260408 with
 auth_id=727
X-Original-From: Alberto Ruiz <aruiz@redhat.com>
Reply-To: aruiz@redhat.com

From: Alberto Ruiz <aruiz@redhat.com>

If device_add() succeeds during CUSE initialization but a subsequent
step (cdev_alloc() or cdev_add()) fails, the error path calls
put_device() without first calling device_del().  This leaks the
devtmpfs entry created by device_add(), leaving a stale /dev/<name>
node that persists until reboot.

Since the cuse_conn is never linked into cuse_conntbl on the failure
path, cuse_channel_release() sees cc->dev == NULL and skips
device_unregister(), so no other code path cleans up the node.

This has several consequences:

 - The device name is permanently poisoned: any subsequent attempt to
   create a CUSE device with the same name hits the stale sysfs entry,
   device_add() fails, and the new device is aborted.

 - The collision manifests as ENODEV returned to userspace with no
   dmesg diagnostic, making it very difficult to debug.

 - The failure is self-perpetuating: once a name is leaked, all future
   attempts with that name fail identically.

Fix this by introducing an err_dev label that calls device_del() to
undo device_add() before falling through to err_unlock.  The existing
err_unlock path from a device_add() failure correctly skips device_del()
since the device was never added.

Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
---
 fs/fuse/cuse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index dfcb98a654d83bb34460a6e8c9e4b196dfdfdfbe..df9d50a9c0fab269102ec0e4b2d459ca2a390c59 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -391,7 +391,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	rc = -ENOMEM;
 	cdev = cdev_alloc();
 	if (!cdev)
-		goto err_unlock;
+		goto err_dev;
 
 	cdev->owner = THIS_MODULE;
 	cdev->ops = &cuse_frontend_fops;
@@ -417,6 +417,8 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 
 err_cdev:
 	cdev_del(cdev);
+err_dev:
+	device_del(dev);
 err_unlock:
 	mutex_unlock(&cuse_lock);
 	put_device(dev);

-- 
2.52.0


