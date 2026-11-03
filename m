Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793731088;
	b=1dUoFVsuEz9YEFkJkapW/TnYZsW6yLy44H56szjbBlwS902tnj91buHjD8CZKQCLDrY3
	 oNAX32+0XommOR2iUCJbmYd+F4CxbkDlcjV8wQVBkio/iRVBHzPcAkCQAXYjGQGiSBWTh
	 dRnrONpD/kRdlQN/KYK9SCKQ7GK2CkViG5Ve2m5gigBG5uAfUmQs35mAJsrnvni5bQrDh
	 HLHeHz7Q8EAsejr2gzuq8X/+54M1KVVZrYyg9N4QWPn1gnfhFNTOkKfrsImCF8aAwuM8J
	 6oe5S3HHlOn99+xKPohG8WDQtRzxQ54cruthZ99VMvsEcBlk4Mc4vW6bCxbpfChj7hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
	b=JDZ64rBSr6NJKDkFBCH6g5i0CTexPO05pTEhn3sTtWwhvtFoanstXxzzbik8JQHupnpx
	 zgSgTGSKQnr1jyVY41WoG8bNoO84e7H094KLvUTRm+yPBoncnZDfefxzFuu1Qh+OJ2R1c
	 7yzTnzO5X5Xc+R7l//RafEZYlZ9gAfxwrAL7Y/YTMbYHwaZxh6DxhqZUjQ7FDDOynIKAz
	 iyN034C/kh5y4p3VsEF6LLaVmUaCb/bL0actOM5Q4qISPUxxHuIKNmyV1pnbguF8et8N1
	 rbukOF6Wifn5yiG3FUD8hQNxakD5ev0k7nyqx5cF/D5WTymBklo16q9NCMfwQMULHUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nVCsNw0y;
	arc=fail smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33D606A31B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 18:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE33D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nVCsNw0y
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so4779413e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 10:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793731081; cv=none;
        d=google.com; s=arc-20260327;
        b=JSPulfNMxiEsCm/WR2/bRGXYFNk60hfKrzPAkG3c9w3WOQ9fa+xpCZXPd48dpNs3H/
         vAirczQ1EvPfnK+kBJ2E5JhCCxi4b/QZpP1B95zgPjM2+GzfaqhuCgP7jkupEtu9emoE
         sypfh/IQJmv4++9XgIqF+5DWUC0L7tDUvGNHNM7nni/GQ9jL5ubcHn97YlZ4DLvxz7WQ
         fveYpW6PwOk4OX9tPZWlO6WGyMQhmyK2fWXO/bVHatAFJSN0cakF46bD293gShivUfRl
         8Y11/O9lxO5NaqH6s3mRgnV1F4+qTjtmMDoB4Ukm5gdvHn3vSvgHbMDfRylFWwe57pVG
         viSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        fh=p3H7+PwUVpA/FQo/spz6gT77zHvueJxNIX/l+uz3B4E=;
        b=RQ/oRMnc5uCvLXn+R4BCpqfVpd0r4gjg5GbSicJyKi9+tKgjhulahQ4FyAoKow6blr
         dBxYvU9Umn+hE8Fq6soOJQ5TUuqhiEmfVCsg+hNBhEwph50QGMQV8hxuxK/+18PYPhkj
         S3HgfPl+EJ6Ubfej3VSMP7CRZbWBMJnrknmIpz+r42L/U9iRkuRNHSILN0+zXttwn5bh
         LiRVxUC0PyiqyqoN+HevCbccF1mLUVLC4q0ZkmQCYqMIN8/KRHoN0FMWHD4aoZVfqNKE
         rYRXilm68hvSXX586ZJAlZQfw4jY6GpP35sf778IfqbUWEzmx4PBYSyPUGKW5ak806zL
         60bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793731081; x=1794335881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        b=nVCsNw0y6hskrENSBv8EU3amWuYztT8dLT5p7AwDRfBEJgh5KCH4wcnDy1+4F8oz26
         mugE2B8LWKKCR0Y9k2Z98xSLZ5eNvcfR272i+te/45lnsb9AWyAtGJcy3D9bL7ir+f71
         qQpNmsSv7T5esoFkU7QTr7zF74lmigXGg9dzQbwmAGy2M5yd+bQ/6ZIx3r0WugxBJ5RO
         hJm/oKDuQExrJP3FUtAD2VCpRZdYySsqRCW8MbRDOe9JChKA+5WjiMn7EutjmI1dtjC9
         TX6PAuZUUq43suQ5ErDcrLsoaFbkM/WfFXDhbG1erayEtyXYdgmMQ2TL7MALbarBBDH6
         21vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731081; x=1794335881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        b=AT8ZXh8oNiv19om1aSWH93e4BR5CImWg7WrbPWvWwbofvAv/dMNxpg3SiCtKQ9xxQc
         lBe5rr7ul8uqv8Ah2TUn2YhclYjbIPTXNwEGnqHVQhVpCjYvpXkYhZ6Iw/7ziWtCMJQX
         06+W2W/bcUDSFX8rEnf/ezaUDJXXNr+wgRJQXryQNM3Vxk5pnX+iIgkqcMdTrhb1TtbR
         ztUa83mWOgjeuFVCXe30fRaEdHQcQZ8N3wNpA0GCzCXq9/bsMxzEMqnsZXX1bhT4JFjh
         DdggsHu930rAg9CYkMzcS8wgn/EfkZU3ZUOb9iKRRGwf1n/6DJap5AAOMqPk0vrmEf0L
         m6ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwym7Lljw9Nf2/1Afg3Sd+nYciR3pGCaAcPl1SpVPFrJSJlb/KvpYdPHsSYaB5DKr606qsa6rB/Mtdpuw5e@vger.kernel.org
X-Gm-Message-State: APuU4Z9RXEIui1lSxa+OPMxv+H50hl8lT8lviR9ZONRUZG4d4AkW+P3q
	mrUKbIRgV1xmu9XlYgQHd8NUMW5i0s2m4K1Tz+bDm7wxDMeM6+Z4VhXPFd5iwmCrZg6pc7XJsWj
	lIgY/kRCNKiqCXNaqU5/XXbV2Y6QPlBSQdlIrpXRo
X-Gm-Gg: AYBFou0vC75fZqM3iWefHgEEfzKOSxu+f1+NU+VHeUIUcdLc1Ud4e0pnz2u2Mbnm4BL
	qUiY4lag2tfZoIHfoqEmmGbiKKBrle14UDQvKzh+X++VXU7AVMJubQ5e6vki28teuIdYDaFIyu6
	7z0hKp1ZYGFwQAj3xCLSVrB0eIq5H4DWH40/3u6gK1mdU8xaUmMH4SZaWjzW+jFWCOdsHATb5Dz
	OJWVR2MmnixSUMi4GZ1A+Q1+dqfPTc38cX1vpyXh2yR5Pc5P4n2FtLykj2s9XdoVqfTOQtukeT2
	HR05F54ZZg/6qKhx1VBQdIZx2eQ2yfc6YazhkSlQzvmpUOeptSO7n36SwiMrvS4ZGHCQXIOttCc
	Dp+MuQY46eeFVQFOslLwPgJqtZ00W5nSL/A==
X-Received: by 2002:a05:6512:3ca7:b0:5bc:e8b0:5652 with SMTP id
 2adb3069b0e04-5bfd9589099mr5147409e87.63.1793731080985; Tue, 03 Nov 2026
 10:38:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <auM32mOlBLu6ZUlt@google.com>
In-Reply-To: <auM32mOlBLu6ZUlt@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 3 Nov 2026 10:37:48 -0800
X-Gm-Features: AclHuK_sfbKF658HbwyCTsOToNn9cXs0qzXn8uaPUG4vxi_nXA5hXmjvbt4jwHQ
Message-ID: <CALCETrUD4vh_iSHV7G0bprUFU8=c+ECo701-tXcbQ3UXBWC1ig@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:11=E2=80=AFAM Hallgrimur H. Gunnarsson
<halg@google.com> wrote:
>
> On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:

> >
> > Why should the task's cap masks affect this?  *Maybe* cap_bset makes
> > sense, but I'm struggling a bit to see why cap_permitted and
> > cap_effective should matter.
>
> Sorry, the phrasing here may have been misleading. Just to clarify:
> none of the creating task's capability sets (cap_bset, cap_permitted
> or cap_effective) are used to restrict the new user namespace.
>
> When I wrote "reusing the existing task cap_bset, cap_permitted and
> cap_effective sets on namespace entry", I was contrasting this with
> the prior series from 2024 [1], which proposed adding a 6th per-thread
> capability set to struct cred.
>
> In this series, when a task creates or enters a user namespace, we
> simply initialize its new cred->cap_{bset,permitted,effective} in
> that namespace to user_ns->cap_bset instead of CAP_FULL_SET.
>

Okay, this makes *more* sense, but I think it's too weak.

I have a sort-of goal of having the creation of unprivileged
namespaces be allowed in most contexts by default, *even in Docker*
(which would involve the Docker team changing their default seccomp
rules, but that bridge can be crossed later).  (In furtherance of this
goal, I fixed an ancient bug in newuidmap that gets us quite a bit
closer a couple weeks ago.)

But tying this mitigation to a parent userns means that it's
completely unusable in the single-deep case.

I do have a question about this whole scheme, though: are we talking
*just* about CAP_NET_ADMIN?  That is, is there any other bit that has
anywhere near enough security relevance to make this kind of thing
worthwhile?  Because if it's really just a single bit control, maybe
we can come up with a nicer scheme.

--=20
Andy Lutomirski
AMA Capital Management, LLC
