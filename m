Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E3212B2F;
	Sun, 19 Apr 2026 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776576431; cv=none; b=cfhnjwSG0Q8ekGyE0qhAIWOEGQtjNPnCxbb/UGA1wGKHL53fnB+32BVjwdqJ1DS9as+JQG1cU/bqUl8cI7mzkpaP5CahLo6+Fg4sd8pMbfJwJc3fnVJ1oJggI/JUmHax6H/sy0+bd7F5arJ0m4hn4Gab26ZzCIhnCYVNykRA+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776576431; c=relaxed/simple;
	bh=PSSI6Le2HLDnJbLBlDeLUo+geEcd7KbRX8BD0ZX0Yeo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=N4qFKpnKFDQLPJ6fWWz6r448+R/NxIlT8iAlHHb1ALrRv6PwcKfyIBlYO+LvDLpxVvCM66lb6rOjnDewZMihTjhIG7Dd6eMpUGu+I3i2lR1Jv93uw+smE1bNjSbOC14S7yqkiLjg/ITU129PtOnsR81gkIqGIThmq4r7kiO6pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LU7nb4bx; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LU7nb4bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776576418; bh=epI6OFlB7icFocyhzO1+lcpTbkBk2nDn6pEBo0JawSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LU7nb4bxm7wto8rIbPpfIv7NYyspKgVEUcdep2708DKNX6WtnfvziUgNst99U7Q+F
	 31AksNniq5y2kx+DqJwaGBYpnZJy1thHKL30byBslp0efJOpawFxfqDd0dNqp2vb3x
	 ygJ3AflnH+5spxXK9yJ2qxByTn06q8x8TxVKn6Po=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 6B723677; Sun, 19 Apr 2026 13:26:55 +0800
X-QQ-mid: xmsmtpt1776576415tqhe0ecpp
Message-ID: <tencent_B2A5880DD99212DDDF5D9E9915CFAC8D8607@qq.com>
X-QQ-XMAILINFO: NCJFlKxSknUZplNoNFIOVwqHMUyJ7u84KRjrvtdqcjZ8XuGm8L1JFEjaeQiQhB
	 LGLsr0ps4f1VsQhwLJbXwhGVBJSF1M59JmfMC2R5cwV/dGn3NLAFb5I0LEsa7qc7yKt2ZG/a2i4h
	 op7IqBQRxxEADiyXSpDNla0w+kbOoeNj+DI3R/Gkh860L0w4CxJhxZTQR1MhQT1L8N1CeHQtEArn
	 lUJ8GhkpKRT4aHFsgLvfDKvcMT+Rt03BbIgHIgySXw0j+wVimBzz3GYmbBUORlw6RtnrtDgE3YCx
	 JIt9J1/Ug4C9vPBW0+t0hfV2C0p08WNpxJaWYLxUSyJaLBylT00a0BUXLWTyosRJxQPLpVkc6DVY
	 veuSrPvgsZsUcidP6IFSL3O22uuH42U7FY4xvl/bx2BmpW6w1/xSsbUoywLSZC3CkQvwxaGXkv8n
	 OkaawdRVI2wWR/HH7CTwbgBuZScj+RzrWRe5KAWhZ7/rF6HafUtPg3vci+xrad7yo2waF9/Ilcv0
	 aK/G/M0VcHYb6jObXNiqJOC2n4jCJF+HGaJa77g6W/9pPIXHCTQt/W4ZAXRATCG7tEVhVPFhx3PT
	 sMPcnvEAIFD3BsggqnTfDEnGrbd2MrhR5MF1de3afH7JR+SPHdBGNXemS8d1/E8GlBLG7Oas/ay6
	 QNMTNxgEY4HFnHPItwZqXT3bodRA8sYKraUa/fl9NwFyXs/jOdEntxh335Byg1n1a+CIkoYTwfLw
	 71Z5mO1KS7EG2OXg9EBgD9tAyHwd0nOtEvhEL6GeRtiVuqzAUHFD3din0pf64kfmZdqKnDzMZoP0
	 tazKgGK/9jgI/bs/+3XvZYynwfBqAljiYiueaFwpDgZkMdrlK8YzuS5QP+74BQmO9sRXG2RXLLuo
	 lcGAFnKcmMzHUt0rADOfjELyFHEW0z71J6vbUfeftc5DxYDSjcB7+R6RLWo7Reu9AFG6ePcsmDT2
	 XcdOPfpx1UTf43Z2eqIcp40aZLsb+Rbt69iCzR/+mKcQRVRTH7rErxzdKHeviLbkBn/gqHmHkDya
	 EsbmbPQBFfpP9vPh7D
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+eede1fb91fb15bbbd5f2@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] fuse: avoid using the same file descriptor when cloning
Date: Sun, 19 Apr 2026 13:26:56 +0800
X-OQ-MSGID: <20260419052655.496929-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69e1934c.a70a0220.7229.0010.GAE@google.com>
References: <69e1934c.a70a0220.7229.0010.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fuse_dev_install_with_pq(), after updating the chan for the new device,
the fch->connected value for the old device is set to 0. This logic is
fundamentally flawed in cases where the new fd passed during a clone
operation is identical to the device file's fd; specifically, during
an unmount operation, this prevents fuse_conn_destroy() and subsequently
fuse_chan_abort() from terminating pending requests, and the wake-up of
the blocked_waitq is also consequently skipped. This triggers a timeout
in fuse_chan_wait_aborted() [1].

The original conditional logic has been restored to correctly identify
the new device file.

[1]
INFO: task syz-executor:5986 blocked for more than 143 seconds.
Call Trace:
 fuse_chan_wait_aborted+0x15b/0x250 fs/fuse/dev.c:2212
 fuse_conn_destroy+0x1e7/0x3e0 fs/fuse/inode.c:1969
 fuse_sb_destroy fs/fuse/inode.c:1988 [inline]
 fuse_kill_sb_anon+0x1ef/0x270 fs/fuse/inode.c:2001
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312

Fixes: 88bf1f670f99 ("fuse: simplify fuse_dev_ioctl_clone()")
Reported-by: syzbot+eede1fb91fb15bbbd5f2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eede1fb91fb15bbbd5f2
Tested-by: syzbot+eede1fb91fb15bbbd5f2@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/fuse/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 25c5c853a791..7c130656c4f6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2291,6 +2291,9 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 		return -ENOMEM;
 
 	new_fud = fuse_file_to_fud(file);
+	if (fuse_dev_chan_get(new_fud))
+		return -EINVAL;
+
 	if (!fuse_dev_install_with_pq(new_fud, fud->chan, pq))
 		return -EINVAL;
 
-- 
2.43.0

