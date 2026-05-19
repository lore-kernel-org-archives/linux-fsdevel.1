Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A4370AD9
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187905; cv=pass; b=RAuq4gmSPrzE3iT1yW/9qcVsdS9f5/nurudVFCSPr3fg3Ee5wGx9aXr9lzaeAx5jSW3JoM5GRdZOmeiKYczDsEE7fHALndgqZwmqMpCRm5/QAF3bucxB40IOSmcIJiaV3zg4/wKRwkgq84Ll35QAZXbEpMaqV2/YUpvLk6J6ePA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187905; c=relaxed/simple;
	bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1mW2OxPbK2PIFf9YmDqthOCvTPs4CdUBxSDAUuCwF3B56w0a/HAQ3XC44BTGTUhdiLJ4Vt9aogHMr3q23u8HtqJmL8NEc0y5dPmig4cRo2nk+PkXokIPCzT8MXEL36/m413jKcQ4qDEVbO+g8vcZJK7YopdRMUvadHTfPyhdwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNfQG1Cf; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNfQG1Cf"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so6217222a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 03:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779187894; cv=none;
        d=google.com; s=arc-20240605;
        b=Sw+AZM7vhzVRrKI9cy4QFO5jX8X3whcItzSE8pE73yLob2el0LxcXKTP/BbAWj2Jr+
         vVPAVl7PUXTVtTQFXlyfb7rxEAMQ4v9yf84P+IgJP6Po38e7AWcmBtscZJ9oLjcYkdCF
         1dU2q4w1uXcpcZPxoOhRnjfXUnGDmjtmXD6EDusD3ZN+gJC1ZR2O+M2H9Q/4EikPDJS0
         1JRDkaDTpzkj1jvO4VaWmrifahR28I7oSW1ESGv+6RgJeazbGer1h7RT7rbPSonb6GfI
         olaFkyksAmCK9ytV2KYDZxa+XoQsUqmRfcgeVFnkb16ljXjxpspUkyXADzhi3wp+Hubm
         Opxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
        fh=9uPO1yV1/xOGbSWiZh747ud/xkbsZqck6KAELJY2j8I=;
        b=UkIBXuo0Tomt4qUjg9XHP7noSJBPkTyAi7AqXOMj0kLlrVlIM4kqEPA+2NpWVADAHq
         BIktgA8BYczncyWfgqtZlp+ETAUkNJISQdkVfjB+12AFwAzTkoJUFfQ7SuBg0+OppJsV
         zRWPN+H0sEBfyua06VKZKTLUQUAUD7uMqctcVxEJDcqnVdbO5lXnr+ecEHwxN4AkK1UF
         rSLJHIUH/irbyrBAeACPiIK78D80TQITRYMFEfnX0hzcPxf/wtOkSuyD5pLpB5JsOmV+
         py1ywkZMkMtOVe77GFFwDc3K5mPUL1hE8GKtwCx0nGRW+ZP8FYQqyQ2LqxXcKl7m3vcb
         uEJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779187894; x=1779792694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
        b=rNfQG1CfgT5ban+PDibQ/+W7/d6mR2Om21tfqvBf3dm44wDQcKOr7K+QaqoqcDjdBY
         e9j3qEg2ZqJaK6PhuC8CE6+n6UhKkLRgjtJ4On8iAoEFa84vpggEAY758ReZDD1v6+Gp
         JSwCMepiaeIXEZtekUiVZEyMRyj/ad15gWuZRcr/ZM0w+53R7Vf9K3B7S3fS8AvzxNA1
         3ihd7DkiAx6GBRasJU4xyDkbyZx/07aZxowePOC3bfEW3tiT5jFZ8gUU5XnhQvD3agrS
         dcWsVbkxooeKuC8rjufMu+RfVaQBNistzUqQnm5h/7uRermXsVvPpc0+2c38gLfwlWbv
         0O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187894; x=1779792694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
        b=n//q5lURR1lm/uaAROluO1GBwFD6jYNFz+1NKrf+5SAIQr0EhllLLqjDFVQWzU/dRt
         Ab0+aGDWunmTscLn0eK7urvS5H1pm2Chx71j7bat8+SA5dSaKu/9XuhGeFsFRtTtNgJJ
         gvK2niM1QJCh8cloh9xDSomwnLngVNRwl/RzbXecPPv6hOUkHDQ3x6tXLrgJrfCS3MnE
         xHUrH8WNeIFICSszA2Vo4ih0kkVTxNSXAy9wi6knQ+t84SSYxNlWU/SdcYvQC4+6ofKn
         qlAV4eVr16EtqXHRhWNUUhz3uZkRqfyY0ChOr9HI1VhX7ZWE3v78TGCzRYxgcr5Qc9jA
         UAGA==
X-Forwarded-Encrypted: i=1; AFNElJ+OT7J1dOQPSFHXMQwwUNDpFX6B/2/+HWGnEzxGaens2Pz3/Wp4W5oCfeuvTkcIIOj0NSOc3uNff/Uni8i3@vger.kernel.org
X-Gm-Message-State: AOJu0YxICYLx90aimo1G4OfOqsXrHBEJZDrf8mGHioN11PEczAkTFH+O
	1D0dghZQiaOTE7XaeVKecYhoNradvdf88sK/dsDTwR7lWW67ubB26suvLRASG16ZgboigV2tMHQ
	FlAYsHVuXEyWDSYdeaKVNHa7ucrdlp0A=
X-Gm-Gg: Acq92OHXMD0cwlhbwohqGnpZF7W8ek6X8/eBvIpMQbBkxvo0WA1Zy0i/Yuog8fdhklP
	tmVbLgsRpW+BZkAFsxKZCCMIHRbuhy3wkwU+DIQTZ1u6SLOaOLmtrCVamjxRBk9YUQv5no2eaqK
	VjuyxVVuZ/Ffe8+HQktZrhKMw8dmB72XlKd3FFFJSlKSCk7uzfv8IweqJX6ytiVRvB7mDygoJ5k
	ZkIY4JIakqxUS8xKVpWVf7Ydu++UbZY4WYuJ/HxQsj153iiWlRVq6Ng6zBL3Qr9lHkjyus2KHxu
	xSj73WH2TJcb+XpzfMQwzmQUeui4Tqai5OHJZ4Q=
X-Received: by 2002:a05:6402:22e5:b0:67c:1c12:3ee6 with SMTP id
 4fb4d7f45d1cf-6830abcc48fmr7158004a12.5.1779187894290; Tue, 19 May 2026
 03:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com> <177918418452.771415.4371785688744608623.b4-reply@b4>
In-Reply-To: <177918418452.771415.4371785688744608623.b4-reply@b4>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 19 May 2026 12:51:22 +0200
X-Gm-Features: AVHnY4KxwAsZR24cEVgsWChCgk4fjPFWjAc3-R7St5PMsRGg6TL6NPpS0u-UI6M
Message-ID: <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:49=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On 2026-05-18 20:59 +0200, Jann Horn wrote:
> > I feel like a sysctl for "disable all the splice-like interfaces and
> > zerocopy TX" would be reasonable to have? Either by blocking such
> > operations, or better, silently downgrading all such operations to
> > normal copies.
>
[..]
> I think blocking isn't going to be useful as it will make it harder for
> distros to turn this on. So we should degrade.
>
[..]
> Let's discuss the other aggressive alternative: Can we try and
> unconditionally degrade to copy. This would affect sendfile(), splice(),
> and vmsplice(). Worst-case we would have to introduce the sysctl
> retroactively.
>

I know at least nginx uses sendfile, but I never benchmarked how much it bu=
ys.

The original patch as proposed filters by rw perms on the file, which
I expect to exclude nginx.

While kernel-internal copy is still going to beat a userspace-based
read/write loop, this is still going to be a hit and I expect people
are going to complain. Afterwards you may end up with tutorials how to
re-enable pre-patch behavior, partially defeating the point.

How about denial of splice usage or degradation to copy are still on
the table, but based on a different criterion: whether code involved
is "known good" for lack of a better description. iow the kernel would
maintain a whitelist of "safe" cases. Random-ass AF_NOBODYEVERHEARDOF
does not make the cut.

Common-case usage would have to be audited of course, but this sounds
rather actionable and would provide hardening without much friction.

I can't stress enough that mucking around splice (even if worthwhile)
is merely addressing the currently popular attack vector and not the
general problem.

The general problem is that the kernel is expected to be able to run
with untrusted unprivileged users, while it avoidably exposes a huge
attack surface. Of course there is no way around providing a bunch of
syscalls to users, so *some* danger will always be there and one has
to expect that even core code has bugs which will be discovered by
LLMs in the coming months. Even then, there is tons of code which is
currently being audited by third parties and which has no use in most
setups. Instead it gets autoloaded in response to an exploit wishing
to take advantage of its bugs.

The huge attack surface was always a problematic position to be in,
but with the advent lf LLMs any unskilled person can drop a 0day and
the position is straight up untenable. In the long run there is no way
around blocking access to code by default, way beyond the current
splice proposal.
