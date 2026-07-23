Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36B41C2F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798470; cv=pass; b=lHUwDCww55Jhlg/7A0Qkkoo6fXGqCa0//MkYttfN5FEKR1ZDFRdE2lfM/dlLQpbTC3SBXnVmf+VM2d3BY6/iIMozTEMO9Crh6JW1Z5uAkIov9MdRWMdlbC3Dvix52mXU6HEQgqXJ9JQMzDLu4EZrzVcuUihigYQ0vKnaNnq4sXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798470; c=relaxed/simple;
	bh=sGg6RHbGOFfY3wrPJw9iaoWvo2EuJQxmnM6MAF2FK6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/X2KBtZWv6tpjmEHjClBGxsRWYmV0ntowJTfdPaTNQG2WVNQ+tO0JeIcj6uBxjNGi5zB7XF3EGF03fGY5Ekb+IMXrlPdmqFE42XYETtzKlPHV+YF05so0Pxn/1yGHREBLL2LO8Ey91AeOl9INTCzXx/Z3+1dMD8gK+7s4Tk5Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/chcEIJ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/chcEIJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so583092a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 02:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784798465; cv=none;
        d=google.com; s=arc-20260327;
        b=CzQ42SxK4meIw7qMH8wxI/PZwJE7H/nLkdEFRtDqPUbjMjr5OtKLuUduu1TxxgyRTy
         06kItOgUR1thaOlNkb0o82PW39AAZOuEtR6w88vzdsG2S/EI2xvlVkz4J+BURaH5RRbg
         HD7YNb96930owubxz0e1lqilXMBYTnLeWDfQPaqdNLD2n7V5I7VCwkh8zTIR6rXKOXD9
         HSfIjUC6ZGOY40mtexIBF+HMkjcGUAI51jJ4H0Om1WhaFgyoE1FN4FQwlF8gGGmuKMjm
         +H4XGN67QY82FzXLI7rB4t/6T5vW5tHbc6TZs18x5LGNdcLa69MT6G9IyTpmJ6lq+o6a
         pBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QUS1duImiuxRUZ48Ef5krHiYH/CmsP1C8hfnRFBWu6E=;
        fh=6ag/ii0LPO44+P4uPP7RGiD2cgLlEkp5iHZp9hsha54=;
        b=ROV842L7JQ96w73B5UuejbCW3HgtEMjc57PAFCaJBGU3kRMmAp3xgcL38nzfzbGOei
         nQSBeOLZKR8M1Kjo/70YOqIoyLRtrgpkXh4uDJryjaN865ptv2ASSmZe6ptDClUVAzzD
         nYtsZoChXS6ZcPX9JviYCzRrn1vJsYO2kJY4MMo/lNHBaQtATvnXFGf9GxG8hEqLtREt
         eLxff39rsHy3Dl5WoZoXzqY0M/G/UGQGXVWoGkkOFPe+IVrjLcTpEHA4Qq3e7jT5UDUG
         qQnPaHmnYpNCZfbvyqVgn1c+y1YbMZpR7kGXf2B5t4O673hm6dPtBFtYfi7pspxVc4Sz
         b+6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798465; x=1785403265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUS1duImiuxRUZ48Ef5krHiYH/CmsP1C8hfnRFBWu6E=;
        b=g/chcEIJ6/GuA081rNIAaKAaWX/CudeYHOxgArtcCJwkdcODlvQWpmc6AToa0FezFB
         c4Ww/SsHx2f7aIzZogx9iA46Il/dSKyEsoiMbglDvkb3erWvpix3+UIpa1fMsca9ACql
         8p02kztGDe3G5binL/egF7FcyOgO/RD2+PD8ueffzRXu6Bs8TETxxj2+TFVw7SUwGd9M
         bAY5PByaDoUgs3y84vKm9xSkd4DdfBimj60ERjE63BZ8fbDQSUgqtMxRXKIMNdoPU388
         nblSvNNqfdXi2OLmCzSOdhqT2uQwclp1bncG4vKEUJuV321S5AFRWGZK+KuZ1RGGTy7M
         fbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798465; x=1785403265;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QUS1duImiuxRUZ48Ef5krHiYH/CmsP1C8hfnRFBWu6E=;
        b=k9ARKJw3KkMKzhQkq65DiXYfoIRCOJdJxkMn8yQFHxlpHzk1B4z16glLUJ3dg/u3Ii
         TSuxmtj76suGIb1NpV7p/3QHY647Mf9gcId6QZrexxiMPgDnwJC6vAtp6ALEZFwDUmmG
         hJ+D4As/Zg+iWD6a9uYmaKDj5/rkgxFavN+yIG78uUTsv7820jXLyDxJdSgR7xQIfiME
         FgeTLbzW3hFg3GxnLw/rMDoReIz133VHVHjlb65q9zrEwvdW31nAa8tGMpQhmzS9by5j
         LDBdXsQU2FUaTaPaXMVQ4LHKp52xGRI2em3uJvEsjL5nk/lsBRo1+SW1vB3Ek0TOsacT
         a6lA==
X-Forwarded-Encrypted: i=1; AHgh+Rqp6sZaAxeCU7Sa4HhsTiNmcvlwPqsXgzD+J+np3r9OzkngyYPmfClB1DfWZ7yU8V1JMtpO+8dzxB6FzGWX@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIJB3mallDCdgD62nYlkSp6jj8yfVfGjM7NfZB337qs0LGiLK
	mrPBY0iFTfEKgtQes1qqs1oOcDpb682KIji37UgF8mUtsHkJpuIPkjyNuQFIH0tkCoI00tBqUuB
	2e0GXNm5sK40HWoPGbJiWA0gJn6tO2Bg=
X-Gm-Gg: AR+sD123YECaEnxqkN5WsUSsfuhop6detF4CQG1CdjHgftpQ3GP3XRYis92gT1Bjtdt
	HNnfNd+SS42aETY1kLGsHKc2DTd3BTrnWmGQTLH+l9fy3ka/WvUfJM+gZ8FTdqrHeO5R3E56IZV
	EBF+nWFI2GZx52B9Kif4mmGq45j0inkHZuuuV09BJkOFOvfC0SglM4tkRPiz7VehUXbIKeyaju7
	BW2mdm3sGRr1BUAlaXuuFQmK+5T3ToHNzE4dI9rKOUwsqO51awBHp39ZpR1EMY=
X-Received: by 2002:a05:6402:2c5:b0:698:a9fe:2eb3 with SMTP id
 4fb4d7f45d1cf-69f7473bb1emr481810a12.9.1784798464605; Thu, 23 Jul 2026
 02:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com> <20260722-fundort-zogen-kormoran-09fb867f1b59@brauner>
 <CAJfpegs9Mzx2bPTmWWzGWv7D2jF5Nspns-U6jf=KeAufiFMXyA@mail.gmail.com>
In-Reply-To: <CAJfpegs9Mzx2bPTmWWzGWv7D2jF5Nspns-U6jf=KeAufiFMXyA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jul 2026 11:20:51 +0200
X-Gm-Features: AUfX_mzGhC5ulgDl4H2_S8AB0-LW8RqyX4r61JB4nfZ8oT5YdWhv684RFp1OggQ
Message-ID: <CAOQ4uxhqmh47w46x0zhOzqJ54iiL0KDpuuAqr2oPyjm4AOgDYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

> > And the smaller details really show how inelegant this model is and why
> > Al and I have opposed it multiple times before. Scalar options are
> > modeled as symlinks and non-path options are dangling links whose
> > readlink still returns the value while for path options readlink returns
> > the option string but following the link jumps somewhere else entirely.
>
> Hey, this is was a prototype to show that this can do what Giuseppe
> needs.  Not with nicely polished interfaces.
>

I want to do a sidebar regarding "what Giuseppe needs".

As I wrote I am all for introspection of overlayfs layers, but I was never
fully convinced that getting an open fd was the correct API.

The starting point of the use case is a userspace daemon that wants
to reuse mounted erofs images, which are used as lower layers.

When considering a single daemon (e.g. composefs) this reuse
would be better done completely in userspace without kernel involvement.

The reason for a need for kernel UAPI for introspection of layers was
to allow cross daemon optimizations, so that containerd could reuse
erofs images mounted by composefs.

This optimization works under the assumption that the image file
or the image file hash is a unique identifier of the desired lower layer.

But what if composefs mounted the image with idmapping or some other
property?

And how many container runtimes are there out there?
Is it really worth the elaborate effort to provide introspection
to this level?

My intuition is that introspection should provide static information
like uuid/fsid/fhandle rather than an open fd.

I am willing to be convinced otherwise with the proper arguments.

Thanks,
Amir.
