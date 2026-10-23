Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748546;
	b=H2tNqsedDs4EaYjIObOEVtfqmZwBT7OrFwkEtiV13bdxWg5FWh/Eg5nAhOkz3sAUYoV6
	 YNhZEl1bNcTqrfbAF7RkauplQvkEEApoIcUS+yAEqjaURftkxhc2D8l8R25WODLlWJAoP
	 kK3MtzrTpQgSEsfLJo7exYG/Fzi9rt6omMuu1ldf8uJoxSD9nH1xYbFSN4HIDPIYalxdE
	 8ARKpP0CZRj2Ia733v+18nwsI5X1+DyCHahMsmXHWVNkHmNlhSNYLyux9prdRDC/Sgr3D
	 RAGX5T5Y0mSsdATnQcKcq3O4FtdO8XC3HUSQ37qrtIIV7htvWMvM/gQvsgSsu789XuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748546;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oh/m1aKD1bwYscoUU4LXYtJgxXywOhLrIG+rElCr0lQ=;
	b=Nvp9YhSDZf5vqcznXH7Kqo8eFlEBUFWvGmhfl7M5ecwruk9TpvNF8Agqye83fOVpmfy9
	 l26a4TmfaV5yZAiEbq8irM7aRBO9/E5kLowiiA2FyQA00lG5ge7zqc8ffVzsoesJaemSo
	 Iqr/11FRYysrHsKapzdSAjld1Iw+DjI1Rxh8wQ72+yllf7kMjcBT562UFVMmf9TgtpMe1
	 CDI8ClaTiKCdDksavq65D+gJ9TQkU7amqZiKKdnKk1YwqWYrzYe0jwrM/drS4IYCfn0de
	 qg2z5fh4MhmOfpUKjI8tj2nE6zltVxyrlpvs6YurNNBtAa9metcV2jP0hMYWZGmEB+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VP5BZ5Ki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8E606A31A;
	Fri, 23 Oct 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VP5BZ5Ki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B851F01825;
	Fri, 23 Oct 2026 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748545;
	bh=oh/m1aKD1bwYscoUU4LXYtJgxXywOhLrIG+rElCr0lQ=;
	h=From:Subject:Date:To:Cc;
	b=VP5BZ5KianjYCOaonJXfdbsIyDCybVficmOW9MUNDeo6B+TH2+F4chPElzBylSCsW
	 9tJju1IDZgFvgJY0wimc6qHCRGQFosF+wdXtLudSHF9riX9B5RTbKGbrBf/eVq0E0D
	 wiyc2wDzvw5taR7qR6WhnH/C3z96SFUSLl04fs6XEAIoDN2jKLV4nJuWgY6bi0rwjM
	 vlX81OQG/LCW1EgktZaveGtnx3iWjrBfRGJjcqcuCGfQZo6Ehmrrnoyb/J6PmmaOkk
	 lgpQQRFDTnSRtxalvV55EXQOuVxEpXlZv/ASIfHMIwX8usJpNOXZzRbyXCMwqIXRO1
	 qV6OW3cCU108A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/5] super: rework super_lock()
Date: Fri, 23 Oct 2026 11:41:00 +0200
Message-Id: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2w6CMBBEf4Xss0toETH+CjGml8VWCCVdQRPCv
 9vi25zJzNmAKXpiuBUbRFo9+zAlEKcCjFPTk9DbxCAreRGVrPET4oC8zBRxDGZ4OBpTZpS1vVr
 ZtEboM6T3HKn338Pc3f/Mi36ReWddXmjFhDqqybhcrT1jWzbl4YZ9/wGykNIbmwAAAA==
X-Change-ID: 20261023-work-super-lock_helpers-23d8d257c1b4
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1bruCOedq7ETe1V/2r6hgXJDUNrkwKn1xvOFjpwcCa4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd1v77lKWiumpp9uLLffovDnCu2DHlSuBH/z2x0Ybm1
 5od+HtLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiy83wT8tpeasufxuLeI7Q
 vvrItpBd5V6TnBiNXBelX7wRGZkvw/BXRuLOPvG0SO8C+7t/vSfd4j853fNTT3yYSfkhdo6Zd9b
 xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Josef's two series (cf. [1], [2]) left us with four ways to lock a
superblock and two ways to wait for one that's being shut down.
super_lock(), super_lock_shared() and super_lock_excl() return true on
success while super_lock_killable() returns 0. And callers that need an
unmount to be over pair super_lock() with super_wait_shutdown() or
super_wait_shutdown_killable() and have to pick the one that matches
the lock they took. Jan pointed out the bool vs int mess (cf. [3]).

So fold it all into a single super_lock() that takes SUPER_LOCK_EXCL,
SUPER_LOCK_KILLABLE and SUPER_LOCK_WAIT_SHUTDOWN and returns 0 with
s_umount held or a negative error code. The first three patches don't
change behavior.

The fourth patch makes sync(2) killable while it waits for s_umount of
a live superblock. Right now a freeze or remount that's stuck under
s_umount hangs every sync(2) on the machine and nobody can kill it.
fs_bdev_sync() already works that way.

The last patch adds a guard for super_lock() for the callers that take
and drop s_umount in the same scope.

This sits on top of vfs-7.5.super which carries Josef's series.

[1]: https://lore.kernel.org/20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com
[2]: https://lore.kernel.org/20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com
[3]: https://lore.kernel.org/tmw22jj2hn6g6lklme2j3rsfjvmstzpoicvibvmmv6sivd66oj@nhc4lng25gti

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (5):
      super: add super_wait()
      super: let super_lock() take flags
      super: let super_lock() wait for a superblock being shut down
      super: make sync(2)'s wait for s_umount killable
      super: add a guard for super_lock()

 fs/super.c | 340 ++++++++++++++++++++++++++++---------------------------------
 1 file changed, 156 insertions(+), 184 deletions(-)
---
base-commit: e6d8f4efc8e2301e15de7bcf9e8d3a2134fb058a
change-id: 20261023-work-super-lock_helpers-23d8d257c1b4

