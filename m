Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1472351C3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465250; cv=none; b=EUmOc+01IJ7IFdMYqNpnT7Fjkh6MmFTEzNguWzX41A/PEe0jEV5SaIbOjA/gSKcnLXHcxenUe65gSho9bX1YaxeWwh2t24OYKcvJ30zIcVEuw5h9U/C2lTmov0uvyGFZpw5K0AqIMSILj1vMtpMjJuhPmHkdJIBlvvtwKVn48RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465250; c=relaxed/simple;
	bh=DwsNKvlGYKtZ1fF9b9hdF+JF2RiPPutB04oJafLhO0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sB6ewEkNuFWt9Pi34i/K9ZJmS7FhLwSJErf/8KvoDceSEZSYAbhOcKcsQVEyevvKIcwZ4pCeHCsiWF5aF/RDlWf/WetQPzJqxHNxmrjd1EVP41NmzoiYuS8bTJS4sG9LsZ/J9inpOZ+1UtcaiLvonU9lTQ1zzjLSOkkHnVueNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=ac3gmVe1; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="ac3gmVe1"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a871daa98fso1277675ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1774465237; x=1775070037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3TfDXqvygN5I94hNBiffuf36XK4iR4Jn35/3DLOLzU=;
        b=ac3gmVe1vkqJAf6swAtBnQ5oxItDtJeqys/PGYN6OQWX5/anxdLfA8iS0DamF+JmJz
         +bmu/jfOB3jfh/ajeJZB434MI5VwZJfA+Dpa5f9o3W0c+6fu7gZYBlNZ0yG6+dHu7AWF
         a5PeQXBPu5TBg6bhlL5F5mU/0eDvmC7Rpd+qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465237; x=1775070037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3TfDXqvygN5I94hNBiffuf36XK4iR4Jn35/3DLOLzU=;
        b=ZEEhDjqppn6jugIhLMLILECipD4JGcnL82RVjeJZ+9UreB5zV9ugiaCs8aMIowHtXe
         iYN9XfXaEcF08C2QuFf21F86ucBj2oCpf41qcsNz4tgTgsp2xp3sNm8eOBfkbwuLamFi
         HPHr3l5RBDofS2B5+dXuOrYCDEfFdvihdrxPt6UINIwCXuenrr8s5PLmvqYZjIg3REPE
         +NmgyCk9ufs/7OIh2bZUw/GQFDdLxwg15kMOnHSbMZd7UUcULnqzrQjQYc7XyQdmFrGE
         JqGC2DlYj++pX1gGgof/EPLoRetzA7Jy+pl/mP3FGSisPX4+ELT2JM6aa8tWxPbqzv4W
         ycNA==
X-Forwarded-Encrypted: i=1; AJvYcCWAha+HnJiKRDDJWj0gMn4EkFURjqwuKOODJYVQNZIhTMB9k5ESViycd+w8iHpEqWMKWbKXghKaAEzMGOsG@vger.kernel.org
X-Gm-Message-State: AOJu0YzjcvPRvauQ0deAx43RSQo9LRtGmfz4Of/ujXZjGUjKu8dMFyiB
	EKlU6TtbhePGHc4E+D+xSjDW3GqXMVPjwPIVVmUegpNnQYqYq3uVEDul8ZBQ18ed994NviEEVmi
	UT5atFwm27fPx
X-Gm-Gg: ATEYQzwE/T+OyaU2LXKQW8AGqjeafdTJP3JWCVRxK3QvCN9LShNGii0T/BXBj7iJHtf
	GfDGTRdD44U11W3WejLAj0OPepqt/PxI7wXzdiKF/J4sRSJvAbFmNL7ZcNDC1m65OUcFxSgElRh
	P26Wf+A6Yg1qn/u35B/K7hxIt59KUg2xjWCZlAdpbwkdCrmsHm2wtkjAeYnddjMMz5gM6Bsf2t4
	b2vLoJ+ixCjmdGp+6nS4hE5JYI9Q4ctqLQvGj+kl9VdvL6Vl3ITHsjfGbqQKIaG1+CYtHrXygtA
	SUPgykTbUMB/q4XDZ9M9QrbIPPXsoAyA1/CSjakahzZ8Z5Bqtcz6C9TzxZ4ZLDEVjXjIPrhU2u4
	R7GY6707eJHiBiTYcyR4q5b8LQGT++7ov/AS74kkUkzes9LfkW7nYCxyk2EOjqf/l5JGCjUgQcQ
	wvzZCrSN4SIe9g+fXOblrMrzXY2WfOgRIeMln47lXPd3GIDuzqwc7yw2ZZD87dZ12QkJGfLSyhB
	HYNPfYUfz9owGcRBgzBPQ==
X-Received: by 2002:a17:903:1aef:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b0b09fa0c3mr52525125ad.17.1774465237050;
        Wed, 25 Mar 2026 12:00:37 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc79f7dbsm6483485ad.25.2026.03.25.12.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:00:36 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: manfred@colorfullife.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	rstoyanov@fedoraproject.org,
	ptikhomirov@virtuozzo.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [RFC PATCH 0/3] ipc/mqueue: add fcntl(F_MQ_PEEK) for non-destructive message inspection
Date: Thu, 26 Mar 2026 00:30:22 +0530
Message-Id: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

POSIX message queues currently have no way to inspect queued messages
without consuming them.  mq_receive() always dequeues the message it
returns.  This makes it impossible for checkpoint/restore tools such as
CRIU to save and replay message queue contents without first destroying
the queue state.

This series adds F_MQ_PEEK, a new fcntl command that reads a message
from a POSIX message queue by index (0 = highest priority, matching
mq_receive dequeue order) without removing it.

Background
----------
CRIU (Checkpoint/Restore In Userspace) supports live container migration
and process checkpoint/restore.  It handles SysV message queues, shared
memory, semaphores, pipes, and sockets, but POSIX mqueues remain
unsupported because there is no kernel interface to inspect queued
messages non-destructively.

The SysV analogue for this problem was solved in 2012: the MSG_COPY flag
was added to msgrcv() in commit 4a674f34ba04 ("ipc: introduce message
queue copy feature") specifically for CRIU.  This series does the same
for POSIX mqueues.

Why fcntl and not a new syscall
---------------------------------
POSIX mqueue file descriptors are first-class Linux file descriptors.
fcntl() is the established interface for per-fd operations beyond
read/write: F_GETPIPE_SZ queries pipe capacity, F_ADD_SEALS/F_GET_SEALS
control memfd sealing, F_GETDELEG manages file delegations.  F_MQ_PEEK
follows this same pattern.

Adding a flag to mq_timedreceive() is not possible without ABI breakage:
the POSIX signature has no flags parameter.  A new syscall is unnecessary
when fcntl() covers the use case cleanly.

Series overview
---------------
Patch 1 adds struct mq_peek_attr and F_MQ_PEEK to the UAPI headers.

Patch 2 moves struct msg_msgseg and DATALEN_MSG/DATALEN_SEG from the
private ipc/msgutil.c to include/linux/msg.h.  This is a pure
refactoring (no functional change) that allows ipc/mqueue.c to walk
multi-segment message chains under a spinlock using only memcpy()
(copy_to_user() cannot be called under a spinlock).

Patch 3 implements do_mq_peek() in ipc/mqueue.c and dispatches it from
fs/fcntl.c.  The implementation holds info->lock for the tree traversal
and kernel-buffer copy, then releases the lock before copy_to_user().

A corresponding CRIU userspace patch will be sent to the CRIU mailing
list separately.  It uses F_MQ_PEEK when the kernel supports it,
falling back to a ptrace-safe intrusive drain/re-enqueue on older
kernels.

Link: https://github.com/checkpoint-restore/criu/issues/2285

Shaurya Rane (3):
  mqueue: uapi: add struct mq_peek_attr and F_MQ_PEEK
  msg: move struct msg_msgseg and DATALEN_* to include/linux/msg.h
  ipc/mqueue: implement fcntl(F_MQ_PEEK) for non-destructive message inspection

 fs/fcntl.c                  |   3 +
 include/linux/mqueue.h      |  19 ++++++
 include/linux/msg.h         |  13 ++++
 include/uapi/linux/fcntl.h  |   7 ++
 include/uapi/linux/mqueue.h |  20 ++++++
 ipc/mqueue.c                | 130 ++++++++++++++++++++++++++++++++++++
 ipc/msgutil.c               |   7 --
 7 files changed, 192 insertions(+), 7 deletions(-)

-- 
2.43.0
