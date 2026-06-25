Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AE2DCC13
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420875; cv=pass; b=r0nOF0qct8PqtcvhjW/+vP90VWz9hXfYbEgOLLZahLfmgePcpdq6QM9+2yUxtxdFF52GjxQFv8tNzu7VMKha842gANZ4Ss9we6tEDMPlGQeidvSFmV9YVIN83Xfd3QaTUg9NqI3XIHsrVpvtDRi1L/vADCO503WPZ8UyvgWs+CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420875; c=relaxed/simple;
	bh=hM54lOYXA6Mdu1DDRr4jGl1n0219yXeQhOn+nt8qkmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjOhuM7ySiTbURqdf/9EJtSeTXuyFz74G2F+HNwfGO+I2YX4PfqFSKSfQKmZHGEFpyDKo222nWA7bnPVGLDTVtQDglQ04gFts1xZaG83WRQ+HFc8yG7GrqpzK5K6J0G9X8wkdY6svO14aYWHonc2F7NldRm97qHsT+DD8hteN1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXymltu6; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXymltu6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9157b949fc7so32458785a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420873; cv=none;
        d=google.com; s=arc-20260327;
        b=PVpp0UAanA9umYkNwWRfnPjLR00Z4afWhxhsfyJ6oSuGObkJOsBsDRlrUfzhC3BfQy
         Nh8ooMgS86S8Sjsk5mlSjWzBOyHtBEdEq4359KWWVhIezTGaLlrlocX6/RNMsUisdHPE
         PlI6wJVaKBnxuHzdSoHprN5CbckSfGDJwJLUjIAYWCM2T8lzCHJktmPo0lZ2uu1N5Rc+
         hTOipkNJp16ydTExFJ0lNDhdJU/PgsqeHXmS1wixtajE8GJ2M+jn+L+ohNZt5+bv6Emt
         Lfk23Vl/3xHpuOfgxjb/WiQDP6nnM0dqy5AEg2i6NYPoGxcRmjpRW/OKd54xAXPMLRC4
         ey1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kivhVnPZ6lJoS6jUUi/vo4yujgjjrudAeAkrAqxP6ro=;
        fh=2hdIoQrwm7Cy2Wz2W/xDu7tfRQfrnhsSD8bt2jgyoM0=;
        b=Vmyy8q1/dWPzkF7yqRhRp5mTuh52uyRn8Duw4aw3CL0CQ0QMZ9V5M94DhjJMTqlsG4
         Vcf9dAitovRWZiNZsl9bDgDtRGndj6dMnH3KRRSQZ18kDZfvHHJ5RUrd0FLCB4ccRa0O
         nDyjYlQhzBMTsoQCWdGLRmtF2gdeqnNE86W00H8myH0GyMcXzzA/QlQi2oHA2uRliowm
         5yMZlvVm94/ZvD1h9xekvEXQz8a5l7rKEFTxGcRRnPpO71Lm67UcC+xKEQpGqNszsd8D
         b7beVULrIQ6cqgF+vdz79m8dj8J8FQPPof4HL04BdMwbRa/wMMO/qonwpJ1QQFEzN6Nn
         RRsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782420873; x=1783025673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kivhVnPZ6lJoS6jUUi/vo4yujgjjrudAeAkrAqxP6ro=;
        b=qXymltu6dJEn8A6gd/s7CTb05vVPhokcyYHesgVtj8X8txL+meHG46eUPJfgl65eFv
         k1pd+dG1HBtebB7v2IIflGkuFWKf3v+JVQPDeesjY1BSczfW2kxxFbMXOGIq3SW9Cyib
         vMVT7mvnC51cCeUJ8H6mMdcNIvCLBnC6xEQ6nxGk9oqNKkL+c1MOHDRfDBQx4Hp4gf1i
         Is3hyyZQ0MCc5FcXQ6oY2ymUHJPDB3073RBIdf7A5FU8sdL61rQAaZ4x2XV/G+eTG7QW
         YiP8TqEAeuWGdA1cc4PTJZa/RvuDiF7Pe6+MqQ+NGG1VTC9DnjQQshFEnPu8eHeL8Hbm
         phog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420873; x=1783025673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kivhVnPZ6lJoS6jUUi/vo4yujgjjrudAeAkrAqxP6ro=;
        b=pMtzH+wAyd7s+gqYSWw6m7YO81UbsLZjhhbz5mHjIHUW+sOWABwkVCqI2zr+slXCB2
         g/PpYHdqRLyB67DqBEhOWhKZz/L8nBIxG8Dt/5fzm7a7OG1ni2/j6HaDezU98WB6YpfJ
         ScyeZALH5bjD/vJ4O/2KrWH+Eaa3nqEaQCqqV86IwtUbNnnShGca0kjycp5ssj9KbDjB
         bB2qscmVqqdhZ11+GTbyoU1P8pvQKIEjJLuG7UC6Y2MED/+clSbp/KO031XRmjuIWUiX
         SV9/h4MLbyxQfQDfAzbIhytHKcgieMSvhT5xwnVJDNadlnXnY6MLl0cVRo7Ox79UZ3Vh
         /ipw==
X-Forwarded-Encrypted: i=1; AFNElJ89tUoK4wO4ct6gsM5xgw1y85Tx6ooho4npM8PgQDA6JibPhGhUy54ohhaxl7pR1NwpqibtMUq6SfPhACDw@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXKEWuoe/dX+3o2vu5tdy42kccHjA8IR1IsFvCWrcXBDu1VbM
	WFcxJwKiakuaAMpv92QK77k3sdC/qUyHVLPfzD3QyhElhyMawHvG5VzMZM9jgBJEFinIY9/bzjn
	/Y8AoxoDlT+lRra6nlVrR0SSg7A83X/lNUTR0
X-Gm-Gg: AfdE7cmoQ3nchvHW7091rnfCRhH/uJNupmzrDIWExlcf0dsEQXrCr+pLxPtwrpTWmTN
	8IcA0oEMklE3gT6zSW2DnghrjpfwJ4bok32XhdfrrIWB1l9ySQz+Ab4u7wy1WSn+2rhlqA1Tjrx
	tTiLioM4YjytrA+/sT54nBvQ4kMN5KFA+D7Bod9m84GCoXxASyy4HGuCHkMWjNJELJ/Mfld0Wo2
	i1jTSkhT6vuzawhLr3zXcXaGCtZLkqtlQ2nhcNYaQCNBqKnlg5hhNwkRNn2W/o5U1FUEpjVQjj7
	uxvteSjk/uT0xJmowhzjtwbAzUf7OHhP+Ks2vQ==
X-Received: by 2002:a05:620a:6488:b0:915:8c48:497c with SMTP id
 af79cd13be357-9293d1b2aaemr645972085a.28.1782420872492; Thu, 25 Jun 2026
 13:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622192114.1147198-1-willy@infradead.org> <20260624065818.49975-1-21cnbao@gmail.com>
 <aj1GnMERF_j54sFA@casper.infradead.org>
In-Reply-To: <aj1GnMERF_j54sFA@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jun 2026 04:54:20 +0800
X-Gm-Features: AVVi8CdriE_v47589Jc9sDFoCpF5Kol7NPi_O35NSMSCh5QSUWtro8gax0Opfeo
Message-ID: <CAGsJ_4ytP7HBN25oEvPEFx_E9+uK7UZzsiEpFw-_t-s+VGJx4w@mail.gmail.com>
Subject: Re: [RFC PATCH] filemap: Remove file pinning during fault handling
To: Matthew Wilcox <willy@infradead.org>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 11:17=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Jun 24, 2026 at 02:58:18PM +0800, Barry Song wrote:
> > > Now that faults are protected by a per-VMA lock instead of a process-=
wide
> > > mmap lock, it is far less important to avoid holding the fault lock w=
hile
> >
> > We could have fallen back to the mmap_lock from the very beginning in
> > do_page_fault(). And for GUP fault-in, we have always used the
> > mmap_lock so far.
>
> Your own data showed that this wasn't the point of contention on the
> mmap_sem, that it was the fallbacks that was causing the mmap_lock to be
> contended.

Right, if the first PF holds the VMA lock, we don't want a retrying
PF to fall back to taking mmap_lock.

However, with your approach, the first PF may now perform I/O while
holding mmap_lock. Previously, at least, we didn't perform I/O under
mmap_lock.

>
> > > This should result in improved lock contention, although it is possib=
le
> > > that some workloads will find themselves contending on the VMA locks
> > > due to them being held for longer.
> >
> > Hongru reported that 82 of the top 200 Android applications in the
> > China market call fork() in heavily multi-threaded processes[1]. It
> > would be good to take existing applications into account, please.
>
> No.  Collect numbers that show it's a problem.  I'm not interested in
> theoretical problems.

The earlier report already included a clear call stack showing the
problem[1], yet it keeps being ignored.

I don't think I'm able to convince you anymore, so I'm giving up.

There have been many occasions where you've used very harsh words
toward me, and I never once asked for an apology. Yet the one time I
praised your contribution, you asked me for an apology.

Honestly, I'm tired of this situation. I don't see much fairness
here, nor much kindness.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4xC5LdhuoWV1=3DtK-RZ5rkjc8aOKOkm=
b1L_8BG_3gtJhDg@mail.gmail.com/

Best Regards
Barry
