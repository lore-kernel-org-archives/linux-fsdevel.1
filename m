Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28313F9F5B;
	Fri, 16 Oct 2026 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145691; cv=none; b=rOax3pAX4yDVPOm0RpdvnDycObt5EHzj/y/v7GHuLwdrYZx69FUeW8tP7i8AOsJYCbIB0V5QNFo9hsBN+V8IYC65gBR8bIoNVb5cvhYxZUBuflgtN494LCb8PLawykhO6SO1zXuzdVQaa99OlEeSFho1p2BN6T0fWyDQm7l0qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145691; c=relaxed/simple;
	bh=e7OBb9pF+IkUOnEvMXXdpg74q1Aiy9bNt87C3uTd6mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcHkXohZ9aVSv06qEHUHyiOhtypg80nm0Gmjs/5z5sLxOfpZdfeF5cZdsN6owDzMmTY74u9TQIeE1eW6sNJqHQfX4ZpXCMhlMw3FDFKOTpuF8QthBV92mT1pAHJVS9lW/OPT44JKyiAIdu5S9ZVyRwx17/ya+NXPZ5cHKjgE+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fazPdZB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fazPdZB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6801F000C4;
	Fri, 16 Oct 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145690;
	bh=6+dkwK0P3R1ISpcL4NeHbYQl7x1iyjIKKx9iTC+YSjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fazPdZB7bUwg3wEP07zuRPUsQwgvM9Ga39ZJZopBCBDCnxvGTHttdQVNtGvOmst3N
	 AGbp1dXhhULIaT0RDEn1EDM/WstAYR4sZ46/wVxZEjVBM6pphNv2nwGV6OLEnxzJ2c
	 0KmgtjWkn0HZCHDkOWuhT+iNQUQIgpqEe+5DLX4Zrd+68SBbHJaKhi054rXmbkiAL5
	 5QmpKK+JzWscJU/uO/qvIViEoeT0Hw4XPCFZMxR2YBK1rLYMmZycRfm8NzzvAIkmEd
	 noD6X83P1eweHy25CZ7wsHTqCUIqYn+HygHVXZEp+H2NlXbKIjUSBKCbNKjqTeFG22
	 7cIax5EiroiMg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/19 for v7.4] ipc misc
Date: Fri, 16 Oct 2026 12:14:16 +0200
Message-ID: <20261016-ipc-7.4-rc1.misc-e31c975da358@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=brauner@kernel.org; h=from:subject:message-id; bh=e7OBb9pF+IkUOnEvMXXdpg74q1Aiy9bNt87C3uTd6mE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/MkW1lh+bqPxhOMFeq/lb3Qb3jDKWKp/wM1sb6cWV 1+2X/iBjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgJtszcgwZWue9rt9e5lPyuwW /Oi58yd/4dmv1+NjK67JFa2RPujjzcjQGlP9VOzLpV6WlO9HKk1+s4r55j/seTRf3vHFervtj/c xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This fixes a leak in mqueue. A task in another thread group sharing the
file table could register an mq_notify() and exit without closing the
queue. The registration was never torn down and pinned the notification
skb, the netlink socket, a pid reference and a user namespace reference
forever. Stale registrations are released on inode eviction now.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/ipc-7.4-rc1.misc

for you to fetch changes up to eb85469f0dd69ca145d63117450e14c31f67f698:

  ipc/mqueue: release notification resources during inode eviction (2026-08-31 12:30:30 +0200)

----------------------------------------------------------------
ipc-7.4-rc1.misc

Please consider pulling these changes from the signed ipc-7.4-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Daehyeon Ko (1):
      ipc/mqueue: release notification resources during inode eviction

 ipc/mqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)
