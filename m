Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721F34CFC3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644769; cv=pass; b=u0KDZGMHn8Bq2stjGVhtvuthD3MqrA7BlgLD1QeHye7+iDZoSrYlt3BA7qIMoiZYu7S2mnnHds6XoIXttiDaj/0y0jNDNIES0Ze6aouvdzCz+PjeOFv9QGkuLY8H+Mm2A7NZCxYf03344NGJvDYnya+uXia6vqDkryF23RfmZEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644769; c=relaxed/simple;
	bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGxDwCfQnDggsFARzItD5A7X6ZUezKxEf/JE38rINShInrXpI/Y5Nz8AnbVmereSE4iofY94MmZGt1O6ooEFre3mG/NPiqNrrnhDDM7oCq5uGKLfBaY7Uw4HvUyJ3UjyNS7t2t92gZBhPxqt97YuIE3iUYYyjZhr3b1st5KvYqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrvNm/sp; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrvNm/sp"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a3fd333eeso33992001fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 00:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773644766; cv=none;
        d=google.com; s=arc-20240605;
        b=ibIKiwtQLMKOs8ZjDxFYUZFM8ENFWo3oiO/1oP02UFQD//Nd+XEGg8pBgDn7T7zKqy
         OlzXQkR6rxxc8kpRH/6tnJR3EpUbHjWu+UMOKSeF3/W77UBh/cbq7VBx75xkW3hgwDeJ
         e9QuElKzzSBr+2S245OaSDoFpj6jgQ3bFvVuQIPp9A2rMV2kM1grFfhpX/5KRARSSEAt
         6UbDkPny5xmeuSgc1owC2wvKhcoYDcskVMzgybT7oKFFrNeiWPCmaRGfQIFvcJFhITuo
         Uwwr7qgqWhE2QvSh4vAeRJ1nvgveuRV+iSGmyyQssnhMJtsHDSvPO6/nUm5OXgf8f3P3
         De+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
        fh=7qg4zRh48OkOcQp5JH5NqnEmkkKZsLin5rb32y6a4J0=;
        b=lMBXRTkP6FylnLEji6MVVnKP1nl/A/FafFC7Hk+4ABKSmeVXPt8y7H6PIHrJKB+uCB
         qQklFcm87vfNDgjWMBDAFcGb4Dtrc5syyZwfObaTUdq5bgORMwfPl/FVkExJW+kn6alj
         GwXPMpSqizVmR7g1X+QUOuiB3drOCCTLHWddHZLp9asxuURThbvxY3uS4C4OygQE9Czl
         d85mcD3oPYqIiPhLZGhQm/0o3X5x1ckTWGtpofSRjuw30n9zmC6aKt11nTaejliG4TXn
         zyvj8nCgyogENnQOVHCWYjvlRCN4yZf6izlMzDVR5cupuNzc5aU3CDgVsonMmHrGIjnm
         bLkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773644766; x=1774249566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
        b=rrvNm/sp0ejqtQpts4YJvKIZJai0U7h6SimZ1+626FCi7l4L6Dzs/D5AfC15pRBoWr
         kv/dIm7CfHnm9HMv/wH+hAenKg7VAAA/E7tVULHXPbxFq6YGS4qlbY3FPnHscS4jfzMo
         D3dH3ecOve/eQGzSnAb4Ojy44wq5Nw/0FFYtscPxcItm710bCdD1kjJ/hOB3448XZy8f
         K4xi4VdbUD1F+Vo4MhfBcbKbgnUdds5xx8LCHziC6xxbqHA6MvyjhOKbbiisyPVocwZ3
         KxoLuACxgOlrc3AY0BNPbelvSOBLVO9w1iQzbOC3uVjI5svhEljwS33qC/sFSOyzUjaG
         pJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773644766; x=1774249566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWa/MwbMbU4Cgy8HcLpzA6KnltFCFdwdVTLoxcjvQIo=;
        b=BDf3cMAtovivSV4SgZh0TILwU8FAQhNUrFrXdHJAPFJfvLrUK4UHfL1AreCav8KbdU
         mH6AbUtC9DgDWkn5YHetu1dwV4flHeVPFRx+7Sjj1xLnqwBn43bNGwMRNJF7kZ9sywFQ
         cC4bCV9WlKrvxx+kJp1j2J2yuwvC1Z1nA1plw5kTHNh+8zu3NLiCHqf1XVXubs2qr0xD
         6m/6cLaZ0Lc0cliIGAccJuGKUw3oi53sgFlVbwY+fPlmooqbhBECT/dJSMOIRJ2nZu9m
         9GfUtW/ayQN6unjbhPyd3pCcuKA5ztGqrINV6p3o++Zhzaxa6Ccny/Ls4GKU/Ii341D7
         3NXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IfIGvRzWUuZkeqWvTHrNCK4VPqSAVeYqhL4GS7p5Of505V1XvJ5DObhRjCbaJ72yNnnasOMMbndl9MP4@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqfU6fcRjrG9G2A8M76hOMHhRmmp3cjGIIg6/nzDk52QWAoKe
	kuG+3XtXl5SPQEhG/RXQUBJ6z8RlJG5EbvsBS0mZdrvlEYJaAeuckNSh7KJcxNdSei6Nk8lY9mC
	MYo/0CBdtB1YtV5EOcbVCiKRRc3tDuq6RjlH3i1Ct
X-Gm-Gg: ATEYQzz/r6lziIXe7JUlhelPu5gUdqqWd1ZKn5UCFoH4ck+qyJCgzg7cfoX6OzsJkf8
	n24S+ZH4kVMsds0XzfxiBxhFaltyuA0uz8lpQBCtVJjXrI0PcozKh5B2GBhzpkJEIgtEJ6Bw2ti
	uxCGVDVSK0ZU1XYGIzWpjxZQnKTnqHl8X7r3gIFcspO+NyQrMUQ/D1amkW+52a92ojuWqxDG4SB
	rgaulTdeZTIF5pHV1tvNsHUyTpSCUvdbJkFnpvJ6nT4vsSAUbFx9SgkysMzoVZ6wUpeLnGUN5Zi
	RrkMvgfxz0ew+Y+jvAE2q5zIQZiGcrsGY8p/pPRe7y3p9yJrItwJnbueMTtZQUN3nhuhkA==
X-Received: by 2002:a05:651c:4356:10b0:38a:2db9:eb72 with SMTP id
 38308e7fff4ca-38a8864c94amr30667511fa.16.1773644766146; Mon, 16 Mar 2026
 00:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313150928.2637368-1-sashal@kernel.org> <20260314111822.63a2ba4a@kernel.org>
In-Reply-To: <20260314111822.63a2ba4a@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Mar 2026 08:05:53 +0100
X-Gm-Features: AaiRm53tuutFjpddzDm8MgJQk_X6I9zzb6Uz-8-_BFX3BICSXZm9HxgKcE0xoPQ
Message-ID: <CACT4Y+arWePyxnV3hWk5RanWZpoc7=ALQ6DV_2MCuQkNoTtJUw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
To: Jakub Kicinski <kuba@kernel.org>, syzkaller <syzkaller@googlegroups.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org, tools@kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, 
	Jake Edge <jake@lwn.net>, David Laight <david.laight.linux@gmail.com>, 
	Askar Safin <safinaskar@zohomail.com>, Gabriele Paoloni <gpaoloni@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Mar 2026 at 19:18, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
> > This enables static analysis tools to verify userspace API usage at compile
> > time, test generation based on formal specifications, consistent error handling
> > validation, automated documentation generation, and formal verification of
> > kernel interfaces.
>
> Could you give some examples? We have machine readable descriptions for
> Netlink interfaces, we approached syzbot folks and they did not really
> seem to care for those.

I think our reasoning wrt syzkaller was that not all interfaces in all
relevant kernels are described with netlink yml descriptions, so we
need to continue using the extraction of interfaces from the source
code. And if we have that code, then using yml as an additional data
source only adds code/complexity. Additionally, we may extract some
extra constraints/info from code that are not present in yml.

Realistically system call descriptions may have the same problem for
us at this point, since we extract lots of info from the source code
already:
https://raw.githubusercontent.com/google/syzkaller/refs/heads/master/sys/linux/auto.txt
(and LLMs obviously can allow us to extract more)
