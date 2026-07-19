Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB02D0C9D
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784486584; cv=pass; b=caxOJso+AJQICsQrY3grKEcYBGfWbPDtgjuNI+o0KT3bkovSMgtoJkKIs+gzjTQmXoUVdRKwPZ86fSJ+X27fgTndGiBCDlk38BA+rMaVpoqyEBCWJKbl5jckDTM0kIKvTVynvOLN+m0RfjAEQiuOqraNkcahNziFT/NII4/gBAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784486584; c=relaxed/simple;
	bh=mFFppR+tgzYK6/5HpSQcE1hem+w1X/QeYlu4aLPPxXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRuoyCDO3iUalKwXEDD8My8Wbs2Qi72iVU6B+oPZOXYacAMZB84OOxLbRXdw/R5u2AWe1uHo7RMOWKGxfKVvf8kXDNDnn7mvioG9pPkZtc7yMW3A9h26/cMM0I5Of8Gl6OqO174X59vcBwLe+RPRkCaLtcYg0C+g1sIxZc8izY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LLMEnHWd; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LLMEnHWd"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c149c5722so39138781cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 11:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784486581; cv=none;
        d=google.com; s=arc-20260327;
        b=o3dRqvEWNTFLiJ2BBUPmtX20wewnIteIVogbwGVYwB/XquEj4xb4lbKsbdoPFvFPps
         jZsV4TLYgZECjYidH7/FayHq8kru/ei0ZMo6AZktGACPVgg5s7fEGlrUNKHS8THq/JQv
         F35W055MZDmb5aqigJYe92VPhnPV/xXD8lyagYhEk5wWb0EGwbTLEV8HSy8952ElZwR5
         Tz6GfOO7rSyMeyXhyhmqKW0P6J33/5KtUEylafrENXWKlf8RpWTksD1Kkzp/VGws5PRE
         zS70DgFC5iRa+FpruoHrz22sK980T2GvQNOnTsjnDC4ghCRVfWk/6sGFWRhUDDiscMgt
         xdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QIWNHNNm4n4NbEoASWprWeRfxUra6wPCmbbue/4Snck=;
        fh=2woUDQ4UrVFtuwlboIJILIzH79W5OQSnis2CizFnRZU=;
        b=OUXAGFigwWkUnHzgZd8YELUkCTVV+P5XdTwIS+cAMUlNb/wlUg4/VjTiu8gzTNqg6b
         VTcWxCbU9YY1rzpToPtzSUn+xFcp6v1sqiKieCYxgrLAL4A8FTRv3uxtmk8ZYYx9v32P
         67n1IpPLMQbdtAWB36RvZwLWW0Z9yesZYy4IgoPToni+Sl7OiOcc06ZvlQLOkNw1h3zl
         aaNABlPmVpUXtEQaKFLJL29zkzfyuWkYJM2zM1P/XNyccvow7iO7qwZal8rUOhQPaPf2
         7MPeHBegqz0z3/DZgUSKkLX9bQI1eV3+BPeQLhzjDIvQ7bghZhnYJVGjLKA4JMYyDsFQ
         kNWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784486581; x=1785091381; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIWNHNNm4n4NbEoASWprWeRfxUra6wPCmbbue/4Snck=;
        b=LLMEnHWd0Fxl7f2PLtvb9/12JUtvOORfOPtaRf4g8nmg3HU91XEiQcSqS4b/qj1hus
         hzqXl1M50X1ZH1s3V0S/v1waL37a/zxRsdJsGbb9yoO+aT3WorFerOjvp9C2QgkXS82x
         jdyc2Areri+08q2M00uVesZs3htcPey6XALT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784486581; x=1785091381;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QIWNHNNm4n4NbEoASWprWeRfxUra6wPCmbbue/4Snck=;
        b=TBTpoKJzsL+Dc7w9B2gOaLaa8YNLVDYtpL/qRUP+w2DgFan3ocRuFQYySnumsBtrQg
         Tnv6oVe6HcWi4Exvo5ROvi8ZwZowFEu0b9urM17+QwkiKRdqbzkWhiHZM3f3td5EBVFW
         dAGlLQ6Ylt0B2JbS/sLCmgrQev/dyUc73Cir+mv645kwga7s+gvf6YPorMORYSVP7Yr9
         c9m3r/OHtFrYvkkZ2BqVIl7xdiUmF8pe46hjYj6XG+QJtFfxrC7yxlCl8YUM9wZnihWa
         rqKOvPEJauJcYPFrnCX2Asrm29vTqSTlTUWAnk8PyfwNboZVUqr1FW+iAWLBUoxhMU83
         /KUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqF/VOzrMcA3R2t7ZOXbmYC+CjXfqJYUlxXUPEqOaYCcm2Uyk5xasXZ77TfkgYWr0vh/P7kJgTdqr/I9i10@vger.kernel.org
X-Gm-Message-State: AOJu0YyXASolepCSxnxCaJd+i7YoNT4lABwXDnpbTwIkqcwkBHtTzCq2
	mXOy01Sf696hQlGcVf64G9lniKYwq+SJaeN4YciQm+6q+R/rtYNSvmwoAqntyUUW0MN104oB3Ik
	EBaY3SNm9pfrK4jKb0hYqZQvSA0pDgAPY5AT2WtQQ+w==
X-Gm-Gg: AfdE7cmcv/HLoxjo47W+HDRhjzB3Kc8n7wGdaU0HBsYcWxlrDaFrnIUtQ5c/5xIfK6C
	NjVYK6bG8wJokchOA+kVILPazSjwUfXl1IZALhxcqUppQbBn16cLNXZpa3lRy+D30FX8Sx3OM+t
	xUa8o6QE7cF4lfXGwT+rTSCPyR3EG6BYB6kzSIsXI+boP1Ie1J29HWlMPmeJ2lHxHxvoAHXob7C
	nCcpCjQ93XTgXBV1+uqJKzdfMZLbq3ndHqgicC/MsbkByOhbRplwPHs22MygguxOOuwgkWfuX00
	SLa6BAM2j9nZD9RCTg==
X-Received: by 2002:a05:622a:1388:b0:51c:7aa7:e0ea with SMTP id
 d75a77b69052e-5212c20f0c9mr108504931cf.39.1784486580491; Sun, 19 Jul 2026
 11:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com> <CALCETrXYHX+OSwm6vhzQqvdk9Fkbxzh_dGuVm2tjvPJG_x1XdA@mail.gmail.com>
In-Reply-To: <CALCETrXYHX+OSwm6vhzQqvdk9Fkbxzh_dGuVm2tjvPJG_x1XdA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 19 Jul 2026 20:42:49 +0200
X-Gm-Features: AUfX_mxZAmDgP1C2hJYyCV36TzCfzCkpkn9ppyiNeH1CkViYcwVDmhXZWL-qKS8
Message-ID: <CAJfpegsS=aZABvwx56tfMtWzSsKWtR-N78q3YQ6JZ-nvQLUrGA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Andy Lutomirski <luto@amacapital.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Giuseppe Scrivano <gscrivan@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jul 2026 at 16:13, Andy Lutomirski <luto@amacapital.net> wrote:

> This gives me the willies a bit.  It's very cool, but it has some
> potential security issues that I think we need to watch out for.  As
> sort-of prior art, NTFS supports alternate streams and Reiser4, ahem,
> supported files-as-directories.
>
> Some questions that we would need to consider:
>
> 1. Can you open an fd referring to a "directory" within an O_ALT tree?

Yes.

>  What happens when an unsuspecting process gets such an fd?  Can you
> fchdir to it?  chroot to it?

Yes.   However you cannot escape from that particular base file's O_ALT tree.

>  clone its tree and possibly bind-mount
> it somewhere?

No, it's an "internal" mount, so no cloning.

> 2. Can you bind-mount *onto* something inside O_ALT?

Again, no, because it's an internal mount, not in any mount namespace.

> 3. Whose creds are used for which operations?

The creds of the process doing the operation.

> 4. Can you mmap the things in O_ALT?  Is this determined per object or
> generically?

Per object.

> 5. Would we ever allow FUSE to expose custom things inside O_ALT?
> What contents of O_ALT can a program trust come from the kernel and
> have the expected semantics?

I think adding such a plugin would be similar to adding a mount.  So
I'd suggest allowing it with the same privs (CAP_SYS_ADMIN) and
constraints (limited to the current mount namespace).

Thanks,
Miklos
