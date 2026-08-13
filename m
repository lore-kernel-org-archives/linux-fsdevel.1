Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF73515D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639510; cv=none; b=OFYNkgTmP+xX+7aMf/pZRBeUSFA+pyicxScftCE9uBI788ZEzq3QOkdaaN7s34EQe+dhnqhxEMmng8KI+X6JybsqJbuWd+QWGbSAcFbiiFDKIjC6uhqGM3QgWQF1sZfgvHhzPjYTYGhfOSNgQwjUNeLfSygJdXk59MhX8fMZZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639510; c=relaxed/simple;
	bh=76sxzFYDS6SAXCw0enJTdxOq+pkrxuViTweRrWBrwxY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AAtO/Bt+ZkOHcJrynN0G8Bt5HmUcP+iIrztaftekxX19RuHZGhX+b2B0jycPQUyrx3rDrHbjxesu4iavmC7jTuaXvAgaiax7eO1RLdt5Tid0V6i+rp18HQFQL4+/lyiG1rQj7MuV6YFZ6dXI3pOs05nSCmqxi/4oxpzhncUWs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tvTdJ/bf; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tvTdJ/bf"
X-KPN-MessageId: 55774795-9736-11f1-bfbb-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 55774795-9736-11f1-bfbb-00505699b430;
	Thu, 13 Aug 2026 18:45:04 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 5579182c-9736-11f1-a026-0050569981f5;
	Thu, 13 Aug 2026 18:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=YiIOIKH98wGWufizR0K1S4bczDzNUtlf6nRpr1sSs9A=;
	b=tvTdJ/bfY9myGrTuuDfQbrH9zysjhLNIFwcuAvIFQ37nfBun6Xo5UfAfssiJe4ATJD1Uitjm+BIw4
	 PajzrIKYDEj/1SpWxbT6t5+l7mLuRs3yQPW9CBAN9RlXq4fC3L9jA0fUWquXDBBzpLuWqhvasK67La
	 G01ZANKwIaa7DzfSWm6Wq5YARK81rmhdNjhGtPjayu3TPVVZYGoUFvn8qT+qVt+dUapoTNr9ZAbYIV
	 m3dN7HSVqTz4Wixn0jiHLyPIBbocUu8XOvZlr2MX1X/GbI1QbqDPFuhM7kvIEmo/PB3LiDwrDbyF1V
	 vSxu11FVQjMMqwMiB2aPxzhTfLwAbeQ==
X-KPN-MID: 33|+cxWKyWXUkWLCqJLe3yNYPNEdxK05luFkdh4LjkwdANceeWpyckqXKLNkbcEhk+
 wAMUiU5nIy0eyFKNUUE6UBg==
X-CMASSUN: 33|/jcxzdd5gD1wNK8mK/zewu7IbMrPMlZG4GqE2+W7rJsR8Z0t7M0FEBVhSbq8H0n
 LyIQv8WFU4BUd5oFWIpo/dg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 556d581b-9736-11f1-916a-005056995d6c;
	Thu, 13 Aug 2026 18:45:04 +0200 (CEST)
Date: Thu, 13 Aug 2026 18:45:04 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <1036785927.390839.1786639504241@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260813162818.149248-1-jkoolstra@xs4all.nl>
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
Subject: Re: [PATCH net-next v7 0/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

My "smart" email provider blocker me from sending more email. Since I am in South Korea
that is apparently suspicious. Now patch 4 is missing. I'll try to rectify that. Is there
any sane email provider that any of you use?

Thanks,
Jori.

> Op 13-08-2026 12:28 EDT schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> 
>  
> Right now if some LSM denies an AF_UNIX socket peer to receive a
> SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(2). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
> 
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot. This option is inherited
> by the accept()-ed socket when set on the listen() socket.
> 
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights
> 
> Changes:
> v7:
>   - block first selftests did not check other slots
>   - READ_ONCE() for scm_rights_notrunc field
> v6:
>   - Let accept()-ed sockets inherit the SO_RIGHTS_NOTRUNC option from
>     the listen() socket, so that you don't need to set it for every
>     child. 
> v5:
>   - Enable SO_RIGHTS_NOTRUNC on all AF_UNIX socket types.
>   - Added required BPF CONFIG_ options to
>     tools/testing/selftests/net/af_unix/config.
> v4: https://lore.kernel.org/netdev/20260705123826.3818443-1-jkoolstra@xs4all.nl/
>   - Removed the __receive_fd() helper and moved logic into
>     scm_recv_one_fd() directly (suggested by Brauner).
>   - Moved selftest from Smack to BPF (LLM assisted).
>   - Add arch specific socket option values for SO_RIGHTS_NOTRUNC.
>   - Undo patch that replaced copy_from_sockptr() with
>     copy_safe_from_sockptr().
> v3:
>   - Separated net and vfs changes.
>   - Use kselftest_harness.h and system() to call the test script.
> v2: https://lore.kernel.org/netdev/20260616143020.3458085-2-jkoolstra@xs4all.nl/
>   - Reimplemented as a UNIX socket option instead of a per recvmsg(2) flag.
> v1: https://lore.kernel.org/netdev/20260428175125.2705296-1-jkoolstra@xs4all.nl/
> 
> *** BLURB HERE ***
> 
> Jori Koolstra (4):
>   net: af_unix: enable custom setsockopt for all socket types
>   net: scm: move scm_detach_fds() from common path to scm_recv_unix()
>   net: af_unix: useful handling of LSM denials on SCM_RIGHTS
>   selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS
> 
>  arch/alpha/include/uapi/asm/socket.h          |   2 +
>  arch/mips/include/uapi/asm/socket.h           |   2 +
>  arch/parisc/include/uapi/asm/socket.h         |   2 +
>  arch/sparc/include/uapi/asm/socket.h          |   2 +
>  include/net/af_unix.h                         |   1 +
>  include/net/scm.h                             |  13 +-
>  include/uapi/asm-generic/socket.h             |   2 +
>  net/compat.c                                  |   4 +-
>  net/core/scm.c                                |  40 ++-
>  net/unix/af_unix.c                            |  22 +-
>  .../testing/selftests/net/af_unix/.gitignore  |   2 +
>  tools/testing/selftests/net/af_unix/Makefile  |   8 +
>  tools/testing/selftests/net/af_unix/config    |   7 +
>  .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
>  .../net/af_unix/scm_rights_denial_lsm.c       | 292 ++++++++++++++++++
>  15 files changed, 413 insertions(+), 22 deletions(-)
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
> 
> 
> base-commit: 3205699d79f262412c1be7fc1c04066610d3cd52
> -- 
> 2.55.0
