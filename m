Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE453CA486
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022047; cv=pass; b=R2+mrNV3UFBtBqvt+Oytyk5yttxsckLW+97GPy67U+dGTfe5/jIuegfHXtYm+206oDrdeLXfrc/ouRPaf69pqC5Z0uwL6otBPIpucfbsSoJeOG+24s+VLwXTS9jyq1+C8egYUT7kaXNW65qMr4u3SJi1fL858nMftbllk4MS0Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022047; c=relaxed/simple;
	bh=v2Ib2MTNHBmW9YmoeK8moKJ46G5ulvBSMcUnWwSOmTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3o1/S9EUszg+G3+jW6g7FXiB5j656sDvL1nNFDszL/Urw7ESI5W88z6jlfeucEPd1Su860PJ4L1BT1kC5MEBX1MYxOh4NfAGZyXustW10Zy33gfBfPwJxR1YtM4Ont3G6yDI9fHEOp+m0ZVDgFYePjqErCdQyHNxkaTH4p8gak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kneA7THk; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kneA7THk"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39675172593so5694749a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 23:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789022038; cv=none;
        d=google.com; s=arc-20260327;
        b=IjfTH85AR1l2NloxPhwThccaTbOl9Hyo9bf7XnTgnvA4qmA5SBkrbqzEE91LwV2DIU
         jsq3umdzrGqAAxOeqPXo628jJw1o8tfAPGwsT1ozFimtvGe5zc0LtnSIKZVs4yVvA1qP
         l8f0baIcLR+iQZarvBCMIUcvv/bsrNUuhJOGFw15soqiHNqgPa9O4spDT4b18ySf/h46
         0ILMvFCJGd1F0th0ZJ19HJlKRYTa81B/PpxzrdwBSN6eavHnWxauuB4R7EfImeYRrmoy
         iRKD0lkLZgIwnOHNsblRdQ9ywtd2k0gms7DPYOIaci0g/f5FHeSWIHii8J9Q+bLjmSlB
         e9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4xny++sZ96Atr1Ra69lnJNWOCs0ZrC8LE8i2a35qYI=;
        fh=wRXfapmUDrT7AEp+WM5AqxjWu8t4iwtzNp4k3RikRm0=;
        b=a9Hd8BjSyiPQN0GOTDheJ1NawGS9g7MwEb3j1jXM0/cMAo0lD9vCMr8XOSQsau2Kyy
         e9F6tQIhixAIuXs3WmLdzmHIbr2W9cbRL412b7yIzHXmmBYVYBWzxqj/GVxyrpGlxfTc
         LoeH5IXtXN4he+frJfzUGxEwXNJlzdk07w9n5nYtsUBVrvZApT5QwxSRf67649lDgZJp
         owx1Fz5CNtMdWKcS+UDCo+lqz53WNBSbUMaEydEc2rf4YZ2D6pUPFE/I6ZSPhWfxcvWo
         /vFmsBp5WCqS83/oyLiF7p3PU59aGF9AMTUF6mdeoQH9oRwefoTzWY8VuAEPdZ+Vr+Na
         9ysA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789022038; x=1789626838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h4xny++sZ96Atr1Ra69lnJNWOCs0ZrC8LE8i2a35qYI=;
        b=kneA7THkZnDbOSChClrANzdIg4PQ9C5/0T9AH6xp3goI60FrwmSuvQrQraRnMpdrGY
         KQZWrVOCRDnRQAT0cnIDgM8p6pnJ6qx7jgiv1J9j4iJ5BTCqJe0uMQ/+wgPWoAOGc6cU
         BzyqPqyzDxQfBEUrxWTlaQ20ZTb2lGH/YrTuLWrLB4hXid3NKD7fKDrbkPe0bbzTf6vX
         uWz7BXBwI6maZUfzuPJMNQQOkePZX5oqDHOy9EtLx22lqzscJGxkWT01Q4sCnGXfceyf
         ZCOsbolJ5M0GCGGzuSoRudwTeLe9Bu85HLM8bsP80car+Mz9L4WN/AfwcqQyJ5X3TWmE
         zrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022038; x=1789626838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4xny++sZ96Atr1Ra69lnJNWOCs0ZrC8LE8i2a35qYI=;
        b=TgfqB3R/alHveRQc9HhPqmvNwbTwa1RHNVuyw3fSQKTUAd+xbo5dJWK5cXSN3NU/OZ
         4DNuWTJDhQfe9zVcQSp7WXpEQ1EvCALTwPsNORbwfsI33LcKSBhd2xR2wDK3jC6MMFWQ
         LjfPFDJ4SLiRLLq75cpWoah/5Cq/Onw4Qo7Haji8i93gfBA1XNcnHMdX9pe8yUOf7lmE
         XnlLreZN2nVxLyt5AV1P9RD+g6BMw8tinDN3kUd3awCzFBe4L6EJLUr0fK74W7mp8QmG
         uTpCPHSiqW4Sjxzs73uYBhnBSGOn9I3kKIZpg2JS3M/J/kDY5KfArFq/bgUP07Fc5+Y6
         i2gw==
X-Forwarded-Encrypted: i=1; AKwUvByfKg8vc9gMXcWLV9pFocIJmCQX3iWwBeJ75cwCs1gcWZQNld9cQZvOr5RcGkwIz1QJQfvuuDtys4zmoSla@vger.kernel.org
X-Gm-Message-State: AFuF++kjNtnahmup0aI84yW4NiDDf085Q47lFAhGbpYjNHgOo1eIiBQy
	ZJ77o6cnl5LyTxdkjEYBxZkuf5qsZGmCJMMkCGw8eORgORG9wML7oaGuVw/mbo8EYUjnFw2ooi+
	Oj3GFx+jboMBJBs5iaCNqF1I4AUFjZ0UM2pyPdHu3
X-Gm-Gg: AYBFou2J6y5kTBAurvFgvDOVGr/f5ZJMtZCvij7rXAN0m8XijMR7fHqKqTu+oOkg69P
	QW0rjFpkrdLO3Y6ExsoLpek/i5p4vtrNTXD00068mdSV6Jk9Gi9Nh9ewCnlIsTuMY82kuoIdThp
	1n478XHinSYWgcLLi/OkdqGtZTDsh0kz5uC+7fi9Hmb3avtpDOE2OHGzTFCKw4zuOOGkmqQl080
	jmc0f6znjJ3BJJlPSGDN9TdPZj/iGUgtSxYOUxbfRLOlDbPtDcHTC3xKMTqCWlF6hMFArQ9cswY
	ISpDuozbh7KzpDTeMhNxqk1jSPmk3lp13/i84Y0DAV/bEK5dwSLQ0SJhTMnk9DFx9S5zPjZ8e6T
	5c44UWmsfB4DAOboSrNK8RYKEvscGPyCxU5swWtKVmu9emmC6UCV27IhuMHBOqiNbfgjcIQ+0XG
	vAexwumv4OSkXj5Mnz2B8mpqMXUgP4dirILiI=
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39b26202ebamr61816070a91.14.1789022037330; Wed, 09 Sep 2026
 23:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 23:33:45 -0700
X-Gm-Features: AcwNN1XxIc8SXTtu_WcbAxVErbfrYnhss5VT5HaYDUiKJKYuAUZY5pPq8E7OTT4
Message-ID: <CAAVpQUAx2K1Nhj64oEYMfQOzsp35uPhRmRrS4hnp7nd=jvj2kA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send and connect
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:43=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
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

systemd-coredump currently uses SO_PEERPIDFD, so
SO_PEERPIDFD_THREAD makes sense to me, but is there
real need/use-case to fetch each thread's pidfd per sendmsg()
via cmsg ?


>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v2:
> - Fix a few documentation issues.
> - Link to v1: https://patch.msgid.link/20260831-work-unix-passpidfd-v1-0-=
70cbfda0c7ba@kernel.org
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
>  tools/testing/selftests/net/af_unix/scm_pidfd.c    | 366 +++++++++++++++=
++++++
>  28 files changed, 907 insertions(+), 110 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260825-work-unix-passpidfd-086a1ec09e8a
>
