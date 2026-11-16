Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794810417;
	b=pMKqFJbQ+73aLmx7pzVQa+diHM1jsZvY4jRQg5tfcjidCuCIjoKaFqpUAGNiVbQqG3Fd
	 plBfx02v9Jy9vyyj/sY8UpVoGvZ6haJvWMCqKm5SLDSVdvHSMso9etIEFiR+lIdCVrGcl
	 7Z9uvPLY/lWvZNjbK45EXSCVImzaP+/htFlpVV5w5iYRsyfi6iBL/de9XLIdZRfQfcB9s
	 MOQ5CGp545cCXhkI5WP0JGJsCWHVx6ELlyP0zzmo3k2xCmz1VS/8ePopT5Be99DQq6ITt
	 B17OZHT0CrqbhwFLQFMU/NTpQrB0oKTd81e06tb3eZU0jGccCfA0kOQfoG6LZ7L62Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wd/v+54C2+9hZ5vK2vynCTpvfy6lXgdEPXyeyseozC8=;
	b=lrQ9gXx3Aha0PwZ4DSyznFGDs+m7MHYfchugk3NgEGS2sOW6dFAjzvCqxqlY7zci5kg2
	 vKfjxe+ILHFfETArOT8Jf6k4sdhhZj2azJ3qm7GfbgVYT1YX/FXRVcGSLPXpL5T78eXU/
	 LAsd2rIum+08yPFaBT9pk/fG7sI8fj2WUshPL3Shd0CVR3HoTlbbGGSS9ptrOTcrPKO3l
	 ZRPp1V8oWOroPHvXIknY8Xi1mCJktThggOo7Z8/W8kRciVfwh4FfmdRLMa5QyoxdmJyxL
	 rfMgKN7B0Sje6104n0w4nV7yWQf2i4Dq4NQhrRJxiBU61qQ5Dwc6t2xE0aZXHzgWTVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCXmteOG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD19606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 06:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD19606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCXmteOG
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so1080970a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 22:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794810416; cv=none;
        d=google.com; s=arc-20260327;
        b=e6i00Ul2bSbN1QhEDsTemE5UNhh1lRwrybS405u1tjoZg4JWYIpO9jpXzIQyrUy66P
         6muyPwz/acWGfMUOENZQnAuWkEmIki47xrllhoxLtjUueU/NLWC0JZgFjgUd0XqIgv7S
         pNqUeJmWhRs635+e9oTO0Foyl7R4WfV0jwGyyHoznIeLu+g5Hd4iP/kQvGDiTMyhTjbk
         1XHm7zdwD87viUaNVMycUr+hP161wRHpePBNnuFk3BsALYi8pMT2ixQ31TNdaWCKxtZ8
         //zTrRjg/rBrnzDwCN3hB9BKdzim8Q13ckGaAC1LA2ocC7a14CAy2iiETnOBBve/8gIM
         f6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wd/v+54C2+9hZ5vK2vynCTpvfy6lXgdEPXyeyseozC8=;
        fh=DxTpcq74zr5Q4RSpQ+51MeH7F7zuUxCPamsTLsx7pog=;
        b=EmRunwWwcmAsKFRScIx+Wv6dSDR/n7jZph8IcSQ6PmGmgupPERdscqd9FIlR7I4S5m
         3SZNTAtQSzr91UAXzksxvfLro5jgSk9/1ZpJK12qJTvWQwh4LFpcqI8E7niUhOcAUc0+
         AKMPQmqjQvST8nL0rh042fHRW7ReraqJNph1fLKgdJPNyIyMvzToIPBtVDqiJwKZZ1U9
         uZfLM5IhPfYRjBZ2z3XLNgdScMUO37K6Vf4UvxMQX6BazMpGq+LM0jjXyaVRvw2QJc4d
         nORbNaAgeApshavZluHse47P3ZLGXe2quIGJodR8i9tnUpDRQiJyn3RkkxjXPeYlmCqA
         Up/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794810416; x=1795415216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wd/v+54C2+9hZ5vK2vynCTpvfy6lXgdEPXyeyseozC8=;
        b=kCXmteOGFlIRiNajigys1uwla9KKP4B8RV5cZoAQXXdTrgwjLHpbek9rmSivaCKBPW
         R1cJYdsD9KKWtnWc4Fcr21U/S7rdFTwvmaqvs5wXYo32fjQlX/AQN23NPivVRr68wSR4
         +8edqNDvQTp7Kw4Z5gucX7bF4ytviHS0V1/44pyBpuZ06rX64T6724t14AcD7VcNx/Ju
         JT9Hr7/z/pvCEQAnhG0DmWiPWDfNVn1hNJJTVAm4SG7srlghKulMg/FCb/F2/xLpPSGg
         gQgiM7xS9yQOCaiDP1+y6YKgSngRbgvgvseO+iW/+7uJE+uBcv8uPyK6FYoaaM5MVCBg
         dELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810416; x=1795415216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wd/v+54C2+9hZ5vK2vynCTpvfy6lXgdEPXyeyseozC8=;
        b=eFgBdWeJDP4LU7Nlrzh8EkLfIE8bKFJhFezqqyZ/ttGVmYCJ0AiWL/g7lRYKFLIxQ4
         M5/su/xvNo33+u9/KMfbComNG6/oaojXDqRuAwTgibEidIqxBaT6Yu1olG6cjtv5I7E6
         YvzboXLL02iOXA1Kr+NvLiqhvLyfaUjd+/sUtjI3TiOz9e3RJVTEqc9+uzcORy5LZ3Ex
         +h3CazvqWhET0YmTd/75Mf/K5VTJAnqhxP1VN8YXaB+QU1X9uA1OVEPqcQQ3abU3XBz0
         RvZZMDLfOxUgytsvlnEZ7Lp08MSmDea5Mf1bTsQCk8e1GG1lD3ABACnkGRgTxdMaC2Ml
         cP7g==
X-Forwarded-Encrypted: i=1; AL+hErFM6T9bC9CTth0J+yUPOc599r7ZhJOwKLjVj9c2aqw1sv15tO4E36PT32tG8Xnhm2Ga9KrTxxvnP1aMLyUs@vger.kernel.org
X-Gm-Message-State: APuU4Z+S/iWHd/uks+FoCY34aaGLXunMOMzjCxro3V9NOMik4bHTmh8J
	svbbyVOIz2ce7Djr2HZPzPDZzCl98o63M/Pn6qZwnWvRXKP9+2baxlBrF08JKalX8Tx5hvYiE7V
	Y3xZ70zioP/hsAHy5LrQRoIC/VSYgeuQ=
X-Gm-Gg: AZFdTZeloiTjluK4v2qh4tKxGFvgdWxkL5vo7ghVgFK5aql5TPNsUOaKF4cv+98NsQ0
	oFeHW8TE7h/Z3iFCB4qZRLCk5QWpTmF3Re01bw2NRYh0q0hlxOD4mW1IVFljsdTgoAVGXP6AP/l
	KUToyR8E5fCL7uNCDRH+rPUW4fvv+1hEid9Tb6xSuTBLuZ7ymSiauhSOxecAHd9g1g/QPvLoVHn
	bFhiiHuJruuJ9zIqic3azHV4WERPt/UJmalcls5O4x73k+GnAGIomLsmIwmSJhJiFsP2I0kjkRs
	7lhiY7LD7kF0P/v/oeFqKZF5z45UE9sPBCdt63OWwDVbXq4IAn751SMd1XGMGY2m0wMbREr8mDb
	kEecIlpwOyGRmwbExtZ79t38AiRrT3q0cMpvkb5rwkLi44t1lOKL1KvrGiKeox+ih9w==
X-Received: by 2002:a17:903:1844:b0:2ed:3c25:782 with SMTP id
 d9443c01a7336-2ee0da7f5a1mr90997955ad.24.1794810416253; Sun, 15 Nov 2026
 22:26:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112140101.647-1-adrianhuang0701@gmail.com>
 <20261112183727.68afda9533aff699eea12cdd@linux-foundation.org>
 <CAJuCfpEqQQb1_UkWH50tgbdVz9KZ2anfCGWsvvoYFsnC_KHcjg@mail.gmail.com> <CAJuCfpH57DNEb5ckB_c4QTWiiHVGSHNhB=S6HFdjvJ6GgGNSnw@mail.gmail.com>
In-Reply-To: <CAJuCfpH57DNEb5ckB_c4QTWiiHVGSHNhB=S6HFdjvJ6GgGNSnw@mail.gmail.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Mon, 16 Nov 2026 14:26:44 +0800
X-Gm-Features: AclHuK9IzBryxrXRbSIYeEf8bDFSSEJ-fF65yis3zCtQgIP3kFYe9Y881Oj97MU
Message-ID: <CAHKZfL3UxswfJgK+2rHj8Y-Lckbg1Kt+oVK4iyr0pkPWRmW6mQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file
 position on interrupted VMA lookup
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew and Suren,

On Fri, Nov 13, 2026 at 11:17=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Nov 12, 2026 at 7:13=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Nov 12, 2026 at 6:37=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 12 Nov 2026 22:01:01 +0800 "Adrian Huang (Lenovo)" <adrianhua=
ng0701@gmail.com> wrote:
> > >
> > > > Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> > > > per-vma lock") introduced the possibility of returning -EINTR
> > > > from proc_get_vma() when the VMA lookup is interrupted.
> > >
> > > OK, but what's causing the interruption?
> > >
> > > > When this happens in m_next(), proc_get_vma() returns an error
> > > > pointer without updating the position index. Consequently,
> > > > seq_read_iter() reports:
> > > >
> > > >   seq_file: buggy .next function m_next did not update position ind=
ex
> > > >
> > > > The above buggy message is reproduced by the following command:
> > > >
> > > >   # stress-ng --vma 0 -t 60
> > >
> > > afaict "stress-ng -t" can send SIGALRM, but mmap_read_lock_killable()
> > > only responds to fatal signals.
> > >
> > > So please clarify: exactly what is causing this to happen?
> >
> > Also I don't think stress-ng --vma 0 -t 60 command reads maps, smaps
> > or smaps_rollup files by itself but I might be mistaken. It would be
> > nice to get more details on how this gets reproduced.
>
> Just after sending this I found
> https://github.com/ColinIanKing/stress-ng/blob/master/stress-vma.c#L536,
> so I stand corrected. Still, it would be nice to know how exactly this
> issue is reproduced.

The --vma stressor performs the following jobs:
  * It creates a thread that repeatedly reads /proc/self/maps while other
    threads modify the process's VMAs[1][2].
  * It sends SIGKILL (fatal signal) to its own threads approximately
    every 10 seconds[3]. This happens independently of the 60-second
    timeout for the command 'stress-ng --vma 0 -t 60'.

As a result, down_read_killable() in Linux kernel returns -EINTR.

This finding is based on code inspection and analysis. To validate the
behavior, I collected ftrace logs and added debug patches to trace the
relevant task PID/TID information. The full explanation is fairly
detailed, so I have not included it here, but I can provide it if
there's interest.

[1] https://github.com/ColinIanKing/stress-ng/blob/master/stress-vma.c#L748
[2] https://github.com/ColinIanKing/stress-ng/blob/master/stress-vma.c#L658
[3] https://github.com/ColinIanKing/stress-ng/blob/master/stress-vma.c#L768

-- Adrian
