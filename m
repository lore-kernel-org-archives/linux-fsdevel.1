Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867991D9663
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780720456; cv=pass; b=eGC0v8zW22E4n8w8T1siCs3myB2wa+7mXJKQWl48OlzHjiHI1jnZM9xl4yQT4zNKN8PKOUsIG8nGQ4QBwistqvLkQOi5FdDihaQJ3ZDJzTFxk7+hA2jQHvxfXzKcWpyWxCkUv5pE/w0yqnb8xnBWG/fPRiFn/N1HzbNPSkFCTL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780720456; c=relaxed/simple;
	bh=atwk/VP3/XAgHMWNAv/4BXxcWWEwDqnTKdyRM0zLjRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiRGnwLUq/34arykFThE3W3KypjK3m4d2D2+nONNcWaBGs2nUfalbQiHz7a2P7bVgvCEBBDIn1UfPFsanjdk5WET9rDIufCa6bq+zly7p+46WscRjkl+QX7HzhXtHLlTxJrWEgAlv1EYNPrAPQAv5VExSbGhGxQ8YpDkJ/YjwUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS9KsNe5; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS9KsNe5"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e053987001so32057247b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 21:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780720454; cv=none;
        d=google.com; s=arc-20240605;
        b=W6TYYlLAzErZsqBc1WjN5DFDOb2PQvctKMg9Dh8OkLF6adqM/Go/pmyjkFcx6azZFH
         FNSDwnjhpFc6Yn1O6yRzWhMG9rrZpNO+KO7B8lI4iAUs5pFt0pR3xFr3EOx/IzK5ft5F
         dbRO+BBWcyR4S317gbJwK2z81YRjfcl5X/1ULtqYEcH1j3HE6iNe/xLiGAw4HT3UNdNc
         CvjY5Tsu0R+VxOxNdQMOBLEiBrtCoA2FnRgmdImdOZip9gnfZoAl27tzVsQwz37ptZEW
         QoX7aJ3/SkYJuyGE6M4ojC/WOzj+xdLx+G7vwAi+ZintBxaSkkkzYGpe5iKMbO7WCGhN
         x6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zt2t/WuCHTtp7cC2hRv1Vd1XVdMi+M1K6U3nkE4aTeA=;
        fh=MsaMqtwEhjhiI/86XW4YGBDVuDqrUxOCMYSrbFA6p1w=;
        b=NyTidG2hh1tH0Wa/YId7YU6Rvo69/qBOyojg0AM6Rz0dUJF2+/kJU5g1FTbR4Svb6f
         zQUIGpC+lDYlouASj2XcsKGChieFSKYnGS91QH1hE36Ee9tr2xs8+dRdJ0FxIH0LB/FX
         hGJ3wnzOU5sVs+ZiDHTLD+aKZkdr4WoYKSiTErt+SiJZAr+EGd68UpmrlIulSm0LX+my
         lc6lnRFAc8FUCwriG2306vLaBu+0BQOOgie3H4355xVrAC3GDsUFBFFGbIVHLrDpkwK+
         812LZ4mCMvmBLhEEx0tzQ/+CtxtTRV99eaNlYSJRiPGLxm/FMsW8O/aa7j6v7kNOpjvU
         CsvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780720454; x=1781325254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt2t/WuCHTtp7cC2hRv1Vd1XVdMi+M1K6U3nkE4aTeA=;
        b=LS9KsNe5ffEOo5PXTlx8d0zLTDV3e9HQRky4RZwCRWCDfEB97Se7tVDHvtAfweZcmj
         le0FxHeQeJnFBqETVymYQOuB2sjinda2R1fmqwqoi6EF1WlmAtYic5HuNhrYecCOkIhS
         A4IK+XwmlPAXYfak0HwJ2j7miQnu+TR433hP4EGF/U9sv0tpe6UQf4fJzgh2dnEpQtw6
         lts9+X+x0j2LgMqJp5j5HHDfPUcstOBumz25UpK0HKJ/RCRrE8lhCb8UQwP0zNJnc/rk
         n65Ho82992OLPvNq7PkzmjjPcDXUB4dggfmLUkR+jJbp1y6WATDATvrDQv4k16fNKde/
         6M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780720454; x=1781325254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zt2t/WuCHTtp7cC2hRv1Vd1XVdMi+M1K6U3nkE4aTeA=;
        b=fWDDFKzXjHgSgPTiwiJXD6VGrQ30xgew9OKRxjrrWXnu6oElCywO5rpT9IQLwDvrVq
         SafxzSN8yYxwqxud0OI0fWRrqHFYlXLCucKZQ0F3brQZ6XfyB6G3IfcKg95ijpm4hljM
         hm9ALIiiwLYYcXS5q132RguygQQYnAFsSngFR1FksH5WB8z+g7VYRitiL6VKONJdaYDQ
         ytJTs0689qnpbBZmTSJIgvvA4OYZeJkLjr/4wwR4bs45nje1OayqYKshat6TvWN5e+vA
         6lCj3OltxPkMhJWeKkVu3wkAr/yKBbVDkTvGEvXY+CVJgehyhs6/A9CLZ3gkzVrK6qlO
         /JgA==
X-Forwarded-Encrypted: i=1; AFNElJ8jAmPyN3C3EcK3M8uw1nNiZiCJJr+IVIDyIfOTCCIwhefE3d+nPq30pXcVgXEPIeuDaGldEwZ0j2UrexKf@vger.kernel.org
X-Gm-Message-State: AOJu0YylR0XJA4yppZgnjBFkW7zHJ2e9+GLMfOXVrLSLmp4ubu7oD+ZC
	IZjej3elOAWyr9hevg9Z+c83g7CR1XYlNhY3B17WZViTXuwFl6LlUzZknA6UByT3MFmKheSV6mk
	+s5vN16HqsgStG2mTw+YjEoJux+xdcxE=
X-Gm-Gg: Acq92OG4qYzPbOMcV8GfOEzZSD50N53iAUjZfFq0XN7U1PQFJCClEIZocNzOqF6uwcR
	qiCk4fGUbmXE0Z/24AYK772j2NwaAB/mUbP+8WZp7YezPaPWSs+f3swxd4Pag9JxiEHtyEP7pNQ
	J09Ff4R+hXF0ESjjmKPy1QNVOAtMjgRrNuCqCDHzNkYG7WmL/BPbqt+6EWUtj1YGGji1jQsoKCN
	npCQfSmQCrARxyW5hNQxsu82/Vxf3HrOZDOvoetkT5KZAiuO9bqmn1cdi7NGLophN3QEYAz5kg4
	60oLNLng3N4mUUQdaQ==
X-Received: by 2002:a05:690c:e36a:b0:7ea:3cda:4246 with SMTP id
 00721157ae682-7ed5028e5damr42575567b3.3.1780720454428; Fri, 05 Jun 2026
 21:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org> <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042112.GA6060@frogsfrogsfrogs>
In-Reply-To: <20260606042112.GA6060@frogsfrogsfrogs>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 5 Jun 2026 23:32:15 -0500
X-Gm-Features: AVVi8Cd5BGcvnLpgX6V7m7EuimiMVqe36pLHGChBDg1y_B9b_4s87AtRfff_EwA
Message-ID: <CAKqfh0GjwVNKbfPfMeoB+YUfffYcUrxopwiwcqH9wJNq=XV6ZA@mail.gmail.com>
Subject: Re: [RFC] Maintainership of the EFS filesystem
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> > On Fri, Jun 5, 2026 at 10:44=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > As I said, I don't see the point.  Do you have any EFS filesystems?
> >
> > I don't personally have any EFS filesystems but that doesn't mean that
> > others don't.
> >
> > > Are you volunteering to do any major development on it?
> >
> > Like I said, we've already found some problems, and like I said I'd
> > like to fix those before it becomes a FUSE as you suggested. So I
> > guess I'll volunteer to do some major development for it as well.
> >
> > > Why shouldn't we just delete it?
> >
> > Because in my eyes it's an awful practice to just delete something
> > overnight (probably not your plan but still), I think we need to have
> > some maintenance for some time before this gets removed.
>
> How do you plan to do QA with the EFS driver?  Is there a mkfs or fsck
> program for it?  I don't see one in Debian, though I didn't search that
> hard.

I also sent this email to Al, but my guess is that there are
images/disks archived on the internet that we can use for testing, so
we can just compile the kernel module and mount an EFS image. I also
did a quick google search and found that the utilities can be emulated
to create new images, but I imagine that that would be much more
difficult then getting images off of the internet.
