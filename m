Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B422F3C22
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038424; cv=none; b=ZdsEwQzCv5JciefZR2OteaGeeCaF0bW0R1JdLH4LbpJ3+x7bws2MuNSulIEOO4OSwYcuU4vkFDhXiAbC0T9JR2MbVxZvY13bN/ZUkJLZa4MK4FjdDOjqNATO2+XDFt+Tjs4suZtunhDfJ3r+1vuenAKD4F78fiwB1XtzmMld8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038424; c=relaxed/simple;
	bh=pkWRAFgFEP8YdKg1ykdHtNj9S3gw+K+Cgdhe7z9+qXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cs+301oggoSZcnq60tI1lHf9qcdpnrbU8Xf5qM/LWm/daIbh8ydL2chwFKBBomvFyuTVbrcMNsnG+XKJh8Z1atp/LmfrlTFwwwPa/AUj6ei3DR/GGaCJF+TURccQuc54uiwUDGUJjjriQrL3XZOBPNQcDPedYRXGWxdMtntbXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGzSQ5e4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGzSQ5e4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A17C19425;
	Fri, 24 Apr 2026 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038424;
	bh=pkWRAFgFEP8YdKg1ykdHtNj9S3gw+K+Cgdhe7z9+qXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PGzSQ5e42vIe6D/lHNg/SRIe2wC2B4nE8o9TF5bzd+Ml856Iej054uPvKEPnlmJpv
	 bt7MLpq9fqTmgVlI30zlopT3XY8FUxitneqAWNZQI+rpOBPluGP5E6IfPV+9xZRSAc
	 KBt/rtbJPCZtHiHe8SwJ9E4enf9/paJmsSsZ/J4LU4HMOHzmLqaiuxi0+2J+Aejjd+
	 3DoVKvVjXswGd6zLM4gnWEdVmoiMg6fecGyPXb/ggH3t1m9GnRipKJ+y0SmxXH6ed/
	 CMZLxTl6JwFbaAbfMi/sKfj1E+tcXYhMKkvYdEdC6F98UiR6gJDweewwu6IsBwRGc/
	 b0jcgh3HmFE2Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:39 +0200
Subject: [PATCH 08/17] eventpoll: rename attach_epitem() to
 ep_attach_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-8-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pkWRAFgFEP8YdKg1ykdHtNj9S3gw+K+Cgdhe7z9+qXI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnE/qR8kpiCpUeCsw3OHzWRWcPEvpUN2s683PPgX+
 z/tquP2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImcn8jwV15kidYfN5ewtjmr
 H5xuuyaX63lf/febq+vWHvZawOI9+wojw/cVtkyi5TfYZ1Sf+M7H586nq1K46Lm6Q7Bp9Io1X8u
 38AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_remove_file() tears down the f_ep linkage that attach_epitem()
establishes, so the pair should look like one. Rename to
ep_attach_file() for the "ep_*" + subject symmetry and to match the
naming used elsewhere in the file (ep_insert, ep_modify, ep_remove,
ep_remove_file, ep_remove_epi, ep_unregister_pollwait).

Pure rename; no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ba1017c72167..1fe9f1772a28 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1735,7 +1735,7 @@ static noinline void ep_destroy_wakeup_source(struct epitem *epi)
 	wakeup_source_unregister(ws);
 }
 
-static int attach_epitem(struct file *file, struct epitem *epi)
+static int ep_attach_file(struct file *file, struct epitem *epi)
 {
 	struct epitems_head *to_free = NULL;
 	struct hlist_head *head = NULL;
@@ -1806,7 +1806,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	if (tep)
 		mutex_lock_nested(&tep->mtx, 1);
 	/* Add the current item to the list of active epoll hook for this file */
-	if (unlikely(attach_epitem(tfile, epi) < 0)) {
+	if (unlikely(ep_attach_file(tfile, epi) < 0)) {
 		if (tep)
 			mutex_unlock(&tep->mtx);
 		kmem_cache_free(epi_cache, epi);

-- 
2.47.3

