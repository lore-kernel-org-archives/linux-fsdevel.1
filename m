Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F89310620
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981535; cv=pass; b=ojl/r2aOpTwW3In0H63UtupdQoDLaG9SRmPkJ2ZlwIV4cR24oRgqyiK45vpxqKWj+JGwYdwMZsgFvdVZIARniwqUnLtXDKljjh98ks/uwkL444UiA0M7fzrzmYOk1gPH/LcfyJiKtQxS7/KwXl9LOfHve+qailYqmE+Q+dtcpys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981535; c=relaxed/simple;
	bh=p7rsmvv0EHAomqczcgPQ/x/wtHoT4UNLYL7IiWM9MkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jP0NERKg+ZDwgI9EnqIARja83s5YxzGsqz//8dofTCRZ9oJvbqV0PZBgrHfwSjsK1/OYQT66bqvmeDlmvBlBvE6pKsLI/y+n+z3+bP8yZvOBdrYSzC2b9k6dNvTHJ+Xr+3G55xuwVE0JYEY3ATciv+0OuKCoD6fJstDCzi1dcQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/2O1hun; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/2O1hun"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270f10a774so53982c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776981533; cv=none;
        d=google.com; s=arc-20240605;
        b=GfPRrPMsql3G5NfWOwp4r0g197LCgURQx9O89vOHO85jG6BFO6XCKJbGkNNUiDE4rW
         gip7vJBTWMmp/GJRw4YN+m0WRxHr8WIcVC/RbSkqmD2mTgfWTe62m2DznsnoSgzQRZyw
         vjDiKFXvR3FHk5lMmBmuhWCK3eVB9xFDbHrj/g7FgfLjPuBv6F7NddXKXNjhPYIiOAbr
         5uu6ZsprFqWICJNRdARV4XQ6NFqAETkFGQUiLvyxPqUdI8HIvMH7iYXhwydVyJO0Jmao
         AwN7Ug/LDmZGZmqavXA67fM6jFH4om1wjYvOVg45vHlH5LCy/0EKlsUPoBjYFB2WL9rc
         zWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbYF9ZG445gn8aa2Rfe2DrFqGQr7JCLV6XOA6mQVPOY=;
        fh=vcq492OgpchVJSMEhMonvrSQw4eqfk5y9c2YYhECqlY=;
        b=Lo8HWtfYHSNVO/ni2FOIweJqHAC/hhAARHxj69Q0WK8eRvcRVD5vdRXp/rKakTJ99E
         j1+mLnSK2gyKyvmGJS2AJ6Snxwcvi1Qws/We7u3F4WavPJFfMoQZOltCiFYIrGKdmN4e
         rgzFFVXC9QjhZKa0Q4FzCmpa8wDf4od1VidOtjvC3a6YiTIT0w/avKpDFXsGzwdFbtDR
         VjV2AMZ+nilyVhjyUCsHG2aPAMhMNZ1SlbSdvKnpzUg1QyRNGBBx97T9GYwULu1qvRpA
         EvUtUu029RdnIz/xzZZPJGT6XK/6OKAXLdI56SChPXwdMVrwavEiqRbnNIO1Ym/WKCUF
         r3/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776981533; x=1777586333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbYF9ZG445gn8aa2Rfe2DrFqGQr7JCLV6XOA6mQVPOY=;
        b=O/2O1hunJgaBbdOWgxriBZC9cZ0bVHuVJJ7N/eGq6ZCYthpFRi4MBB6eSnOKuFShV0
         cdADc/2Is3ucSocaCV23q4txAMXWKONzF1rTijdhD3faqd6RdpAcfrvRegPYQTJEDWfg
         SbIl28FDZHyGGibymCaWE9wPz0wNPhTjhLyvpyN7jTgfJSdwylRZ66tdnfsdrK1aJY/p
         MgEL8w6HDVaokKnSHWlZcNXDxKz7PdQ1EAFWGiOKt0F45mbf/nuVAQMrD8wvFLuOPwBH
         mkvGnj7T0YwCEEm9WcUlVi+EStjOGP9wDgxPHINNAkIVOw8ZaSkGyL2InaPtv6lCHUqP
         4lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776981533; x=1777586333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YbYF9ZG445gn8aa2Rfe2DrFqGQr7JCLV6XOA6mQVPOY=;
        b=kO6OpZBE0fco7ucgVstTUSu2wdrkI/602Z7C/6DQZrDai1eSoygBRNyXk4OdP/ouuH
         Kx/y98NfAmYRqAHFxhTEm2/VJ6znb4GipWh/3aj62PmiSClEFnbN/+mXQoW64ARVo5pU
         8HE9S/JmJI+BFwgnupAF7BxZY1IDiJ6ocM1SvOzDDCjL66pMyd+7MCIU6vWtICPIaUu5
         bV9WLYmnAWeLeovVDyhnVa09htuSpUvY4LVWtI+NLG66JnWya+LPoRwSAu+bA7CNEpw1
         WEgygosCY/0yBCC3i1Z/7oBmQvJq0pgDjIWI8XuHDroLDJTKoPdI9k/GjGeMzsu8z1g8
         1Zag==
X-Forwarded-Encrypted: i=1; AFNElJ/uGpKKQbovmfdgGZwkrjrxgNthYrcczs1+NsBpEns2/UFmuoE+nuEYEU9ZAXAdurMG4jlvlsgrzTZ/28C+@vger.kernel.org
X-Gm-Message-State: AOJu0YzboLyC5C829OuHKqbUqG9+kJJGeam593hW6h35DyafIZ5+QqwD
	2dPjHGK2riVlnSd01MQbvgvhMCjtsIuEbJXT1b+4X0tebl7HeKko0Cfm2t6mHm0lEiuLvVfq3f1
	T/yCeSjV0xU8XhB0dEpSXIOWKsbZIhgVl3WFlMist
X-Gm-Gg: AeBDiesz+oI2E7hfBs64EDiLxS2tdY3G9v1X/SmY2tF98V53tERV4HBcgmdtd3L1jBH
	ne222IcqLYMmRl8x1ChSyCWAwb/3/fNenLGhdHH7Jrtu+nNKkDwSr2nRMpSLu5LgmdNWpUSD/Ej
	8SeCfnXNRsN3X6g7XiGKpBN4LhTge0lL7uzYamlMO8VXa+QNBWh1vkMGfKJyjt4b5zHHaeu3Mgf
	f4JAXPC9tSR6JAk5felb+dyne64NsEx7jxsE3/kFRu4rQyJW+huLu1O+zNoBCD2fKyBGH1leQPV
	/6PECGS3fIjbvUDZgKHbb1zEEn42vmv3EJ3d5g+UWxeKx9KaGsdZ/JQN+ANJzO1YebsyKg==
X-Received: by 2002:a05:7022:4396:b0:12a:b39a:31da with SMTP id
 a92af1059eb24-12c7ab5879bmr1020973c88.16.1776981531942; Thu, 23 Apr 2026
 14:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422005608.342028-1-fmayle@google.com> <cxthb6g7tqgluwicuh7xc75i2bp27hjlrx3oreionu4duknk32@x4tmnklhvkfz>
In-Reply-To: <cxthb6g7tqgluwicuh7xc75i2bp27hjlrx3oreionu4duknk32@x4tmnklhvkfz>
From: Frederick Mayle <fmayle@google.com>
Date: Thu, 23 Apr 2026 14:58:40 -0700
X-Gm-Features: AQROBzAgJMo_Hhy1amk3Qek_Bw09oB2dffxAYeLAqOYckcRkm-f1GTxyRcN8b7c
Message-ID: <CAHCxdc47qCEpEWtmq6dbeWiz3X5CP996zFmKNUXKX07YWjefkA@mail.gmail.com>
Subject: Re: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, 
	kernel-team@android.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 6:32=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Tue, Apr 21, 2026 at 05:56:07PM -0700, Frederick Mayle wrote:
> > When a file mapping covers a strict subset of a file, an access to the
> > mapping can trigger readahead of file pages outside the mapped region.
> > Readahead is meant to prefetch pages likely to be accessed soon, but
> > these pages aren't accessible via the same means, so it fair to say we
> > don't have a good indicator they'll be accessed soon. Take an ELF file
> > for example: An access to the end of a program's read-only segment isn'=
t
> > a sign that nearby file contents will be accessed next (they are likely
> > to be mapped discontiguously, or not at all). The pressure from loading
> > these pages into the cache can evict more useful pages.
> >
> > To improve the behavior, make three changes:
> >
> > * Introduce a new readahead_control option, max_index, as a hard limit
> >   on the readahead. The existing file_ra_state->size can't be used as a
> >   limit, it is more of a hint and can be increased by various
> >   heuristics.
> > * Set readahead_control->max_index to the end of the VMA in all of the
> >   readahead paths that can be triggered from a fault on a file mapping
> >   (both "sync" and "async" readahead).
> > * Limit the read-around range start to the VMA's start.
> >
> > Note that these changes only affect readahead triggered in the context
> > of a fault, they do not affect readahead triggered by read syscalls. If
> > a user mixes the two types of accesses, the behavior is expected to be
> > the following: if a fault causes readahead and places a PG_readahead
> > marker and then a read(2) syscall hits the PG_readahead marker, the
> > resulting async readahead *will not* be limited to the VMA end.
> > Conversely, if a read(2) syscall places a PG_readahead marker and then =
a
> > fault hits the marker, the async readahead *will* be limited to the VMA
> > end.
> >
> > There is an edge case that the above motivation glosses over: A single
> > file mapping might be backed by multiple VMAs. For example, a whole fil=
e
> > could be mapped RW, then part of the mapping made RO using mprotect.
> > This patch would hurt performance of a sequential read of such a
> > mapping, the degree depending on how fragmented the VMAs are. A usage
> > pattern like that is likely rare and already suffering from sub-optimal
> > performance because, e.g., the fragmented VMAs limit the fault-around,
> > so each VMA boundary in a sequential read would cause a minor fault.
> > Still, this would make it worse. See a previous discussion of this topi=
c
> > at [1].
> >
> > Tested by mapping and reading a small subset of a large file, then usin=
g
> > the cachestat syscall to verify the number of cached pages didn't excee=
d
> > the mapping size.
> >
> > In practical scenarios, the effect depends on the specific file and
> > usage. Sometimes there is no effect at all, but, for some ELF files in
> > Android, we see ~20% fewer pages pull into the cache.
>
> Didn't Android have a gigantically modified RA window? Could this be why
> you're seeing such large effects? Or is this no longer the case?

On the device I used to test this, the relevant storage device had a readah=
ead
size of 128kb. In general, it can be configured by device OEMs, so perhaps =
some
devices in the ecosystem have giant RA windows.

Android binaries can have a lot of padding and sometimes unrelated APK sect=
ions
adjacent in the same file (see https://lwn.net/Articles/1016860/). Those ma=
y be
the source of the effect, but I haven't verified.

AppImage files have some similarities. They are an ELF files that include a
mountable filesystem. Here is a quick test I ran on Debian with the latest
neovim appimage (./cachestat is a binary that simply invokes the cachestat
syscall on a file):

    echo 3 >/proc/sys/vm/drop_caches && \
        ./cachestat ~/nvim-linux-x86_64.appimage && \
        ~/nvim-linux-x86_64.appimage -es >/dev/null && \
        ./cachestat ~/nvim-linux-x86_64.appimage

This patch reduces nr_cache from 4134 to 2131.


>
> --
> Pedro
