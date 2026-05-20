Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F253A451F
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283488; cv=pass; b=XYytkVFq7hmbynBOEYGHmcxzgCsrLl0D4RSW/VsnGjc5BroqAh07DzeFFOBzow9UMlz9Vc4Lw0R/rV20Uw2RbgKiu/rCZDW1OoyYeoND6BEhRj2T5CrF2AKHNMOTzc+SgNhaPb/5tz35zryEyV+GVi8z443CgH0kaXeHUrkDYMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283488; c=relaxed/simple;
	bh=Rit3XOj+nAqSskgBa3AwkCsmGpVaId+gpzvsbFjHRsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfE0ST/SNKUpVbyRYLqWW+AEq9w970Ar8OY3hcWNZGTE9dRQOJoO66Q8ROiTjnd5WZ8ovhtazncTqbIdV9NvDJf45+1bMDO7UJAYs2wgPwUz7MhvLu6eDtjZOVrWfpAav3s2QnCS0yuPjUQ8/RjoTRpLp+HMQSUs75IzHfVuL88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwKoCw/P; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwKoCw/P"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so469862a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 06:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779283485; cv=none;
        d=google.com; s=arc-20240605;
        b=UwRV+MR0cPcbVcZRChFBRsTFShU03jpdaAUYZkOf4bibote0YOme7pg7HlP86v5EUB
         1IEwkqGPfWig3FoN8ma9TpG7vj3QWmREG4ib4syPD15H/z5cU2JKF3/LUttGSm2EAB3u
         msFlPvvDFfouh7zR6fzv3IT8u8y/kQVQkYXspTstr6eE7hKBCRTPhFJONabnY943kf3H
         L1v9MygIeQnXffvms3zTr2GEFyqWl0/4YiHMRV5dX3PwWjYf2bHGAuaXA+MhF2iZ+TAz
         2l1d+XpaXb6wiEzoI67p2GHLazVSgJUWqOXYpzhhUT8i1ipvM6Lv5EI9UYWBICLLdqgy
         Gq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rit3XOj+nAqSskgBa3AwkCsmGpVaId+gpzvsbFjHRsc=;
        fh=8G4QI4ZlfSkYNhbeISRPn9fkF3Fxs9caho/DuSbQs9g=;
        b=E4wIwU0YvIHHn0hiuPnQNo+kYKybDlu2JafX0EpbBkwlXFoAWRe7hi2M5yvemETbRl
         e/yE5sXzSKdMNMF/V6nKNKgOPe0fDAakTqze17yrcpIztfr0TbaZyl6uqRVghH7CoW0f
         r+5oKr5rKxTFXV55E0ePH4NbjyOGfx+LxLCBgoTlLGo1mX0Ugw47KaRrd5hRmi6LHMCs
         DqQCJFY91AFTj/rwORR8uTCgre6F91x13jjyF4lk603G9pS0Fxh6AOl5LBGf9+yJC+Wo
         AOGPAtjYZnXEIqSs2hvd8s/X/LTViLk/4K0BYfh5w/TiV0yPYX4e5e7nVi0UiHItqpIY
         FWNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779283485; x=1779888285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rit3XOj+nAqSskgBa3AwkCsmGpVaId+gpzvsbFjHRsc=;
        b=DwKoCw/PT7mQ10vNBMUrsTEgJ/KD0xilvxMKeI+aiO7GBDvQq7XKJJ6kyNOOhWPRFC
         qAQRff8dLVNruj1MIMY+n75FGD1FnYxldtzIkNgu+HLnxNvGPuCim/abv25tCKOX0c4M
         B90eJODV43Mun+Az+kck902Vl9CJYMttimw0RXk+sRWyhFsmweKWF99SC7Mwan6wOHFe
         ECm4lVjQVlTWgUeeELJ94rOZn5g2GnGibbV9qeU8cfV+5qB+iTfrqeWOwpY9JiXUFeT2
         qwR5fHpfjh1a5z5kJLq0R3QIzdIesXZWyZHMBltpqUvmJGhNMGt1egwYWRwxhVmDRO+w
         Lh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779283485; x=1779888285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rit3XOj+nAqSskgBa3AwkCsmGpVaId+gpzvsbFjHRsc=;
        b=Yq+V8et+gCgDret5lZpMXCaSGe+a3B0d/X0oGzoPIjD+Gm6Ej78En+VaqNPx0zYt6k
         JNJO3Wu7oOFLXZ0oLfHYgiU9vFM4gnmJnCsIZ1Ktka093DXIxXHoVrQVZZ+CnC56s2nO
         mpkXTLml5GlIfK79lfgK6VTUIlkAH+3vTdvXfm+NjjKnWCBSDmvk7nVnYwzMEzIY8bym
         x8JIWxrfiYIR/kWmya8V7xMse7VcdDcbTQgr1B+gW4z1d/fCjjmIKhMxiqyZ3iUzMoeK
         ZqknatJvOx1qIFzgkS3mHxmZfm74Ne0EV7jr613BvYy6nLqYJSmr/9AHTDMpIgXRuL4x
         9ceA==
X-Forwarded-Encrypted: i=1; AFNElJ8Fq+Fesml9b5C98ntWC2YGa4Pqf6PIVC8YiUYhYmnSA5TBNZzfnAXFPTEHPVrJIs+KQj7AOYLpDT+Dgtg7@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDe9IV3rf1GtpzZoRXff/HecozOwwpfeufvzfbsRnrgb7RgLN
	O7e/PyZp1RSbEoc1CdFmKYkO4uhEplX+V0G66UgKfhIQaLYqAcCn/Z49PDrM3RInHW0BvVL+QD9
	llnp6gHCJck3hx1espJD5cs7G2MHiPzk=
X-Gm-Gg: Acq92OEyR9JdD7sl0A/dGWp3ba8192y3T3RIFv7Rneoe/R8cglzLgKEuT8X7MFeGOuA
	vtsulfie5t8UrnmnvSrm0IOxhRzFB4SFTYT50kx1Tr1VKXNzvHuYQ1OqJr47bELCHIkLRLNSHFs
	Q3K3P1wuWBx2YPLmeLWRZQUoGZ7nlmvakPFFxMW9ZHlRr7F5xy8mk6HElLBdaf/2DNDkn0XuDIy
	xkfwJtm/O3LuDtBpnerUYD/v16wGTcsWa319yjol+p/q3C3ybMrp91RCzR+oUIIFj0Brtuv4FkF
	D5JX4ieAkhD6vID/UTyAoAmXZ01CJgu+GCYqVn/qROBhisW+z3/H
X-Received: by 2002:a05:6402:4313:b0:687:285d:44a3 with SMTP id
 4fb4d7f45d1cf-687285d465fmr1620985a12.15.1779283484506; Wed, 20 May 2026
 06:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520123722.405752-1-aalbersh@kernel.org> <20260520123722.405752-4-aalbersh@kernel.org>
 <n67pde3prjxt2c2u2pvjytfw7uzwbeij2yljlrwh7fixcgnzhp@piqsltgpcc4v>
In-Reply-To: <n67pde3prjxt2c2u2pvjytfw7uzwbeij2yljlrwh7fixcgnzhp@piqsltgpcc4v>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 May 2026 15:24:33 +0200
X-Gm-Features: AVHnY4Jb9lW17aXG5JPAYjGDiGqwrTNH7OJH9zvcsbDKfZCeeZ6RTdTNxiDlapc
Message-ID: <CAOQ4uxiNN3U4datJb8kxxGVp7VNRFZB6_zEnO76kh9oEjE_-bg@mail.gmail.com>
Subject: Re: [PATCH v10 03/22] ovl: use core fsverity ensure info interface
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:54=E2=80=AFPM Andrey Albershteyn <aalbersh@kernel=
.org> wrote:
>
> On 2026-05-20 14:37:01, Andrey Albershteyn wrote:
> > fsverity now exposes fsverity_ensure_verity_info() which could be used
> > instead of opening file to ensure that fsverity info is loaded and
> > attached to inode.
> >
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > Acked-by: Amir Goldstein <amir73il@gmail.com>
>
> Amir, Eric, this is the last patch missing a review. Could one of
> you have a look at it. Not sure who should review this.

Feel free to upgrade my ack to:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
