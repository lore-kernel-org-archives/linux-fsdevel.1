Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021732E6BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011700; cv=none; b=XjsQGxpGBzhnJlNuPbJ1uB+lPDnVJuDOFo/32h8wNQ0JYGWR9Pdm/UlVzs3luNUwfkLwgh6QNZeN5kJlaHtRKVvVs+FFLmXt+dNkHfrrU/U1cdVWdY1VhnUq3XlBk8Gn1GpGymo9McJ5ODExoeBtfE5KxklpEsc23nviooxk7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011700; c=relaxed/simple;
	bh=t/v+01x/SlMKSGNTTUeFXO8LtDsuHjztaYXG4TiegRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX7TZ1PgDSIJqoIK8MYrFoL2xDMIfKPNbsJziKdsHOvUUEUVerSJ4OcuOBji+SGbI7lfHPAvWgAP7v6XMoDW+zjGNBOXmmM3NGlp5SdkvehQ0dUWOeFPVl+3JCjQi4535rVocGk/utfBOsuKT/S1JWnFvyOr4BqyIeG7QV06jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K4m1Zr57; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K4m1Zr57"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso6940581e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 19:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775011685; x=1775616485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SvFriZaW8bLArbVN0QXK8aUBqOdPcHatKYbe5GnZcWo=;
        b=K4m1Zr57dPHq5Pb1Eg5EncybyYxO32xRcar2yZ95XCDAbsFZiZE16+R7VbpRsruu10
         iqa2zblgljNzmQv6d5fwoI1uL+PRGLRa86jRgB/jdqDjRHiC33CRUOaWAgjXIq92yxeY
         2MtFW/QzgSTrBiJ5AimS+7SoiCjDNBRP9gJ5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011685; x=1775616485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvFriZaW8bLArbVN0QXK8aUBqOdPcHatKYbe5GnZcWo=;
        b=tRkn+GostJlIJsDhPuyFU0xgPJyJTBUoTpjt8vrysK+WH3ToOwTOT1OiOqbVwchcdD
         sI7laHKF2ObaVJ4IK1Jay/nkLXuOd0jEp2EEFZUg9Zih9w33xGX92RgEdm/HHECwjJq2
         DVq8GxAnGMkoGFtZjjPwOUm1v4anTvz8eP6mbKeDTq6CNn7bwe2RRgvDdkV/z81iLsWQ
         gg4EvudwUA7aZbkGYsVLnX8sNQj0l1CM8C/WQWMwnJY06KNQRwJ9KKm21/rblYEYrj4O
         HCxUnxgOJgX6qfWYxE0QDS7Mgd8Bz0ZMs0Xs+qvHd/ZNuusc4yHyviIXxUpptxPDz7sW
         JjZg==
X-Forwarded-Encrypted: i=1; AJvYcCXs2ppopxqmzczjtb0/ULZqH150kfIAliWLDVOapMdSPWYFpRbgUhh9zXWbfZIdygYGgc1PPO/DRr/JDlT+@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9L9CS8Sl+onx6BuU6FfRGN4Y9hjygJkvVxl+kFogxUNKD12k
	0DYXpSclGWLe/r+dXQJppDosSZkHVoERBgnrUNXq9wAtLPUsrxkqNJRTVaxQ6xQ7B4qXXNg4PP1
	uVT5i/h5vBQ==
X-Gm-Gg: ATEYQzzJ9moboCujxJHmJoGT8pOQHJWvHSf81Pe1d/+yFPBkWv5CfrQDyAE39GOYBGL
	fW1Y4VJJ6UHoUZpNPP7C/0DbKLXueKTrWCixnDwFkQteSHGIHsXkadVbFjSdkYBWgF18zhaLEPh
	qkahGZFA4ZsFL2BQcRGQG1hgEBCmI1wsUWzONIFn7oqnjljbBYhh9pDFfo/H0hK4uBQJWNMLY0t
	NWCN6XQ3LWFtDeWpL8hJlFlAk8ksgwYknxtHK60VA4doYiZERCMZId8WeLm5sJPfdj0yTRmMrEa
	wTpox/trI5VP2WvXwACsBCtV8ibumHeL658XhhUySt+JREraNw7MLcKxJI02+iEXrA8rzjGNXh+
	V1GU3HosUbgKOrqKMRb2h607CvJR9WBHLVZZzKik+kFsb0GEMh/CH1hpZVaPezjJjV8FZILbIQR
	HZnH6jKsVjqSrdauGhJOa8nxHKDweOP34iTkpwec2M1tWd/vMr5SwEdVwl0aZRqdCQnIpyHGlZ
X-Received: by 2002:a05:6512:138f:b0:5a2:b582:2431 with SMTP id 2adb3069b0e04-5a2c1f33f00mr619025e87.40.1775011685264;
        Tue, 31 Mar 2026 19:48:05 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b144f75bsm2917577e87.60.2026.03.31.19.48.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 19:48:04 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59de8155501so6616344e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 19:48:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxSYZtsEurLKAW1ENfD2ngV4MhyDPU/bBKd8K8p0pFjcZZW3IQyWIrXFfto5ri21HnOO8xTME330JO8ZtT@vger.kernel.org
X-Received: by 2002:a05:6402:1ecd:b0:66a:199d:138 with SMTP id
 4fb4d7f45d1cf-66db0af1f18mr1048614a12.20.1775011269072; Tue, 31 Mar 2026
 19:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331012925.74840-1-raven@themaw.net> <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner> <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>
 <d54d4791-dab3-4141-9665-091fc8918235@themaw.net> <b04c1c86-100e-467b-b104-7312c4dd0251@linux.alibaba.com>
 <24d86595-a1e8-4fc0-b4e4-7fc62d51049f@themaw.net>
In-Reply-To: <24d86595-a1e8-4fc0-b4e4-7fc62d51049f@themaw.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 19:40:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuh8s9Gs02OYaYqhHRCpQzZJ62H70-Tx2Rv5x-Ugx_Og@mail.gmail.com>
X-Gm-Features: AQROBzAGsY8b2chKtM_VuSwzQJh2H_YCliYPvwTmYAa_yi7FQQQzy-wMNDmKMgI
Message-ID: <CAHk-=wjuh8s9Gs02OYaYqhHRCpQzZJ62H70-Tx2Rv5x-Ugx_Og@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Ian Kent <raven@themaw.net>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>, Jay Shin <jaeshin@redhat.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 19:21, Ian Kent <raven@themaw.net> wrote:
>
> On 1/4/26 09:47, Gao Xiang wrote:
> >>>
> >>> `d_lockref.count` can exceed `int` on very very large
> >>> directories in reality (also combined with cached
> >>> negative dentries).
>
> I hadn't considered such a large number of dentries so I wasn't
> trying to resolve this case and I guess the change here would
> only postpone the need to re-think dcache design which I suspect
> is what would be needed.

I think it should be trivial to limit the lockref count. We did that
for the page count, and it wasn't all that hard: see try_get_page().

It doesn't even require complicated atomic sequences, because you
don't have to be very precise. If things get close to being too large,
you just fail it. And you don't fail every kind of operation, you only
fail the ones that are accessible to users as a way to artificially
inflate the numbers.

In the case of page counts, it was things like splicing the same page
over and over again, so the only operation that actually needed that
"stop at big numbers" was generic_pipe_buf_get().

I'm not sure how you make up large number of dentries in directories
if we just have that limit on negative dentries (which seems
reasonable).

So I think this is very analogous to that page count thing.

            Linus
