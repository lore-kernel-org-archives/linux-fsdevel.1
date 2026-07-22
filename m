Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF831DDBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680016; cv=pass; b=EUrxMqS/c3HUR8pYf3Fj3lWbcR1mbZSfvYQy/Cpd8VTdPz5flzkV4rimKimuK+zktTqC6rjLK2DIJUJliq5r6+GUqu3gSdW9dqmiWtzlg0Cy5COmLDRQ2+L3L8Wc0sONi6WNLVarIM1N76HWmA5R67GBQWXFbQrO3+5Yo0lUiHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680016; c=relaxed/simple;
	bh=dfoCcDupWhDSCg4m/chiZQM9PGxBGqDy/mQQu3Vv3Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCEyWhVsXAwXonDxwFQ9hdJisQNqZGvrpc3E0f/xewuUtRNBnLm4WgEj4J7iy2yldxcXl/9UHKJLnXoj7xJ4rsheqVXxgIoshduq0m3Icd5sXuuB0UqpuP7NcP7bsvOvbfQhnqvY8mwCBOO3NrLcFMxr/NCsg8azz5UaxWbUZ+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtX+7K7l; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtX+7K7l"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c15a5b265so1254561cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 17:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784680013; cv=none;
        d=google.com; s=arc-20260327;
        b=BHz7RHYpcHPBzS8bdpN4MSW7DUwIYG/wqsrJiVY9fk5x6CItpAegfqXzIV0SNMuhrp
         M+Y+wXAC3twHtt6cEqsyZ8z3N2ba6K6mJ36/liiHnNBhI4ktoDnPdpderCZE5Nz5qiBa
         dtlF+6gXYPkzcOlUjoEhArtTnbk89JFAhBFgWEMtkCOy5n8uZ21sR3v0q6Sv8q4Pym9c
         +skzCaSsxq3/y526fd4j55KZUCIJVliwPk406vqbATN++UdsbslGkcjlaGfam7ipYP4v
         qBrS8qU+bH+5M7S+zzj4qKjED6U3Wa2I3UjErmKl7qyVnDWuICS7gIXaS11jdOJuCWN/
         GyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uD92fx8V5ur/nd3PoFyGrqnVJRnMeqRGxm21Tu0obbo=;
        fh=WRGhBf5i2D+lllNbk56LsxDikRJRsWQyl+wlpaMzw44=;
        b=rzMEM6zC6aMjnrA0NdUpJg0BdhFBnnDbFaJB/GWcu2pvIx5EMiz7IZI5ElDVP56PAB
         FUphPOzfqxEJqC2MnjtYf9VgePt4y772gKvr/lQUT0YAL2BtC1V3N4mYnFxHjrr38gBx
         3DtPkB3TiGaf+UHAezheYP6RJXn/VzM/47HcJrbExvFDkjJmwLUo3w10uKaKfiSDC+7z
         Mu+ct4cl7LfNKvJ4hn6UNAvj/taLm2BdhL6rwK6QuqF93EzXLbS55JCzy2BDK4EI2M1T
         muR7nFYHK+E6CPFjA0IqugCKfY1FI/TeraF/R3skJXBJtVY/+6U1zX+kcaRfCZftwWAW
         C9WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784680013; x=1785284813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uD92fx8V5ur/nd3PoFyGrqnVJRnMeqRGxm21Tu0obbo=;
        b=RtX+7K7lY7V1rIyNnKBE8LQwFB3L8LoaG+mXs/WvqDJZ+XcByIA/iUF3Zu4M53MYYi
         lPF3+AEHEOg1urv8vilvSxdxOy+K7OR3VLXyeSc8sx7myoQ+LtP4Jo7fBrlQeFUOB4Dl
         K5r/ks0UjmBv7g2EXVVb5EuDN4NUQrMCMzqctr0aOsY3lX32oHfGBPCilyPmSaX/ZD0s
         2EqxFitTRFsEZiDBFdL/cJsaI5ujGXV4qBoAgX5vLT7ViOfT35vMyYsHw0GFGuIhMWlQ
         A0b6gD51jjK1a6swAfblo7xDf2vXgH2JgBOIlbKEG5B2y2PBY/Nl44Is8TiQqTiPS4fV
         SzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680013; x=1785284813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uD92fx8V5ur/nd3PoFyGrqnVJRnMeqRGxm21Tu0obbo=;
        b=PtRja8zHGGSNl6bslnS1zl2Fs2i1kwmZ6CUyhQZ09/Nju5vcKqRoYPwXr20qlUIGR6
         UkZwlupxblGhx7jvl89mFX21UCiDbP/2WaClS7L1jA/xN4QrNxXT9Q0j47dHPFUo2EXz
         +KOAG8HyCjijajvQ+G7AHy8xSMMZSBZz09OjbtF28H8kl0x65NOJ4FlMouvFb5eAiox2
         dZVsgX9Iul2u5vXeVH7KC3dkdjHpdLiGadb149TeOR4xiek7Strd4VE0dSb6Tis+2fQH
         kbmLyQzWMOHW6mMrLyXgJYmvBED5MXR+svAiitocPlIgpjQPBfLdDBjsqOfiboaZtiKL
         86og==
X-Gm-Message-State: AOJu0Yx4r7fXFc1TmSYF4WS4skYnvu+m0KI+oahaHZ+X2xJZ1D3nVMuR
	zzPuVxX9995xKGcOsButW9lanJPvrtpxBSwQnHYSkDgG3yFmdyVzD/4hgyQ2WDdC5mvqGAcRGH4
	eJJJFHYrHHc1bGPTxmUatiBF2RTlJsX6SrRgEWlcR
X-Gm-Gg: AR+sD11GXp8t3umy/RFq6HFPG8yOmqtPQYKlFeyttCBX0QtGko6ghkMct9wFu9d/h2W
	8qL99mDNrIZedgq1hHN4QxmcX8HCG1YDdn+hWKkTmFEwjsh5Mg7DywaevnIWlVm3CDjC3BdMsnS
	vlC2lNKFT7pNXFFGRcIX9pvc5Qtj5NRSAb+FphBZ65Zlg4o+XeoS+2wvRsPwRgBv+lNrfzmNkn7
	3AL4ajC4XaM6S/iV0rk1TlNU3rroERsq0IvX6xAFjZIeaV5+J9s+h/t3+JnRifl4MfEtSs=
X-Received: by 2002:ac8:5c96:0:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-527ef5410bamr2873441cf.5.1784680012014; Tue, 21 Jul 2026
 17:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
In-Reply-To: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
From: Cole Faust <colefaust@google.com>
Date: Tue, 21 Jul 2026 17:26:35 -0700
X-Gm-Features: AUfX_mxSmiiY8-d5_xVZCKQKR1Qs5Y8FBQWkFaJ8MEfg_EbYTGCWjIPL3g2UAe0
Message-ID: <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
To: brauner@kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correcting Farid's email.

On Tue, Jul 21, 2026 at 5:24=E2=80=AFPM Cole Faust <colefaust@google.com> w=
rote:
>
> Hi Christian, Farid,
>
> My name is Cole, I work on the android build system. We have similar
> goals for creating hermetic and relocatable builds in our build system
> (a custom, android-specific one). I was very excited when I saw Farid
> working on $ORIGIN support, but then somewhat disappointed when I saw
> the new BPF-based solution.
>
> Our usecase is mostly to decouple the glibc version used in the
> android build from the host machine. We've had several instances where
> our CI machines are running old glibc versions that cause problems,
> and they're not trivial to update. Ideally you should be able to
> download the android source and build it on a modern linux kernel,
> regardless of the userspace.
>
> To register a binfmt_misc handler, you need either root + modifying
> global state on the host, or to make a user+mount namespace. But if we
> use a mount namespace, couldn't we just mount the interpreter we want
> to use at a fixed path? I thought one of the main goals of this
> features was to avoid the use of namespaces because they don't always
> nest well; Farid called this out as a problem with buck2's sandboxing.
> In android, we don't yet have any nested sandboxing but there have
> been conversations about increasing security of the build using
> something like gvisor to isolate the build from the kernel, in wake of
> the recent AI-discovered local privilege escalations, after which
> these complicated kernel features are likely to stop working. And
> requiring root is definitely out of the question.
>
> I also wanted to ask about the security of this bpf solution. I
> understand there are some security concerns about $ORIGIN. Why is this
> new binfmt_misc + bpf solution better? An attacker will still have
> more opportunity to place a malicious loader relative to the
> executable. With the binfmt_misc solution, you will be able to only
> have it active for certain things, like a build, but that's only if
> you use the user+mount namespace to scope it. From what I understand,
> Farid plans on registering the handler globally and persistently on
> NixOS systems that want relocatable builds, does that not make those
> systems susceptible to these concerns? (correct me if that's not your
> plan, Farid)
>
> I can't really think of a better solution than the originally-proposed
> $ORIGIN support for build systems to use. I don't care about setuid or
> complicated filesystems like memfd, so I would hope it would be
> straightforward to just error out if AT_SECURE is set or if any issue
> arises like not being able to determine the directory of the
> executable. IMO it's fine if it only works in simple, known-safe
> cases.
>
> Thanks to both of you for working on this, please let me know what you th=
ink.
>  - Cole
