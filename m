Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120524C041B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212991; cv=none; b=dRUrGRi5drz4d3dWq278p9QRspTYZjmOdoKHKgIiL2g3PHI0BzRg1LT2511pLNKG9pAc/4WsmkOBUoRljfR+O+2E/srpeGr8lL9RHqTPTV7nRHQEGCE7l8leK9yPgdG80ZmD/1SvJSXqHhwYKlD3HBZ8fwW/p+C3kZl5lUaHi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212991; c=relaxed/simple;
	bh=f/woB4zv5hScqqREFIP6f53WqZ95GL6Jj2Xs5j03KO4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IrRm59DDmIrNd+2TQEgXlcW+H355oiEYU/HvN0LY6UxLywr6gvCitTfTTtdWH7oo/KoUemUVNzl1z2p39fhYz33Zr5gSWtGH6rfwzOku57mk7t6p8vtNp1gFFwZuwiPo6Osd5HUkB1w1N0+kMmpHofCLMl+Pu1a/gpnne2uy6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=Ri3ctAsy; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="Ri3ctAsy"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8acdb1ddd96so12262207b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212988; x=1791817788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4D5E7ltBzHimp9ShKO1mDxupR9nAa8S/1Y35nys92p0=;
        b=Ri3ctAsyzeoPsl2AqZ7RO34QMpgUrXFPTMPrQ3mWxAxM1wLJXKWuIyXP/hCZcpKrLz
         FwoX2nmMgZfM6hNzfAY9+r3VL/m1zShTOZBktjH8hXTisB/JKXp25lzx5FbaP1P5MjGi
         4y4sKVRlgX5pDzwd25ELPIB/gNdoLfSJHv20zuNXyDPW18fo5X9DwHxGYOzTdzUNhgvx
         JzwMc4nWortBSUR8YUvgioutf1bvzaUlySgHB25JyttTvmi+jXqAyy2noSQpfAs/XORe
         6nIpSRQFxGDxoyHC+wVOjipt9rpfLzrSIr8s2K+Kr8GrNxoOw80D6whWzzHsLUU/DN7U
         wMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212988; x=1791817788;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4D5E7ltBzHimp9ShKO1mDxupR9nAa8S/1Y35nys92p0=;
        b=Iezgh7qySw7+XLTXn/PuYR0QPC6T3T9ABrgyyvlJjeOexIhVdxKxd5rGDArUIQKwzO
         cbVmMgrJl6YedWTNBU7fYNLkP6r7LuEore0Q9vt/wibjU3Lc/grWDRzQ+Q4hWM0rUZ2w
         T2GEmCmOd/1b5SvDaOF+Thc46Q+VkTCvnPMKofSVoVktz6joXiEr6oZcR9REc6kcWIWi
         eIMbQfpioJ7nxUKe5dtyFDNTIOPjAkhwoubW22lT6+3Lpd3s5jmNO6Nnxe4qdUWMpaeu
         3p1D7NpfXwiEX9XdIpr65yJfhqXMmhpIqO3ctqaLXyMU7Y+AcORcK58s/ys5OSqfTa6f
         xs2A==
X-Forwarded-Encrypted: i=1; AKwUvBxlXbkjRthYXPtkZXbmMTra9JBQIYlabhG2sR8XUNPIoKNoe1bry5FbgjyxnCduTiGvOL1nuWpFfO0ebVrS@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5Ye/8liF6vJ5BfpwHmlYH81G2yUbbp83IB8M7yxrJd2W8sOG6
	dKZ0zArGOHNDGRe6gNUDvuTIrfvVSjheEdQ3JifYR8aJ4X5N8UHWrGlVPI6QXAEWyfUY
X-Gm-Gg: AYBFou0KpUIEz+lXbtVdNeJPU17KyEsUJ10fd0kwISrrH7Tb4SyBqnmpamCAJnkmbiO
	6gMdKBIFYxnXdCV+34IWPQHgk5kmTnvxac2qxE886yTPVYaTYrrGjkcoEp/cFdqx9h2LzBBi6Z7
	Gq2mPoM00nDz+6NQvKOjz5cQU823X9s+FS6/HINCEKaHWpRT3upSOTrfC8px/L9q/QDY+aVoTXT
	04gxPhl+odzYw84zYpdD8uLZ7Yu3tiNWXBnpKskfrx5t8Ns+up/L2HhOqmrXn52GW3LWs92QoZ0
	rbrftcLkaVZjqnmkXlcFlybChfyHUaMR2gkege/XJ+uCRjZwTIaUDeNQEhQQq9l9NlOOQs3HN+h
	bbdg1WcN3U6U2/lbwPKzUeS5Tvax8hru8fUvt7/F3ezFUuUAJEzE+pf0U+70iPGxYUsjJkhTODw
	h8bKGAJKN0YuHJIwKrPVfMZp1lMnw5D+8biBbgDCqkhcL8n6DIt/z6FhAYEUiQHkgDZo1CyCcah
	DV73Dr5QNKVzn/ijs3Lbz/x7tRQEO6wcqneNTz6hh/NXfF4daXB8j52Mpd5413tPQ==
X-Received: by 2002:a05:690c:e215:10b0:88c:b863:e405 with SMTP id 00721157ae682-8ae39ab3796mr31469067b3.38.1791212987733;
        Mon, 05 Oct 2026 08:09:47 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:47 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH v4 00/10] net: support thread-specific pidfds for send and
 connect
Date: Mon, 05 Oct 2026 10:09:30 -0500
Message-Id: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oyw7CIBAF0F8xrIUA9UFd+R/GxUCnFh/QQFs1p
 v9uR41uXN7JnZP7YBmTx8w2swdLOPjsY5jCYj5jroFwQO6rKTMt9UoaveTXmE68D/7GW8i59VV
 dcWlWoNDJEg2w6bNNWPvbS93t3zn39oiuI4oaFjJymyC4hk6ECkLFFxVUoWrjcxfT/bVwUER+x
 hTq75hBccnX0tm6AunWFrYnTAHPIqYDozVD8UNKbf4jxYQsCy2VgVJZrbZw6TuwZxQuXth+HMc
 nqMF8ejsBAAA=
X-Change-ID: 20260825-work-unix-passpidfd-086a1ec09e8a
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
the thread-group leader. The coredump server using the coredump socket
cannot get a handle on the task that took the signal and is writing the
coredump easily. Workloads interested in per-thread authentification
have similar problems.

Add SO_PASSPIDFD_THREAD/SCM_PIDFD_THREAD and SO_PEERPIDFD_THREAD. We
record the sending and the connecting thread in addition to the
thread-group leader.

SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
SCM_PIDFD message for the thread-group leader, SCM_PIDFD_THREAD sends a
pidfd for the specific thread. SO_PASSPIDFD / SO_PASSPIDFD_THREAD are
independent, allowing callers to get both styles of pidfd back in their
cmsg.

SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
that called connect(), listen(), or socketpair().

pidfs_coredump() now also stamps the dumping thread's struct pid so a
pidfd for that thread reports the coredump like the pidfd of the
thread-group leader does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Andrew Halaney <andrew@amutable.com>

---
Changes in v4:
- Moved get_pid() out of scm_set_cred() into scm_send() (Kuniyuki)
- Dropped unnecessary helps (Kuniyuki)
- Rebased on v7.3-r6
- Collected Kuniyuki's RB tags
- Link to v3: https://lore.kernel.org/r/20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com

Changes in v3:
 - I picked this series up from Christian at his request (thanks!)
 - Make SO_PASSPIDFD and SO_PASSPIDFD_THREAD completely independent (and
   in doing so add SCM_PIDFD_THREAD) instead of mutually exclusive. This goes
   against Kuniyuki's suggestion for a separate flag option, which I
   argued the mutually exclusive nature of the prior implementation +
   that would be confusing in v2 thread. I think with it being
   independent things are more clear, and useful, and it matches the
   SO_PEERPIDFD_THREAD counterpart nicely. For that reason I dropped
   Reviewed-by tags present on the implementation / selftests patches
   related to that.
 - Address grammar, reverse xmas tree, sk_is_unix() feedback from
   Kuniyuki Iwashima
 - Collect tags
 - Rebase on v7.3-rc5 for Christian to make shared branch for net to
   pull from
 - Link to v2: https://lore.kernel.org/r/20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org

Changes in v2:
- Fix a few documentation issues.
- Link to v1: https://patch.msgid.link/20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org

---
Christian Brauner (10):
      pid: add helpers to operate on a struct pid array
      af_unix: record the pid of the sending thread
      net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD
      selftests/net: SO_PASSPIDFD_THREAD
      net: turn sk_peer_pid into an array indexed by pid type
      af_unix: record the pid of the connecting thread
      net: add SO_PEERPIDFD_THREAD to get a thread-specific pidfd
      selftests/net: SO_PEERPIDFD_THREAD
      pidfs: record the coredump on the dumping thread's pid too
      selftests/coredump: check the dumping thread's pidfd

 arch/alpha/include/uapi/asm/socket.h               |   4 +
 arch/mips/include/uapi/asm/socket.h                |   4 +
 arch/parisc/include/uapi/asm/socket.h              |   4 +
 arch/sparc/include/uapi/asm/socket.h               |   4 +
 fs/coredump.c                                      |  22 +-
 fs/pidfs.c                                         |  27 +-
 include/linux/coredump.h                           |   4 +-
 include/linux/pid.h                                |  53 ++
 include/linux/pid_types.h                          |   8 +
 include/linux/pidfs.h                              |   5 +
 include/linux/sched/signal.h                       |  18 +
 include/linux/socket.h                             |   9 +-
 include/net/scm.h                                  |  10 +-
 include/net/sock.h                                 |   8 +-
 include/trace/events/landlock.h                    |   2 +-
 include/uapi/asm-generic/socket.h                  |   4 +
 net/bluetooth/af_bluetooth.c                       |   6 +-
 net/bluetooth/hci_sock.c                           |   8 +-
 net/bluetooth/l2cap_sock.c                         |   2 +-
 net/core/scm.c                                     |  40 +-
 net/core/sock.c                                    | 108 ++--
 net/unix/af_unix.c                                 |  66 +--
 net/unix/af_unix.h                                 |   3 +-
 tools/lib/python/kdoc/xforms_lists.py              |   1 +
 .../selftests/coredump/coredump_socket_test.c      | 175 ++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 ++
 tools/testing/selftests/net/af_unix/Makefile       |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c    | 602 +++++++++++++++++++++
 29 files changed, 1137 insertions(+), 113 deletions(-)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20260825-work-unix-passpidfd-086a1ec09e8a

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

