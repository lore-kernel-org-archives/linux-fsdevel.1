Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE24582EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437427; cv=pass; b=syNrFlOkcf+I40gtf/g41sCY9mR2p2mwDlp7v4KealpFI3bd7EVJemrZQX/TRyJtMKBiUVN7i8G2/qvNGGmFcrxPDhUwsjyqm3qx1AXxxLrOp0MgwzuzJNq9Kj9AaxX0qclyae7/axTWkkT3+mGbiPRSz8yUosJsR+Gb3yzZLfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437427; c=relaxed/simple;
	bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMKkjmn74GX1CcHPuTiFx74ayd9Ccw2mixkqT/Z/O0uXoU63au5BbdN5j/c2XVCT3OH5mxWnpoDT+P7alR1COHEEiSA/PEIH+4D/TYrVwYoWvh0+SPKwrJzyKZGDvRvFHkT7Loo1SZfPEZguMEvCUJN4UokhdeEQ4MGCzRHpLoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Ej7zYc; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Ej7zYc"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso169228fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 11:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785437425; cv=none;
        d=google.com; s=arc-20260327;
        b=KOneu82mAw/51WjRIL1ufFYxebpsN2OR3tlcR3vO3wDFDeXNHaU1zoG0TC/2QfsW3B
         22tq5mW/1kEABGeTnxpN/ySQ4zQT0xRQVdV79geTXmeYQ3pbj09P8z0IGeBNlEBJcImo
         bXdWhBuoqNLQqwIrtX1zIB3s4WSHRyqpPWoYBODgxTwME7cXtVUuN1+2qy+P3Xhf20yp
         zM8sJAi6etVAuUMF7J0txRkc315aOusbJ1aX1xjT0eUM0Xe8cHloYtv9kjA61ax9JHMK
         bGS0GVzbRPMs+qEz30ldgDPQMOMcnLEOJ0FbaxYv2GWGRwszVRsBI0ISfKEyFdDkYLnR
         bRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        fh=P+xgUb9s14HDLkPIaucXULX61hZq+CXnX6txsei3xKI=;
        b=SIRadTrGkZh+hzNziRgazj1pvAVFvGQiXguNthuDz37eH7FndwuYlPl/SoSCVoPLOt
         tgil8ZAmUPObYPEmqmA6EdZzmt07cfpmKaWiqIHu2+vmezPB3zL5O5qy3KsO/Wc+X0jS
         CZ+kyAqZQPTwg+iw8WKw00PxtB1vaxwCi/vnR7EyoT0YCCA4Z5HZZc5S/yO1SbdnocxW
         CrcO5B7JZeJPbdl/rw1asYSkKfMyJLJKUxmoceGt7TuDG+0H7Ung/jZvYHhtctOAyUJW
         HfqsJtWNtovERveIXW05JzMPBHlaeQlDTXYogvHxjtS8jMCI0R8Eh2SXzfiiPFXDvdoj
         XPsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437425; x=1786042225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=f8Ej7zYcREBo1Ix7zZLzyYMQJtQKmTw4vQxRTwvgZZ4l45bRzkXbQePryCxlA6Gpym
         usN/hO1GLpIZSxskRSKwpaR8otVXoEkHEd3JjzWhJL3aLkcfslWeD48SDFTXsi0PqLKN
         dhnwpfW4BT+GatS98gLfA+20Qdb3t0C5y0NDuNNK8ecekSSTGBi7r+BZol9czngbZhNW
         1ASfRJ8CxI4ptIlM4fLxkEwKq3qaEaT3qx1+FkZrY4QBhxQr06m33FACAdtcWh2LVMcO
         KAsDdfDivuX3+EnVudaXUvGbdN6y1GS41aw+5dGCImrGPpIx0wz3azmyE2bpaxUfXkie
         M4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437425; x=1786042225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=RRI05aVrnZpafFYZAffZOe0eVNl+67xcxLnvUbNO+78tlmDKHt363wlS49ZluB2QH+
         +G07VJO8iOCYZpcctXdFG5AVR2+YKDomeJk3jTCbItOtZXsfJuyR7FUz3G8L+sDvxqjV
         VePx745tZ9FPPGOQsLY3nKV+wxA2Z9tznpO6TQd+l8yee22ATnzj72+K+l7QU7Id52vN
         Lm3zHafLlQOaRTv9Nkr/DsliO4Aylpxu1EVdhSmQWxafXWbkCawSzwLGAopEFwJItPhF
         a8Ju/GLpNv28jYILJq9AESig6Ki3q/u3OJmtVxQk8E6u77rtRT6ka4JkZrYdyFmBhYv+
         SP3A==
X-Forwarded-Encrypted: i=1; AHgh+Rr8GCYU+Y3nm36q1EdduRUhwRGC8oH5liiwGWXlduE54iVlCXJaqV5II1BbkOA4eCYG/LguRiZTkidyXYc7@vger.kernel.org
X-Gm-Message-State: AOJu0YykytS+e8Dp1YEJ3lgumCTy72fCZ+ZFiWkgyL5+8CPcgXcHHypo
	fEIL1qYOdYS3cYQllA1IYPe0S3T5r0EVi++mLMOc6HBxvbyXObruyKjUyywqf8kNcrNqASbfJW6
	OOc4od3gfhNlOBmWIFnjYiDfGNMH/T4g=
X-Gm-Gg: AR+sD100PEZHKcLFMVrJl7ssXvUDJ8Caq1LR4d7oErRilr9FOwrnJ+eafCkn9+jfYLA
	SfL2b9TGkeKARGOaOQO5AnO76oPX2D3tpBtk8DfIWzUFxIdHwsMNdag06R96TfP2N7XVNZlSQKy
	qHtc+HKUwByk3EQOXeH2476oScRqSRBKXkcHFeubbV+c2xI5Rf2tRqxz7A85A8UReu/J4/+mTq8
	NNrGKcbpHElZQPvTyol35bi7J+CrNtXXWkTUx2qzY5BKtvgL+MnyaT4tF1PGjhGU9T7Kerf8uE1
	ifSFVpY52JgDme/ZP7S+gnmwcoeoT8cyUzjpkIyFn6wN
X-Received: by 2002:a05:6870:8a29:b0:456:b249:700c with SMTP id
 586e51a60fabf-458c0e1c200mr2600508fac.19.1785437424719; Thu, 30 Jul 2026
 11:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net> <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 14:50:13 -0400
X-Gm-Features: AUfX_mw-sWflnKZtGKmCqYRU0sb3jjE3qrtGy_CKaW2nfsOdhimFd1pr1NGG468
Message-ID: <CAEjxPJ47CTKXxx_DvSbuO5F28T-eNPnQQ+Gm_-qaAeb6R3wPfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:10=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
