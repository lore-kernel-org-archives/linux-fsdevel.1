Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168030ACF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038420; cv=none; b=BEkIZ4RSpn88u04DUdTvIVdioyjeobw3AYghNeow85xN+6U3RBsic+tdkJyoknYF5LqBSVXNQPiHGb8rsWKHmlyV8FIO2MBxkbZbhkU0TUR0tKSubrkgohYummqD/P+HA4NaCxCgHthpf0LdCa+nT1rObq5GOTMWRmXs9EQKeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038420; c=relaxed/simple;
	bh=BDYPJ67P2eTFZU6F52gAo7pHVJG3afRZPB0osNnsy38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaX00M8upBbew3XSqjilNMxUNI/W0nP8vXKey17W8JviX0Ra2Cb5jj8HpCR1yrFP1sJG38UClevdsE4+ThpOf8KGEEvcmR066WpKuz/bHoYEFNIJZrzMHs3Jq+KvTbQ+CQMvxv25X85chrdWv3ME6zLntb/WUVyNwj0V57Ii2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/1HfMwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/1HfMwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD22C2BCB2;
	Fri, 24 Apr 2026 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038420;
	bh=BDYPJ67P2eTFZU6F52gAo7pHVJG3afRZPB0osNnsy38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J/1HfMwfmmFl8MWgIQpEVla34iSRl+jp93R+B/HxJTgXgBnjQj+bQ+AZ/9Zzp91hl
	 FHHHLVTGXzgCf29aFeivdRdKEvZ6CQdFTGvy7OO+YXwdgH8+ZbfG3Xn7ze0QFXj9uY
	 sphaFHjyiPojF7grRwKBb//Oi0bzk/D2UZhdmyItLU5S93TTYdFVZTA7fwKJe3h8ZZ
	 Nwe65SBq3dpZOeDbNGYHDv5s4UblIi+hkuFxYOtVyRRiXsY4glsPxunLCYlrIxgYcl
	 jeup6i9OaoWoL4Rf20ObxsR+TAV6VabbZLxCP7+tLk/SfAx3JvDl3l4v396j1UQqfL
	 6iQzov6ZbRM5A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:37 +0200
Subject: [PATCH 06/17] eventpoll: rename ep_refcount_dec_and_test() to
 ep_put()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-6-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BDYPJ67P2eTFZU6F52gAo7pHVJG3afRZPB0osNnsy38=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnH/klrOoyTGWso9Y3Lpj3+HX03/xyY5cZ1XoNpGJ
 9mz2yzbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSE8nwV2bDlgtHF9Sp7Ngk
 bPdsU56urITFv2WtAkwpgo/S8j8WsjIybLiS03S13/rNr+LkH8Yvtx8PO2Xs16oW+yx5hWlEo6g
 cGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_refcount_dec_and_test() mirrors refcount_dec_and_test() verbatim,
which reads fine at a call site like

  if (ep_refcount_dec_and_test(ep))
      ep_free(ep);

but awkward at

  WARN_ON_ONCE(ep_refcount_dec_and_test(ep));

and does not pair cleanly with ep_get(). Rename to the idiomatic
ep_put() and reword the kerneldoc to spell out the return-value
contract (caller is responsible for ep_free() iff the return is
true). Leave ep_put() as a bool-returning wrapper -- we cannot fold
ep_free() into it because ep_remove() calls it under ep->mtx and the
mutex would still be held when ep_free()'s mutex_destroy() ran (see
commit 8c2e52ebbe88 "eventpoll: don't decrement ep refcount while
still holding the ep mutex").

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b6a14c69c482..da31a3ac6057 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -969,9 +969,10 @@ static void ep_get(struct eventpoll *ep)
 }
 
 /*
- * Returns true if the event poll can be disposed
+ * Drop a reference to @ep; returns true iff it was the last, in which
+ * case the caller is responsible for ep_free().
  */
-static bool ep_refcount_dec_and_test(struct eventpoll *ep)
+static bool ep_put(struct eventpoll *ep)
 {
 	if (!refcount_dec_and_test(&ep->refcount))
 		return false;
@@ -1100,7 +1101,7 @@ static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	ep_remove_file(ep, epi, file);
 	ep_remove_epi(ep, epi);
-	WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
+	WARN_ON_ONCE(ep_put(ep));
 }
 
 /*
@@ -1160,7 +1161,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 	}
 
 	mutex_unlock(&ep->mtx);
-	if (ep_refcount_dec_and_test(ep))
+	if (ep_put(ep))
 		ep_free(ep);
 }
 
@@ -1339,7 +1340,7 @@ void eventpoll_release_file(struct file *file)
 
 		mutex_unlock(&ep->mtx);
 
-		if (ep_refcount_dec_and_test(ep))
+		if (ep_put(ep))
 			ep_free(ep);
 		goto again;
 	}

-- 
2.47.3

