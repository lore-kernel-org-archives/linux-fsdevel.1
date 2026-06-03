Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BE44BC9F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480646; cv=pass; b=U8aujmsgg1z2vD5NUSZRvy+i4QR0avX0kHkxJc0YWbh+YHke2tzq53i0xpVp7MtlwiG5ttiFczpsI3innuyexgh3MRuWzGiN2LIA2rtA5dHmNGv4UwpPll8U9vu5H6xxC6cehJEazT3WNFCbkDb3fy+0PSe3kjJv2EWjiQ+wy/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480646; c=relaxed/simple;
	bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2aoGHBYX+ZT3U+MNA+y9fgXCQEPYB+OZLUpHwlFynueRRJPfEeVLLsRAtZXBExmrCnell9F1RDLm2yvycmzkWqhhCaeWUlC241EqBr/sYFtwjaXy7VqVJz5qDP5jooG3dZ7qr0ehrxXNYHhSZXy0UGYV1gkt+hp92H8qxSmc68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HkDLARZC; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HkDLARZC"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9154ca1aa1dso71503785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780480643; cv=none;
        d=google.com; s=arc-20240605;
        b=S7ZrE9XkLIdVGW+Sl8RqH0B1K+t0iVbM3W1DBddj3Nm5r0sShKEtKQLc/sF/zePXc6
         BTjoCEZ48USvoE/vLRv8s2RljonOIf+nr77ggomiZIE3iBa3I7B0NPIBLGNK05Woaaj8
         tdywLHomsJdFmkCBeMW/w4KgR/CqJ2lWMFr0BhP6+VrtFtRR4xAWbMIeaQCfRL3OQi61
         I85PFuxjS1bacpulC0pn8ePVSRuiAlUqMfMnElNY75GEQJmjwW749AVpSPXxwdY0yuIG
         zb8VnW6u+R+JjUX1B3fh3tdpacOEqo0ZI0wx3lsMoBG9yxK20a413JzrKutF0aAiUX6R
         iLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        fh=WA2QoWLyDCQNyoy4AAoc+MYA0GMfzhH2Z2fxmbGaJWQ=;
        b=S0MFEI0vlZt1TKR0oeF3UAuOWbJay38IwiIh/bZlEYCuCdAc90J6ZNj9jUwxm1M7tt
         /Uo2bfnM+uYBXm4uqlDhrMLEP8rEM5AYac/4eq9aolxEmii0E5K4hmvHAZ2rJwrArpIZ
         SNQ68AV0Jw7FXRkqfgLV83bo3r9ATHKZVXFlHe/d4dikTrHsaTpbJ5R2GX+bhqCdUEiZ
         gArGtXEvz3qnlgJZ5tgjllNMFpTE8QcUYvxBZjo5Zxfm1Mlc3MX2INFpoqn35K97DMUB
         t+ZzbZVxXJ0kwNJfEw42atWaqYhWoVZq1Oww8etwPuYySMN+x/uHPoduilfrLVXBIsih
         Un7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780480643; x=1781085443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        b=HkDLARZC/XPgnAkeNQ5n3MAM79d1kM1OOAeIKHRtNGpfkDXUv245i2yp+mD6JQPeUA
         64NZTw9EGfWhoENMoiIPb3oOJkXL+vE4E73fmxTFzb0nVraMC0mwLrTACZFwydQIAExR
         aNhk9bnGc++zz0NIEM1FWBwrjxTfiTh4xXjBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480643; x=1781085443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        b=qxtjjJKZ6txUv3yuYkHsX+AsVVz15Vazp2nN8t6EJf6aIGrW+xQ1g5m/R+OlVlDo7W
         6p0hrRI3Syw6HK85IwsbiG3j16c8Hv1tZdhC/6joZtbY1NlZo/Jc18TgKS57GYQeSINb
         6N40iBnxkhsYfDTx6b6qPDYwZ3wL72s8WQsTeVgjNrcy79oKJ0X3Q9wzCsMwkPq77eYb
         h1Gq40RMLEiyKqUCK4UTkZY57ML0mfv0OY1rc23s2X9ZCpAA5WpA+YY47ZGX1mD6PYRS
         v4zFm12YSnVmUmIjB9k/Dk5a5Rq1aIuPktH0mEwR0fBKAlIjU7W5GHdYujga2gCn7P3j
         9ESQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Tty7u88jFIjOfqOJ8KFODuZ1Y0t9ekqBGAYTrFskmP4kQ1/EuBcPmQa7/l8DRZc6g0VciXbY86Tr1FFOp@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAp/8VcpQFsx2pMpLpoYXVV59HojgwXmpNVX1AJQ+KGyXJlyw
	3YxsUjkFc4Db5/OskuA1e4zJpJO/zEpuB1rNyDjFJxYs5ZGRJuNItWi+IKTMXFv4CLSUx9glTby
	2dqea7gURyc3YD0roi3837MYbJtHwZvS1mB/BL6NUHA==
X-Gm-Gg: Acq92OH9CtfOexti1cvk2BCCk9RjMalDjZuHWBcVgQls+nua0DokvwxinOUNuPTtvte
	Ma7fAYz65Wg9RhlSJ4wEnYEqV6fCIwX7z/s6Ev0061xLkPuHqmU5CKU6igH/OFVUvlhQ45Rfe0d
	jFRQ82pOOZMBWYvm9UnW73RlyKaV8nZzhj025Pwta5qZZ4mRTFHNMGrB1zVkmYoObRiTjLcOcZM
	5tK+hIENc4NSzGyUCZI0vQU5+mgRpdaKwrfzFsJof0+lW4tO5vo3vTyKvDJag0gIsOBL/XMHwy5
	v7d8YM6VZmU8HcwpSc916lrj+pfGajZ4QqpHVwFliHp/l+BISbLFe0R40g==
X-Received: by 2002:a05:620a:31a8:b0:915:422c:a0 with SMTP id
 af79cd13be357-9158b6e2074mr292177985a.22.1780480643420; Wed, 03 Jun 2026
 02:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com> <20260601173325.GH2636677@ZenIV>
In-Reply-To: <20260601173325.GH2636677@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Jun 2026 11:57:11 +0200
X-Gm-Features: AVHnY4IqQCqMS4qklUMIqRUT1Fpv-SuCQDkhxYBkM9m1uTwHwBhUln17rZFWNU4
Message-ID: <CAJfpegtH-E79D-3UL=pPv-QqJk6C4ODXLLZSAjzQJwSSeqqS-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Joanne Koong <joannelkoong@gmail.com>, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 19:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
>
> > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> > a big simplification.
>
> FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> Communications between the kernel and fuse server at least used to
> seriously want that, so that would be one place to look for unhappy
> userland...
>
> splice-related logics in fs/fuse/dev.c is interesting; another place
> like this is kernel/trace/, but I'm less familiar with that one.

[Cc: Joanne, fuse-devel]

I'd favor simplification, but care is needed to not regress performance.

Joanne might be in a better position to say something about relative
performance of various transport modes in fuse.

Thanks,
Miklos
