Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4E30B514
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868530; cv=pass; b=urY99VLoNNQ47fxGhu3c9Ffo85bvwjiAivf91cG+BEVO30vvEECR1VovtkhADdgoMsQ6AoglUboo4XlIan0EjkVA9EVngMj0+SHDItcOCeGPK690WIxwizty7PgJDdHkYcLqEriJbpIumWHHk97MeATXQxZEl/cv0dFEjodELfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868530; c=relaxed/simple;
	bh=HWOlXvMq84jYL3ZpGui+jJnZMAehwjnJC7xJHZBOLYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sazda4r8FdZ2XZBeGz87fKi5278YJZ3kQEIXWZZZi7RcuLAAV5b0YtCx/SkSiBxVKf3bsrAc252zjEvC95nea2GrVG8PoKhL0Sa3qMOGX3qs78NP1cMeWbzBzJ+ds6cnIbSMOa4rji6oxh7uyQ6Ry/8yVJqXav68hMS/shPPrIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1gsSiEC; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1gsSiEC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba36357195bso658255666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 07:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776868527; cv=none;
        d=google.com; s=arc-20240605;
        b=JrSjXiZeszt8rHxzUeuBHjQuNWWvULNJHW0S6+0vN53VkKxv+07J9hg7o4LYj3sjOV
         1KPLIIWBEGMLatzY1eo4v1wDJ3GW6XePuZDPaC+nf1mBawrBGJRBTan/Lzk6olyofJSl
         drCinw3WIRshsoQweJOxPWKwg5GesOGAB+3H5JeO6Q/gjVwXyzKGzxCTYGHHcFdDxjHe
         aZfJE4TzowyJexI+4MXd1Lr7a3vC7+cofaWyyt7hPY4g6OvWfgk/7h+R+tH1mlQciV31
         aXJejD3MpvhsRKwhfRknCAS+PXFBWaAC3nf5WZOSHA2LkpMQWoIoW3U2Z8HhUMsNDHfp
         FiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKsStlY+czWnKm2r/iuX/7xGvMuoeswgl+7UHWaBGvU=;
        fh=Hqq1JKhveV9lYjahHZmSpRBHn8IWPrbemYpBgWn8VG0=;
        b=G2VUN3hZhyxfl06LvuYztYBsIFymSukadBYdfSNonWa0YIr/Jbd0YN2dFkYZrNniql
         1Hhr9FoPoeTUGAVPK+2Z/nRQHO4qpKIP1TghVbTp3QwHa1vCxPaoUReV3P6svIuRaAEm
         EwVVdXZq8SdlzeMaJCb1bWFYHG8Z+esNFRkrssRRstGqcVrM7WwUffQJ8TEBxkVqsw+n
         4Y2ai272VNZi8t0fIBIL0yeYMbhvhObOtVh4gdfgx8KnjaOSJNuZI/+JS4tB9SLb8nrS
         hq9UhzUGI1pHnkOYiLXtUQ5iFkVi0zolliYMdgICnKvKqx5pS1ckL/rkqAGGw/fOBHzh
         WJ6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868527; x=1777473327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKsStlY+czWnKm2r/iuX/7xGvMuoeswgl+7UHWaBGvU=;
        b=J1gsSiECWPbXY54NmtG9HlpbWYuq1Zl09id679pt4tsyJolkYtxENRKXmDbIxddcdL
         CONRSUdPi97rohOhHhvu8psBdc5rEuXdaBIW3gWbXuIZ+kj5TAZs8d4uFfAgZL0Hp7ra
         AB4bgcBai+K6yo7dcGRY1cGgJP7wAfW4FjeaJDxHa/xUdxkVOZPy29IwjnuBO9AvDG+T
         ZgRPthwanapd00yf5wxml2x7JISwvmeZ2WTYYTYF/IqO8xvRTiHskMuUwLgpiHYkmtPC
         JILNNL08OBL43yZjlSyZaxuQo2UQu9PKgKrr9+giEzOU+1MAU0a0HJ8wP4tlo6jMW3Rj
         R2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868527; x=1777473327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKsStlY+czWnKm2r/iuX/7xGvMuoeswgl+7UHWaBGvU=;
        b=OmZN/Ti47DY9w6rioUdG8cdClwXhM46fyzCs2UVv/bX5XxQe8wPmR1zjdgJuM7LTMd
         JHr8DQNHnNZBz3Ge+/xTei7gQqCSmHrg377Dwj1V1feztH3LwSe1GHK8KULcVFQ2niUj
         L/TNEBokYTSRXYAIRYy4by+KZ2wlLB26DKro8ExD5k30PKPlb4mgTtP74XJ+KhV+keyn
         dO+41WoH3+thZd+qmmv9+6TAAshGSmO+KsmwNXCUHdx+yr9ADwSKBIaI2MBQbFwUAlE5
         oDy6Ndt1CX2TeRGApswmnW9smbWxr8bD0oMD7ATXXHm77U2SpGPpazchD7V9/vRUE4Eq
         WVmQ==
X-Forwarded-Encrypted: i=1; AFNElJ85OxE/0AahmpR044GJIheeJfo/+4bIP93ljQW91n8CzUImNDCqHEXOmsZnJh19e+oFhrwhHNTaZcuZA+Xh@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRU1QQZxblmwTd0ShCejCv5GFmXuUEw54NQ4b2xS8OfPLq6rF
	4XWLRuh5tBxSsJAZkeHvvsKwO6m1Ok1e7UjuZsttAVzk0cLa8vbAXSMatDcKopKeJVZaD5L3qdp
	Hk3ddQb3mYMePsGMO2NACtFYpiplAYs8=
X-Gm-Gg: AeBDietlI+ysc8I8M2oe6NXnqMjIokKygZVOJvSqwvA2A+p9G9MPCOE+y/DHG34ZQU1
	A+0IjgVdKQ7a80+FyBpehqL7Ft4cUibNaGz+9IQetYyGfnb5x7YykjioxSKIYR1k7jEpXXaLBg4
	8LSA3VRxHa1T9j+o7DXcTM7UqZn+a0JkEcwk8r6Eympe9hncnMGAvTNyYnodcdYytijPK6Azi2h
	zDdImeWHi49eatJc5kFGXdhxL3YkmClc/h3izie42Rl5Qgf9I8N5PF7yAKR9e+n7iMI6od16tMO
	+0FLAYyFmiII9c3pqDs331muMXQKS9tNNEVuElJv9307FteQagg=
X-Received: by 2002:a17:907:a0d6:b0:b98:595c:a76f with SMTP id
 a640c23a62f3a-ba418888cfdmr1070881966b.16.1776868527017; Wed, 22 Apr 2026
 07:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
 <20260421181026.GG7765@frogsfrogsfrogs> <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>
 <20260421201502.GH7765@frogsfrogsfrogs> <CAOQ4uxg4S=1jBGusNSHDH20+AHdFucFfWie9wqBU9V=LUWqwUg@mail.gmail.com>
 <20260422140923.GA11127@macsyma-wired.lan>
In-Reply-To: <20260422140923.GA11127@macsyma-wired.lan>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Apr 2026 16:35:15 +0200
X-Gm-Features: AQROBzA0ez7Hgvod_imCktTWw_fOZR1Gg9bjcjMqOsLzslHs4hLVJsm2OyHBe7M
Message-ID: <CAOQ4uxgaKsFqZYemhS_iKzOAK2ZKJ623FUm5ysFiTvK3idnG6Q@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Theodore Tso <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 4:10=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote:
>
> > > >  - Handle security issues and regression promptly.  Both those repo=
rted
> > > >    by ordinary users and those reported by test bots and fuzzing to=
ols.
> > > >    The filesystem must handle corrupted input gracefully without ha=
nging
> > > >    or crashing the kernel.
> > >
> > > How about
> > > "...without corrupting memory, hanging, or crashing the kernel."
>
> I will note that security@kernel.org does not consider maliciously
> fuzzed file systems as a security issue.  And a long-standing position
> by both ext4 and xfs has been that distributions configuring
> automounters to blindly mount USB sticks dropped in the parking lot by
> the KGB, MSS, or NSA is a Bad Idea.
>
> I'm a bit nervous about stating this as an expectation, especially
> given denial of service attacks on maintainer time with a large number
> of random academics which fork syzkaller, and send security reports
> that mostly duplicate upstream syzkaller reports and don't support the
> web site allowing developers to test syzkaller exports which don't
> reproduce locally.
>
> It's certainly an ideal, but I'm not sure it's one we can expect or
> guarantee.  It's also certainly not the case on most file systems
> in-tree today, to a varying degrees, but outside of the most highly
> maintained file systems, if we were to state this, (a) I'd be
> concerned that we would be setting expectations that will disappoint
> Linux users, or worse, class-action lawyers (well, they would be
> rubbing their hands with glee), and (b) if we actually enforced it,
> would probably result in 90% of the current in-tree file systems
> getting removed.

This is a sentence that I removed and Darrick asked me to
add it back, because "Not screwing over a running system is
important, The guidelines ought to make that explicit."

"The filesystem must handle corrupted input gracefully
 without corrupting memory, hanging or crashing the kernel."

Please suggest a variant which you are comfortable with and
captures the sentiment that Darrick wished to express.

Thanks,
Amir.
