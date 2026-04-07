Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D7221DB3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572515; cv=pass; b=SAqZAmmI73EQCY0S+8ek5id+FmLtQHDss2S/SCaI13BDUiU/nnBr8MH20GtrkMjNQJVOJqGZWbxVrcJqCLeILUzWHbAa3pUXfxZH5OTu9ztJyw/K5F1uiw4eugV1FnN/GITwqp04VdCsHEaKbLOz36ehp0jdYYwPewyGgtKTQ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572515; c=relaxed/simple;
	bh=52zpGg3kueHgGet8IztKdLA8+tZp4VM8MiDQmi08+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4/9QTWfRgiGfO+50ogF7Yik0hFDQUwK2nzwNNBkmDvbFteOSudhhZw+1iAgTK3Js3yprgz5HHyTX7pIy3e/O6h6SCkNFtp5sM349XldimK9UekZMRNtqo0r+5fnPE9iT9JzcZLkAVyUYcote1fDk9bWuA7YnW2OsC712GWC07w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MSeCwIrQ; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MSeCwIrQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1802421a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 07:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775572512; cv=none;
        d=google.com; s=arc-20240605;
        b=CmsD91fHL8kp0YEXN1yazoozH0TYZRovOE99LKTvYKAYM95uzncQihAyfd+xO8+KPn
         26PZApCvvQbVE487Mh1ZZ3uImRL1uXPh4c7SsPgLMfpSsRLPIqsjB6ev76Me5w+iExUp
         D4tvBFHroBdtqUd1Kto1AuQz69MhrJsUEA1eSketBnZdHupFDx619AUB6cRDHJi9p9FR
         j7340a9fd6YVa73ml7ngeTlOVn3ZYv5KLaWsJG8wIWyqwfJNMY+UeB9n7MnpLIgE7WUr
         1MV1BMJlZI+RTaXW2Uw2l7xGN48fQDbQlD9uwBl7XqtMDxXeoNLNS3niY8PwyJI94uAM
         88VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        fh=c4ayhAviAK6bKBNAYHmyXHaW8JjdeuT1zYA5lgPEkWw=;
        b=PaODX3L4zJp7ac8zHfame9oyZrZ2ybK3uCiiDjuaFLAnfVweOMuD/PNVgsHvj6/caJ
         AGxFtD9a8ViVHNVjnuUHmCcKXfbqg7UFHC2Yne0zh1IZKxYRjirpZ28HCdioBtdsEOu8
         qtfZb/jUfeujAaZu+wnQcrhSHVxbs/ze7a4rflv5Ll1RaOtK0+qhnOkRp5YRXJOFL4ie
         uhKRi0CYqIRwaakRSQSJBgSe4TNIMBQoO4c8uk0V3p4O1/I33NoQ4jjE9lpIAHsLJMi4
         sKM2e7xsN4J/qMHVNxHhTXn24oG1zt3j9tHuGDmxXTeuR4BrhtlKJDX8wZJ4tR4XdtZn
         nJMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775572512; x=1776177312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=MSeCwIrQe235ez7W8m6HlUnnYkAayZ4Ym0rsusDeGgjvysabx79GAswgymvMDwdX15
         FZci+n28iUiJBkB94aYRm7cQN12xS5bQ2IvJ7vp9ZFzi01QrgKVQbOKHprEKQycHOx8g
         SwVpNT39z5mwh+sxkYl8XfXHIQ9jVIlGYCnWPXnZEZpiWl4+pK++qko+6KngzKrbFYmN
         zgQHd4/KTK9qCjAsNh4izeax1jtfpXnjJn6T9gERrt5c5odoNSP2z1QDpX+Z7Erj5g4t
         g4zNjphNUV2pniRnLFMWEo9qP5FZzGWUsKuGfgyxQNrK71fbqKDP8i8JNOaOfLepmYl+
         xAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572512; x=1776177312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=WwBhXTwRSRP1xS0dquFDKKX8wxQ0bg2RJTl0JF81MHHjPLbVgYD2ilO7C8laeCkyYG
         RPJCFDEF5KffFUQAuEpy3GiIhffjebRbMfTHt1Rbc2+8ToMI5coRyIDX4gdZGWBFwfI9
         mgIX0hOruLafrQYd4/XAKPvn334ZajNUi3UI6PhspF8JGQDEqDgh3QNXK1Vx7g3GHK7m
         szeyuG3uEFnNMlu6evxm4Qp8BgtxTLdvu8AaeApvlyBVr7/y0tn94xyMFGPOjpMzdQot
         cgHxVj1nqY3E/o7XWlJyFyA5ZmBw/WV8q0c2sX3VjyTUnWWPsJ+7wvLWx3VduHuUhMt6
         clSA==
X-Forwarded-Encrypted: i=1; AJvYcCUHgyTntHd3U9VVlkLd3iColUd6wMMLsFd9enHPzkRuf+RkCyf4wrQpOV8Ik557qxwoSRMq1dHfoPZ5lOQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwrPqAP53+G4NKiZ9Ca1usLNJAgLcN03n1+PCvR/YvA113coi
	gjVvsUA0c4+ibi5itllBjgVwzVJMpoqMVdMC6ScnmnZd8tSk8/o+1DV9t/Xe18v+eu1SFjr2RNa
	xDlvQiJM9JQ2B5uS0vRIAxW2EKve8XmgypufvmT2h
X-Gm-Gg: AeBDieva7z4EFpZAvi2H3UsxTJZe4ANUJkVGpmcwTAKh31I0oV2LcMhLO8SJz/3Bmkd
	sbFwVKU2ChSaWquJRS5BPmqNG3zCJjT1DDnlbj2tvMDj6/c73pUfPYKiblv4BD3lewyabQl9+OH
	ocSURR6nggQ71iJPDZdKXk8p1Y/LrAORFq4FF+AEHZI4E8UKIsgu+dPvcAXsz4wqLUHwRnj26w6
	OYl0YDL72Mbj/n/ZGL82qTFX+baGRUmLSVMQn0qd0N6CAPVSIMCIVnIPpSUQUvx8MRZLqaiAFIS
	2CGqaRQ=
X-Received: by 2002:a05:6a20:a91f:b0:39f:75a6:16e3 with SMTP id
 adf61e73a8af0-39f75a642ddmr6186836637.2.1775572512468; Tue, 07 Apr 2026
 07:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 10:35:00 -0400
X-Gm-Features: AQROBzCbJor8xEV12qkCxYwq58fXkfkjQP4svTBOSHpDEN5glYblz9lJ5v7xffk
Message-ID: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
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

On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing SELinux security model for overlayfs is to allow access if
> > the current task is able to access the top level file (the "user" file)
> > and the mounter's credentials are sufficient to access the lower
> > level file (the "backing" file).  Unfortunately, the current code does
> > not properly enforce these access controls for both mmap() and mprotect=
()
> > operations on overlayfs filesystems.
> >
> > This patch makes use of the newly created security_mmap_backing_file()
> > LSM hook to provide the missing backing file enforcement for mmap()
> > operations, and leverages the backing file API and new LSM blob to
> > provide the necessary information to properly enforce the mprotect()
> > access controls.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Do you have tests for these changes showing the before and after (i.e.
> failing without your patches, passing with them)? I tried running an
> earlier set from Ondrej but they failed.

A few months ago I sent you and Ondrej some feedback on those early
tests from Ondrej, but yes, I also had problems with Ondrej's tests.
I've been using a hacked up combination of the existing tests, some of
Ondrej's additions, and an additional debug/test patch to ensure the
labeling is correct.  It's far from ideal, but I didn't invest time in
test development as I assumed Ondrej would continue his efforts there
(unfortunately it doesn't appear that he has?), and I wanted to focus
on getting a solution as soon as possible for obvious reasons.

--=20
paul-moore.com
