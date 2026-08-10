Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469642C503
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380811; cv=pass; b=RQh0uElwU3k4c0IiqQWYANjHypzFbPZ7pth4aY2wRYwD1QMySyBxBkEbj8vmuVrYRV3DQBbO8Ss7FuFu+6K5AaVkQWiO8ASiOy9J1Jxsf0GL+A4psxo7qnjl/k+srRw8/3zYLtls9X/BpngX1P2Rm10k5Cu1jZnVop6TJfxti7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380811; c=relaxed/simple;
	bh=hrTBjMU5ss08E8NzVEAVH6LfpDvtAnBYsIwgUDaw6sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpZ3AS9OK2AA/Vr9+ts3+I00EJ+XO+4d7BWRS/fdlqruPezyC8IOWOMHmgT8dkyIdyLXAIoy2+EsdIUN339f+2xkUGQSy5ODFTy6Hd0VVHQRk/jfbb0BMCk484tjSXxu6q/35BUYUm/4GmWVIVNPNFIm3v6lecwSZxLOj3nOhfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/3125D6; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/3125D6"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so117156e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 09:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380807; cv=none;
        d=google.com; s=arc-20260327;
        b=flBXE3KP3d3tFdkAQTyHBERfL5BSZMWgscDlyRd+OY3t8WV5SetyblnbM/oV/i/ihf
         p0qb5s8+WO8Rdwx4/jFY+wGS5UYcC5f5sX+JFuN2ki7FUlRTQPHXId5JIl+8nTUN42L3
         +VutqSgi2SpAnBvcq5oo+4qDkGzAsNLEdPwoi8WLJ8y5lFD3seGyCO9AT3ZLkSr1tk12
         12F3k3Pc1XXlDJU4PX8rcKZLKUK0U8YiUrswkB9koL4Zr3/UGreGUjbQysz1ItEJce4g
         9fEBaCXFpvBwZbRwlv/qDehRRz5qTBFa2GZjd25CJNPh7nmNUEbPLwveqpslalZq8gWN
         zsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
        fh=CgeSEoFgiWA4rCMTasjUo8NwI5ip9nNS/J6L3uZQVUY=;
        b=VqHy2m1v2sI42MEyzTunoGrRVAtgsuQUv0jzsIGjXg6FYVkNH3PnHYGor6A0GzSiO1
         yPp3WMTwTKhM3PR/DUw68uVtJZsLdnw9AFWUskHnd6vZDVsE5XjvL7OR9eSwVbob8nQS
         vwUT8cDeYJDl+Sqoj9J3XbbFDlGyYbBl1h89iChkj3z/poWaicwj6swlCdv0CRBl+Yvq
         zRiIBRKku5HLlV5VyUtm2bhT4kJu3TejwJApURHrewBV4EPMAPMsBZQcDYm9i1IbOW8S
         Y8WJ6m1EBw/U0G20ATpF6uYrL83quagyEi+ddqiDljVJL7mZYPvxiVNnXkePJ5IVn0FK
         yn/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380807; x=1786985607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
        b=l/3125D6/+JkYuTGDdviT529e3skBZUjgHelNWQBqKyVHWClDOUViZg4O1tqvvTmx1
         ORHup6Xbwva4Ct0TI4LPF2uoDsyTMxyPBxQiHfXU2PujCHPV01eA4YrtJH0K8ORTFnTQ
         4+uWwch9JBSaE1hErh/5TEAff+RXPUG82EfpTbAAIupp7yEhSdKKcTc8C7D/aIAht2d2
         v9KtWSeNd5jDHyeIuF2yZHdAbimElKH10HAaBO5J4cBXrVOuBqae9elzwpXdU2WqgrKj
         u5fcf2E32U6o0tPnO08Y8/dh4T3xtgHaAdfh9Ns1vayvX301iWBzQXdifOsGuWC9wdYp
         PVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380807; x=1786985607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
        b=XFgsCL9IzHuVZoGi+Uk+5d1H/+s1Racwz5y0YyCjIbXPbXN+6Ibl0OayswTkyDNgTv
         koQS5hdKb0PYNptGKHfQ2e53muZsic1Eu066ZEMjqUGFsVqr14OomJVhBzdQQuyQAHmC
         /NkBXD1REQp40ZDm3NwkaWSwpiXYqk2UPafFCQgXDWAaY714ISx3Q8OrHeYO8AxhMZj9
         +MoxCbaD1Jgvb6LHYod1ZMUGhLUYzpd5dI/RYm6c3/xgVX3hAhWxt5SxWZBe+BdPUL0v
         FHouo9GMz/WFkunc/08aAduoEYPmhuuJIejhP+dlccql2UNz9k6IPhYw2KC9hPX3eA+g
         8Uag==
X-Forwarded-Encrypted: i=1; AHgh+RqbT5BN00huXn5x7eSM0lYE0RGQ2JoELebLvHlX3TOq2cZSkcU8O90ZsL3FGvC9gblq2mxclMTgAvr+On91@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+50t0U2XSoDUJ6txFAVYxm207Irqf4LPR5DZNTjZJqQwZFp+A
	o2qweaahPE7w8AwtgAKLWw7Ct1wH1Vct4NSY6Pw4IZozEUVylMfY8x1/eH32AktKuGZTSa4I0PL
	4g8J/LYriP5lqNUSBr8fWFUzWA+shMVE=
X-Gm-Gg: AR+sD12aZlwv/UkI/dgUqudDO5tuxOLHhlgfR/axHA41xWzTczPRygBSnNQiVKT9enr
	aIbqAPGFNq6I+0+tPxmdSu6phrSlrGEDFB6BugLF622YEYi9U8h+Tklq2XQrOK/BA24pBTzuz4F
	0sNG01d7bwezpoVdqiZ11jVB2a+ELxVLH59PwFbpAVh7CNQ0Rvh9VFkCJyyEiamsZKKUNrWnICa
	joC9b+wWtcG+Si5fFhCWUitwYeHc/7ApyBbguTcm1spBqH/R5boYjVIGeDw/756sfgVFYiOHJpL
	/JGoObR2CtT8dAsTyWQBhBEDZTrO+qTdNJmS24wAgiHMrozK4yQ47KZxhb4A9KU6d2HKaFy6YIA
	CGG39VLlQtQ9kd+Crak3A7Q+LaJXIQGskt5J64VsZ3gYS5g==
X-Received: by 2002:a2e:a589:0:b0:39f:af21:75d7 with SMTP id
 38308e7fff4ca-39fe8316b4cmr28346751fa.2.1786380807071; Mon, 10 Aug 2026
 09:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com> <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
In-Reply-To: <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 10 Aug 2026 09:53:14 -0700
X-Gm-Features: AUfX_myHa-HGIxfGx31VEif489SQOdZ1JWJCG5M4SLT2WDWvbOhVQ3bd6pEJrl8
Message-ID: <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system suspend
 using PM notifier
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com, 
	Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 9:34=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/10/26 8:54 AM, Christoph Hellwig wrote:
> > On Thu, Aug 06, 2026 at 10:01:08AM -0700, Daeho Jeong wrote:
> >> From: Daeho Jeong <daehojeong@google.com>
> >>
> >> During system suspend, a race condition can cause f2fs_gc and f2fs_dis=
card
> >> threads to call submit_bio() while the underlying block device (e.g., =
UFS)
> >> is in Runtime PM suspend. Because Runtime PM worker threads are alread=
y
> >> frozen during task freezing, the threads become trapped in
> >> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
> >> timeout.
> >
> > That does sound like a general issue with our block device / threading
> > handling.
>
> Daeho's description above mixes up unrelated topics. A runtime suspended
> UFS device is resumed automatically by the block layer if necessary. The
> issue Daeho is trying to solve is unrelated to runtime suspend according
> to my understanding.
>
> >> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPEND=
ING
> >> during PM_SUSPEND_PREPARE. Background GC and discard threads check thi=
s
> >> flag and immediately stop issuing new bios, allowing them to enter a
> >> freezable sleep state cleanly before process freezing begins.
> >>
> >> In addition, check freezing() as a fast path to stop issuing new I/O
> >> when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested=
.
> >
> > .. which means that we really sould have all the relevant parties
> > invited into figuring out whast is happening here, rather than
> > band-aiding something that looks like a horrible hack inside a
> > file system.
> >
> > Unfortunately I see this a lot with f2fs.  Please reach out to all
> > relevant maintainers for something that does not look strictly local
> > to f2fs.
>
> This information was shared earlier with Daeho
> (https://b.corp.google.com/issues/515470309#comment45): [ ... ]
> Register a Freezable Kernel Thread (Recommended) [ ... ]
> Why this works: During suspend, freezer stops freezable kernel threads
> before devices and block queues enter their PM suspend phases. When the
> queue freezes later, your thread is already safely sleeping in
> try_to_freeze() and will not attempt submit_bio(). [ ... ]

Hi Bart,

To clarify it:

f2fs threads are already freezable: f2fs_gc and f2fs_discard are
already registered with set_freezable() and call try_to_freeze().
However, a race window exists: a thread checks freezing() (false),
calls submit_bio(), and gets trapped inside __bio_queue_enter().
Because it gets blocked before reaching try_to_freeze(), it triggers a
PM freezer timeout.

Hi Christoph,

Point taken. Aside from this f2fs patch, I agree that addressing this
at the block layer or PM subsystem level would be a much cleaner,
system-wide solution.
I=E2=80=99ll give more thought to how we can properly solve this race
condition for the entire system, and I'll loop in the relevant
PM/block maintainers if a viable generic approach emerges.

Thank you,

>
> PS: I'm no longer subscribed to the f2fs-devel mailing list.
>
> Bart.
