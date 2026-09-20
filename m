Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB83D7D94
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929255; cv=pass; b=M0CRE3l4eli5ATm+o/RwJPTqkWGJMMC1OdfLWD97PSTJK/IwE5Yp5nCHt0+Z2okm97vIBx2XaT5S9JMKHyP2mpc0liOFREhSklLKKmB4Uf6dYWYinRxwkwuF6EbvVS83fDl/ZCDgMTFCWNavzbLEMuagyovDConb9or3HXxVF4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929255; c=relaxed/simple;
	bh=SQV2oiqKeznGQCDrUMB6LypdK9wv6yvcWGpy0dftZ94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUiL7Ez5I7ZG5ow1p3V8h4RfsLNG84ArV5P3ivrbNXG4ol8VnVeRe3dag1abOlC1GeRwR/mvMJ2QcEHRU1B//EMk7/lkNlzQYn6OZ/IbanyHReU7i0Q87ggQfbcb+r8g9lWPdGv4QS6Wm2Pfcfej3XUqS8BDEihMjimpKUR7A2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=Sj07iJpt; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="Sj07iJpt"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so22998767b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 11:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789929252; cv=none;
        d=google.com; s=arc-20260327;
        b=rnxhR8iOMyTdMr7hPpdmRJxWCdjFy+JnGSxlUzLR+dds1T4FhQty2nE2hrNg89L65V
         kbc3BNKrfHpnSvfqxLHKvzBbB/IwTSPqBZxwUizCMRcHlC9o6bzk+P4csxiynKppDjOf
         6VrrS7uC1Oe7yHYVQ1vISa4VZBGxhJtKoRP4JKJZi4v6jpUxjULAIRMVIBYSPGD0s05O
         BaQIKtFqafMUyzBS9JSULqgBF7kpZ/fzLFqm/eAYAtgOSUkhUMbAZBFw18D4h8OLxJtT
         cs4Q5QXo3JcQFWClIYPP5wrQ0fzZJvGs9v0VBXeSIcUI98X4Q2YTZv/V2HZQwJy0+UiO
         MsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fxPbHcmjqdMbT/W0TK75dgYdyLTxWsOSVmrzLuv05+Y=;
        fh=FwyjvRm2iABZAsJE7T+fa41ez7Mz0GMQ+DDrByMr/0g=;
        b=fW4Z2IxWRo2MUDFl/AxkB9cK+ZB7hYBad3KueEVw+1omP1UXmn8JhOVOxHV0kwyaMO
         GI09cG0slKHiAgxjU8PzX5nO3JOtd182IU+vQfEleX3ETEWi88mQn/bscVWk+i1AnKYm
         NcR43PU2OiMyKwyGe0TeEj68Vn8EaDT1WR0RABTu13CxJhh9IBqypfRAf8AmYCBloWx8
         mKbF3FlN90LgpGaOP5Lwf1/fSod5H9pQwfRjlE144QHQYu7yJ/8nIknfoo/VHNedEFFM
         5hHnSlE33MfDy2P0CCxEOwdMZ/TGQXn4MXmawGalCLb8dk2Jr4Haky21xTIkMllttSQc
         WBzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789929252; x=1790534052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxPbHcmjqdMbT/W0TK75dgYdyLTxWsOSVmrzLuv05+Y=;
        b=Sj07iJptjYW8qKFc/08x5ub65l25vVtHqoI+CR8z9LsUDmPjoN8/2EXarewV41e1Bl
         q68CyVjFpIOnB/A5gcrmAueL0oGsOIsTD3lu+/v8+kRL0TGCaYXLwxUwxskvl5N/XYGW
         4kewGu7KT3bRwkXgo2Ehlv+Sd6uzpgBCOAlVhhqIO+lUVM3FmwtbobQL4p3eZ5AamqfX
         7ok+pLcHPlQl3Q+atfW/W6VrWeRtTlo5gwWWPGPXBFOfGj1zs2Pms3zO9KCWZ/M39JB8
         VDPknJRFzSJBAuMTEgWw9fBsNWpyO+WQBWnLGMqg7NSdPwV+yaKyYxm53bCHDV98oBSr
         9XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929252; x=1790534052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxPbHcmjqdMbT/W0TK75dgYdyLTxWsOSVmrzLuv05+Y=;
        b=c/jRR3HEIMCa/tw7NNT6qJUjqG4fAKEzv/5q+84WlJeDJsKYlAvZQUxX2o4oE5C/c/
         nJB/rZXO7Iq/SRW5FS6XjTuX/ReGZQtC7VCIDUPLFQfrEjd4neebORpZHkEcfAGwil4P
         yvnAXxdeBfQQn1p9QQHWDA6JNYjNo6bAD16oJnS9Ng+BG3Jdh265be82HyhV4ve1zCwc
         OIAhV6yxibzTJ2kuIg0EMVJR9QxJAa/pBrJQBIUFRgrsnIXmeJ/JIRrQLOPC18aUPTr7
         jTTKBStu+Lbgp8eKE1/+2PgQ1rc8kz64LtMNkh/KuBKvtAUkdCzVe+BqRxFd/rpVnob0
         /j4w==
X-Forwarded-Encrypted: i=1; AKwUvBzMtrLmQUgObDWsSojbGQ138eWREKZcJwmriyHDIwvflgVh7gO6jA66+soKZQNts+NUSf8s9tqDBFQqKkFq@vger.kernel.org
X-Gm-Message-State: AFuF++lHr17bIPzAO74NR+8zyTGcv7o81PrUbGu2t77XeMm5vy9G2jtZ
	LyASzpDLh77oFnnYiyhMK3KzR9j1lqGeAnwTZ7QwwCNOUMBJ6wWABGLSpRg9y7rc1TG5m9OSVky
	XdQBuQW82bzGBF1kNcHgJsIMb43aR/wA1Rcq5dDfq2mk=
X-Gm-Gg: AYBFou3uWqlXSYAnOTjk/pQUUmsp3awwba9bC3yAgnEBhGqOkTq8dv8u1/OPDhzwEcN
	wUIJgh9I/qbsXrUYks9zFiCsrljC2qSvFWwdHhw2Xt7/BKZc94tDMIRJu/W4BoZtz+Nt2uKODzK
	v5tpwm55qjJ/jBIrL0cyw9u8BDWAP063CHN2jF7laSSSAZ4DBY/Mawl7/85bI4DaqaZTRr4ABYo
	mZmKkpaDAnZhJ/ypurqc2DTzqkMUW0l07Qu1Z47B4kyAWjOB7Px7GuiD4zxLcDQggYgEKw1PkI+
	H7AHTWDvhODJWfRCu4Qg7o/Mx8/C4x1WdBIo52A8zwDyd66G3Vxc3BrU/R/nLLf6WXcjfBOVhD7
	OPpclcd1/j3mYojnpUwrrd7wHAHkm2zyOQOia33243gEPcNGoPiWGz2tG0zwARiqLEXNxHrXumX
	Rzb6W6oNHGFUK0xh2axW6ozGRE
X-Received: by 2002:a05:690c:e24b:20b0:873:5bd1:98b6 with SMTP id
 00721157ae682-89736b37e64mr15478617b3.40.1789929252348; Sun, 20 Sep 2026
 11:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh> <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org> <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
 <CAE2Bdm3FqBPAMxqKoz_h1cw+OXpm=LJHdJjsME_Jy966tqhq_A@mail.gmail.com>
 <aq6gJTYTpTr8sYPj@cashel.logfs.org> <CAE2Bdm3K+ZnrfB7xzkg=2fzMs7AmJzdF3aYCpN00h90TR6FMog@mail.gmail.com>
 <aq6sd2Z3nZuAYbMG@cashel.logfs.org> <87cxu8axvh.fsf@bootlin.com> <arAHq0imD-Gm_bOc@cashel.logfs.org>
In-Reply-To: <arAHq0imD-Gm_bOc@cashel.logfs.org>
From: Chris Roy <iam@thechris.in>
Date: Mon, 21 Sep 2026 00:04:00 +0530
X-Gm-Features: AcwNN1XxQ2tTnCe51T1q51ULBvx85COBmsrgwZB0hguL-K1VAzqspcbd4FKQXzI
Message-ID: <CAE2Bdm2TpoA9ctHGhvtrDePvz11Yf3koyiw9S4WvY0jS5jZSuQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>, dakr@kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-mtd@lists.infradead.org, 
	vigneshr@ti.com, Adarsh Das <adarshdas950@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz set subsystems: mtd


Regards,
- Chris

"But how could you live and have no story to tell?"

On Sun, 20 Sept 2026 at 21:50, J=C3=B6rn Engel <joern@barelysecure.org> wro=
te:
>
> Hello Miqu=C3=A8l
>
> On Sun, Sep 20, 2026 at 02:52:18PM +0200, Miquel Raynal wrote:
> >
> > Not saying this would be a bad move, it would be highly inconsistent
> > with the current code base. Every single allocation in the kernel is
> > checked. Such a change, without a documented and agreed upon method,
> > would lead to dozens fuzzing AIs sending patches to add the "missing"
> > check.
>
> If your argument is that such a change would be inappropriate for the
> patch in question, I totally agree with you.
>
> I would disagree with an argument of "we should do the wrong thing for
> the sake of consistency".  If indeed it is the wrong thing, we should
> stop doing it.  Then we can regain consistency by not doing the wrong
> thing anywhere.  In other words, consistency is irrelevant.  The only
> question should be whether such a change is right or wrong.
>
> There is also the practical consideration that changing the kmalloc
> interface will lead to thousands of changes throughout the kernel and
> requires a large time commitment from someone.  If nobody volunteers to
> be that someone, it might still be better to stick with the status quo
> for now.
>
>
> So making an entirely theoretical "if I were king for a day" kind of
> argument, I don't think GFP_KERNEL allocations should have to check for
> failure.  Neither should userspace callers to malloc.  An interface that
> frequently returns errors is pretty safe, as callers with broken error
> handling are quickly detected and fixes.  An interface that almost never
> returns errors is dangerous, as broken error handling in callers becomes
> common and will eventually lead to bizarre hard-to-reproduce failures.
>
> One of my roles in my last job was to fix userspace malloc and one of my
> fixes was to ensure it would never return an allocation failure.  If it
> returned, the caller received what it requested.  If that wasn't
> possible, the process would crash.  A crashing process isn't exactly
> desired, but it beats unpredictable behavior triggered by broken error
> handlers.  And dealing with a single error path costs significantly less
> cognitive effort than dealing with thousands of error handlers
> everywhere in the code base.
>
> Anyway, since I am not volunteering to spend a significant chunk of my
> time, this is just the opinion of someone that doesn't matter.  Feel
> free to reject it.
>
> J=C3=B6rn
>
> --
> Why do musicians compose symphonies and poets write poems?
> They do it because life wouldn't have any meaning for them if they didn't=
.
> That's why I draw cartoons.  It's my life.
> -- Charles Shultz
