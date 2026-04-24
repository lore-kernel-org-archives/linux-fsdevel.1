Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0F353EEB
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038422; cv=none; b=IT1T7r0Rl6ckwJw4WNBvFbkZFwkazNGqoPKGtnUP7/wVa8aZtkAYvvpJcIIQ4Rr1KwKCDUU06cTR4mv9eNoXYrHzN7yRKIkgLiRq2yC2+1ufKslNl3+UIzeePJcHdgWo8aJxQeKAuZIHGoGrPgDrcgPGKA1moBCXKD0nbMDcTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038422; c=relaxed/simple;
	bh=7ZmQldM83mJaWzIf2qop/MLbIG9rm8tAL4LReYnObJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keuXWNPE6YJD+CfK1G9kyTktwVwVvtrFCK9qglMhzIGRHHz53BXkIM0T+1C3xXOTinZeQYTJ+cqhIPAk8IH/QQKX970mb7qUck1rQ5MLC0Y+77faB70q7f7VMd0jTQcROnfmP2miZu35blp5TWLy6gEZ18ReeDhSiMQwyeMjXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWZnlkzs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWZnlkzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074BEC2BCB2;
	Fri, 24 Apr 2026 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038422;
	bh=7ZmQldM83mJaWzIf2qop/MLbIG9rm8tAL4LReYnObJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tWZnlkzseBX9nqNeTinaWoemmz0KybKGu7EBUbT8AgYy3R+RCK+AYLOLKcJ6Hj1j2
	 92zHQd2d+ExLG9kj0WA+HyInAeAyrZ+pMnoGY5igr83p8upcy8RgWkJrIR9Fp1QMR6
	 XO8qLTJU6JYB4GlfyLmPHeIHUngdZVQ4SjYFZNSh9NpsYl1jm3VfAHkJej2WC5Od1f
	 Lt5IZ7SpGh1w+h4XZPcPrNj71K2N4MXJilFfhkUnduNmkockUyPbi0D2NwqKfZ0vhk
	 WwDirDoOlTWMMfTIBps9GyWdUiwTpf30rtDiRub+MGGPMAbKRlVWwZondItgRFrw6o
	 61EZDeolxBI1w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:38 +0200
Subject: [PATCH 07/17] eventpoll: drop unused depth argument from
 epoll_mutex_lock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-7-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7ZmQldM83mJaWzIf2qop/MLbIG9rm8tAL4LReYnObJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnHPuXlxz1YGhpCQggf3T3DIaBTJVC+PC0io0Px95
 MX5tOPfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyz5Lhv5fHbvmzWbsZLrxa
 q86uI/Ju/uMvoldknZd/nrJAmGkGuw4jw+uSHZcW3zvV+PjwAecNBi8cPb713BFZt/HD9hiXNSs
 5VDgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

epoll_mutex_lock() has three callers, all in do_epoll_ctl(), and every
one passes depth == 0. The argument has been dead since the helper was
introduced. Drop it. Because a zero subclass makes mutex_lock_nested()
equivalent to mutex_lock(), switch the blocking path to the simpler
primitive as well.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index da31a3ac6057..ba1017c72167 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2432,16 +2432,13 @@ static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
 }
 #endif
 
-static inline int epoll_mutex_lock(struct mutex *mutex, int depth,
-				   bool nonblock)
+static inline int epoll_mutex_lock(struct mutex *mutex, bool nonblock)
 {
 	if (!nonblock) {
-		mutex_lock_nested(mutex, depth);
+		mutex_lock(mutex);
 		return 0;
 	}
-	if (mutex_trylock(mutex))
-		return 0;
-	return -EAGAIN;
+	return mutex_trylock(mutex) ? 0 : -EAGAIN;
 }
 
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
@@ -2513,14 +2510,14 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * deep wakeup paths from forming in parallel through multiple
 	 * EPOLL_CTL_ADD operations.
 	 */
-	error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
+	error = epoll_mutex_lock(&ep->mtx, nonblock);
 	if (error)
 		goto error_tgt_fput;
 	if (op == EPOLL_CTL_ADD) {
 		if (READ_ONCE(fd_file(f)->f_ep) || ep->gen == loop_check_gen ||
 		    is_file_epoll(fd_file(tf))) {
 			mutex_unlock(&ep->mtx);
-			error = epoll_mutex_lock(&epnested_mutex, 0, nonblock);
+			error = epoll_mutex_lock(&epnested_mutex, nonblock);
 			if (error)
 				goto error_tgt_fput;
 			loop_check_gen++;
@@ -2531,7 +2528,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 				if (ep_loop_check(ep, tep) != 0)
 					goto error_tgt_fput;
 			}
-			error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
+			error = epoll_mutex_lock(&ep->mtx, nonblock);
 			if (error)
 				goto error_tgt_fput;
 		}

-- 
2.47.3

