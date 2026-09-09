Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033DE3C3458
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983368; cv=pass; b=qA9u9YZEt/FscztXpJ8kclxY2tGCZ8gZB3ecaxPbeuCcr8lMLHiJR//6C/ALoeForvl1gXh0mJ/EhoFDqo2+eFr/aZAQoQ1SsUHnYGeRKjmta/nksC7qDBvNaUP0Dnyk+qARcD3qW3rCMS67Rgn/kmk7b7H6ON9cjZWxmriALMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983368; c=relaxed/simple;
	bh=i63kkYRN+s0Z6WIOGfVRLoULhk9JW5XKXKE6rv83tEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJ/X2GZ4DjMZ6Zl3y5KPwNT69XqfrPz7G4TVAVrtSJpycm/0Exj6rnA8pJhmFGPG1aJ1DzneK3k+mCsgAZY8ve0QuBbBHLhMqlWhP7wie19VX5cB4uY5LhGIf8pFnCY7jy+cFp2c8SBh8W7ZbNL4VbWsn04Xw97PT4qd6YpZW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vy+DOp/v; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vy+DOp/v"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso8560383a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 12:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788983365; cv=none;
        d=google.com; s=arc-20260327;
        b=Bw1m+vxXoSgrpkQxT6+2tQgLBTZ7K1bHzLnDqdyeIHUj9LMPUzUcBuKOSHVNjZEF30
         PApNETqy2NZXY583mCfFqQAa38IU1mV4t08W0WOJYiC2r+zr4yRC5R0ObdbqL7E0VOT3
         /Awl6e5CIbWG11Tw1kFs6kNxOqOyiHT0ZHTRSi/cYhUCXNWl2SxIdf5w5QFD7M378Nfl
         7QmcMcfcD3YwgDq6QBNdnZG7fr7oozaZNRNQAXzuF14Nqf7Ldsp8GDKsVBhxQBUKxArn
         loeTlQ/4mnqpZcWYO1uHESnKeAVNQ36+b8jn7YfMfFfNf9Eeb9j7tWMhd/LeP7sgDasJ
         KvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxHsThRV7xoUza64gH6LQVWpwNMtliqmldDr2tNl4fI=;
        fh=aljme77Xt8XGdjtqrS9ZKKFblATM2glCO1qBnE0eN6k=;
        b=D56bjIuQzXZWr5+8sKSVtlDP4PI4NAfFtIxZ/ImAmhpZx0nQsdnzs2vrWCQ2aexm/n
         XZLnvylWDvjXfc46KFGcAIbhdhS10krI/hTId/rQhSCjPuUD8y5CGxUoJ3dCpbbWyQ51
         xdAX5URkGI6274ybVvbdtVJo+/xNED4lX8d3LhY94xCLAbqDte82PrpLV4O0qdIZEOTS
         SFSms6mldoBtq3q5kR3O3MxWrAe2GOpJvzm3P28BX36I2RkzGd+pFgpGzYv7LZCAgP1R
         vGc6awNylSFOzWx+E25Sb8hk9/CzKuW3a19NTU9ZKHfB1/Ve/HjovPl68O6yOG0B/Dom
         HJcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788983365; x=1789588165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxHsThRV7xoUza64gH6LQVWpwNMtliqmldDr2tNl4fI=;
        b=Vy+DOp/vjEHIbXQvjo4ifi2hdshUzJe4H+hOiJozAuGmTIXFFEsLYZRo7d6DypDbcM
         DOSOosKTICVVCMj3zZunPcijPljaagq2pSorME79SLUPNOFpLZqBBqGAZL//YaHBKVcg
         DSa0KY4WeidcW18GK61Ke/LJHlFmoIVDLKqIZq+qF032JAK33h/ORbBnRh86A/+CkxGE
         WjTHooB51REVgbYEGRyE73+hks0wDV52Fgi6rAA08BctzeJIYvptI5N3Ohlkp5KcrBO5
         jLz6x7m952NTwkbTm3rDHWojA6HryvMjNkk6+Fbyl5kpo+54WhsJ8aXJRLkgNlvUGdQ5
         I9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983365; x=1789588165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxHsThRV7xoUza64gH6LQVWpwNMtliqmldDr2tNl4fI=;
        b=PBzi2lbB2r8HOdh3Bh98BPz67vS2fBczYg664DM7ocpxSVsfeOhSSq5aYa8y2g0nD5
         3hGJ/74kgmZDioIG921dQ9yU1XqH/yuX8fAVCMmVFOoPKqNmEGLogwXDHgnIWIYVGjOm
         vK+DUxl9L+po53pZzeICqv3ehvLFNVRS222PuN5wcmTX/6OJOFg5nrDUmv/CffJCsLT5
         ZTBND9UIsSVJR4VEuL+PhFeWtlVm9cR4TXog6fn1vezD+YydSW3G+b1sH/h3q3kP8eAf
         bXb229FoF9xy7PyVTASWqOmV/AFi6Jk6f6REDboA/WX5Nksn06EF78NSApGn0PJqFqU0
         pQXg==
X-Forwarded-Encrypted: i=1; AKwUvBx+8xjJmDVp+83Uttx/YQ1PjXngFcsZUcrgsGHT7KAvgFxC9Xhi+VLUMBzRAIw1yguBQ3FaH+9Bjyojv/gs@vger.kernel.org
X-Gm-Message-State: AFuF++l274JNb2llP02QE1ocoHpUeXZul1pgpukXwkpotVGPgphXbeaw
	Fq2h4GI3KAHMaYde1RBIQbfNnrU7z2xHMvnea0D0Xajgcz/KLDxwCYSlRodCO+8lDGB7XeEuDZj
	3wWWcPuL1v6LgydC3UTl+sLVApI3wy3825sez30ga
X-Gm-Gg: AYBFou19RHukUuQ6ZYmDV7gubYh63npCV776wBeOhLiZujTuTv0htrWfOkHpl8+j5+v
	P/+wLbzJnHDakrKg0sMnRX5YPDvrD1WL8xnGqH2wd11cl7umhKWgTNBzIV0uukTM7LbeLoFyokw
	h1YLsZ+Oq28hh5vY76CGLsvEKkGvCNtzR1IkGdbMqfCVGHIJrhIpCLjlJ8xIRPf43t/qMU7LR8w
	mYY704sy1lylhGPZD9RhJl0XWtICRXLvffkJ18aGsnv+qnYhk9L/eSjTiCHWgN/zUN9pQXaC0iy
	EVTCPRxckiAVPlxwCNG+27liBC2i+Fjcgha5iH91VPHXdslgrYlZB+ipygvbX9AtquowI2L4DfT
	yfP5cxFdWT5g=
X-Received: by 2002:a05:6402:2350:b0:6a6:37a3:2b0f with SMTP id
 4fb4d7f45d1cf-6a7e8d6e0cfmr12759887a12.8.1788983364537; Wed, 09 Sep 2026
 12:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726161400.3010511-4-mic@digikod.net> <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
 <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com> <20260909.quahcia8aiF4@digikod.net>
In-Reply-To: <20260909.quahcia8aiF4@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 15:49:11 -0400
X-Gm-Features: AcwNN1UQqkyFo5vvQsxzjUKUnny07mGrmWOQtO0xD7Tk7ZJkJIAuTKutOi4gn-Y
Message-ID: <CAHC9VhSRV_axaGM0hTZngQY36Jw1ULy_sHHsik0_HCSdVv4P+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 2:35=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Mon, Aug 31, 2026 at 05:26:20PM -0400, Paul Moore wrote:
> > On Tue, Aug 11, 2026 at 4:16=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Jul 26, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D =
<mic@digikod.net> wrote:

...

> > Micka=C3=ABl, if you would like me to merge the remaining patches in th=
is
> > patchset into the lsm/dev branch just let me know.
>
> I'll send a new patch series soon because this v3 would not apply
> anymore.

Okay.

> I'll include your lsm/dev patches to keep a consistent patch
> series.

Please don't as those are already merged.  If you want to stick with
the same patch series, which is fine, just note that the first three
patches have already been merged into the LSM tree.  It's not uncommon
for patchsets to add or drop patches over time as both the patchset
and the surrounding environment progress.

--=20
paul-moore.com
