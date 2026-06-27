Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E708191
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782534411; cv=pass; b=gQgqSHvifAkfY3XbPwnPAPiQZsT4msrKaXtpD8XhI6HUXEIG0si6tnsAptMSnOc4N3xo/fDRSC/auEWyyKrwm5hKHQx9gsyl/GX8/Am6uww2eWDWNY7Zu8waK3DhLy2H528AGRIf7ZkpMi5xUcEZXr+7ITHbzhWEeM0V10RuC6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782534411; c=relaxed/simple;
	bh=JyCgR7XmuSS+o5PBuXFtKqdTV7XM7Tolv8zwogRy8Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3FwchoAnL13U3YbtXpz0n0JZ8jXLExXnSw9LZ5ZHVPLnFCICkPWxK+ZQ6MBmDSJKxODgp/1q/qPhBvhfJSvakkV0rhE/swWAgDYqx9XB3AA+FXC5blKfRWIcSnSvi7Uv5v3F3dpFj+R9WbRkcp7pg/k80o2UdgyA2ARpWRA8sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kduUna3R; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kduUna3R"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7f69b71f7b2so19687457b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 21:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782534409; cv=none;
        d=google.com; s=arc-20260327;
        b=fzDl6taCp1dm+h3I+b1ywkaS1AJ4zm6GAF9aOoWb5RJTEFCDAkKZnt7qiYmaoqHAEH
         t+9OrktL64fZhUJ8cSHBPzldq1Ar4mIyohakgqOP1dgB7WXks8qtRU/Ko26FJw/sFgg7
         FevkAp1xdsd6HNuIgBMClgL2BfuX6eoIfb1WnPVuW16eSCJ4I+9+TBJVCXPYxADJOCnB
         4V9OB4eEgoctVyAfMAf9P1eeLd6m574sZva754xMznnGWXnoArrX6j/AeaFJl+6UUDNg
         EftVeTBYoBCOQOLu5pAAN6cXnpqNJivMBOi3pRwqUe58K7jvKuLnqaDfsnPTKSr6t0PC
         DQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JyCgR7XmuSS+o5PBuXFtKqdTV7XM7Tolv8zwogRy8Yw=;
        fh=EZV7npbBGQlcRLykFWXAtJzB7Bs4+2MTXgreM+vxrQU=;
        b=MxXr/AAOTq0n3PLkJs4BUv5v6ACovxA74iGc0ztfB76ftAZ191dHAt2ftlEf56pQZB
         ypYLUP6qnOEOHhaPkDYd7lAJLpyCt6joDPtpoKtj6MmE2LkWeamgvBktOQJ5GAn4N+ud
         4QBAHTnnpHjmyVpYaVRs+a1Tmog24pgq06H90u/uhYkb3yt2L/Of+MetuVLqC+NdeWaK
         Jub9ylsOB2i6td09lp5hnbqn4YFLWfGtzP+xBN8LlUeNvEFKL3K2SEte3U5JtDrLG2VN
         ojohoR2jCKiUnvPazJrRuSP8CprM4VlWaMQjWdFQmYRUcEZ0/7MDMirYWDwaJoqcznsX
         sxEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782534409; x=1783139209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyCgR7XmuSS+o5PBuXFtKqdTV7XM7Tolv8zwogRy8Yw=;
        b=kduUna3Rf7F8PA0iPeRkV/6Ck6GW112w5jv3fy8kAT3dbI+6Ra1YnOAhoU6qFtyUk3
         B5pv2mtWQsHQoGIfm1Rhu3mjkUW3bLy7w5jtPvmybsq6abcUdboDXl+//XqREfMTgWfJ
         NmWmc+aO4IrLsUb2DAgUy07xEJdu5k9fTdn+pEu95Z4Y+MfUG2zjthUza+n49t3wKChK
         MlZ6UMi7DCRJJ8/GJTxuM9WWo60BJa7bPTnc0EYsS++Zfm78yXGRSgRAKSNdY4q8lnap
         Xg/L/nM45B5GGemM9lS8Fy15NniLb4jIrUzydiZFosdGu6kRmbQqqn19mzxl7nWLUPBm
         lEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782534409; x=1783139209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyCgR7XmuSS+o5PBuXFtKqdTV7XM7Tolv8zwogRy8Yw=;
        b=mSaNycb8Y2aL+C6P5fmTmQSzXZltx8MMJ8AOYfaicuFRdxvJYgfrSar8bBGu8yXJPs
         ZdrBYEcbb8EExbwDVyBxJQ4BUiBuaW65oLzE1Do6A1xqiVQ0a03VzElgvJtnSmWijsJ3
         pvPnPbI9f0LZ/ZmKXvOUJioqBKwAL+zwu5PcPIxyzhpLPbLPNozbdxFGO7AsNk2H87au
         cE5KQByiYmOt7cLlbn0jsKlrsIigFiqXQhOJMEU+Gn0F/7YQVJKVx2RSDzUGt0VoFwTr
         Gf+25TlEP2u7JRc9uf/Dad2AAfcW9w+DsxybmPnG3qZjsv7ltesMXh56hpmdw78VueT2
         2p4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqdCxWWK0oD57U74lPIVabbF5hAj2ofOHynVW8tJYHroBCLbkk3FxCE3fdvVHEayNH+uuJ0/9Dk8G2yelDm@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmFa0SpESXqs321PghsgHr/MivmoRgRbEHz0gYVwiQVsGjNUn
	YVz3x4yWbKInS4QIo9mbT9zGVcwIDUYTq+hazZ2pG04Po3d/qG7gJmyNggusUb8PPm4ZQgAQYWr
	q9+J1CLrEIgfMEGGGrUD8HEGmjyXpk5avNmfE+V+rcw==
X-Gm-Gg: AfdE7cmmwMKphVzB3MsIhO5/euRHe/p9wPYyKXNA79WsXc1cgZqORnLxuOKYLNvTc2K
	p9vcAI0DVBHGL7nwvm6hok1Vk0KR3a7Irul4lPDMXZZFu/FyuJz6eFKimzlcv4xI5JFrq+Hwyzk
	vTEFD7V3+YU300fVhO9PSCA1cCQhIY/SlXqgHR0mxIX9HYsQIBJ1G7bLqQLWOLCHtdSrU0sQxkY
	RL/sMxnR95VnXmWghcaoCbOHZjPX5qwmNfK6oj70amiNB6AvQUeJrrgSa2xgSt3M0JZn2DwtDyZ
	KZr8c+gh1A==
X-Received: by 2002:a05:690c:6e08:b0:80d:35db:7d9f with SMTP id
 00721157ae682-80d35db822emr6059627b3.17.1782534409394; Fri, 26 Jun 2026
 21:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626014706.2840003-1-zzzccc427@gmail.com> <CANFS6bYPxyfkSDeUH8vHyjjRNSnP-tgHSEHogA8-ZRiEKqnDsA@mail.gmail.com>
In-Reply-To: <CANFS6bYPxyfkSDeUH8vHyjjRNSnP-tgHSEHogA8-ZRiEKqnDsA@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 27 Jun 2026 12:26:37 +0800
X-Gm-Features: AVVi8Cdf0LAYNP85_xHhL8dZrMXS6m8fKkh076fxfqCRrO6EhaCpWTPhTnK8pZY
Message-ID: <CAFRLqsX-3JtnZtRtK5a6BEsiMpRdu2csK9sdH_PCq5729THj+A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: serialize read iomap lookup with mrec_lock
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunchul,

Hyunchul Lee <hyc.lee@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 15:30=E5=86=99=E9=81=93=EF=BC=9A
>
> It looks like there is a race condition here.
> The concurrent writer may create attr_list immediately after this check.
> In that case, the reader can call ntfs_external_attr_find() from
> ntfs_attr_lookup() and access the newly created attr_list without the loc=
k.
>
> There also appears to be a few places such as ntfs_attr_map_whole_runlist=
()
> to call ntfs_attr_lookup() without the lock.
>
> Considering performance, how about introducing the rw_semaphore to
> protect attr_list?

Thanks for your review, that make sense.

I will rework this to try to use a per-inode attr_list rwsem instead.

Thanks,
Cen Zhang
