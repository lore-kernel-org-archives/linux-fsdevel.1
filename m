Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F812459E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480386; cv=none; b=UBlAi93MMyfUeKcE0zxDgZmOz1dUdBw3hWsR82wptJOad6ZvwvcZb6Rau+QS65tY0DxYe4kbgwgfhSPjqz13cXk1tgRqRLoGieBpouF2do5joOfcJrib5lQZCMEhkZzFg2zaBrLDC9LpkBALlE1BYH5TVlBiChh0Zxkp8c+M7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480386; c=relaxed/simple;
	bh=FSRpAu+WACFb8hxEvRIm00KNoLoh5efbcy2RSnsDEb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e58+W8dksTYurdNrgzpjxBx50Z3gZPG0qPLaidKQOxFs+Qbu4MLYpGJjJHo7zKzC44zl7AUj8oG31o2J+0tq/NL0OpYFqViJsBX65g+2HpymQf9O46XT3PSvwhMG1fkf3stN8i+kU5xsynzEGi/PoPuL3Wd4nVrbca7JvAGQZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL4LeivT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL4LeivT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4924593f45dso12753705e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782480380; x=1783085180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Voq7hjuwUidlNWLMzAJPrs1yx3BiWD0UlJWeQWkFWrE=;
        b=OL4LeivTsp/+BLlVzZuZeZDu2iIrgW15xyb6Td3B+r3PqGKesVCZvYI8I33xLwDkBo
         fdWtTNI5kwAr37fPPt+AJQ4eP6RSFi9UF87GKHbZK00n9QZ+SQ9YEHE07JpPAFUmKaQY
         ZSxEEqIf+fLuuBJwKFLMjiftLrBLiqdLnv+mPGB0GMCsvpB3fl2QzwCn5DGDQ0apYjdO
         TnD2dRtGJl+fv9++XaonuT/IYvGkr+sUo+DKGcShWzlGb3VaeQX+x0Vh4cXBZ5o+I/wT
         ZlXpKOk2KdwUNDwdiPn85ztDQLhz1TsNnXozesW/0Ydgky1yZ18hzigEk7+M2qJ2CYDD
         wSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782480380; x=1783085180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Voq7hjuwUidlNWLMzAJPrs1yx3BiWD0UlJWeQWkFWrE=;
        b=bf04SJucXDI4clzUf1tvQeYmVzEN6tbrTrgqtTL9lSIaMj0pGcH/qwdqNTf/+8GtF5
         zeWOFmApP1/0KQjrNZnHdO7EHGOZtuScnGkLx6p07q3nWY6gwzNjjokUyLyiANabYdpj
         Ka5FiOwXU9TS41xwNZ3coBVqqf/dZga+9wIBiegFwCdxdDY/3pwwyD/u6STZOc61aZlq
         lWJLARwwm8QL0vnrieZy2L5cULxjQ8vwCmZHuzGn9rgYdzr7mDqumMzAkPYtrv4Ha4CY
         aU/QQq2jbdIveNlThdxGp00hSlALA3h76+korBPp1XD2/soML5hrVp019LALsH6TNMI4
         t/sg==
X-Forwarded-Encrypted: i=1; AFNElJ+KLYeXVDh61evcgrIR+VplN9WilolsvnkUVfyJnHnnJW0G2eKhyYFI/Jt3iGSOFU+ZN3BRJ29gRpkmC+Q3@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJJrI9ap7JgkZzn1DbtWmIO5AhN1n6925ryjme2H2qHA36Ewc
	mdi4klbE2nCrGh2J+5hlGrD9n06BA4hKxPupeTaYN/t5WXomNKeg68V1
X-Gm-Gg: AfdE7cmjwPX3KpdKGW8QpLudVNzrzvnV4+ZZ0scXe0ErGnKjTYElkbj4ciM+76Cl55D
	bJ8w7TbZ/miAEA1+9jw1bK2uIG2qbNZ9mxxeu6LTxDV6xVqCQj0ppPIzUZ/u5kMtTcZxDzVdPsi
	1uY3M/dqStvjkWFgVovcE+0lmZ0z/o4kj4EeW0jPzl5NFVruPMkXL+jMu9qnRGBe3IMTI8g0/kP
	2bGYJJzBlqY2bLi7oc47VFBbxf1GUBo9se8cCpGQ2Allg8oT8f8d6KpbO2az3+2At19uTYJcTAP
	fc3SjwaElzKVGNPcUbGehz1DZaDSVvASNgiLCnClia6KmGzk9hAAvZTZy+/ngsRu5RckQjBGa1X
	wb662WYhVFGP9KZLwB56rB/7TbXzMdZs2AJgO4d7uTiKjLL3IjA3GlTN1isWCU4Gajmlw0iewR4
	XaA2+/+GJJcZiMiUAKlssytN3vFVziE/qV5/21uZlVi2hEUUEFHw==
X-Received: by 2002:a05:600c:8a0a:20b0:492:4c2e:9610 with SMTP id 5b1f17b1804b1-4926684a979mr76376465e9.11.1782480380120;
        Fri, 26 Jun 2026 06:26:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268f700c0sm85859525e9.0.2026.06.26.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:26:19 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:26:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, John Ericson
 <mail@johnericson.me>, Farid Zakaria <farid.m.zakaria@gmail.com>, Jan Kara
 <jack@suse.cz>, Kees Cook <kees@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, shuah@kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <20260626142616.5232c61e@pumpkin>
In-Reply-To: <CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
	<sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
	<CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
	<24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
	<20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
	<CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 14:39:22 +0200
Jann Horn <jannh@google.com> wrote:

> On Thu, Jun 25, 2026 at 10:50=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > The arguments I have heard from various people so far are:
> >
> > (1) Userspace would be able to clone a random chroot to /woot and run a
> >     binary from it without having to set up a complicated sandbox
> >     effectively making dynamically linked binaries more like static
> >     binaries in a sense.
> >
> > (2) Quote:
> >     "If you debootstrap/dnf a chroot to some location in your
> >     home dir and try to run a binary from it, that it tries to load the
> >     libraries from your /usr is a pretty unintuitive and not at all
> >     useful behavior."
> >
> > (3) Quote:
> >     "[Various remote execution things run in locked down containers that
> >     disable userns, which makes the sandbox impossible and hence our
> >     builds wouldn't work there." =20
>=20
> FWIW I think someone also mentioned to me that it would make things
> easier for them if they could build a piece of software in one
> environment and then bundle it up with all required libraries and such
> and run it in a very different environment, without
> container/sandboxing stuff and without static linking. But I guess
> that's kinda niche.

The problem with 'ship the shared libraries with the application' is
that you get all the problems of static linking.
If there is a bug in the library code you can't fix it without getting the
3rd party to rebuild their application package.
If the bug is in a system shared library updating the system libraries
fixes the bug.
Now this does require that the writers of shared libraries maintain
backwards compatibility and that the 'system' provides the required updates.

I remember a long time ago the company I worked for shipped a system where
the libc.so the linker found was actually an archive library one of whose
members was a shared library.
So some functions were dynamically loaded and others static.
There was a bug in one of the static functions (IIRC it corrupted the utmp
file), once located and fixed the 3rd party had to be persuaded to rebuild
and re-release their product.
(It has to be said that anyone with half a brain would have realised that
because libc was split for compatibility reasons, statically linking this
particular function was actually stupid.)

	David
