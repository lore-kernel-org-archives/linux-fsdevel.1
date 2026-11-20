Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182150;
	b=pCvLvR1e9YPPePy7I7zAZP1Risyqi6byobPjbICH/cYg2QJ8lRdBatPHIxTyqF8JtHmO
	 s7xHYH9VYCtNuiIbFvzj2+SuLerIQQB7dAC4AEyxTMFSryFKEIx8OnD3uGHRiKqJAL0Yr
	 PBWcr2z0oKaO4dfF3HfGXmzCZ4Qiuzm2A9JNc5Qd1fWqlIOxflUaT6QGpSD2jEUkVBaki
	 Bx1+c7mTuNTeESvvxFcKy0cslAZzpVZ8PqqdjBQlgcdNst/4/7chBmPvAqz/B7shXxMRZ
	 yHtf084qj2v7bMqIdlHV0tsbKTR/JIUW68ovmnbvL8uZhXfFAPOtcBfVAtP5BgKSGNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182150;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PxknjzXyKlIZbBI8K2Iy/IF94QOe7DF6NOjeL9QzLkc=;
	b=WZt3aq7SPWhoohmiPl/cndragdpyKo42rd7s6VLXeL51vgZ7zfclUIHb5gTlVqIE1FCF
	 r/BemOaeINd5vxzBgYl9vRJUTLj2wZlS8GGUtGUz4G93ALuRvHw1Dwi0va/+RLAxecrd9
	 nqoOrjJkF855J88dbJznl+xnUWcLRysKxVbLr61YfviyP6uvFkP3Lu4V7U6aWK7OoFVB1
	 bRZloJpbT31NUclu304I939QbByqQzxyyaCt5O6UNL+Kwb8WogjE1VWjc6Q0Xibje069K
	 4H+wlcQgvZio+o6SK3JS/fwjnuy8LNKgD8A18hMXSLKahRzmeRj6l5gzQPWBUKOgAag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE7K5lkT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B95606A334
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE7K5lkT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6545C1F000C0;
	Fri, 20 Nov 2026 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182149;
	bh=PxknjzXyKlIZbBI8K2Iy/IF94QOe7DF6NOjeL9QzLkc=;
	h=From:Subject:Date:To:Cc;
	b=aE7K5lkTR4egrzTaxc5ukEBMPXht8pKpIjSsNFY4eWV3ZaAzQHqS9nFg5eau1aT4S
	 HTF5bcFYvtEhabzME3ixN1AUu3F3rJR6cFOsM6qIONmCH2z43SZB9/iWVFu6Yc1uNL
	 9ucX6qweiQzi2NyXbEir3ti801+p/gnpyS7ekr/AtCKD25FStr0KjeHMfCM5imLwM4
	 cuYPXlSGvSMUPu/e+Te1QwMZirfJbPQqmEQlYcVD5Sgsy6F4MYLpoAF5AQzET8EFTl
	 SmeVLdGPa5o0sImRMPoEUygkADzh0Es3ZPWlMRegTSBhhH39/LtsvxUqhoEb3Nqi/v
	 TMJRSzvjdrfMQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] pidfd: use one helper for pid namespace visibility
 checks
Date: Fri, 20 Nov 2026 14:42:08 +0100
Message-Id: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBBEr1L22y1NjLZ4FRFpko1dlbRktQqld
 zepPwNvmHkLCCUmgVO1QKKZhceYQe0qcEMfb4TsM4Nu9FEp3eBnTA+c2AdfMsq1fOyTUHXOGBX
 0vu0M5PuUKPB3U58vf5a3vZN7FV9Z2F4IbeqjG0o1B8G2PtSbHNb1B17xI1icAAAA
X-Change-ID: 20261120-work-pidfd-pidns_visible-18c441f23784
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jiwoo Kim <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=brauner@kernel.org;
 h=from:subject:message-id; bh=avi2yEAxjJ5v1EMR55Cx9mpcbWIvVTDxij2cio+1u1k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz+Nm8vD1f553U9adnDUXYOatWae9mYMvcm2DvrZl56
 Pr+iz+tOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZScYzhf3DB3/Ljf700GXu3
 MMQ9sZDQ9Zt05Jro/bD2iVIZRjd+aTL8j3vAEsQ72+rF2S1qBYYND2V/xLYyFzpekd8zgaU+erU
 4IwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The pidfd api checks in a bunch of places whether the target of a pidfd
is visible in the caller's pid namespace. pidfs has
pid_in_current_pidns() for PIDFD_GET_INFO and the namespace and task
path ioctls. The pidfs file handle lookup open-codes pid_vnr() and
pidfd_getfd() does the same since Jiwoo's fix [1]. pidfd_send_signal()
walks the pid namespace hierarchy in its own access_pidfd_pidns().
Yuck, unify it.

The rule is the one we settled on a while ago [2]: anything that hands
out resources of the target requires the target to be visible in the
caller's pid namespace. That doesn't turn pid namespaces into a security
boundary. It just means a pidfd doesn't get you more than you could get
by naming the process yourself.

[1]: https://patch.msgid.link/20261117152332.1221-1-arpe1618@gmail.com
[2]: https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c153cb3f9f74@brauner

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (3):
      pid: move pid_in_current_pidns() into kernel/pid.c
      pidfd: convert remaining visibility checks to pid_in_current_pidns()
      pidfd: restrict pidfd_get_task() to the caller's pid namespace

 fs/pidfs.c          | 12 +-----------
 include/linux/pid.h |  1 +
 kernel/pid.c        | 31 +++++++++++++++++++++++++++++--
 kernel/signal.c     | 23 +----------------------
 4 files changed, 32 insertions(+), 35 deletions(-)
---
base-commit: 0a5864ad213c9fb2cf627a2dcd6f448a1fb7e065
change-id: 20261120-work-pidfd-pidns_visible-18c441f23784

