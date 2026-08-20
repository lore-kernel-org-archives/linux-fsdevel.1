Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B03876CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201851; cv=none; b=D0ZiE7eF5Eeo8w6O+zDeOPbR2GpSGPO3Mnq+Y23wtsbiXJLxh+zjWgyR+ahJMzwO2R2bW18nfy1VxxZ+g+PKyhnHyR0dfrn+KPi9YFGl5yoeW0MUVp6gl4641UrxxAX+GtySonknHfl04SUUQEPwNl4A7L1lHnTqRHYR6a09wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201851; c=relaxed/simple;
	bh=2USlnEWAV/BsZQrU3qAzmNex/6iGANpKQ905z4pSmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odrQQ9cejO9bAV/lIODfqcU/CPUh8b20b2BYd6RW6ZBqMHQTSSTV5gr+6bvxkkU6/dNWBy24ITQpDX9/dqfXC05xwgvq27Fr+C/0HYCwplu7874KVl7poJyGvFVGyQaBGIAXbTNEq/G2n6kmqvZy5oG7u8EdGxwEpq4VS7Q/aU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rnb6fY8X; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rnb6fY8X"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacb8416a1so15445225ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787201849; x=1787806649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t8/KAiE7r+9ujV+X79tz4aj1EOYlpuTPQ/LgkCZoCHE=;
        b=Rnb6fY8XzmWk++tGPS4marHGGd6HEDv9/s5AJwrDzOPSmMnbeOmfCoQuAwigvuwecT
         s06SKDVo618FU0QW7K9+DvGeZsFNHfmRn5973eq4Pfj2tYJ+CUy9fhMVVopKlWKAOViZ
         lgFesUkO4WLS2AmEkgXxLL/99IVJ/+tqjUxoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787201849; x=1787806649;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8/KAiE7r+9ujV+X79tz4aj1EOYlpuTPQ/LgkCZoCHE=;
        b=SGpsTpwNPQpEK/5KMlWYzi98+QfGc0I8Ed0EOuyqKiO4AiHNYzg67nwNBjhd8v5twm
         sMqLhonZke9b9eBKyE8vHXPNtGmf+M8P8hQG55wyA4sDRK30M7cevsj6usUZfO//O4h1
         J8F2JePah26WeDj+xXMwapUo0SsTaDCMbdxOzPOd+dY72lB1w5k/PCRqDl4daqKLO/RK
         DcTTv8j5LgQ0miWvplrFxqRmGMk5D2hcJPJKIykEqSGBQy+BnbK0TDsKhKXbWwagN5+X
         oFV4LUpJ6zYnxrX6N8NAmZ2+APcVjYoJhC2yjzMzEMY/kRnNz63XgymxcL5TQMWfdfQY
         cbaw==
X-Forwarded-Encrypted: i=1; AHgh+RrfsMrtQ+E2g2saF/ISl39GrTGyeJRK75pmttW50OT6Afc8F15W1LsLoOG00RwSYfQUjxmlBBY+Dr3RPrv+@vger.kernel.org
X-Gm-Message-State: AFuF++mbR+U6IfCnXq3g3zKzjuT+jf0O7+idG+B9xYly6zWjawDuyL41
	fLTV+zZXnFH0qR7l5K9KK8ztkQq76FPkRm90WlwSZdx0fHtPwb4nHhGcCLEFo9gAwKTVsupw31I
	TGtE=
X-Gm-Gg: AR+sD13mC7FozF+CCBw8IVJJBO731FgMo2bgjS3bgGd8wBy0VMpOsTeW3jPShxkWnkn
	4CfCl5OGYbGBwE6QVM5jj1Bk69sVn3veJzZ3KM56Y0ibxm8Swo7FTgZuTyNpugU1gKK1wXZH8/+
	pTeayGxVQbps8Qi5BFEibiA+9I0iiDyaNoi/daSVKF3xKPA80sABakbWDftPjHOQhSsq/ux075t
	uaz64fTxQD9WzfLRWV4QQpo1EsWxgGSesGpltvU/idVg3leQZHCGpRCo90dTvyn2HbkFBPKcIvy
	MYfvw6w2jI+v4u46scTFFPPoVeEC7AusfDen+zjsDh8iJmEEm/O1WCwF/eUL/TH/yVaXBhu+Wrt
	tNfLBipOsc87rzdACYAT2JTusP8N9zha71MMm6eqVrz8ailEpN00yJCph5XzH7oLdEVMSeBhZaz
	NyOf4zSRveD3HUYJPYt+I5AkuBGb3lvqy++HEepIAGl9vp3z1yH1ssXJKI1I4YyammPKuPYvDo+
	ft16/PVHLffi7XnCJQ/zDJIiw35
X-Received: by 2002:a17:903:3903:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d5fd6af8acmr188906615ad.10.1787201849305;
        Wed, 19 Aug 2026 21:57:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7beb:7701:c87e:f611])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d587eb2sm2002465ad.24.2026.08.19.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 21:57:28 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:57:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <aoaGrFzQFfcd5le9@google.com>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>

On (26/08/19 12:03), Miklos Szeredi wrote:
> On Wed, 19 Aug 2026 at 04:35, Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Suspend freezes tasks in random order and doesn't take into
> > consideration producer-consumer dependency that may exist
> > between tasks.  One example where this can cause issues is:
> > fuse server getting frozen ahead of clients, which then get
> > stuck waiting for req answers that never come (the server
> > is already frozen).
> >
> > Make all wait-event calls in request_wait_answer() freezer-friendly.
> >
> > This, however, doesn't address all cases.  E.g. in-place
> > PM-freeze of a request_wait_answer() task holding a contended
> > VFS lock still will block suspend.
> >
> > Note: this uses TASK_FREEZABLE, not TASK_FREEZABLE_UNSAFE,
> > which may trigger debug_locks warning during suspend (if
> > request_wait_answer() task holds some locks at the time
> > of freeze.)
> 
> This is not okay.  I see the "no new users" warning on
> TASK_FREEZABLE_UNSAFE, but this needs further discussion.

Sure.  In RFC patch I had TASK_FREEZABLE_UNSAFE but eventually
"don't add new users" won.

> Existing users of the _UNSAFE variant are NFS and samba.   I haven't
> checked the context where these are called.
> 
> Apparently __sb_start_write() uses the safe variant, yet I'm quite
> sure it will be called in various locking contexts.

We also use "safe" variant in fuse_get_req().

> Why is this unsafe exactly?  Does that unsafeness apply to
> filesystems?  If so why do we allow freezing while blocked on
> sb_start_write()?

Right, I don't have much to add to the point that maybe file-systems
can get a waiver.  If we suspend under un-contended VFS lock then it
doesn't look like unsafe here (we similarly can sleep indefinitely
under the same lock waiting for server reply); if the lock is contended
then suspend will fail.
