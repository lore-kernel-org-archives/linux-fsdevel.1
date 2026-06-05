Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD373264D7
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670403; cv=pass; b=J2grGbHB2AqZp9t7F6r5pD5ougxdjcEm7mUrNlsTI5ScHUtHBgFc1rqZM8yFt/sh/XqIgre2a8m2bVsObOb+nwFQjclqO0PqhcKoP8vQTkuXOHGxdLrhWuWBVFnoaikYsJ40iNJvdJ2V4wXqYCyh8/9ZxMA52QnbHtv/4yS7U4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670403; c=relaxed/simple;
	bh=NOQZeUgc07KS/OvgX6TK90IWE1VfXavRads+HOY4Du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAr28IbSDHw4/19yp/AUIw4xzLi/IE9/Bq0CLQ06ppIGUvP6Q5VZAVrLd4mwF4CHIHPmAqgu9M65oUP5AwqijY2/i97OD3YtoGM+PAivCcT3zifzNJAZqgfV+h4a4FjEZVt1ydh7QtKupWtEIBdDArDOtwiBIIy/nZKvy0fzhSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Be9mkyhk; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Be9mkyhk"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so12172a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 07:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670401; cv=none;
        d=google.com; s=arc-20240605;
        b=OR+1/j371JtK2L8TqNK/WAyPmo7NzD7e19/TN254m5npWQtGvF5V3121nv/mT9EPcI
         ZsUCUFfAQx5XXf0VYRPeu+lmyYMOtnbBPKc89nB4FY4627WsVHRZI0IizaOcKAm53IR6
         qFPzkjTr+7X/NZMmWP9UAga2eOh/kQRVmkW1bMReJ5pCLbOBHUxFCvgkjAix2gVyoFS7
         dafslrw9QuXBys0axdGapjJVfPRawchQq6uj75dXGVbznUW3ALs5xm5lp7atdsfD31A+
         EPvNE4D3W/Z6Wxmkmn5KNKYohAFaO5Vxp9JfsQ4CgfzPZXq/DRZrOHszdmo5llxY5kV4
         RJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=as1py6QfVQjWXq/H/j8qlkW+Qk+QDS/0K5XkzZmjy6M=;
        fh=xfCYUdngU/wyZOdGO7Ujuw+KmzF9AWBanBvepQsoBmU=;
        b=E40XAbTFZdou2ooR3250PzSnaZhk7aa3Qsi7Zt0t5+fTEHhzXTLKAqm+3qu2PF16w8
         3Ho9qdLyOrRtodL+LvQVjQhWqd8Ke4+tS6arcQNMoCgWkIVX5vtljKykvKuOVgXMHgJf
         J/9LZEk+Ggs2WlssUdLKtb5drOkLQ7e1LPUvvwa0g5xDkWBVjeFGw2ECDSmJGtNrDzuc
         /XmlXhGxX4dmvbghB+iLULFBf4flqgp/OmMfWar0HRyWzJJE7i+P8t1PhQHk72xSMUr4
         hk0xNAjXYSsDy73z5XuTnv0rp3fNOAgoCZIOVJHkCh2XxHiCa9FhW5jXG3Id7qxWnal2
         fYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780670401; x=1781275201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as1py6QfVQjWXq/H/j8qlkW+Qk+QDS/0K5XkzZmjy6M=;
        b=Be9mkyhkMVD309c+/wHXBrEtGxXhvdbtwfJe/nxjdkovw99MZwmqPux/Z1IFKkvpFf
         6gxN2EMXD05lcaV6oVNQfivjFi/sJeSIsE+QFuk7gH9h90qqRcdbXExWw2CDyy61ncHw
         HG6cadsbpx9jAWtEghV+AzYktVMELUZczMzHRQIB423v9yujZ0tRkcCTYMuBK9pLHNvs
         hluB+a+DczRfGjj2R7tIRuZUwzjYiAJMUUl2SUtCTvFk46z7HeEbcJEEBYSD+Guf4Lg9
         +LpykZqJlCCORzjao4v7vl8M+5cK8PrHlffVYU5y9fluFnqyXscFFYkzZn5PH8GqiDFC
         ic3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670401; x=1781275201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=as1py6QfVQjWXq/H/j8qlkW+Qk+QDS/0K5XkzZmjy6M=;
        b=kr4VJyeqKL4TrAg5xoDtUuW+jwloD+ZNZ9+NvXrnfFVF4EPX7OKjXUYLAOHgL2p+5/
         luY6Ubxp2/ylDqPjn39zetUS3REST/fC/YRnrX8TizLMuB7y2dABbVtmS8x0KgavJ5h6
         LetG5wI/o2/N1lbz9SbaXPus1kI22ckNEi2KDsbyEHh2SUWNndZxjcvXye2wEI13sbGT
         eTVazyswxe8joURBOpO1sPpcBRETkfu9h2cjUgRlXhXEAj5ojmVqp2fHRAfhSplGDXPE
         bC/0ItqiVjLzStFFSd4z62mZXPxdoLpPzlPkhcugk5raAa3SsZRG7wN1qxKHgxUq4MiY
         cylw==
X-Forwarded-Encrypted: i=1; AFNElJ+SlFjYdRS7N/RrRPmJvEgZb9Pjjkbjyj9yXlA31u+1cjrZDwmpymzWyCCBlTl/QtPLYTNOTk8AwFxWh7bH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1XTM4oM5VTdMuNafIie9ugujY9fC9V5HN1+rQRo4p3NiADHo
	T4GVKtkRs/ZZeMvys+8KphhT5gZHD51V31k7Ooj7Dz2K++qP38H7Ra8pv8wYrWxBvyyiM33oVym
	Pq0nfRLZZBP5FVDCFPWMKw+DPlu4qZBZKymYNkksp
X-Gm-Gg: Acq92OHrLGXwDYoxlt2ZOhYHElJXqVaWeJ2sCKs41Akemor0gxVBVF8R5IYbCvLs4lD
	vAf6gMJbEh3A9+lhT60MAibRADiPTCXEGrDwBsqNNMLkAVLFKuCzGiMLcGWropOhOLJ7+Qk8buS
	KoS5jiQwo8mi2u4VOTi48m02aEL3Rx33bqeFCnTTIRMGlz9vgNJuKOnh1fOy5Ce5xi7gAMPkWzI
	ttKesYzBUUmQBJbZYxsBebv+QC0eZlCjEz09viBI9/XHye0gmalTYdPqbzfjQofKLwvwJPUMZk/
	OovaijXxTxMrTDt/gF1MdQjjn08tDPcUmpNAbirrSEtl/SA5
X-Received: by 2002:a05:6402:52db:10b0:683:33ae:8689 with SMTP id
 4fb4d7f45d1cf-68fe8b4cf79mr38019a12.4.1780670400617; Fri, 05 Jun 2026
 07:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com> <05811fd9-6a33-48d9-a970-281003466c80@sirena.org.uk>
In-Reply-To: <05811fd9-6a33-48d9-a970-281003466c80@sirena.org.uk>
From: Jann Horn <jannh@google.com>
Date: Fri, 5 Jun 2026 16:39:23 +0200
X-Gm-Features: AVVi8Cf2g5iNAdBBEcbfvUYBHLR4xpYK8oqIRwmCptFF6s_EQcEFjFFXqKVPwDc
Message-ID: <CAG48ez0V5bgEWgZkYaM2z5qfr0w6PXg6YDU8NS19=ZU6XLxTBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 4:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Mon, May 18, 2026 at 06:35:15PM +0200, Jann Horn wrote:
> > Fix the easy cases where procfs currently calls ptrace_may_access() wit=
hout
> > exec_update_lock protection, where the fix is to simply add the extra l=
ock
> > or use mm_access():
>
> >  - do_task_stat(): grab exec_update_lock
> >  - proc_pid_wchan(): grab exec_update_lock
> >  - proc_map_files_lookup(): use mm_access() instead of get_task_mm()
> >  - proc_map_files_readdir(): use mm_access() instead of get_task_mm()
> >  - proc_ns_get_link(): grab exec_update_lock
> >  - proc_ns_readlink(): grab exec_update_lock
>
> It seems that this patch is triggering a failure in the proc selftests
> read test:
>
> # selftests: proc: read
> [  259.127414] ICMPv6: process `read' is using deprecated sysctl (syscall=
) net.ipv6.neigh.default.base_reachable_time - use net.ipv6.neigh.default.b=
ase_reachable_time_ms instead
> [  259.158773] /proc/cgroups lists only v1 controllers, use cgroup.contro=
llers of root cgroup for v2 info
> [  259.177155] sysrq: HELP : loglevel(0-9) reboot(b) crash(c) terminate-a=
ll-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) s=
ak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-ta=
sks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) sh=
ow-task-states(t) unmount(u) force-fb(v) show-blocked-tasks(w) replay-kerne=
l-logs(R)
> # read: proc.h:49: xreaddir: Assertion `de || errno =3D=3D 0' failed.
> # Aborted
> not ok 19 selftests: proc: read # exit=3D134

Thanks for the report!

Yup, https://lore.kernel.org/oe-lkp/202606021924.b6d8a0c2-lkp@intel.com
reported this too, it should be fixed with
https://lore.kernel.org/all/20260604155806.1402880-1-jannh@google.com/
, which has been squashed into the current version of the VFS tree.
