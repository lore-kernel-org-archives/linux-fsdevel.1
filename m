Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601248;
	b=r36nOb7rmwr3jrp8j7FbW7+oLe1IljC4ZdCjVUj35ASfRmOAn3KVna6DmCDAuBaS0swI
	 Mj71XVYKgWSMwQunC4aKdoGKr1cAfYo/aEqV4WOmjAHpHLmrMyz0dsESsKd9ebQUa8rez
	 tbsoU9dAwe0LH+ksjoaQskQFctLyUFKAKkfVYj2Q8os+b4JqvUAqZDYc6K4z8jqHhmZ7l
	 SKTfNKquv7xzHoVXyzhluzt+F8Q6dxPJZB1fhhj5qvQ7/fPsqSxqM063DAUXk7wfhnCno
	 fTabKTjpfV05/uH3L2q94un+e+tTPD/3W6n2Ub2tsGiLx3kVg+EXRFpvemnQRwx+WPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZZZEQJMItiqpnFGu5aV7NtwnGpNdzBOLgdMI4f1zBl8=;
	b=Y5mJ3BPoZ/XYhTw497QpgrHn22nbxJUQo4poxrVVAogPY0jgvo+cGhO9nwOsC8hzYyJl
	 6Kiz7OGYV3tBH0LTBAybyYkdfM0psPr0G6kgJ8D8WeWfmEZOsgs8F+n4BH8BTyaFwmxzd
	 ADYQzlxwiPwK8aDwYnevJT3SopRhwkMxryBOKs8y8vo0iFKNZNH3DaWKoW8OOOKiO9GDL
	 xZnkQW/KKIXOkvFjyOAHSrrMD5cDFsu48KnY69tQfHW79/J1sflkHikrXwRGolELGYbuo
	 vr+dsRmOYmlKnpuTAaoOiNSEqf5QQDiijB2fYUbNmpCFsEyp7cYoRWBVwQFqpzjjRRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FRdg2YOM;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128A606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6128A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FRdg2YOM
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91befbcad6dso15980396d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792601246; x=1793206046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZZEQJMItiqpnFGu5aV7NtwnGpNdzBOLgdMI4f1zBl8=;
        b=FRdg2YOMBl/W7NmySpi8e/ApbFhgNz3TsQgZ56mcFIZgseKDBmNn8imA3YaVOI3my4
         kWOuuw0zr6L0DGmGz243kDzLoNes97mXbaWHA0myrzAUdrxkt18sqQJtNwLfhcAZbpBp
         hdWf/PnVWdFR6msiF4P81fal67bENGCztuWAB+L0IlXk51INkT8LAZso/m1kelGQIxu6
         Z7MuTEuq4TtrA6WnUqnSLFZavgNvWcyUgzXwCHT3/lblR2zP2+qVMneRdO9uL5pKKsUO
         atx4q7uM6M/F18Wq7WB6vZFXluwGrmWNBZdMJqB7exJrKl7a9xkpvhmMtMl/QZ3njojS
         cNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601246; x=1793206046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZZEQJMItiqpnFGu5aV7NtwnGpNdzBOLgdMI4f1zBl8=;
        b=DlfGzTRLWwe2BWi9MU6T+/H9d8deNcsZRn4zvjWcF8/YkU7o1iRA70xxxzOLEpMY5/
         Y5uVbw7pMtRoNZBOl2H2ILw7D/NmlnO3qL1YJ4iXMIolEKkOKHGNa9C7+9MjM69Ah2ip
         f2daBsse4cgfAT+GM/zlp+BV8yM7DsTJRSYddRKdsz+zSz14tJmE3vix2u0SnySTUnuQ
         +vuvHmhPEtBa32t64cXtOehXGl9h5SrvjjCZZj4OzVUyBD7WNdSer3Iw1wLyRvrYQdDE
         /ui0PFxBRKQX/4amT9CXJpQJ+I12+oJQsFbecjW0JyjO/Fdd7xmhCNa6cMsqnWI/WiKF
         Zj6g==
X-Gm-Message-State: AFq9FYLWIcq9hkUNWeXNYDYg9I/UYYFH/qZ1lCd4VmNZzlrmNfIWxuVW
	pOwQFUIUmWHJGrDGaKJ744ZYwPQvV4cIFLFW6OKhDLcRjp3rEbyzIPzZWTylkXPq6VA=
X-Gm-Gg: AYBFou1nfB9im6Wma7avSMGgyEQpfUqe7ODJZvBb8suF2kwuWF9zEcLUyEJfiEv0PzD
	8aaw5WFMngKZfzNj0JRebBYopQ4K2beXTwd5bBe8AZexLRCdY7lC9ZLxekQpiX8G04iXnA6ndUT
	cs3lfhc8ZePiW+6+29I1cw7Dq0dbA4Obr50Ha6RVcoCcqp6k0DT0b7yfZald7FefDHy0DHyjiiq
	qohGz34QbjyjIyyV9YolZZ/fWqAPV65EUlmz21iNDhVYi20q958bl/3R1QQ05z6L6uiXfTLSym+
	qXfwApVlcVEGJEEvVPF5jucpj6wEPz907AQNTL3rOJstbHETi/aYUK/bnRT6hzr2Cj5yrcqyINO
	eLCpgSsRB+iUo4BzXBc9XSSTBvTHlgmdKjLWx02RUM7ChNRwssocxzJFdiJQ7pEUJsoLAxiJ81d
	l/2P6Zgzy6CFJGNYc24ywQRMCbCmprsqG48T6bM3ziT3lZn4nUrp/RhhSH4WAK92871auZJzoNN
	m19lzChXvqM41woGgm9HxUeeYblU6LCGdd6nIlmgVLSU9bBLv6ltAKTlpUgtz2CbkeLfUKXwA==
X-Received: by 2002:a05:6214:2a4a:b0:914:2c9d:b376 with SMTP id 6a1803df08f44-91c12f0c309mr45509346d6.46.1792601246149;
        Wed, 21 Oct 2026 09:47:26 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b74c01sm28740316d6.8.2026.10.21.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:47:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 16:46:59 +0000
Subject: [PATCH 3/5] fs: make BLKFLSBUF's wait for a superblock killable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-super-lock-unborn-v1-3-0265eddb6dee@toxicpanda.com>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792601235; l=1603;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oUk6uISnfWFRH6uDQHX+PYQKTdHZokFJbKYmrMDDYws=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ+Z3H3tEY5XZg/PqP8ScfgS76VfJrH15HB4kHDQjOPrm3mUAW2pDXZXX7fa4LQy9Xaps71vC0r
 zyeWkDqTJpgs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

fs_bdev_sync() syncs the filesystems on a block device for BLKFLSBUF.  It
can already be killed while it waits for one which is being unmounted.  For
one which is still being mounted it waits for SB_BORN, and then for
s_umount, in super_lock(), which can't be killed.  If the mount is stuck on
that very device, so is the ioctl.

Use super_lock_killable() and stop the walk when the task is killed, as for
the unmount.  All BLKFLSBUF does afterwards is invalidate_bdev(), which
leaves dirty pages and pages under writeback alone.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 40f92ffa39c1..ecba64ed0c2a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1676,17 +1676,21 @@ static void fs_bdev_sync(struct block_device *bdev)
 
 	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
 		struct super_block *sb = sb_dev->sd_sb;
+		int ret;
 
-		if (!super_lock_shared(sb)) {
-			if (super_wait_shutdown_killable(sb)) {
-				super_dev_put(sb_dev);
-				return;
-			}
+		ret = super_lock_killable(sb, false);
+		if (!ret) {
+			if (sb->s_root && (sb->s_flags & SB_ACTIVE))
+				sync_filesystem(sb);
+			super_unlock_shared(sb);
 			continue;
 		}
-		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
-			sync_filesystem(sb);
-		super_unlock_shared(sb);
+		if (ret == -ENOENT)
+			ret = super_wait_shutdown_killable(sb);
+		if (ret) {
+			super_dev_put(sb_dev);
+			return;
+		}
 	}
 }
 

-- 
2.55.0

