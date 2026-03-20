Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442F37FF6E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011986; cv=none; b=S28jHPo7aRnuYHwQFne2zaOqrS/CEVw1unn0JoMeOTA8Q95cHtOL4C5ib6lMWLON1UHWRd5/7jv2vcRFdI3y+t+294lUXFg+xS8xlgOJBfjIcfzs6Jv9JN3w/Dl6GBIVcDXXm9/Knsr+Qu/BdhDrUkovjtxHw1/y5u5W2wtZ3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011986; c=relaxed/simple;
	bh=XdWxxUi8M8qKL2a0KZXDrJDFH+bThvCMhp1c2xvASbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFR4uixWCn7qfiuynwn4l1yPnMo32pBlR0cPjJCpx5Kpmv1uAHKUxw6cmae2iLwhqQNjcNiREo4U2BiTJosr7LLoDpXzQW24Ark5QNsWe3X8Uuf9l1SFgIPfxoQGQURwVvBsoKTJ8JUSeBUwzPf9VYzPZ7qA2XIkNA549fS3U28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxhMv/O4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxhMv/O4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adbfab4501so2511075ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774011984; x=1774616784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJMkq7GVGOz9LqrIU8kFv12kmHDuU07O67kPhufriQw=;
        b=UxhMv/O4zy0wf4idZ3QX+wV57Q+syNx7awson396QI6vyRsoqIxLuK6oIhvogZJaog
         4OZFfSnx542G64AW6kX8OIQhrsNxeZWLC8sGW4Sv9zXmbnCiupcYkjF2ox0GA/q3Ny8m
         eaR5OjF3CgB+psqfyFAYABoBO50PdwwxAIGfE0nB8iH8p6+BLHyBc0kO8m6MUkEvHt2g
         wRTlgTZioHsGv5NL9B522BVV6ZVRETopQbI8wIE9Oj9CzuwjWTeI8U6dajz3/rHI4p++
         nUiVekEtaKQjMRosbQm2+EYKjiSZYAps+2qEv8vdUNtzkM9H9h0oHa1Z/QZyo28JDi9f
         GSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774011984; x=1774616784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJMkq7GVGOz9LqrIU8kFv12kmHDuU07O67kPhufriQw=;
        b=b3yliwU37qLEZ7jyedPaIJEhRwso5/hFE9HESQMcs0X+sES9alE+mfNfHOhEwmZ5vM
         vKdYKQS6zK0J/omPD6hb5USc/75gj/33KPOyaJ/Crmz6n3HYu89gvtGk3lZegKzw+BsJ
         E9rgMvJF49LmTNd6xdnt6yQrjNkKvxdUuefmhbLvseL1B6z3J/Usa79u/nJnqpKOEWAK
         0mBKk2RqdbpRzqW0oIc9QlsY1rl+RsRYbe3+IqKe/yK82eaj8LPzm2jz2RUiuvrLlLzm
         d32TbTXsM1ob5f5oOcUXADXikHKU5JlmA4TUGcqlh8mn7DJR/oxGz6+bNhh6YhuzuAKo
         u3iA==
X-Gm-Message-State: AOJu0YwtUqbYNFIYaDxckgqmMZ33yk5TEqT6MhN++TijQ7PTP1xcs2bw
	G2lefi1ngOBrNArTAw6AcP5rbUsX1aH8YvcmGPpdy4Cl09CmYNEL5sEaTVosKw==
X-Gm-Gg: ATEYQzzDPEYBIqeto/qKSKCpf4XvI5TAyoemGnvq4xKDuCtHcf/k3cUAwzq0d868bIW
	/tW186DSR25NvdmSwsHrv/1UCXYiM3my0vjsmkm+NGSBHWuEheQfmNUT6F7QLM9MWfvS/rZnM+x
	ZqZgogPt490U/Ng53EcL5/TUV0FsqjE1cXhIw0IBDfCw19euYYeSquyMI/ZdyBJ28THdNi+ngKz
	3iGkQp3cEMoc8KeTHQ5uSoA8xscZXDs76HtDAOVVQ/scD14AzaiPswYYsMwlKM+jOfi2eHVyS5C
	X7T2VAPALatjAMBnLlzM4v8EIr+AXZfztf83KJrea9jvF1XeLmb6DFPnYEbkvukERrzHQQ6WkUf
	N4LbP1SUv3rGSBsQR4Z8ohq16pjuAS3u6pDqGIF8WxfTPt3M1f77zVRe41gd4uujz4N3eoRjDLu
	NhAI8VACjHIiwUYomRDgv9H0JgDHlXBQeTRPzSZhHhxv7crnVvCfkkMsN4RbGJ8W42JYTzGml2u
	6iz0Ww=
X-Received: by 2002:a17:903:124e:b0:2b0:643b:41d2 with SMTP id d9443c01a7336-2b0827eef09mr27317415ad.47.1774011984021;
        Fri, 20 Mar 2026 06:06:24 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:a157:2060:c54e:fca0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08368eb9asm30624955ad.69.2026.03.20.06.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:06:23 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] splice: prevent deadlock when splicing a file to itself
Date: Fri, 20 Mar 2026 18:36:15 +0530
Message-ID: <20260320130615.1109449-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


When do_splice_direct_actor() is called with the same inode
for both input and output files (either via the same fd or a
dup'd fd), it causes a hung task in blkdev_write_iter().

The deadlock occurs because sendfile() calls do_splice_direct()
which tries to acquire inode_lock_shared() for reading, while
the write side already holds the same inode lock, causing the
task to block indefinitely in rwsem_down_read_slowpath().

Fix this by checking if the input and output files share the
same inode before proceeding, returning -EINVAL if they do.
This mirrors the existing check in do_splice() for the
pipe-to-pipe case where ipipe == opipe.

Reported-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d31a3b77e5cba96b9f69
Tested-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/splice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..c0ad1859de34 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1199,6 +1199,9 @@ static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
+	/* Prevent deadlock when splicing a file to itself */
+	if (file_inode(in) == file_inode(out))
+		return -EINVAL;
 	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
-- 
2.43.0

