Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031E1FB1;
	Sun, 24 May 2026 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618496; cv=none; b=B8pUxhldnBSt7OXPSHswfQ8pUJJVWlpLW7/Wzvt7m6tANyjQItbjXZjXBziyA6BeBI0DNU7X83j0M1nWJ8iyK1mrSZzFUXO6StMW9ODxujL2hGF28TNiBg8fWM5YPbTfLIbhL7yi5+zyI3He4G0V9avAeHmicvTArVOO3LRXC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618496; c=relaxed/simple;
	bh=Xb3AIuA6w17BTO2YqXiZP2hbyLk641gzWXXjki+KnKY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nZNLsYghHHii8QLQO4Pde3RDVFdk146V/b9pxOEct7E6r003fnPt6an7XWZLPAgcaHFV5LcGr1LMyKQSLk3wloMhBpvnkciTbCGBujQdy4u1XsdIDYbPSUo1zQvOdQsYREUKYqleR1DIr7AKNoL3H5hUUi8ZR/8/iciQctQSI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZuiE4kSk; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZuiE4kSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779618482; bh=9PnlQJZqYOeJVAOHUkjCwwX3UOWTdgUchO08xYvFH3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZuiE4kSkBQi4hh65fHWGXiTNZTD25UpU4ld4Hg1kMsEJ3dVSl81NjJMz6d28mloPu
	 qg28oXyoGnrt5uRvvgkt1cTm9l0HO3Y8ui1UanxBcnRYFTA5qbq3EfD4mYWFK5NBO2
	 d9WAOC1+ZKYst5nxbyMqP4mZXO7iZi7mXIi/K5FI=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 6FB2382F; Sun, 24 May 2026 18:27:59 +0800
X-QQ-mid: xmsmtpt1779618479t8d9aawwh
Message-ID: <tencent_C65896BCE9C2EEE2CCF078666E102DC56D0A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G2uGFb4f/iol6kckihl2viM6jNMoyzLNTaOlfS1ufgrtXdMGKNQ
	 bXTlTpiPOw6BaQqhudgjoL1pCU0VFEeXxgGKvrmJNLe9zLUmESIwiUw5nfmIrEdqs6+IRBQjWPLF
	 N1bp2l3e0yapKXY5VWAMrQYr6dbskSfOAyK9dFiJBdBh0gp3Lwpctb0hW4bumiZctmbwbsf0O7CY
	 UxXlcphRK27ycHf1qAebuQal83+RA56SSuXtS6KKOeTqjbj0ztvOzi1hLJTlxHfVZEdsVIuZSVm3
	 GzE0iy3c1ypPLfEfY5goJF/YHSl8qpIeQUGKQg1b1R0QMeJLjN3we8Dn8Iwa7bgSzCGMjQ44ALbk
	 0apYi2oxnieaG1dMRsSl5N9wX594UVSnD4QzxosNxODByN6VcsfN1TEVfGa0MtrZqFo2PGR4VeG7
	 hNp3Ut/ISUYn2Fd2LTGUM3o901RoEJSk55Z9CUuB0QEdRgWH8eRqzCP0amsQy9YI/ol+wMtZ1ogc
	 ZQ+tXBRUA3KKg03u85nhS1/pt7HwlMkWOYjQ7E2xSrGes8X8xpnCH3fe4dGa266ZxDlAHRi2xr0R
	 8VKZn/TALLd1eE1rxAhAwoQ6QlprcmhadbFtgoPlWMNddLQJT5pIdi0hHQ0JUGsvjaqo2kn9V4yo
	 9dQ8yHKwaBjzephr5FQdXlLNCfVGld9Fcwa2zPlFJJi7/J480Iit2Rm+/fsxQXXiEuC15QOujXpi
	 TCzDxLEwJjoosfM9LSBfHk40zYG0CN1jsKJfcNey/PYSL0ZMRls4uAzZf4xb46LWaOASbRX8MIMU
	 ie/yla8/lFC3J7Cm1oqKKp6bb1aNlAtOvn2JbFGsfg0yMoToc2VnKHJrq1rfzAjOe223TF4g8eTR
	 rewoJAGnydZN4U4U90wm/+Zi7zMcowndgBZd48Ji0uHZBFhS49Dtq9Qa3+ZopV9JAeZV8/Nz30dU
	 953w2Xs4Q09qwiz8s9OT5PUh9FoVxkZllTVYLU8c00MVF0KqR7yEwmR5IYTkzvdvQ5Df38r8uX1h
	 84563giaw0oWhw9drI
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH next] eventpoll: delay file list memory deallocation until unlisting
Date: Sun, 24 May 2026 18:27:59 +0800
X-OQ-MSGID: <20260524102758.105414-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a10a5e1.050a0220.66ea1.0008.GAE@google.com>
References: <6a10a5e1.050a0220.66ea1.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e09c77d94003 implicitly sets the head->next value within list_file()
to NULL; this occurs because ctx->tfile_check_list which resides on the stack
is initialized to NULL. This introduces a potential risk to ep_remove_file(),
as the decision to reclaim epitems_head depends solely on whether the next
pointer is NULL. Prior to the introduction of e09c77d94003, the presence of
the sentinel value EP_UNACTIVE_PTR prevented the next pointer from becoming
NULL prematurely; the next value would only be updated to NULL during the
execution of unlist_file(). 
However, following the introduction of e09c77d94003, list_file() also updates
the next value to NULL, which ultimately led to the uaf reported in [1].

To mitigate the risk posed by the potentially NULL next pointer, the memory
reclamation for the file list originally performed within ep_remove_file()
has been deferred to unlist_file().

[1]
BUG: KASAN: slab-use-after-free in clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
Read of size 8 at addr ffff88803f021568 by task syz.0.74/5985
Call Trace:
 clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
 do_epoll_ctl_file+0x8fd/0xed0 fs/eventpoll.c:-1
 
Allocated by task 5985:
 ep_attach_file fs/eventpoll.c:1751 [inline]
 ep_register_epitem fs/eventpoll.c:1833 [inline]
 ep_insert+0x512/0x1820 fs/eventpoll.c:1876
 do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
 
Freed by task 5985:
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6411
 ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
 ep_insert+0x1372/0x1820 fs/eventpoll.c:-1
 do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651

Fixes: e09c77d94003 ("eventpoll: hoist CTL_ADD scratch state into struct ep_ctl_ctx")
Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/eventpoll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a569e98d4a99..66aa4f200909 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1080,6 +1080,8 @@ static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 			v = container_of(head, struct epitems_head, epitems);
 			if (!smp_load_acquire(&v->next))
 				to_free = v;
+			if (!hlist_empty(&v->epitems))
+				to_free = NULL;
 		}
 	}
 	hlist_del_rcu(&epi->fllink);
-- 
2.43.0

