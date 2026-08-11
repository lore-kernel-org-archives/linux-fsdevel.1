Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256F1F4631
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462965; cv=pass; b=O5PC5UCaa5kClc5pKepihF++d3iZVhtebk9z+oz00/5kuOIT3NN9B2qM/cLJwXBjRvr+340mcQKNKZKIs51EyRtDQcY+SEzHwADuX/vdITI+ui8flp/xtoeeeoJS88zb0gRXSsZZ+JAZ1nj9D5A1qaDPqgCMXaUfsk1mbF5CV60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462965; c=relaxed/simple;
	bh=WK32yOxbLjB3jonpeVMeBQOLae3OsMqNjNC0RLtddE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qw6xVWn+QFx2l7mkiUSZCHLiCmYijZkz/nCBqF44TswVDSzMbPknZO8lXNvblujHz4xJJq3xLPqDZBzkZyrGHc4P55zM8hmZ+4FXj6u+NtIX2xqdlAi47SqXHfpr1nXW8cjKIUgOZ/NdgkbezlQaaEZBJVmQJX6akrLman5528U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/vZT5Fl; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/vZT5Fl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cede6375caso119585ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 08:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786462963; cv=none;
        d=google.com; s=arc-20260327;
        b=oWpdYBe1ieqQtD6B8Lt14t6+1Bg4LtOo49K6FHPlU6P9nFaysTLWMHvITvkzC6hWvg
         NywiHC0cWGAtOCncvH/gBscLKfFNQwzg8RaPhO/oqbgretFXFvbFSZlvKNX+PM3VThAG
         wI7I6YcYh8qHQ1Ku2ZEgKL+ZtRuqoXFgr/fJn3k3r6hb3H2HxQR90XnMmza1l/xrx80/
         PqEIYqlkEqA7Kf2dU9PCd+xtXFMZmaNAlbMzlPSe30AmiE3aQqClZ0Tka7aurdZ3UV1F
         quNPiAAwfp09mjL2R3Ukk2z4W5O5Jx9l3uIZkaEHzMWuL5S+4L3A+EBretnzDQATru9P
         xXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67yVZg7Sclh/kMsuis6FMTvEKCWItPaYWqtUQHP9qvk=;
        fh=5HMLG50Pe8iWW6axQqnw8bVlzrItUQXdzho5MIZz87M=;
        b=Ko7ccGIwBYZcFnfo8aWq3FbtfZ1j324auBprNgm/gxoiwwdKPWSnnUsNZYPYvOB8WR
         SMtgUX/CpDnxNOAhuBrAHe4pxN0AuBEAAJwcEkiRWsdKTsziInn+r+WWXAlFZl+dMPPZ
         0+SV/P6jZxQHTEqeAsXV7zvD6CybNGur/LCG1ViZOPomcv6l9akZ9YW14SykD9WIQvKP
         uUED26ZyYcYSS2/Ni9vl6N7sJXQ3ZfGujjwi2uPnjPYjVzAq31JFCpbu4ZQM4oqwUgjA
         qD3oz/cBaFaLnYZ6wU9b6lDEiXTY3sqRno+hFWmLtBWE9SksMpzAnGe064LzaHSGaSv/
         vMkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786462963; x=1787067763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67yVZg7Sclh/kMsuis6FMTvEKCWItPaYWqtUQHP9qvk=;
        b=P/vZT5FlGeRzPydjx7H88Wt495KHomad8D0qpb2LeNzGd6hiJB7GHy5pZDLgzgD+xf
         Cfy4oCGY+pxleUs9ohfVRPjS9KjzR8Cl++268NzO5cESHhvmQ14HevsnEbP+IB+3I9TK
         kw3kq/cXzc40urXdS6Z5BxOIhSpEPqdi2PgUYKGU6haWqPXKHMvHgz0b1A/XEglBQW5K
         IJt7l/kssuI7w/ORgfyX006OYNWn+z4hwL1kl1W/yHdz8EGnv+1OwuM1VLyq30357JW5
         xmnJQIxI3csfCaxOgcWr4nCwPVVnyM6SdNtUmBqf9fWl9N4hdES9R0fI6hOppJ124n2E
         e8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462963; x=1787067763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67yVZg7Sclh/kMsuis6FMTvEKCWItPaYWqtUQHP9qvk=;
        b=RUOaya1Lw63Jc3LwvlN3mvrpm+XMZHrLk+Sne+AiauT7mcz69ZAtmXmfwcP7fW7GGy
         /OoGRFcdON69Paj8zvO2S1Vr3BNcFGCus0mOVgBXlv3VwHg17BvCugANHjFobwo5gNEJ
         awQJuAvz4lBSnRRh38bojQpr1c7/FeS0xJ5qHYW1RxTgKRctAf0Mww3LljqhJhZV9qLN
         ohO+0sQ4DpYjE3CCkYVAE9NqzWovLlZZ9Sd96TmhFfHIh6RUY9njkvc4SiSuohPM29sI
         6VPAqaF3GrBqh9PQ5AOC6WparO/R99rmsaEYksY5apJCVdfvIpljP6w80TGbzqbKZqop
         JLsw==
X-Forwarded-Encrypted: i=1; AHgh+Rrn67NxzT/nvcnD5/b836yk03Szx4Ru8yTBEPu39L9jkJT5ZjwtjKcU1hSVtu4RZaiKCo8awL/4zHiQ8c3F@vger.kernel.org
X-Gm-Message-State: AOJu0YwkELlc1ENVG6Th/qx6pGJ9JvkRMIH3tVCcyliwsNTi5j+4MZED
	VqkAhKwBAyBcaOrd5OwxthREIA74KYsVIh4Cnh18yrI3HRLmHfb4woJm4sw6NQ1kCu3mRIY6j1h
	hr2ehrEskxjg6v1mDkMGH39pJbnTM2lV+aLlhHwRl
X-Gm-Gg: AR+sD10mmV9oLhXx6EnfxWbLbcvfeglVGwvg10M4BBPEqkVW/qiLtZKmXx9X2bF5rVY
	BJMC6jobzl908k7+iAnDT8dlFxHfcqAhrQ8QK59yn0ZUJcCuJULpW7xIGMpOMZgQ31Cu7KrGORL
	garYAA7l0pk64eOe9t0vA9NvNI2w6LkJ7OPUeQSeTFCUOaWiB6KhO70l1/74GdOLXkbBxd/yLiV
	p58gF8Yt3jVEJIUcEK0Zx31fYUN9MquUDekwpPjy21C2OtlY5moYdDv/H/SNrYjnmeWliScKUi9
	x/NeOkkEBPloZF/BB5/7xUPA11YxbxwJthbfrIkuvASlAVV5Ecp2sFXIhTysq/LV4Qj4GVJzGjM
	IaHprCPutsqV6pPqOV+ddHzrs2DdLa1k=
X-Received: by 2002:a17:903:4b2b:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d3171a56dfmr5502005ad.2.1786462962320; Tue, 11 Aug 2026
 08:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260810204118.1981755-3-morbo@google.com>
 <202608101713.34DEA00E9D@keescook>
In-Reply-To: <202608101713.34DEA00E9D@keescook>
From: Jann Horn <jannh@google.com>
Date: Tue, 11 Aug 2026 17:42:05 +0200
X-Gm-Features: AUfX_mxNDlgHpFyI6ONdIW4H6ADGwKcPUAc6snIFj_-8RLhUKE1_F9ggNW9ZDT0
Message-ID: <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> > +static void fdtable_test_alloc(struct kunit *test)
> > +{
> > +     struct fdtable *fdt;
> > +     unsigned int slots =3D 64;
> > +
> > +     fdt =3D alloc_fdtable(slots);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> > +
> > +     /* Check that max_fds is set correctly and is >=3D slots */
> > +     KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> > +
> > +     /* Check that fd is allocated */
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
>
> Nice to add these tests! Can you add one for each of the conditionals
> in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-up
> logic, etc)?

Wouldn't tests for stuff like the rounding-up logic get into
implementation details too much, and break if implementation choices
change?
