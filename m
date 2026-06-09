Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C33AC0C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008432; cv=none; b=Ba9R8gkGrWjyDGWUu2y2On30TJac25QiMytkRBWRhJB9Act2UAea6ZLe0VmOKTZHd61j5XDjpRsAArtBOErEaJcCP24EToXZNyRI3TTCmjACOy0cH1pidaY5raXWe0EFqR/RIBJ3bre8EqOGqRkaELddhYG+LaXUhbzium21jAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008432; c=relaxed/simple;
	bh=uItYMkbGwUMGus1uTlQfEdNxfjafDF8SG6tMDHg6mFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmwvhUeyCmN8t8Yuh5KZpEf3kCd8/6+sDFRsd7PZAqGjdf7kGqRc92F41gp1rKyhdLb4bEFaMwTk1bqliEsiQobe7g24PlOngWjLCOTW0r7i7Tn64OcXTnW7OKT4cCAXDbqLT+VsUvT4UMyn7126CeAiFKIXSYCh2QRqJ/fw5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=jRFfLNBa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="jRFfLNBa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so45433715e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781008430; x=1781613230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAFliuNuGBag3YIZHCuBnS4rEUt7FD0JImbIGYU3nTM=;
        b=jRFfLNBa42IaMqJxZ3vqahnieNKgT9uSfU6fCMfA+5cxOgkbQ+biXjA5Bj3WK9wdUv
         IcVizpKwI8Uuw2pTxy6zP4wIgJgtwN6Tv53ZkS9F1bpKf5Dezq2jLp93+Cec66lQASOv
         TnvHdhfbUeLcEhoG/rzdfv+rubVDgTK3nTtetXPtg4soWZdgHdmaMv/1dm6rpPCApQWO
         4GWTEAx/kUAbkes0jAqvx18fwZP+mzm/BAiI5t8vBljtRQUjQuqvseKbvlGRdWQcCZgo
         RZoSDp5FvM8AvL7Yr5ZWSdu9NdvO5A1SB6kfmLv68xRLCpSg0dw0wFKHqpzBhZt65VoT
         7ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008430; x=1781613230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAFliuNuGBag3YIZHCuBnS4rEUt7FD0JImbIGYU3nTM=;
        b=C1m/Dm8UkoSac9graGbdKMd3QdJoOkOHcbDXJqz6Z77mNFgXJnHQbw75Jrr4ZsEqk8
         +x+kAeymzA7Qz9RGEO7njb6j3z7xBpa9AGKNIQ8Dv0jIEfMu2DdRwp2Ux9AQSj6xmSRq
         96U2/b1YlTDHR1mIvRTCCKHdo4ZBzq6WElubiBUaoyy1Sqwple8/sIsPkZiGrKzVLD71
         KwJSt3Pk6RMq9joKnrXCuuP7AqiKhXS8ZQTBK5juI4q35kkGn2ePY9IczeaMb1puRcdf
         h20wgJ2ZmvDKLG0oeQOHZqqyxcuz7RS/Er/dsQNmlJ9UMnxVjBmKC1loy4jl4uf3RQe5
         nOFA==
X-Forwarded-Encrypted: i=1; AFNElJ9XT02+8h37Zw8imoUTojyRC3mKuCOjp6G03sVoLdXLNjcZDuWgZ6hNjtt2lC2oh/SH1hMl+HSTZip88Yg9@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCuSVgVQ/PUJZlsrV0G9dglA82EUlEhuwIO6RnzaD+LUnsLPk
	z9q40ZnCrajYOwwEleO1xsxYHiFd/z6PpiJYyQeT0vn5a0jYl7Tvk8My+EzzhvuE4nM=
X-Gm-Gg: Acq92OHeqcUEDm2/ZQhR+AuGxQbq3peJvT6NerTnG+JcVHqQajv8w6DI6W56L6WZCqo
	HylDJrcgoq1i/u7gF0wXLjRDPMP/0u9dDgf5zIahm0l3+/L8U9CQ/RzIGZCpStYd+j2dZf53zml
	UPp24MwR4a8o6aUqGE6GFeTpGDYDJgDpS6wp5SIN2xkd0jyFrgKiBeEB0rTf9+s8Izg7mukDNux
	xCpWIpQmhtvf9TpY6yoFA8prpvnt+KAwgRfRGKWCH4VYW2An1h/WY+iPBAmixx11M1xoOm0b6u+
	/BogTh2FwGbmcCr1PmeM9hfE1vXI15Hw8MhXTcmWzIkzBw1lnZrp2RGXIbbL9fuXWZxFVITDEUR
	V24NSYzcYPGoIdQXtusJ6z54H5ofccVBxJUr44jlOsPbjTWsNu3CJ3JrvUX48IODi3PmaKPKtBM
	QYInIqtm8pwpSIqSYJW9eTY+lzVSo+ZdZd9mBaVvH1Px+La9q/K47CzS5ttd/8utvZK3GqyV0nv
	wOjVA==
X-Received: by 2002:a05:600c:4fd1:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490d723a47bmr33072455e9.32.1781008429729;
        Tue, 09 Jun 2026 05:33:49 -0700 (PDT)
Received: from localhost ([46.101.197.76])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2e4b18sm48530516f8f.10.2026.06.09.05.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:33:49 -0700 (PDT)
From: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	wooridge <1063373698@qq.com>,
	yurenwang152@gmail.com,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: add CAP_SYS_ADMIN check to panic/ctrl-alt-del sysctls
Date: Tue,  9 Jun 2026 12:33:44 +0000
Message-ID: <20260609123346.2800585-1-dominik.czarnota@trailofbits.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026-04-17-floppy-moldy-vile-squabble-JZOuCI@cyphar.com>
References: <tencent_4BACE37ED72C80152F8C6A8C585893505A05@qq.com> <2026-04-17-floppy-moldy-vile-squabble-JZOuCI@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 05:14:06AM +1000, Aleksa Sarai wrote:=0D
> More importantly, these kinds of check-permissions-at-write checks are=0D
> actually quite weak because of setuid binaries -- you can always=0D
> redirect the output of a setuid binary to a file to bypass these kinds=0D
> of checks. A very classic example is mempodipper (CVE-2012-0056) but the=
=0D
> recent "CrackArmor" bug (in particular CVE-2026-23268) is an even more=0D
> obvious example. For those reasons, if an attacker can get access to an=0D
> O_RDWR handle to a sysctl file, you're long since screwed.=0D
>=0D
> So, in my view this logic was somewhat flawed back then but makes=0D
> absolutely no sense today and should not be propagated to other sysctls=0D
> because it just gives a false sense of security.=0D
>=0D
> I also want to point out that the files you mentioned aren't even the=0D
> juiciest targets -- kernel.core_pattern gives you free root code=0D
> execution on the host if you can write to it.=0D
=0D
Hi,=0D
=0D
I was looking at this in the context of sethostname()/setdomainname(),=0D
and procfs/sysctl seems inconsistent with the syscall interface there:=0D
- the syscalls require:=0D
=0D
    ns_capable(current->nsproxy->uts_ns->user_ns, CAP_SYS_ADMIN)=0D
=0D
- /proc/sys/kernel/hostname and /proc/sys/kernel/domainname mutate the=0D
  same UTS namespace state, but only go through the generic procfs DAC=0D
  permission check.=0D
=0D
So a process can fail the syscall after dropping effective=0D
CAP_SYS_ADMIN, but still change the same value through sysctl if DAC=0D
allows the write.=0D
=0D
Is the "false sense of security" argument meant to apply to this direct=0D
API consistency issue as well? The already-open-fd delegation case is a=0D
valid concern, but it seems to show that write-time checks are=0D
incomplete, not that the direct write path should be weaker than the=0D
syscall path.=0D
=0D
To summarize the current situation: no fd delegation or privileged helper
is needed. A task that passes procfs DAC can mutate UTS state
(hostname/domainname) directly after dropping CAP_SYS_ADMIN, while the
syscall path rejects the same operation.
=0D
If the already-open fd case is the concern, then the check should happen=0D
when the file is opened for write, or should use file->f_cred so the=0D
write is authorized against the opener's credentials. The kernel already=0D
has examples in this direction: /proc/kcore rejects open without=0D
CAP_SYS_RAWIO, /proc/<pid>/setgroups rejects open-for-write without=0D
CAP_SYS_ADMIN in the target user namespace, and file_ns_capable() checks=0D
the opener's credentials.=0D
=0D
If those other files require capabilities, it seems to me that
kernel.core_pattern should as well. It controls global coredump
behaviour, including pipe helpers, and a pipe helper runs through the=0D
usermodehelper path with root credentials and the default usermodehelper=0D
capability set. Direct writes to this sysctl should therefore require=0D
CAP_SYS_ADMIN rather than only procfs DAC permissions.=0D
=0D
If you agree with this, should I send a patch for hostname/domainname=0D
that makes its procfs writes (through proc_do_uts_string()) require the=0D
same ns_capable() check, together with a selftest for this case?=0D
=0D
Longer term, I think the sysctl documentation should state the policy=0D
more explicitly. If writable /proc/sys is not meant to be a security=0D
boundary, Documentation/admin-guide/sysctl/kernel.rst should say so=0D
directly, so users know that environments exposing it writable (e.g.=0D
containers) must treat it as privileged. Then individual entries should=0D
document the non-obvious details: whether writes rely only on procfs DAC,=0D
whether an additional capability or opener-credential check is done, and=0D
whether the knob can have sensitive side effects such as core_pattern's=0D
pipe helper execution. That would avoid having users infer the intended=0D
security model from kernel behaviour and scattered examples.=0D
