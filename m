Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEE45D5C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103370; cv=pass; b=U5nseSR8sCJP5n4IWD/VDBUU3WznBkuSMogKfDyKrResFmu+HHNcUqHdW2BwLsB2GMFbY7wrd3oFuarfzSP6xHxrtpwCahzkhEXcNXFozt7fLZAGWPLCAqozbB2/blbD0G/fVYzytnwWIUtat7OJ7udVRvmKiByEYQdH8dMGu/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103370; c=relaxed/simple;
	bh=AXRRS22uutXkOu3guPUe2GbkmsWxR1BXKHyZbsJzLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmd1K+rPSdoigfy5e4iX0ptF+unnfZ0le+Sb9F0+zPEWCmeBSe4v6c76ZX+31vmNeWfcH0bKijCrn7MGAaWmqyUaAG6POlDiZpMLFpBkw7w2p/wo6ypLee4EUcTJvJxPIoc41/6nBEA2b/4VzvthsBk0tTuJBsy3SC+Jtf3gPdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRVAjXEt; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRVAjXEt"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533202fe429so120511cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 15:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792103367; cv=none;
        d=google.com; s=arc-20260327;
        b=CcZ60N7iv0gVZtB01Sa6YMFELx3dsWZklM6MTT+a3dwF7uA/xRlMQCTYHt8528EYD8
         hmTEJP8ug8779E6x3+Q8MN2dVRZgfcbRsjxk+jeoAlA4hVWfKvqgF1LJZCO6bCmr5v4d
         WqAC91RThps2ofrWb609qnDrLAD7JunbcLcJer3OJw4Q6nrdv2FOWhOv4BAbK7482E+H
         7c+5Y//rTili9vZvpoUD8YqpFrwxL2JoTZSZSAYnoQ1JFWep/2YWTW9eEuuiuQOkR/23
         ST3OVMGujNs5xJfzkJjAIurAmk1OR4ssfJzqRW4EDHZRlLc2O0nlhvbSyPiri9S9Ram9
         X5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fx0meqXkpmqmZ+T0ZUXv6LFbVHDOrz59U8bjk3O4KlE=;
        fh=ueeUfASWYaFizq969Jkq26vKjkZa2mlipkBjjKUtjfM=;
        b=Yh9B4HSw0XfunAXxFJ0jRkLWHX0Fg/lO3gq7IpoONdFDgO7TTQva25VU+e5oWvtjqm
         DwV2ZO7kd2Rj3D3yjQuSy5jLjrVfx6cpwsMQuotdQ/Kt9OKVw3xUSXPnLvQQHpQbDwo8
         klEq4+oxtg3sr9cT7dspMHROX7Gpd2ZbVLBKATAgQYMKQmeWlySAAj26Z/jnXlnM1+hk
         qFkfo3fPsfzxnm+C4aih+AQpHoEx0Sgh1VLdrCZzTf/49NGcACG4aSSlNw53SGHAY1Cp
         Hritvxd23labfsWW6HdMeUW3FrT5sn812KhCIj+e4/yOHP/lIzH4T4uCwoQxu/1h9QKs
         2Nbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792103367; x=1792708167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fx0meqXkpmqmZ+T0ZUXv6LFbVHDOrz59U8bjk3O4KlE=;
        b=NRVAjXEt20dCgTC1AdDpGbOXmNtHTqK3ykULgg9QQmKY3yCKHMT8KPw2ao7Ln27DBR
         Usl+Y3wt2Y7k8Z8uCzEoetaxmOLL0n+g8rrjsfVsJKFzRVYCxZIDLHRTnMkNJtSydYxt
         fCESTcbCsNXnZ92hd1VUi5dPtA1i8Fz0vcM9tsGzkJ/HKu/4gr7IElT9ybmcdhSFirj8
         s6Tx+j3LWwMODjwNeKBx2JLnVi3H7JT2FacHoYXd5/jwj8tQyrm5tYxTvrNrs1jFekNI
         hpHBcfHiXfMf5jqLLoT8gAmtkjsXSHJFXTQWtLz9Mut6QpoYOieEhcyn9fBoN6juG3oL
         zNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103367; x=1792708167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fx0meqXkpmqmZ+T0ZUXv6LFbVHDOrz59U8bjk3O4KlE=;
        b=e1Bic0zll5rbh/99zv9x1/z/RcpOAzz4efWI6NUpji2nbJ8S1Zut0kBZ0JbwV/xkjM
         U6jMTStxbzlNei4AZ6yTceliAKoz2YNjSnQPzB+KQMnB+XS6IsptGx1DxZVZRgULediu
         YE0cnVTkUglqGNUtku3+rEWaT8O3adRu9L4e4obITFLTtfd9oPr9VMlOoEx0UN0H0TUV
         oMjwD9IY4LDYEupUgm6CgH0dB9nAlBMztB7tLtjhKgMaMSn7tCgyeREs8sJAoN+AKvuK
         XO5NRZ6rIN4luJ44SLYHn2TL2lb+Hn1u4Z9S3czLb0iwP93cBWksYmuL+mPIRMwmTe19
         nC4g==
X-Forwarded-Encrypted: i=1; AKwUvBy+JQDztk4FbctXLNV9AXq93bm6VuT4l8e7J3499fPk4H3u+jMVHhOMkEpcebIWa5lWrIxgR6zngGR4eVEn@vger.kernel.org
X-Gm-Message-State: AFq9FYKdGyQQcp6irIoRxRqDX/1/PZ0Wb0cKxY+hOHGj0r8HfbN+d8lT
	MrjXl9C/d2eaysthVoETOlJfomimVXsAeeWVz7Jy+OkNR1x9x793puh3L+9nwKhQfeI3ZYiA60Z
	u/9hL+mD8o2CKLCrxS3Ollx0uDiV/3VbepqKIzF11
X-Gm-Gg: AYBFou2ZbrgreW3Xl1NVqDbMnzGFupj4Ww4v0KmoyHjfaIpts1I4zQ4WKSPxQQBDhkX
	sknNeEC07WyQsuIoKFl5iHIr3igExcr4HBZ/e8EaNMlvm3sKC+ZIvBgYKiBnUcf83e2gKcpux4x
	ArhupQ4zErurYaJ6uBpek8LJ65VY2qfyMZ4ccMGR/NmRHqcDJXIoZECOtrs4kYY9ZLlFs5uiJrJ
	drVeZmuSYWIvdZ+WhzWgVoZ+ljnVOWI91SyVfIlah8XzsWbDyBBAu2yGMjA2StgSWI0oIIDfkGi
	hfpQSJFKTQwyqLGsuzl/5fZfKv1aH0SGt3JohCJXmzIeEWO4M6wS5S2nhMzMbQcm8BP7hqCK1Q/
	NBnIuCyI3hw==
X-Received: by 2002:a05:622a:1a89:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-536297d3336mr5010261cf.3.1792103366183; Thu, 15 Oct 2026
 15:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org> <2026101532-fantastic-deafness-e04c@gregkh>
 <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com> <2026101515-oversleep-related-e4dd@gregkh>
In-Reply-To: <2026101515-oversleep-related-e4dd@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Oct 2026 15:29:13 -0700
X-Gm-Features: AclHuK_bhqpBXC-6cMMrPjeFLsPs6nuRXrMV9IFwDJ4QNHEyGqQj-Q86H0SV0Zk
Message-ID: <CAP-5=fX72cGXtOVYFK0Fr-XMWtr5nfmdr0y3dwVeUcuAueW3Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Greg KH <greg@kroah.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:50=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Oct 15, 2026 at 09:47:34AM +0200, Miguel Ojeda wrote:
> > On Thu, Oct 15, 2026 at 9:11=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> > >
> > > __must_init might be smaller?
> >
> > That sounds fine too. I like that it says that something *has* to be
> > done (like the original name did). Hmm... On the other hand, I guess
> > "must" could sound like one has to initialize the field "somehow",
> > i.e. writing:
> >
> >   struct S s =3D {};
> >
> > definitely initializes it, yet the compiler would warn. Would
> > "explicit" hint a bit more at the fact that one has to actually
> > "write" the field, even if it may have been initialized anyway?
>
> "explicit" is a description, "must" is an action that tells the reader
> what they have to do, so maybe "must" is better?
>
> Anyway, I don't care, naming is hard, either is fine with me, I'll let
> the authors of the patch here pick what they want :)

Fwiw, I like __must_init for being both short and intention revealing.
I'll hold off sending my v2 for kobject::release to avoid renaming the
attribute.

Thanks,
Ian
