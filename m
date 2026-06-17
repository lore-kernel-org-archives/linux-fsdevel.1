Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A317D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654775; cv=pass; b=HQbejItfIV4DiUMcTR5ow1OYMXImNA3cBGKV9vAKQYaslF8RbyHLAZXo8MoghADUKdipUDhUAOQJNHa3p83S62bd2pfLLTlGAM1NnrJFdk0ep3cS47GMQhDyMLE3E+dsvCW7ubDBPD026mvCu/ocuYayw3WVZAe+3Ys9EZSuYzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654775; c=relaxed/simple;
	bh=fkrCmopnIb13ipuEWVakk/KrAFvH7xz7xKtU4zl9YnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAb0ML36Jn+8ri2Vk7FDSLi5px8lxqCN5aPKHgn4s5PT6JXVooCttRHSmorBtQ7NG9uvBSGeKfn08UA90UVbef/6o34GEEAN0QvOUNuEpoKNjzpmHQDDaMLnvU7L94LGJI+FgawLYW9Ypd8mXvOjr3Tdkl/U0nryrNUjEUXDdvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyKfVvUQ; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyKfVvUQ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bc871ecdfso666140eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 17:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781654773; cv=none;
        d=google.com; s=arc-20240605;
        b=bt8KN/0DNw6Jq3o1MLBko2CULmX0l3eCv5G+NyhTVs6DpmxNYFkgCwBkSwUpY0gdiJ
         tTRU/KfH5IDu+SqEXi/6LC1FoprY5O5yNPcwrxyuTU5ehU++JBO1PmMP3JmPWnMMy47G
         m7bwCQohuhBP3YbfXb0D776/aQwED8S1MPZ3nqLEu/noQKgj1ikIH8mFl6HPwJP81e3H
         gNDJXrbUteNFh/Cqy0t4SeOG2q0Y7hp3KYB+7xYVZq3WPaZcy5KYFsQSHbiWOTjeKQVH
         RvqJHShzct2THMFVkZxHNT+3oN7ivO8XazSOm1fpQ3eHmAUhULAKmO3RzaxpqGZxPck1
         1DTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        fh=08zpg0MrMnKnlE8yaGBa08HMNGWsqIYmuqqpETtGNdg=;
        b=LwlcqpeofS9k8qyDpCW9natkXDLow7IBT5tWS5i++zo2OLyJNPvwJYka7+3MavFPuf
         bgJH0tnidcn3kMvepcgafX6dPFRD3KnhX3+iH9vx1KZoWGbY1ANquSRnNfCkfVauyGFM
         1K5zR+4X01Pw/9vTmBZEIHLuXDoSIoBWej3+MktAHcLQvHSl6/n8sqseryEqosU1uVgj
         s/MKeAT1jIhb3ohb7IQmOhpPWWcGL2bviGbC6G8AvpZrjUxlmr1nyA58uRuHSzOTMXcZ
         R47/7iqN21HDxGMhJ+qFWLt982Bmhqk1socynd9t+wQRhzThNBtMJYTV1GqakIC2Rc3W
         FZgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781654773; x=1782259573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        b=VyKfVvUQXBCvLPemoQfZAR1bpev/sXFbiYLvZNnkHW2QBnUmfUW5+EnR4H82tLJ5mQ
         fbIQrNhDToKOI5DMRmP4+w7EMro+mYGuAIjLLKP9Lzn3BfdQXT8za5DyMs30k5w653om
         XFNNEfczuDqsfD5hbSGTrtsSYddnbJUa4K7C4jvMEM8XSaE+n2lJ2mgjTlg98ILI/z76
         5t/97QXRzCQrAYGq/eN2YsAu909DuCkIu8zcIYY7nQBlK3P3EbeJa+Rby+lsQstVqhGe
         s/lv8vyKhwQXfYlfGqAo27FN2SyY3wnxyRwRJJSeHt0qUK6RDEP9lV/IulWvAMzMpe4T
         B7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781654773; x=1782259573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        b=QOTFfuFNFqhi/FUEfvIUs4SmWM8caxFbhv8RSnQALGa/PyB74AFAawFkq7LASJ/lQV
         wqht0pHsS67SKRCrdfXlzmMe3YYWlTYl8DLkEGSFoD378jVtjpnM6+Jpeqm06eGWuRj/
         +0FHFsw3myZA0Px0NN1IyuHE3pm0x+67ltR0fRSmsWyVnBUpqKUgXSxP59N7Ric5tYMa
         uJiAZDWDXuGsfZezmXNsERnL1LAqLu2Di16hj4Gc+DLi7fnrka6js1h8XOC0O9zBQrqm
         rceOCELV0X5qOMl6HfVpHL1nDidZnAOxLWqlE1FjnagSjdGJQzT1Q9GwnK8V/SrdWRAm
         koeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6kGUIYdck1ivSiHvvnobG0m+m2CGBS5q8UdK3Qmvi9xmS1Sjsz8erBKWmNKNMwa4egQ7REvCJgy9ksSA2@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaNQREAgUPKIsjWd5kCIqRrwkrdZ/NX9hbg2sxo9t4gUdtfE8
	smoYHPg24frQNKc/pqcSAOz+hn9FcbNmqSV3kgRxsdHcJ/PBfeWPQiDc67PXAMgYTFiZWAQJoqN
	gK+r+BxxnhnJPL8625WIShuC/w99Yy5sfBeKv6vl1
X-Gm-Gg: AfdE7ckiqdvGtmdeWQPW891izQkKsUfWZYUtQ7rQBu5pGUw+bjiwOJZqgcqFt31rByR
	Jhf44LhD6XZaHy6mUigf88UHPN9zkBOzzkdD6sJGbJnXoR0oxQ0b6kj4ezYid5lPZZS358hEYUL
	7PGTSdbyZ7zHq+4QuLxisS4CNLtqRkNPdnk0USd0O0XQAtyhpSJIhgc1y4H6be+/d/tsMvfnoS1
	98cAnFJ96KkyNLbqOG0WFMhH/aB/QNcT6BiGGZH2nqgI19Sj7rlo9wuIvxcdU4bbwZmi8K/jy1Y
	EE6vs4RWpZqbqefS1xSExuACDm9IQrLcNuMiCfE1JPKJBXu1LuZEZFpMgFGXlOmjojrGqTfHHSd
	CVW+N/pyA2l5urJEG3N7bQYRzhb5M3dKRMo9gJ2E8eQDW/l1J
X-Received: by 2002:a05:7300:6917:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-30bc992c59cmr985150eec.5.1781654772212; Tue, 16 Jun 2026
 17:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl> <20260616143020.3458085-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260616143020.3458085-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Jun 2026 17:06:01 -0700
X-Gm-Features: AVVi8Cce5oIkQ6o0SM96_tTZrEuKWAAnxCW1BPbsireeIZuVvbRqCN_usM_TBAY
Message-ID: <CAAVpQUDqPsRXdsW31prBCDart-LGsF2EmFVN31gB3Nx6WPT2kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 7:29=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
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
> and store the LSM errno in the blocked slot.
>
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm=
-denials-on-scm_rights
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/file.c                         | 48 ++++++++++++++++++++-----------
>  include/linux/file.h              |  2 ++
>  include/net/af_unix.h             |  1 +

net-next is closed during the merge window, so please repost after that.

a few comments: please

* add cover letter
* separate fs/ and net/ changes
* do not touch tools/testing/selftest/Makefile
* use kselftest_harness.h and system()
* check other local rules (reverse xmas tree order, etc) in
Documentation/process/maintainer-netdev.rst

---
pw-bot: cr
