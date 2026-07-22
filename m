Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E836997A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759150; cv=pass; b=O2HF2u2SxQdFi4vJDY8C5UqA/pkAjbocR8qADmOf0lSzMEVOBMdTL6twEsaR+qwPH4zcbiCoCZoWA0k3DM8Onfm1VqJpkr00Bdwhs/Uk+8VU+vfh44U6VHI0ClEg1syjTR8ifPZ8bOF3CBqugBqXGWI7MGhgtZcsXNAK1nV2pFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759150; c=relaxed/simple;
	bh=xtvuZpJ5jE61xxjvrqsu+YYR1Wmy8Kk3wJkrH1vSxEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raIxcra4UTrI+Ij2YCFs+F3cOUbEZbBVLV2pACqoJ8k03lW3MobM0VWp6YuOHYBF9hNkzmJEIPM1WUn15PnTsCU8cfwSZJlGkZObUi4LzAFneFKcHNCGfqjmrZOf+5+H+8AipBZw9XILaRPRD0rSCuVmKHEHffK4uCOc1L8OgMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXURGw5K; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXURGw5K"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso40135ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 15:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784759148; cv=none;
        d=google.com; s=arc-20260327;
        b=jE2WfquWFXZaYqXFMIIH/SVhYsS4oSjRs7dkTjRV9aqgWvOMIcid7zyaho2bePGXAZ
         xbkCE+XPnOBw8HH1rdXvjiVGz3c/yiUULGURy6EsrXKk/HFMNnhBP03R5J4KfoPEK2b7
         lESuZ7TcxMPIvGhoVtzniBP6Qi2YbIjZE8ig+1hC54DaltZvxFnmiTCkh3MPkCuv/wEd
         0Wq88rtMgvVbwJpsL5yWVPtyJdA/wgsgBLvWAz9RpCnpMWvSwIZWFRFlsLMmTtuAXswU
         OzEg9RdFU5Aaco5A4T/yo4fIurWCBpgj4RTMhToqDRaS1h04izTdUoRv2zcPax5FY++N
         4mVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h3qQWpco5+qoVGf6bp9Mmlxz9tLEeIFkYyIcMI6PqM=;
        fh=Sjo1ocyYgWyfOjBAhf41+b5MjWX5mhFVyNR/FZ2Uz6Y=;
        b=VAFtnv8mbPil29EfBp37PD6I9PF2IRtFgM36FA0hM2HzwdK3Ca28fY5XO3mVveHUvu
         VoI3VowFLcT5fpzT6t4KQW7NT1Ush91OK8VW3OxZFntA6T9FWwCzD0QIzMwkv9VTVLVr
         yn/l8U0ldUbF5y0rUawACq+lRm6M43SVP4FZF+cWIITHZQ7qQ5t3ywRPcsGkWIQDbkh+
         Ry2LnIoJGgbf9J2JdJmHZRxx5eTOpyUToWD3MVnZVvv5X2uqyWRDdcv7AsIpxxuC4ag6
         A3c8KTC7zLBmTdbDuuVzZaag9Kn/BbvMprVnwQ7EZQtUXFIfhAusaO3lOcY+6yGUjgbH
         Rxfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784759148; x=1785363948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h3qQWpco5+qoVGf6bp9Mmlxz9tLEeIFkYyIcMI6PqM=;
        b=EXURGw5KnReyN55ceGHVpy2kDJFCQZRDbDLMTpTAHPaAuewCEF05d2xf4XbAwijb90
         zO3/ivmvgmCIuXI+57ia+x7rkwnhMloMZV2ijlKtYMcA6MjJe18frg/v2Ybzwy5TTVbO
         9JTMKR1wODkHppNz2P+U3uUSN4WU5RRV446igtIpKIOsRx3VwVMiEUbv9FMQkkdTntIc
         X8JM6JfBfu7RrBDVX8KVXpjekgyjZnY/Xz+UybAAfb0vhk5kMs6n97CuwXW1aXzSusPj
         p3sbHJF46oHpIZ4wVPFH+NVOv65ioeNsO8zYwobfQW+ksGIKakBO5/QEwZlng5yqiHAx
         iAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784759148; x=1785363948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h3qQWpco5+qoVGf6bp9Mmlxz9tLEeIFkYyIcMI6PqM=;
        b=nLDHFHaQYkduwgsorksaiw5/WZ8g/VnDVgsgxiNW0drq9HvAQmw1J29bqItiBo7YqU
         5OjZb3AESP2z1B3p5B//zmjsv3NZqjLNAsOXoXZYrS22g/55GDTATIyJrk/Tl3BnH081
         +W6ulMXB83LuvyCTNlCmGDAmpy4/DNdWKCri8Y8gM98kW5QVObSHTeu8suncJtkJF1V5
         Gi+RLkntcvLzCmmUASZin8/HiaUqUgIgWpZIYORgxHwW+TEGM9m/N64XO/Fda0biQ5gO
         viRqTchO+U3imkEfYfLJkTSzd6uQ77C7JkTj7u6A5knx7muMbXEWEBAcPNrRyXw6jBXx
         lLmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1/fBi95Q+a72zi+cTs3URR3Tt7ynTfZECGr8zsufy2LG8xDULLZvUBZ8/jX9IwMYxxXDmQAtnvXpVyVfV@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrfa9xUGJ5C1T/OeQ4DWMawPT2hPmtr3v2rCX8fUNYOjS65Ex
	41wjWPYDW9fww+EnxzMIl7ufDwTLOpQ3NrfxGNmR1zjrrD/GR23TH2GvrkrACCyli/uof+dnCuP
	bhYUWcsVH0rPuqe+Yx1I2CiddZZsHLMZnzkhY+Bgl9HnVJyjIiqxjerBZNfk=
X-Gm-Gg: AR+sD11HMfHk+vuPRvVstKJ38qX6hKvnjbfRT6+NhL8v+6FJB65g5XCyo01kKIUScJc
	KGa6ENMeNsHVxqhClM63iy/CgvmBmq6GzZykW6figbBzP1QGHSIHiQbcppJS9/a1qGNCPqYvzs3
	C3ZSMtm6KczaZMP2GC8bBejcZLc76j9WvDeIL6OA8LUGPW/Q46Yvz2Kgq42cVhUJs5q8FvUu6lM
	ktm2hvX5ESBKW7cZMAUOOZYRmN6f1g2RNMoX/o7ZhxUnatFIs3kpiyYt7uybqWr
X-Received: by 2002:a17:902:ccd0:b0:2cc:80b9:3a1 with SMTP id
 d9443c01a7336-2cfa805cac1mr833945ad.13.1784759147611; Wed, 22 Jul 2026
 15:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721051903.691848-1-kaleshsingh@google.com>
 <20260721173939.6bee67b6af17b54961daf4f8@linux-foundation.org> <CAJuCfpFVSrP2DGNr+tZadVzbuWvi467F879qndkQ4VTx6R1w_g@mail.gmail.com>
In-Reply-To: <CAJuCfpFVSrP2DGNr+tZadVzbuWvi467F879qndkQ4VTx6R1w_g@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 23 Jul 2026 07:25:33 +0900
X-Gm-Features: AUfX_my343AdXLfm67EJ0VM2HIkYy0Q6sLnlzZfJO1IPOW7lRXEJUd7rPKBKswQ
Message-ID: <CAC_TJvd69gy5Gmrt2mz6o-yBd-ZVEUnAZ9UOcj8VW=EvfQ2HEQ@mail.gmail.com>
Subject: Re: [PATCH] mm: proc/task_mmu: Use walk_page_range_vma() for smaps
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel-team@android.com, 
	android-mm@google.com, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:17=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Jul 21, 2026 at 5:39=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Tue, 21 Jul 2026 05:19:02 +0000 kaleshsingh@google.com wrote:
> >
> > > From: Kalesh Singh <kaleshsingh@google.com>
> > >
> > > Modify smap_gather_stats() to use walk_page_range_vma() instead of
> > > walk_page_range() when walking page tables.
> > >
> > > walk_page_range() internally calls find_vma(), which asserts that
> > > mmap_lock is held. This assertion fails when reading /proc/pid/smaps
> > > under per-VMA locks (where mmap_lock is not held).
> >
> > So the kernel is emitting a WARN trace under some situation?
> >
> > I'm surprised.  The offending patch is only six weeks old, but we'd
> > normally hear about this very promptly.   Is a bug report available
> > somewhere?
>
> No, when reading smaps "start" is always false, so walk_page_range()
> is never called.
> Kalesh, this is not a problem that ever happens in the upstream
> kernel. In Android kernel there was an out-of-tree change that caused
> this warning, which I pointed out and you fixed. However, the upstream
> kernel does not have this issue.

Hi Suren, thanks for the clarification.

Sorry for the confusion,  Andrew. Please ignore this patch.

Thanks,
Kalesh

>
> >
> > > walk_page_range_vma() walks a range within a single VMA and does not
> > > use find_vma(). It relies on the VMA lock instead (when configured
> > > with PGWALK_VMA_RDLOCK_VERIFY), making it compatible with per-VMA
> > > locks.
> >
> > Sashiko said a thing:
> >         https://sashiko.dev/#/patchset/20260721051903.691848-1-kaleshsi=
ngh@google.com
> >
