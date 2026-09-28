Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97D484891
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587657; cv=none; b=bV2pj5uQUA/FZm1/pDB5fWxbqQNRTcTjMjvVXmHl9v6rDimtuIIqAPcmhFjUoR33i10zZioM8+1k4EcPxIfPSQrOhVMYX15QnaF1tu6aKX3NOtY4nNkZEeVoo9dNXRh30rQZuMJAeS4a/dx+YI+5w/VSKKE8qbwxLtoCl3wHELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587657; c=relaxed/simple;
	bh=ncdgJTfMV5JlicQ4RDOciZ3MJx4A6qJLeufYK6MaEsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZGR1HCXtsULi+BjkGnGINeYRIEfvyzHWu9GeGx7xv7sGpy4ILNTbXl978Tqn7MAEoPwYj7cOjkL4FfdRcmLrTWIe8zpcoC5Rlb8SMxAsOg/aIsE8fbMotH9g1VDL0Ej3Ou6eZG+SsoktuM5FhyPv3jQqLcl6HkkIkUdvoXNdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=L5w0qBtG; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="L5w0qBtG"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf5e6878fso3438317a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587653; x=1791192453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lnfSTb3zhY22AJo5+gwx3fMN3WZeStPLDrenOC9xrfM=;
        b=L5w0qBtGbSXrGPSXGs46ZSGNmFUHrrIFU5E7nx0hiSuw+FtwUEPfyQhp5kSJH3vPfj
         6sRl1WrGzxrLG8m4wigoBxY/3ZJ4TPkRTe1M6/dOsKUm6Ogk2Cl4SP3HQqnSoEgvWBbY
         RHzkiW8cvsA6B+lcNL97Bd20IZRIZg/RvwJ6n3CUYRmdDK6IvG8JqzK49wE+3Y/iuI3i
         xmDUxnOn4eNqyNuGjMHrY0oipl05ZjK1SeXm6zDfnphTzh1pJ3nzmSCEnMMHNlCWV7wb
         xdKrHaVZUorwFhGFMGXQzwNrZ0TMVlvrEjo9pdS9j/6suxL7U4glSpzSlanwD7WRnxQu
         G1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587653; x=1791192453;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lnfSTb3zhY22AJo5+gwx3fMN3WZeStPLDrenOC9xrfM=;
        b=zrtfuzkoHpbk5KkGi6msK/5ix+WBnzoXaOmsQg9YnvD0YCaLyAZ+HCc72PIitOjA4d
         78rMvao5ecaitKtlXwYxtEs9Qa5qU7WVp79TDjchjC0pTZEGcRHXbX+zT4tmimiFijpT
         nW/tEUtvMUYiYpFp+GMWq7kVq4ouHTkbBzXfGTCWYnBAHRx2Cv3OQTrSe/EVx7H16dLB
         97yk1iBNwHxI4pI46FCHMlDY4avcrEQYynsgtXbtdhLj7SZMETsnW0+8pS2ORruZl6Ka
         Jd8r2nqA+m+auiEMVzE9NoCNRaBFK9HJjtCDKxb+u1ZbIg70OZVj+3M8pKv8aadxzgB5
         mw1g==
X-Forwarded-Encrypted: i=1; AKwUvBxrE7bgFgHhqaZMXsHOsIe/37GXc2Ue/faZaArln0YyPIIOo5IhRMdXvUDMCXh+SX0hZgrVYtQTVvELzEkb@vger.kernel.org
X-Gm-Message-State: AFuF++luuxfXL8cGtBMHSq1ldeVRfcPt5sVEeCK6xq+G7vdYfPQzXJOk
	NaAHyPF9RxUqqBVohTkW18GOpA/NnZ8zpKlwMO2E/ISO9xJaLX7qxjp9v6EZn1KzNuqP
X-Gm-Gg: AYBFou364+SqDyWChJ/BXuDBYoKhWwmD9M8Uqy5rFud1iygROOgz1Q+mHqB1i1jBk1O
	DbvgToDKP5i89KeD1PSu5xdqGGWBiB4OIFwGqBItS+sGbzsU0f09gnFvppimcUHKRep7aJwfidn
	yGncxaMZbVmdAMUiM90YMKBAMPpq09V71ipstzZzjy6wZQSs5y5i4Mc7wiYmxaXIw16v6pRMN1G
	q64AK/ybNBvHeMF9+qnOVDY/yzjWulcfARM/V4t8l2JdDakt1FIs/xKFWS03p5VpNFYKy5iWrb3
	LEazZP2fPFWLrAwwmsbGkrmshTo4YhLKMB7Oa/rrESr/mPtPunAEXqzES5GuzGzXeUvZuGYHFIq
	ArwWfS2niyCMIysRqbC4xKVdqjcZzGVR2IDRxt0KofutSDjWq9bdpp8Ymo2AGXL573EB04dcuQJ
	98syd7KL6CauMDnMMQhFTfhL3FhhUeMobfeVcGQAVR6132RZX1eXnivngYdYAEcTeCV6U+hsMTK
	K1m30k9OiCWk9z5LIiIcNFu1PBiSbojTLMo9Bc93g==
X-Received: by 2002:a17:906:7311:b0:c2d:ccac:c1ca with SMTP id a640c23a62f3a-c2dccacd49amr258517966b.37.1790587653104;
        Mon, 28 Sep 2026 02:27:33 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:32 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH v3 00/10] net: support thread-specific pidfds for send and
 connect
Date: Mon, 28 Sep 2026 11:27:07 +0200
Message-Id: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzQ6CMBAGX4X0bJsCEdGT72E49GeBFdOSLiCG8
 O5SNJ48zubbySyMICAQuyQLCzAhoXcb5IeEmVa5BjjajVkms0KW2ZE/fej46HDmvSLq0daWy7J
 QKRh5hlKx7bMPUOO8W2/Vh2nUdzBDVMWFVgRcB+VMG09RKqJU/KQiTuK0RRp8eO2FUxqV35g8/
 RszpVzykzS6tkqak1bXDoKDh/ChYdW6rm87zsf49AAAAA==
X-Change-ID: 20260825-work-unix-passpidfd-086a1ec09e8a
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
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
 include/net/scm.h                                  |   7 +-
 include/net/sock.h                                 |  18 +-
 include/trace/events/landlock.h                    |   2 +-
 include/uapi/asm-generic/socket.h                  |   4 +
 net/bluetooth/af_bluetooth.c                       |   6 +-
 net/bluetooth/hci_sock.c                           |   8 +-
 net/bluetooth/l2cap_sock.c                         |   2 +-
 net/core/scm.c                                     |  44 +-
 net/core/sock.c                                    | 108 ++--
 net/unix/af_unix.c                                 |  68 +--
 net/unix/af_unix.h                                 |   3 +-
 tools/lib/python/kdoc/xforms_lists.py              |   1 +
 .../selftests/coredump/coredump_socket_test.c      | 175 ++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 ++
 tools/testing/selftests/net/af_unix/Makefile       |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c    | 602 +++++++++++++++++++++
 29 files changed, 1149 insertions(+), 114 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260825-work-unix-passpidfd-086a1ec09e8a

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

