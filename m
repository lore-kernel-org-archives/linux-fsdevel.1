Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715E3FA5DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805037; cv=pass; b=BvWFZOLR5UFXSYN+CGMDIAUYEpCAkgdKem7IgOUg7NOJSg/eMvdXt6w6RS7RUmNzQ3efeAL+/qKCsvpjHQ0O0stBeaTqdjNs0Q8lFK52vItr8abtYZdHXZBdr+YVvGCXywUgNFrRKQaX4IBoK2PNksbe/ULRx3jmKzRBqx6tvRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805037; c=relaxed/simple;
	bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9FA7DdzNVXkKNas/EUzdJWipaqJ0mjOAamq2KeEHRrCtTdEtZXXJm9KrFNraqgpn0MDDPkyl4LdlbKaE943D2MrDvlrgMdEHKhs9sjnCCoip2hCw2vHxz8RL105VLqCthDoLPut4/FzOpd7xnIxRN7/8d0Kvya1vS57sjSP7TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEVLVDeV; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEVLVDeV"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso238a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 07:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805034; cv=none;
        d=google.com; s=arc-20240605;
        b=ZjdBxyd46kyKzZNWxKG+njVQjFMip2Rubx9f+sVt6/vmOb5y98ipOIb7vGbgt5p3uH
         BkA7jb+Qh2YxAf+4ftcr8Mgg4p4eaPtSYgyDBBtNFlgjRZYEMsHdiBIdkU7lUbUROB+K
         MgverT1l5bbUC3Wvp60yY6IBixaivWCJYySFnJwudgSZwtYmS6ktHHRjqhqBbJZ4ZBFL
         qQAnQ04oFCrftL/i5kfroozMeF59uP5rHUaKoxOza4K1Iy2kpAFdtql/tS5RzVtqKbh9
         hAhg5wWzh2QuHw4lry3dFQ4MmYJ2nZy6LvvNhuJW/K3SJN4bcxnlSbKSwolYRl1IwsjP
         3DAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
        fh=htshO5iBXrWg7lCncC8z3QqtkUg89OZKtTij6yIfacA=;
        b=EfBVxEuHDVda59NoMRKwWj1KKEzaOkkG/Jb4Jl3LoT+356AMN2qY+/apUVn0uB4WzT
         aPLUCwcgjQt92/6qrpR1azCCBaZg/7flXM4bF/nKb8eJwHPn+ykSg3qeac5Fds17GIlI
         ZnwLIuw/5x7yL0k1I5I4hqxsbaCU89FzE4NoC/+4Sn1TGFYVa0Th3aHHsRbvWDVAwWvt
         av5Rq5CJt9vqxcRxLbnMGsSK9zXgyQPin2U73nGLfwdmhLbNM3jX9NZrA0SgjQMXMO07
         kG+ZPaaXMfTpPFk7ny/gpfKcAjzHWwSNhqpMEAl61UdrJfh/Qu+OhzldJb7npjkDJ/hw
         /7vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779805034; x=1780409834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
        b=NEVLVDeVmB09ZakIXQABBnMAOAN5zcI00dCeG45Q5SFKpOD117RIfBjbDYx2nZl+Nk
         M7LpvEw9vJI1Jc+88k2YAGAl8opEFblXRhSSQMcDNVRrOqCiezvSjg2aSnBwgxDBsjZm
         VF2cMj6knMRkMHcPzm1/2HImHkVNIilk/vF90V3Kh6Gua5xHwViP7RpYewlPxSy5MKGA
         RQ43+0aypv4soaRe7ovAl+xQO1zGLSAamQk7+WUAQf609Hp1vhiu+2rowtoeElWypPVT
         ljQPhBvlP8phs/jSg8gUi79aUU/+ONg9+HnDOkOFoP6MkSokufkDv1LGx8F/Q3HlQd3o
         zDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805034; x=1780409834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
        b=qeP2FzbqpdOW1tsK8yEmTf8E+AkSU0oLlc+m25EigY/tTB8r0k0JBvNkRA/3xKUjdT
         +diLKswWmxrhPI3TKAUTsEIriTOIFsA3kgGJ9op84tmXb4yGrCKSx5yr8byZuZIqD9lP
         O8KM6KMOR5kkz8wyxdPfRhY4QWBoqm5yqNc6A6Bg0ck3HQaT8DpUJIK4KjfXt2uvQ8kp
         ieIIHvgWcl/0IJ8mtOCazcF4NPFwletElp9su1T00GEZv3YAdBvDmRZtU4jKll25f/UH
         Pxbh/wmouUTPH3YntFHIsWPzRuzikY0d3LcNs9/XKuYqJ/YrSBPvlxIU7v/m8ST0E2FB
         bufQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LNdBM3R9F6gizNpmx15nBhFbaIPcETtePDw8VasEDwmdFdMT+pvzjdwkqH4vwj1/+3OKOGEAsn66QvuJS@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4E7tyTXw0yLpw1e/JAyWApOTLi6VaNgRmZVHOZxFEU/BVgZe
	oJmI2J+WlDQ4wCl3sAXkTZdgVLylJGsYD9wJS5MKW/NtajrkWpky5ybE4NkmfClS5BeKIFQBnX0
	rlzVaOkReyFJND9YCQM1yW2W39fVScKceibNEisSH
X-Gm-Gg: Acq92OGOFQweGA9eEYLdIEI9hmXEiqkT8xrXTYIsZHWcCoyUV7J60F33OFu37oirCiA
	qoGC7u6v/C5stnW5bWF+ncbgFAvzNXH618wAHDaHAJYfElP0ClLeaNeNH1CMi4lqnfp4TAK2CbQ
	TlNkB3iGDoMXM2D06UEKAM+dSBdoi9C0t9SvqgsUhAV0TvIKUC889Klx/jyzBHZ4+GgHFfpJajq
	jlh4ETppukeUVuxYsXvphJmuAFgwzkUNtytUPeX4coMja25wlU4FBe5dVNApfpvZxH1tC4megRS
	eJ4o7dgW5982Pv7UhWqd9cZu5oEaMis1ynAtojh1Sm0=
X-Received: by 2002:a05:6402:a218:10b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-688fd0d59f2mr99577a12.2.1779805034137; Tue, 26 May 2026
 07:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com> <ahVeT9TTxlJiW2Qu@redhat.com>
In-Reply-To: <ahVeT9TTxlJiW2Qu@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 16:16:37 +0200
X-Gm-Features: AVHnY4K4DHuWauxa8YYdJ76QkCUHkIbYxi3sUWupwZ45vX9yRo8ZoO63RX-49Zk
Message-ID: <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> On 05/18, Jann Horn wrote:
> >
> > Fix the easy cases where procfs currently calls ptrace_may_access() wit=
hout
> > exec_update_lock protection, where the fix is to simply add the extra l=
ock
> > or use mm_access():
>
> I thought about this too, but I do not know if it is fine performance wis=
e...
>
> And what about proc_coredump_filter_write() which doesn't use ptrace_may_=
access() ?

Yeah, this series doesn't fix everything, but I figured it would be
better to at least start fixing some of this stuff rather than leaving
this code as-is...
