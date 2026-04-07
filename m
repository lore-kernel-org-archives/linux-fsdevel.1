Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB3363C61
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593315; cv=pass; b=dkMlEkQ9KL/4almHWtw6IesBdC9jK0bC1xuN82JjSDHuC9jMoouMJwzMR+KLWQspmD97CZv8t22ep3St/aR0fBSAjVgC8RYXRdOO3Niob5PRXK37GadeBRQzcW0gJz6z035zfv7mMRhGg7YJ4UEhEBuwz/vMC29Iqy1XPbwvp1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593315; c=relaxed/simple;
	bh=s8r+Vr1ig1OhurHXWjJkYiIRQ8nvrWmPw/5iPQbFVX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RClwzeu5Dj+J/zkrh6UQtbs4y9X5lKFMEyCXqsXvXk4BAPIVM11n9vhxzszAOT7yPj/Z9zJhDFwYOC4Kp0RJBTTLE3kEjqCXVhKoScL6wQGt+7w2O/VAGEHdAQpCrPBpEwvBcQ0rZ/YdqVsI9H/YA6A2yuhR1JukkiXjMXCvk1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IC2Mf/76; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IC2Mf/76"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so2393194b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593312; cv=none;
        d=google.com; s=arc-20240605;
        b=jOWtYKZZ2zgsi4oFqD4kle8gNo1HWQgwZiBDL1xmWgD5ql5JMt4GuLvEWiIqgXXeyp
         ajfiMsmxo2CW7HHGViSUR5FD+NEX9LsM9OeCOFg7RfWUecHNwDEBLXnHYPuKrayDtRxd
         CyDU/5eRr/eV3MoamsHwDnpBWpY7Gs6GEQZPmsu5L+UILDUU6C2uT7QmVLy1HniabhSu
         NEpFhFRRpY+E+Pi7muJib0VEH/hf2F2jVFpFikJ2bJVAsoSRE0yTNUclL7pfLoSe4ybG
         18JHMA1JmCjg05NL0suJ9r9kZLxt/ZA8d58xe5c960xICVPD57y0miDhB830F35iM6n3
         eLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        fh=qPmjtyB71nA/0OnMCSQ7dNp/W777Z8g9WbJlEuyX69A=;
        b=CggeJCs9gsAdKUEOQ9Tj4C+IEcckMMzYLLEYsUxBvsMb06JupUoxUOovmDOAe4iu0R
         9XhXcJ8Xb+44gNIeDnVzbNuunAWYj7fNxKTSY9ikQYQFEIULXfovsRHN61gNLRy/6we0
         3eHUFkwzWJYk1uRmNJv3pcoxZ3FjX1sn9syleV3z7uqB2ewzlZaGkVmEJ8EnMlODD76V
         QLtfD8BNtgwXtGArabJDXTGgWP5qC96z95uFyDdG/80r79I6Yo5k1QNMYD8048RWvIBU
         HD/XK/tGpu4RFRFjMuksMwtwSBEhXG75m9k1dOYjh08QuiGYxu8Bno4+JhA/ujeTnbf4
         Fv4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775593312; x=1776198112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        b=IC2Mf/76v9d/4+Vh6KzdO1wOwI2ty3/6KLd9aw31Jtecua/uQWbW5+nbP4siULJXMu
         6WeZ1BfHZ68bJ22X9VtLypqRXjl5TwOS05KNkt2SbxiZchp30K2/GorVjvcNyKmbIPU9
         nnnIuWJeqVhuZJmechP9u8OQX238BxxuBGR8k+bJosBBkwvg1eOOAIWdz02ujgKD2EnO
         QXSsuX0SyQ2T+plZugFMZaXTvgf8v3+ULApDpbgmCr/IcrTr3eslMgmePJRq0n+iZO0c
         pqfSpiQEmQlmb0/EhCC8SEAUleZLDhRSmcB0Exsg60oNRTQyjVLuIEgm4TsxM8845Nuf
         ccvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593312; x=1776198112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        b=JW3M3khBJ3or9gvpTnPvQPzd82JOEKCKmVab9KDGP+3jEAVoBHAR/NjwyAvk2JxPA1
         12WJroAkFanqKsE27GNuqnKoDyAnluImVtvmWnLLZZ2JOyqAoQUtyimfEngjGi+EL5DI
         uD2IvH/DK01eqp4r1sk73lb8sk+CM5sgmC8YvCuI9xCkjO5IveAnI/pucgAjxjiztND6
         BD9fgwFpYXMbiE+Sgopw+e5WzFjvjh5J8JxJieUpwWFrK88AMblVbporpnTEAFklF6x0
         ZElUkX/VBGPCA/k6sxCUkhwHqxTOAY/4oiU5tmV60O34EjWwCr2nm/fFMllQJwyW72Yq
         V9+g==
X-Forwarded-Encrypted: i=1; AJvYcCWJar+bnJ0Sjxq/Jc7VAG6NP/Bpy36awJM4RagBLo87qOLNLpjya1q6oNjFmj/0KutvtLZs0lVUakNEqXnI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8InXDApyCYzy289tmW1fgk81kNKmBaqhsS0oWndSEwHmaTghe
	qn0/vUPOrYVeCedi5hJKk/GjQp/9Nnxk3wc+gOKzwJO0r7bINqJggf+31DGcFwy8zrzhIlKhoUK
	nCpSdvsz0g7sLgmgG/jlPajyzWhtzCjt8HwmI1IGx
X-Gm-Gg: AeBDietx2GLjuQe1LIFaVG5bXRSOPP7+a8dgHXQpV+NxZs3YZABulWr9TIs44uregDG
	lIzazEx1rJsUK8ILnKKaXNJb/bcq5MCh5MjWObcVp09Qwu6gFJtbjfqAh2uFWPzdz/pRU+Coagu
	zmryqVwCeDBxRc9gB4AdfIOI2IOGQYN/ctOEI0qCKUWwiKGKEfUK72JVXzITf9sFw0yN+0ZsiV0
	euDvPC95Mi9H8sWb3F6895RNx2kPs2Hg+p7ww9/4xgG0OAbhqeeUKdvPsGmDGuX8ijMt+qCmkOI
	4svJkVRYpkKi83a0Ig==
X-Received: by 2002:a05:6a00:1a89:b0:81f:4a36:1c7c with SMTP id
 d2e1a72fcca58-82d0da74ce9mr18411507b3a.23.1775593312517; Tue, 07 Apr 2026
 13:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com> <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
In-Reply-To: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 16:21:40 -0400
X-Gm-Features: AQROBzC_mkg1V6Olu64dm2ucorBxgS86oz5XW-KOWVbdzobSFYHPihrj_73P3oU
Message-ID: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > The existing SELinux security model for overlayfs is to allow acces=
s if
> > > > the current task is able to access the top level file (the "user" f=
ile)
> > > > and the mounter's credentials are sufficient to access the lower
> > > > level file (the "backing" file).  Unfortunately, the current code d=
oes
> > > > not properly enforce these access controls for both mmap() and mpro=
tect()
> > > > operations on overlayfs filesystems.
> > > >
> > > > This patch makes use of the newly created security_mmap_backing_fil=
e()
> > > > LSM hook to provide the missing backing file enforcement for mmap()
> > > > operations, and leverages the backing file API and new LSM blob to
> > > > provide the necessary information to properly enforce the mprotect(=
)
> > > > access controls.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Do you have tests for these changes showing the before and after (i.e=
.
> > > failing without your patches, passing with them)? I tried running an
> > > earlier set from Ondrej but they failed.
> >
> > A few months ago I sent you and Ondrej some feedback on those early
> > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > I've been using a hacked up combination of the existing tests, some of
> > Ondrej's additions, and an additional debug/test patch to ensure the
> > labeling is correct.  It's far from ideal, but I didn't invest time in
> > test development as I assumed Ondrej would continue his efforts there
> > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > on getting a solution as soon as possible for obvious reasons.
>
> Ok, I'm happy to look at even unpolished tests - just want something I
> can use to exercise the before and after states.

Hopefully Ondrej can provide an updated patch.

--=20
paul-moore.com
