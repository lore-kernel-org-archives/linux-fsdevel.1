Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795520571;
	b=MzbVH0Zxa2GYxJ76qd1RWpqPagMoo2k7QC1Z9EVhEe84sPBEGaAPCzdQKZpuVUTmsidF
	 FTGZLUYbBKzmhSqISUsepxPpqU6MlwilcIFvvzOBA8V/IC0rlru0r1DfVd9w/pz1Lrame
	 mKroENybpl4ha4ysLWAoOp7UaTT+o0g/KkiB9OkU+do9nscyEhfrgM2ohaIqNx44S+z95
	 pc9vgNpJ+tqUBpKk9bzWFNEMyBV1U2AY7UGallTzyESVFQPLKTqVQwFNOkRmLMeXDEQ7e
	 1Vv5mYZTAqGfefTXqVBLRXUQHKJtdZP6nNbswO/fWqAm5zO9mWn/NJIlEQ4Rxt4EqMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/z5ch5pLpPdbk1BmHD/hwwHu03qByQafwYZQeBV/lWk=;
	b=utPJp2SyZmhl86Ku5jBZenoYYgB8KzK/3higbvLOOGZ95BULymt/a15IlR/m26+q1iVP
	 fq0GomJSjCgbSpK2vDTgWao7Fx4357D/0noZJoUM3z07pLEb3I87pmYG7nrO8QEGCc8Qb
	 VjY9snT/Ls64RmrynSuzl+6YGxy1lzEah4WDqdIkbBLbMFsorOm/OiaLKNVoEpFLFIuvh
	 3sURFxBxi++JK50sSF7udgM24fmjZ3Z2A6bcNehvMuD/Fkg1u/EIkxl8ut7qCgPuYw/b0
	 o+FwFz0yRSG7m6vILFXPUi9e0vEduy6E89a7zt90uBQ96Z0aczz/0qzp/bnefAI1Reg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xq2R+zD1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1A606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B1A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xq2R+zD1
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c5118deebcfso644804166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 03:42:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795520570; cv=none;
        d=google.com; s=arc-20260327;
        b=XgIFt2bENz44r/C50ZWFCqBH2Xb7PcWXMPqWTkMR1DwewiKOG1uAIzewZPWgptpBA1
         RxV1JyQFvmqLEyKrFCf7LMdoLXWRkkK7MajiqoOTlYvY6qFnsJH6UznxPZz8ersXPo0E
         uavRdT6OG7C5H6xKYhuB89Wqhh+E7kEkbvzhALRVNTV0v0Stp2m6MXdUHiI029uNngl2
         h8sOCxn/I/Pe7bQLFL+YbHnDQ+0mn1h3IORJhyTFXn1VbBOw1VvH2m/z9ZrjKxwT9NoN
         GuWD8gIv+GbUDX7drZUGZ5Qdy9T6S0QOhKkjlsLCDdGc0uxUcDd0XoAxvBzAywTTaEBc
         /Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/z5ch5pLpPdbk1BmHD/hwwHu03qByQafwYZQeBV/lWk=;
        fh=SxyRNp1eUEOJN7n81rUQCFMEzM/+t9lSwuiwYJjHREI=;
        b=I73u/iUs75Vj5hHqrb8TFC9dEs/khP6thUVTXgQ1Jqc08p4h6m55i0wKkpbFAiRa2Z
         kWsNda9grT3qvtspya9Znjea+8T8+GuYiwnww3Y4ubPXRnbVaifIv4VLcirQkvVk9TvS
         LGBhN9xcRzx7uCg+jeUeJVksuKVnKZbF/laSn2z0zVnGnAo29jdEDKmgQh8Cc6oMSApG
         3vRH0wMRvtcas5eFhid7J+AE/UF4pphO2YoFs122a4+AdbpmleeUv7AwJIZJbrcemgeI
         ChSlNpG7eCo3taftrCB3kAhyWNxKrduexH27lAjHOiesguxj0oALV1qgK8NYCeROnQkp
         ozzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795520570; x=1796125370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/z5ch5pLpPdbk1BmHD/hwwHu03qByQafwYZQeBV/lWk=;
        b=xq2R+zD1p5RXUgEpNuhoK8xg7y7NVsHGKr0JxP3zhBiQsU4buKR1kPpzJ/h+RQqvIc
         K55ISJpK52O/lqUCD5pfVaavDjp36RTFXuUvgSOG1ZLmbK/9pg9kLToRaik2nhslMcSw
         f8N0rFjHECKAxVeGwTTUI4YuQcWm+aY7w0dKOqzF8x1QwWuKu5HsvTINBxEXBxWwc95U
         UT6yrwDt4LNX1XlVFwwn0ahcfAe+N8X0MLHch7P4VkP+5Omm+nrwg3OwKrRdP9DBDa80
         fnCWgJRXNa0BguDlQChN0Qc1ponkNx6AtmdYdcRuTKZCxjhv3NFRe8n00Nvq4C4MwGs6
         e/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520570; x=1796125370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/z5ch5pLpPdbk1BmHD/hwwHu03qByQafwYZQeBV/lWk=;
        b=z+Myzk7XWO6d6ix8l9T0ADtEH5lsmxrhlxPG92puBKCKBN+Vq59VVzOYCTNpuAUrt9
         r1KCc8/LYxBym1DxlcLvs30SBD4cxcCFGn6ZvWWfgrY6mui3uwSWdGz+mWSZOwb3Kh5N
         MsQj/E55cosVV+vz1DW0IVbQbhSzCuruImgDlMTeFX0MHg3gSzuOGVRt/DmSuyOfyzBv
         D+WshqzJ+/Gj6bHYNlMpZJJi0U7m/XMRKYg/82CXQl8XQDJZohath2wORJpH2rNene/q
         y7oaCwh0TRWs82QwsAK5Jf6G/ZNX6Fa086pzD9Z0IGjcElFBV1xGFiowp5E6LgczD+oX
         4uYg==
X-Forwarded-Encrypted: i=1; AL+hErHDbTM2+9SFvuyn+M/FblwlAHTuMlksj1VeSq6I9qReXqbEU3ObWeP7bFemVhMufsXlGTU9KSztkX/Omuqt@vger.kernel.org
X-Gm-Message-State: APuU4Z/tpUy9JEvt1TaG+XUTPVpHlwzmINo8SLQm6DyhvwGEydt932qL
	zMiAnE2eX6V+R/r7C/PVMHNFvPPqcZk6M3vnyuiX/mFJ40mr1UlAfvw1QFgvWQEhq1p7AQQT6c/
	Qd5wf9LYWLhMi4omC9Rkcr7w1/NRWUoQ=
X-Gm-Gg: AZFdTZfaKDgWhMe2ebOMrA2k/ESeHqZEQSfU0q+CHcvYGqVR03A8KZnKiRpI2OvwTor
	V8TDMxFMNfHD2zCPaeOMnVGq6HD2E/n5ednzcL6l0XLYSAXE8M0sk7FtkbTHEJdVESdwCkBmRgA
	kSJM9QE3UJCkdZMs3OOqMKZ7tsr2O3p9UHgnU0ENPpcWJbBiiBlOEzWfuqrab9yssALUqp/Khgc
	m0xWh4TnmoInLWx5npl5w61tUUrVelAsiCQSPkM/p+yjCPJuDWOw6HFwIkTA1A8MivmrZ5vvokK
	r20J/JJ6rY5n8vzFLEyOgIeMmc/tudVgBlOqTfmObuogP4rbbtfZYDiVcjLiywoPau7AIYQgmJm
	2Uvugnkfw3xbpl1zVx8/Jzka/fOdsNGFMkZ+V
X-Received: by 2002:a17:906:1255:b0:c2e:378c:8ceb with SMTP id
 a640c23a62f3a-c513ab2f292mr893283466b.36.1795520569665; Tue, 24 Nov 2026
 03:42:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120095559.429515-1-xavier.qyxia@gmail.com> <awBN9VvV6yM6Cjut@casper.infradead.org>
In-Reply-To: <awBN9VvV6yM6Cjut@casper.infradead.org>
From: Xavier Xia <xavier.qyxia@gmail.com>
Date: Tue, 24 Nov 2026 19:42:38 +0800
X-Gm-Features: Aa3M54qQ26PffOi-ROWCmcVbedXfEWG_6O8l67P-4AZYWdcQV7atuYSopUWOUaU
Message-ID: <CAEmg6AVjtaiq9Q8rC_V5TcgAxQ386CsDtiXO7A6UzC+FzNdGTw@mail.gmail.com>
Subject: Re: [PATCH] mm: batch per-task lruvec stat updates on the writeback path
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	jack@suse.cz, david@kernel.org, brauner@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

Thanks for the feedback. That's a fair concern.

The original fio benchmark uses 4K buffered writes with fsync at
the end of each job, rather than after every write. The improvement
is reproducible in that setup, but it is a synthetic workload.

I also tested extracting a tar archive and copying a tree of small
files on ext4 backed by a ramdisk. Initial runs showed 4.3% and 3.5%
reductions in wall time, respectively. However, these improvements
were not consistent across independent boots, so I don't have
convincing evidence of a real-world benefit that justifies the
added complexity.

Further testing also uncovered correctness issues in the patch.
Deferred NR_WRITEBACK increments can temporarily be missing from
the counters while completion decrements are applied immediately,
potentially affecting dirty throttling. I also reproduced 8-12 KiB
of stale file_dirty accounting after fsync in a non-root memcg with
periodic writeback disabled.

I explored a writeback-local alternative without modifying
task_struct. Although it passed the correctness tests I ran, it
did not demonstrate a reproducible end-to-end performance
improvement.

Given these findings, I don't think the current patch is suitable
for merging. Please consider it withdrawn.

Thanks,
Xavier



On Fri, Nov 20, 2026 at 9:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Nov 20, 2026 at 05:55:58PM +0800, Xavier Xia wrote:
> > The writeback path updates two lruvec stats per folio through the memcg
> > rstat machinery: NR_FILE_DIRTY when a folio is dirtied and again when
> > writeback clears it, and NR_WRITEBACK when writeback starts on it.
> > Consecutive folios almost always share a lruvec, so the same counters
> > are updated over and over.  On a 4k buffered write + fsync workload
> > __mod_memcg_lruvec_state() is about 8% of the profile.
>
> Is this a realistic benchmark?  Does it represent some real life workload=
,
> or did you just choose it because it shows the best benefit of this patch=
?
> This is a fairly significant chunk of extra code, and it'd be nice to
> know that it benefits a real-world use-case before applying it.
>
> If the real world usecase is more "there's some pretty high overhead
> when flushing accumulated megabytes of dirtied page cache", then there
> are simpler solutions that don't involve messing with task_struct.
