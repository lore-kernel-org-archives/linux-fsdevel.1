Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A852D2DB
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952226; cv=pass; b=Q73+r1wIoGkr27ztz0UmTDouCTJQtQc8lh23KnxQqzDR9Jm1BbiOOflQzg9CzGzRTI95oRGjc/+n2iDtsAD3vprgX+WuuwzRqLYhrgbm+9z3qizU8vg6hVbELDzu/iP9Ae7GggZF/2DvhJJYSPRfut9znzsBT49dRCYsDA99EEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952226; c=relaxed/simple;
	bh=YkZ9FXYxom6GTJ696R1xgKPjABJ5NoWT2CU+7PuBHFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFpubITgRJCix6wd4R/5Al95IEkplS8a5LBmM+YXjWhYb22NdJ1pD9SwrEeOYJOINFQi43SlFiXv41fkznSjUao3mR4AdimSvkPxow2DyLsvoawhjq528/KSBbnMJdzCPTepFayrp85YnY6gwEpyYCsc5Nt02LagYi5OPcYxVQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=dX0q+oK6; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="dX0q+oK6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so5074966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 04:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952222; cv=none;
        d=google.com; s=arc-20260327;
        b=kc7GloVS4tKMYf6TG61s1YFPRA7ZMwjDjcSkm7j+3qepoVZBU0/nfvLlZpLxNZqkKU
         1xoP76AZF/MhdMLRne3SATqI0+IC82hPj8fBvhecOLthy8Jmu7/YL162VCw2v7gSAoul
         FdFw3vF6JeNIhXPWw1pJ7iogb/G4RQHdH82SuAJ3HJJQ8SkTIBmbCRYaAca2w+XT5jIf
         1SXtS9tOKErY8HWV9BWZZrxbWXEmHOB3rwbCjma45oX4G3JyRwt0vKWKL7XnjAlAfoCY
         ma/h5R+1mPwIbVGeEzB9VwcGtoxpoo2QA6o6KvQT+Goc0KePXkmbkdACsixhVYJ2mxlA
         g95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mgt8XRgHU0466zZJnQp3K3kwl0ZmrdZ791mHZpm+8k4=;
        fh=Ehd9+5SFwukmtY/3l0tZtGpnuJ6ngO3qCeqLIAq+3NQ=;
        b=CaTnFmfgmuFyshf0cssNjKxkGZOOipX4zyT/J4nnLos70FVTVAhlSwGbfEZcR9LtT9
         Y66pV4a9Lp2SkHc/I90d8Zf0T6tA91KY8hARJNMQ7BhnUChKCBXmk+T+kIDR6i2BmSvi
         jDZFhKkxkBuyKDyHg7cKaTTvBFOTI3lAKx7yCzV6UfNTt062o0aKfQuAbi1rT/nBfyI1
         K0uJ3hTJ7lf3/8+GhYCWGytLOskt7RfP77lvjJWIjB4ibIMJsI4X00VwAYb5f9ad+u85
         5Q2khn0ZIbwF41bScoHTDQ6TKLDr3SOGal0b4gZudgKnV9SHUsvt+ADH2LOeUI7+TgJ5
         Qa9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788952222; x=1789557022; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mgt8XRgHU0466zZJnQp3K3kwl0ZmrdZ791mHZpm+8k4=;
        b=dX0q+oK6psQKBVWpzPmJNAB/SUPsmrJYjWjuLSDb+yl4yOhVR75twv//YochFw3j4G
         f1fgEdTt7HbsfDGgHZJWplKWqJcs8PvMGOKdA9sM0+Sksnc9ZjRmbk1FTI7+WN+FJyer
         kZJ0GKY23pR7SOJ5QB3rJDr/KexOrL5QPQJp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952222; x=1789557022;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mgt8XRgHU0466zZJnQp3K3kwl0ZmrdZ791mHZpm+8k4=;
        b=D9ts8uCv52FRvLzJZ65R0lSTg9BC4p4VW1CaCmfKFnXt34NI3bfYr9aMkQO9NZV8vC
         PCimBhj+1/KU4treyWkarQbyrDp/lXY2mJWJkNJO/NVdndDIkVKthLDkRkMxmnTY3xV3
         BewGIMZDvL4jK71KAgINsLd2di/tpndHeymkcAOvNLPmAyPeJyaAU6sgPZttyoTqkm4E
         RWE6sch++irSje5tMEA5QWT5aBmglYuBqjhtCOgH2L4xDj7Oo5OTEXPRgnHTF9qF43c5
         4DG+GEMQC5j0dMblVG5SLtyroI1sRUyPwFPe3WWM6ytZgwCN7Vp6CvoUxmT6CZmMEtxE
         hqBQ==
X-Forwarded-Encrypted: i=1; AKwUvBysNiNATUd08d5Ka2X2HGzKnbJIhqEw0DiImUcR0ohXUaUs2NfmUus6rR0W5UtDSblAZsM7VfuikM+Myrbu@vger.kernel.org
X-Gm-Message-State: AFuF++nhl2vi+/0E7kB22pdMyt6GGM6Wi3WobhgNmCXgmot9yNNEOqJA
	iisdb+Gt2MNHiuHQAYaVkc0MyVWpHqS1ofEChPWQkgh8xlSHKT9fNz5V2lDqYcesVPUJaMIGVJY
	UfwbqO3sgXMoiZKq6fuV6xgDFbcfZFakvIhbJJ9MoFw==
X-Gm-Gg: AYBFou343c6Vaqu+ttRDvjgAZOKn1pgvutgDzXdI4jlWIZ5eahKbAF564ShciRu5Lu4
	dE8uB9rqLrLVgY6P5hpWUtT8+y6rcNal/Q43TfZFebC7zDXQsL9EamG0f+SGm45GUws+lckmEcU
	Q8m+ueQFqWN9SVAaBf1QfN354DNtYyjco23NRYRuykxrLBeE+Vc35y/UM3ZNSrsT2kPind6zzOa
	84nmZEYQNq6BoLI/JfJWVTXL1U3O0ZH0eUB6K/LJQ4GHvjW0JW5Z/iKhOnoc2+QqzaC8syHjice
	oFMqHGQhPDIMVRifi+9rBGqjwrw4uvAulgaqmGhQ0SeUgGPVc6Xuhhoj3oiDqNHOk6H6+lZlSod
	Cqf3zlQFPNy5nFHmvIUgxAg==
X-Received: by 2002:a17:907:c09:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c2941ae9193mr12751566b.12.1788952221639; Wed, 09 Sep 2026
 04:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 9 Sep 2026 13:10:10 +0200
X-Gm-Features: AcwNN1XTgvzqLxcVf_sNNwgtEWfE868-Kflp519NXR5vjxPBUXSPcRZwXEOLDjc
Message-ID: <CAJqdLroLH7x1Zrgaa2U=H5v9pFfdzJS4CCcAmSvqShS8Wh+0rw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send and connect
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mi., 9. Sept. 2026 um 12:43 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> the thread-group leader. The coredump server using the coredump socket
> cannot get a handle on the task that took the signal and is writing the
> coredump easily. Workloads interested in per-thread authentification
> have similar problems.
>
> Add SO_PASSPIDFD_THREAD and SO_PEERPIDFD_THREAD. We record the sending
> and the connecting thread in addition to the thread-group leader.
>
> SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
> SCM_PIDFD message for the thread-group leader, SCM_PIDFD sends a pidfd
> for the specific thread. SO_PASSPIDFD_THREAD is mutually exclusive with
> SO_PASSPIDFD. The last one set takes precedence and disables the other
> one. Both SO_PASSCRED and SO_PASSPIDFD receivers see one writer per
> process as before.
>
> SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
> that called connect(), listen(), or socketpair().
>
> pidfs_coredump() now also stamps the dumping thread's struct pid so a
> pidfd for that thread reports the coredump like the pidfd of the
> thread-group leader does.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
> Changes in v2:
> - Fix a few documentation issues.
> - Link to v1: https://patch.msgid.link/20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org
>
> ---
> Christian Brauner (10):
>       pid: add helpers to operate on a struct pid array
>       af_unix: record the pid of the sending thread
>       net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD
>       selftests/net: SO_PASSPIDFD_THREAD
>       net: turn sk_peer_pid into an array indexed by pid type
>       af_unix: record the pid of the connecting thread
>       net: add SO_PEERPIDFD_THREAD to get a thread-specific pidfd
>       selftests/net: SO_PEERPIDFD_THREAD
>       pidfs: record the coredump on the dumping thread's pid too
>       selftests/coredump: check the dumping thread's pidfd
>
>  arch/alpha/include/uapi/asm/socket.h               |   4 +
>  arch/mips/include/uapi/asm/socket.h                |   4 +
>  arch/parisc/include/uapi/asm/socket.h              |   4 +
>  arch/sparc/include/uapi/asm/socket.h               |   4 +
>  fs/coredump.c                                      |  22 +-
>  fs/pidfs.c                                         |  27 +-
>  include/linux/coredump.h                           |   4 +-
>  include/linux/pid.h                                |  53 +++
>  include/linux/pid_types.h                          |   8 +
>  include/linux/pidfs.h                              |   5 +
>  include/linux/sched/signal.h                       |  18 +
>  include/net/scm.h                                  |   7 +-
>  include/net/sock.h                                 |  14 +-
>  include/trace/events/landlock.h                    |   2 +-
>  include/uapi/asm-generic/socket.h                  |   4 +
>  net/bluetooth/af_bluetooth.c                       |   6 +-
>  net/bluetooth/hci_sock.c                           |   8 +-
>  net/bluetooth/l2cap_sock.c                         |   2 +-
>  net/core/scm.c                                     |  36 +-
>  net/core/sock.c                                    | 120 ++++---
>  net/unix/af_unix.c                                 |  67 ++--
>  net/unix/af_unix.h                                 |   3 +-
>  tools/lib/python/kdoc/xforms_lists.py              |   1 +
>  .../selftests/coredump/coredump_socket_test.c      | 175 ++++++++++
>  tools/testing/selftests/coredump/coredump_test.h   |   2 +
>  .../selftests/coredump/coredump_test_helpers.c     |  49 +++
>  tools/testing/selftests/net/af_unix/Makefile       |   2 +
>  tools/testing/selftests/net/af_unix/scm_pidfd.c    | 366 +++++++++++++++++++++
>  28 files changed, 907 insertions(+), 110 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260825-work-unix-passpidfd-086a1ec09e8a
>
