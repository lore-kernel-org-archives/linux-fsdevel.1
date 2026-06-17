Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1675227B94
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697585; cv=pass; b=fHQrPrz5DEidUZooLYalQnAE0DwTMQKhaMT+X8JVKJcP/tjk68JrWTNfelb/RNOfkoRABUVFVvmxKrC7kkcJktkx0xGV2gWBjs1Zqj0BFYj2LfsOHHWPdcz7kPrO2ggNlLvrNublzRv1QrKyYUvf+trOkBUOWl3A6HZzJKs/KSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697585; c=relaxed/simple;
	bh=8akt/BMqI4Kjv8lSIjzIFUGEQibAxUf+a29pOQsWUmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3QxOvXKu5G7HpAfeP0UerPQGt/xtpQwzTzm8eFtZ6qGeEudfj+/tRwmfDz6qT+uJKKO+u1EXfCd/g9lwhwW7drMl4GFB7/91xSIiWqELnbv6uscmsRrAzwFJSet/H2ufWeenXj302v6DWT9IEHsP19vOJAMW2kj05AalfnLhVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqWfKrxl; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqWfKrxl"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6954810cfefso1270326a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 04:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781697582; cv=none;
        d=google.com; s=arc-20240605;
        b=aNGFTcgIcBlgLj8pbfcIjPElQAfbeR8iDhU1hdBdDwztA5rOcEximPYpPHR+mi0PtS
         sHv1I1plmgBUcCXESqJM3uOBZFJrpRUaTHAqxlAR9JAErLGV/MyERY7TZ/Sfcg0qaGlu
         HOuHg7w+pUEGJOXJTbVWRtrofxX2//44ws7TEXhroBkgBEevGWjMmtd2qpUiYMT41res
         LV5MzGMWuT1fIVihuxIAHmoJumxdQMHN3913c7NLiHvlHm9SNlxlL5TCJuFHI/Q7jI8S
         9yS2pBNIssYUAqZ73Dmygo60Zi2p43exL+YBzRf2BJznJnee2Gk+LfnJ5c6F4jAbK56Q
         esbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WSRlCu2GkIH7ZB817+Hh/HHTjCSZH03SYLagMC/Q7yw=;
        fh=VrifAmtlGd4NEjOXJ4K+ikbmAwFq2YZXmHki6wGBSO4=;
        b=PFt308mjlvOEI4kpqQRhcBUGpeI4vbEzRlQZtze/Ue8gVC/qad8GAfxl/W0RsQxuyZ
         RyRKrfnmsImoG+M6jbJTD7r/0FeCwZZvsc1NkeG5VePLM6c6g5HVJBzI7gJUYLRxbdOe
         OQdDMXbjXj79Ae8tl/wS0GofvwNaSwU16pePWsz0RkmIYH66vLANzko7K1WlHFnAybbE
         3u1HIlSK8gqPcpUf2a4tpOve7G0Q/ny1xSHMWMPBxsvm953jrP2Fz5XTjmiyPhbKZgYA
         e9R6LYc2+zr9BMv7CLvIezVVSCCM5ckE6VFpLN8JrmNoihn8a7yArINXUSI5v7mCQ3Sh
         mIgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781697582; x=1782302382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSRlCu2GkIH7ZB817+Hh/HHTjCSZH03SYLagMC/Q7yw=;
        b=qqWfKrxldPapGQY4bno7uv7ozsRcBDfdhOVuf2w4Rncvj0OS3HruiTTSz4YeRrHETe
         yzW++4lmgHXfTWcSt6yosJ0BVh1/UosXBXrpsFNh/Cg7BZdYCY9ajHnEYlV/88J43RzP
         Eu4KFW3T5h1SCX0BbVsDZC3+qQUtwjktNbGTtV9JXvqGUR8IAzOtpk7mzPk7jx9EIF/V
         sLc1xIsMTrlPr4Gw/ON9yvK98K2BEcvdEwIjfBZXUeKtzFvftjJuFTrBFC6cwL+8wLJY
         AlPD8UtLEPTNteJom4pqGxv844kvhsR+BoEnNN9fCVtM4z99wnr3y5s+PKgFCveg1FYa
         984w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697582; x=1782302382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSRlCu2GkIH7ZB817+Hh/HHTjCSZH03SYLagMC/Q7yw=;
        b=d345a6kwY1T+YdMUfhzdE3J0pO+rnFCIgrxMG6LzNjvTw8kzcY9vgc2cshL42Swklx
         +jt1XM9/ghSvmPVSP3zqt7FoFIwK9uc31uFLCwv/eQC6SUkM7tPb9dvLsuTvMjKBtT/w
         7OPkNciDzdi5jE/shlrOv++nNZQpy3G0DitSTNSewkCz1cqUjVvImX3paMeJpZC8WHEe
         pYHttAr6rOkworDgs4fwydjOgzHj8IEcfnRyXXDwWbqqMWjQWKmQ7xpE8/3YxFt96vux
         jzfZ8U48SX0fpLFNB09AHikld/epOf19LCqNlNJ97Pl2uzYLnIsD0gBTx/jwgdnKQGyn
         rJ+w==
X-Forwarded-Encrypted: i=1; AFNElJ/L9BKVr166EUx1XiM45m4zD8epaZE/rEBLHBG0qAv5OEYt2JFlqNNoQgL+OZpLz4NnuJAOroa7pwjTNWw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIbuCxJRJZKjz1jAkRNyZQBc6MfBYaF5YTZtC0hA92zMPg/NG
	Eo5kuRTYzEHhq/VpnhVjtZR3vaqofzRVRmNKlNiHB2R86Tzob6aXQcM66PnybFqoeM6e1WcR6P1
	dcTl6V0aeA1AGjP3EyFff7og9RxfwjbQ=
X-Gm-Gg: Acq92OGg0w+4IEt7e1TX9yYSEaAjgvD5213/pwSLl/mHShnFUM2A1rr+ypnr5ZkGFlb
	eAmI2RKIoZpDcO3fsl4PT1XvipIbQCtkdehAr6OBE7Z3J2cXd0mlKEjX8Nbm72dOLWNeOlX5jRd
	/fq3YzJlzNpQSOUefwOjn/312Pqt1SS9MPN0+ylMjq5stB2J8agwj1Agu6XzNxVwiWUgMRHvHdu
	mQ1ajb5apuncEwtBQytFwr88Y/AUntf/y2VaFEXc23nOVqbTubGp1fNda8erDRJxMus8lJ14aWW
	zO7qlUF4vqBxhXJLEhYTb5PEJzA=
X-Received: by 2002:a17:907:b18:b0:bfa:320c:b93b with SMTP id
 a640c23a62f3a-c05a6bd9a6amr154958866b.25.1781697581767; Wed, 17 Jun 2026
 04:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost> <ajJgWBCFYwz9OIo3@redhat.com> <ajJ1Xi1p9UhQvILi@gmail.com>
In-Reply-To: <ajJ1Xi1p9UhQvILi@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Jun 2026 13:59:29 +0200
X-Gm-Features: AVVi8Cd0aWE-N2CJqRiE84I13EFNt0mxlHrGNQ-K93V_evKOBFVmX_CosDS-2DY
Message-ID: <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
To: Breno Leitao <leitao@debian.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:24=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> On Wed, Jun 17, 2026 at 10:52:40AM +0200, Oleg Nesterov wrote:
> > On 06/16, Josh Triplett wrote:
> > >
> > > On Sun, May 24, 2026 at 07:44:57AM -0700, Breno Leitao wrote:
> > > > This series pre-allocates pages outside pipe->mutex in
> > > > anon_pipe_write(): for writes that span more than one full page, up
> > > > to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
> > > > alloc_page() loop before the mutex is taken. anon_pipe_get_page()
> > > > then drains the prealloc array first, falls back to the per-pipe
> > > > tmp_page[] cache, and only enters the allocator under the mutex for
> > > > the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-pa=
ge
> > > > writes that skip prealloc, or shortfalls when the prealloc loop
> > > > fails). Leftover prealloc pages are recycled into tmp_page[] before
> > > > unlock and any remainder is put_page()'d after unlock, keeping the
> > > > allocator out of the critical section on both sides.
> > > [...]
> > > > I also vibe-coded a microbenchmark to validate the change. It sweep=
s
> > > > writers x readers over {1,2,5} x {1,5,10} with 64KB writes against =
a
> > > > 1 MB pipe and prints throughput + latency percentiles per config.
> > >
> > > How do the numbers compare with 1-byte writes/reads? (It's fine if
> > > they're not *faster*, just want to make sure they don't get any
> > > *worse*. This case comes up a lot with pipes used for synchronization=
 or
> > > event reporting, such as with make.)
> >
> > Note the "for writes that span more than one full page" above. Pre-allo=
cate
> > does nothing if total_len <=3D PAGE_SIZE.
>
> Exactly.
>
>
> The pre-allocation only triggers for multi-page writes:
>
> anon_pipe_get_page_prealloc() returns immediately when total_len <=3D PAG=
E_SIZE,
> so a 1-byte (or any sub-page) write never enters the new path.
>
> anon_pipe_get_page() then falls through to the existing tmp_page/alloc_pa=
ge
> logic exactly as before; the only added cost is one length check and a NU=
LL
> prealloc pop, both trivially predicted.
>
> Measured it to _just be sure_, 1-byte ping-pong (perf bench sched pipe -s=
 1):
>
>     baseline:  2.674 usecs/op
>     patched:   2.710 usecs/op   (+1.3%, within run-to-run noise)
>
> --breno

There are trivial touch ups which can be done by adding a bunch of
predicts and inlining kill_fasync if someone can be bothered.
