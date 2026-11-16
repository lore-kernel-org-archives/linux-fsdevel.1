Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801013;
	b=Oc3XUl0CRr76j1fOuxIXSU5KDtbMMq7VMlfP8RNWEoK+AnT6gi7gkxg8+UbKOKRN8Bh2
	 M+aue1cC+J3DRE5Ah6CN5L1n0MYMiKUzLGD47Ko5dCNooDJsHjHglYILgiKHjgKKZzy0F
	 GU4RdiPHh/YzujTvsO41iCDXPScVc1V8df4GdzI7aeabo+WiFBytOOKDV2ShoeZsQslRF
	 lkQHoU2rKTTAUAYEJEfhnoZHbvCtFwNxJce9+Fl9DROJzSd7SlPzmy4fv6LCk4zjozlNs
	 MBfhq58CBrL513VSV4yfFcxW/qxQIOEHsC8Px0B2XBsaPyEnnGy3amVR76IQm2MH85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801013;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DVKNMHiAne/pAOxESoHWHgqgvhvXGeMeX7vs9NEnLB0=;
	b=BlsNZz2OVM7oPTObiNmreVmSJgTpEd3G6hJkIviS2G8vZ6HTQGfypdHwqDVHLqEiJQta
	 jRnl8NjEqVz1DjnmRPOwqwFWbcZv0BZBYus8RKresI6P81ifFD/woZA/U9Ci6k/2CThKu
	 zUGmJUxk7Ygpm7nqakAO3iuIqc8cpyEGvv24s3LPqml2ASOfpujL74NV3OgpCZWU1yhgY
	 2AQmEHnpY7xhPZQnLT89n3FC6BK1ewWtqU0RQNljoQqPH9kkO7Q6ElG/ghkYzRcUACWO4
	 4iW4GtgtR8rbINkLwb6rcQc+VaxdDeUerMq3Q1Af2wbjA2XHX0XnY5nU9a7nPbkzKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=KoWY5YbX;
	arc=none smtp.remote-ip=202.108.3.17
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F12606A321
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 03:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=KoWY5YbX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1794801010;
	bh=DVKNMHiAne/pAOxESoHWHgqgvhvXGeMeX7vs9NEnLB0=;
	h=From:Subject:Date:Message-ID;
	b=KoWY5YbXNZEXgRwq5fLM7bMzHwrlmY2mmDxtrqWNg27e0gDoNuFZ++luuFsLj+Kig
	 0iVve3SCQ3pDN0sPHdDbHS7ls+OQzyRKSFC3Nb9CDd65LpaMZG0EYTMebhDd+Iiht9
	 2EEl0E0ktg4YzB3Cc/LsTVg7PPL5NYU9cEXAjU8g=
X-SMAIL-HELO: lxu-pcd
Received: from unknown (HELO lxu-pcd)([111.198.225.163])
	by sina.com (10.54.253.34) with ESMTP
	id 6AFA7D6500000196; Mon, 16 Nov 2026 11:50:01 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 087026292468
X-SMAIL-UIID: 7972829F43C148A3A8F8107745C86F51-20261116-115001-1
From: Edward Adam Davis <eadavis@sina.com>
To: syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@kernel.org,
	richardcochran@gmail.com,
	driver-core@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dakr@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ptp: posix clock is available after it has been successfully registered
Date: Mon, 16 Nov 2026 11:49:57 +0800
Message-ID: <20261116034957.40991-1-eadavis@sina.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6af9e1eb.920b2b3a.148c65.002f.GAE@google.com>
References: <6af9e1eb.920b2b3a.148c65.002f.GAE@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In posix_clock_register() (kernel/time/posix-clock.c), clk->dev and
clk->cdev.owner are assigned only after cdev_device_add(&clk->cdev, dev)
returns. As soon as cdev_add() executes inside cdev_device_add(), the
character device is live and can be opened by userspace. 
If posix_clock_open() runs in this window while clk->dev is still NULL,
get_device(clk->dev) is a no-op and fails to acquire a reference on the
device. When the file is later closed, posix_clock_release() calls
put_device(clk->dev) on the now-initialized pointer, causing an unbalanced
reference drop that prematurely frees the struct ptp_clock; subsequent
invocation of cdev_put(inode->i_cdev) in __fput() then accesses the freed
memory, causing a slab use-after-free.

Reject posix clock open if it has not been successfully registered.

Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Reported-by: syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=667788430769ef9ddf25
Signed-off-by: Edward Adam Davis <eadavis@sina.com>
---
 kernel/time/posix-clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index dab37295c8c2..37cc015cd8b0 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -99,7 +99,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 
 	down_read(&clk->rwsem);
 
-	if (clk->zombie) {
+	if (clk->zombie || !clk->dev) {
 		err = -ENODEV;
 		goto out;
 	}
-- 
2.43.0

