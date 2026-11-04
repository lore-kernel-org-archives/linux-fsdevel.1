Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793764957;
	b=rAoGacYTochPaemho4m+9v+R3E9/kuLZQ2SWvzmop1PyP51VIdBs2Jf+3O1isnXMm+F+
	 eReG4AyxTyytokZt15QA3cK2TXsyv3AthsnJBS4YAkZcZPHc18KTaCHUSFoqlZmE2UF2K
	 Se9rgA8kI7jUH/Q3Ihg4sYaOMNaybhiZvpSweW3L9aOqZMGM+eIsM8/YE7O8sZIim5iAY
	 XHWvR5kYTcVx9Bki+rAm0h5dh6ysyVO4tnNSiDarqRkt7y+L/fZfTfPXIKwPRZwqllO2+
	 MBfY0dPvnCRwopvDkBwrNP60ycHnVY2bqQMTjLC1IMwvUCBhtxYQAmcmGMFOrJgHBgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hfsn3svuSn2UYUgGkIHtdaxh7qZRWlSurHoCxB6ikgI=;
	b=phj5K1ol3Cl04p52mJNe8tMtEbIk3624zbQ4BskD7gMkI7S1Sc1j5fXrP53Z006A1lWs
	 R/sTImpDmbiKNM1c0uTSy0Df1F2mnhUgbU28q+rG8wtSEzqaS5xJ/qh+aVSL85tBYbCXr
	 WhCBvd4KvgHXK0kLC+xSzN8kXXv9gl7d88AHI8y4Rm9q/lsohY60b4HAzK9Tb8fe+iRR0
	 MSJQVy8OEeEoi34BV8F74DwrC/bJiRjFvSg6LPr9ClDmTGGwdJgRem+nkcJX6FPjTwGw5
	 Jcfk4j441xh0FVqsIejz5SHsm3ySIzbI6HNBWcPD2Nik8P+/K8cfeiZqD5zr0Vxl94A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947B606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 04:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E947B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso1656419e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 20:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793764945; cv=none;
        d=google.com; s=arc-20260327;
        b=WWTnyqfIKdnuKh5YvpIwk1ck0oE3un4v0tAVrLvxBbEVnW7wJwCuJZddjx6i57s0Zk
         UuFth9LH2fyUG0/ogq8hTZ2oCd5qqDjANtzuVSHVT/pMb33T8+k30WAf6/g5iUJw7Da7
         2Zb2A9gs+AOQm0b5YmsHmHAeUo877l2e9kZfw6k7SAdPwGa8uKDpMkwCV68k+JiSYzPg
         rN41hM4tqc6Bc4rWAZ/2e32oA6cssk9BK2UxOGpk/o8t6FEdNaPFJwit615EI4zs7g/I
         doEH6Pt4hdrqE9JJoI1rBnYspAKE+4jvPFcXvxUAgdYD59dpiEeV1t1ck2PPC1FjAX0q
         LNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfsn3svuSn2UYUgGkIHtdaxh7qZRWlSurHoCxB6ikgI=;
        fh=ep1XPRQEshE+G3QQ384H/zBAI5o31fWQjI0pOXb8z4s=;
        b=EX7oY8oBTQr/F1xRjAq+YuHkH6p9XGILVwSmc73kpxoaDxl8lcrTqf4zgZesmlZ3hD
         uzUMfTzqbb6g9Uu/TsX/j2gc6y/TtY+OjfVRy7kOy6V9uzgYRNmB/Cn+FR0Tihna65bC
         OXls474sKw3oe/2naQkMLnKttzA4cKowpLOVIBM7xdTCp+rNHHbPjkLC5cN8PGzZFgzT
         71zF4nRKAnDXNggAC5EOQkbFBWCfDJJIgUNaB6IMdGmFR4+F7pIoWhXRZ1WYQ7uk3ah7
         5J2z1fvSN78lRrQTXqygMxiGSg933AA6BNy2gAx7sLWOmOAiTlM5Pxr4iZoSXaR4MJS3
         8+wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793764945; x=1794369745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hfsn3svuSn2UYUgGkIHtdaxh7qZRWlSurHoCxB6ikgI=;
        b=H+fmLhXrrkvfDZlWGVHCS/Xgt2ts+HiINeDRjYU1tILKj4uC4FJWvAcHvWxaMOjN23
         D5Gp20WTldXu0tgiNi3OmQ01yoQ/iHN/u95HiOGxM/0mhlJ9XmSDGdMaANAeZER/z8hl
         lGSVn+So/FYWt475DaUOq1ZKlWEURGFfAgN+HKviE9prJCdcEDqocgPIPtR982x1NkmE
         4biZpz1IXWJI32RBxS1TqyQYdpD96O7zfx4wr1NGpzTgyzmNlbr47MLimxivOdoGFygG
         SIL+6Hft1ckhBa7AjBoL1PHXT6Y3VsgLZZYDHnVZ1bRt0zHa6frtr4PHhKHEnJwpV01C
         dMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764945; x=1794369745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfsn3svuSn2UYUgGkIHtdaxh7qZRWlSurHoCxB6ikgI=;
        b=zLh4+u77uY2s4K69woOH1D4fyDoCRAbdyCOFvlS6uucx73mQFHCQqKBs7USk4vN2un
         rSvMMRklKbmSlKKhtkGs5TdhzS9LLSVybu8Zacm9F+OH1jDImKPlo5MjdAow1SJ/Pqla
         Tf0x8hQ5j6L9BGTFdI1n9PyvetGO6UncG9UYfYZt02h1GsNFJzX/Yan0yRPh84cEa+HT
         kplurQQoC9VtvWaMEc9x7S5M/bob4HOIcHoztDOQ6mBdHqMimeQfBQDNO53F/duvvkl8
         ef4WbdPBgiStng+418HccLGD6s1laUZ+Xpss0DWreJif39nhUG+elgVZEq+JmbOry4ln
         gt5Q==
X-Gm-Message-State: APuU4Z/Q4n6LfjZ6ESIAdox2bjuSxd3RD87WiFx0B94UyILc9eJwXxRB
	DgJXIpJdXPwHKuBO2plGDppM/0Rpi27zZeg4b27TWEKyxD0uKFhBf+Jt98XTYH/UPU78gy3Einp
	nczIb2X7AvOvGoEHkxW57EVXJZK8Bu2Hn1Ei8uuAGFrGzAYgZAxfY2A==
X-Gm-Gg: AYBFou33xmw5zNe8SsPiZeys1C18EU0L+IAwoL7aZF1G1qZWpJTRALg8wOkNhCAlhbV
	GloBF/hVa42nSdTEQBBYU61ABTBBPXH2uU9wlSVEwOK5hHaU9BP48JEyQy8MPACX/5NRz0rktxe
	YEP0VprlpCR4eVOmCzdhdOQ50/zHhBcCkj3THM6Hf2BK+lkcOxojD+QAfxWp9KFSTaRLrnwbI/Q
	xvDJT1uE0T93HbNgc2xTJRKjxEemFB8WgrN2Ikd6MZHFg89NuIPtpu/+ZQ/FYROygTK5w+DIxBf
	SmJr7H9w7/Rfn3K+/pmRTzV/kBWrmF58tZibSKkBwufZ/swC1+ncxzi1A58pgGuRZZsd0ubpwju
	yKniUpm5yJ1fVCWkiRfYqoZ+HBpNf3OpnYA==
X-Received: by 2002:a05:6512:3599:b0:5bf:d226:a231 with SMTP id
 2adb3069b0e04-5bfd226a2bdmr3558911e87.18.1793764944982; Tue, 03 Nov 2026
 20:02:24 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALCETrWDJKr=LMzfPjwwRRuKapFKQ_OaYF6qYz-9Cs91xAXUgA@mail.gmail.com>
 <87se1hclmb.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87se1hclmb.fsf@email.froward.int.ebiederm.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 3 Nov 2026 20:02:12 -0800
X-Gm-Features: AclHuK8Rq1ure5jrSqU1h7Ma_hUjTZc0HgFdGOQhHoCimQVJ-46MEYCIww-2oPs
Message-ID: <CALCETrXnZVq4pcmo=2T2S=yzWuj9Q5tvrpuZTXzU4ptHCDnjBA@mail.gmail.com>
Subject: Re: Accidental mountns/tmpfs API break from 2016?
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:37=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:
>
> Andy Lutomirski <luto@amacapital.net> writes:
>
> > Hi-
> >
> > I (well, an LLM following my rather explicit instructions) just wrote
> > a little tool to make a tmpfs as an unprivileged user: it unshares
> > userns and mountns, makes a tmpfs, fchdirs to it, and prints
> > /proc/PID/cwd to stdout.  Full source below.
> >
> > I was a bit surprised that trying to create anything in the tmpfs did
> > not work without a uid_map and gid_map.  It looks like it came from:
> >
> > commit 036d523641c66bef713042894a17f4335f199e49
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Fri Jul 1 12:52:06 2016 -0500
> >
> >     vfs: Don't create inodes with a uid or gid unknown to the vfs
> >
> >     It is expected that filesystems can not represent uids and gids fro=
m
> >     outside of their user namespace.  Keep things simple by not even
> >     trying to create filesystem nodes with non-sense uids and gids.
> >
> >     Acked-by: Seth Forshee <seth.forshee@canonical.com>
> >     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> >
> > Now my tool won't actually run on a pre-2016 kernel due to use of
> > fsopen, and I'm not about to say that a decade-old commit broke my ABI
> > and needs to be reverted.  But I am rather curious whether this rule
> > actually makes sense.
>
> I am pretty certain it was deliberate at the time.
>
> > I'm not creating an idmapped mount, and I'm
> > using tmpfs, which could not care less about the mapping as far as I
> > know.
> >
> > Would it make sense to only enforce this for filesystems that care?
>
> Interesting question.  You are in a user namespace.  You are
> running as a user that does not exist in your user namespace.
> You want to create files.
>
> You can map a that single uid and gid without privileges.
> So there is no hardship in getting a uid and gid in your user namespace.
>
> Is it just the extra bit of code to perform that write that is the
> problem?
>
> Why would you want to be able to create files as a owned by a user
> from another user namespace?  Even if you created them reading them
> would show an 0xfffe the invalid uid/gid.  I think there are then
> some difficulties in using those files as well.
>
> Why would you want to do much of anything as without having a
> properly setup uid or gid?

Hah, you haven't quite figured out the ridiculous thing I'm doing. :)
What I want is a temporary tmpfs that I can create as an unprivileged
user.  Linux doesn't let me do that directly, so I'm kludging it.
Shell transcript, edited for clarity:

#### Make a tmpfs, keeping the tool running to keep it alive
$ ./temp_shm &
[1] 34157
/proc/34157/cwd

#### cd to the tmpfs, which references it and keeps it alive
$ cd /proc/34157/cwd

#### Kill the tool, since we're done with it
$ fg
bin/lktool temp_shm     (wd: /workspaces/master)
^C

#### cwd is a working tmpfs!
$ echo "Look a tmpfs!" >some_file

#### and it has no '..', as expected :)
$ cd ..                  # and it has
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory

This whole workflow runs in the init userns and the init mountns,
which is exactly what I wanted.  And now I have a tmpfs that I can use
to run my test suite unprivileged to test some cool code that *needs*
a tmpfs.  (Yes, I could probably use /dev/shm, but that's messy and I
don't want to.)

I'm not actually banging this out in shell, but I am running literally
the C++ code I posted as a subprocess called by my test harness.

The user creating files is not in the mountns or the userns, by design.

>
> At a quick look tmpfs just uses vfs inodes which use kuid_t and kgid_t
> so it theoretically would be ok.
>
> Still what would be the motivation for supporting something so silly?
>

My test suite! :)

> If there is a good use case I could see it making sense to support it.

I think my use case is excellent.

Seriously, though, I think a *much* nicer solution would be to allow
fsconfig and fsmount to be called by an unprivileged user, at least
for some very limited list of filesystems.

>
> Short of a good use case we are talking about having to support weird
> corner cases that no one really cares about that will just bit-rot.
>
> Note.  You can identity map your original uid and gid, instead of
> mapping your uid and gid 0.

Does the inner uid made a sound if there's no running task to observe it? :=
)

--Andy
