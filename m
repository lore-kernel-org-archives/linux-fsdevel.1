Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249183D34A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041180; cv=pass; b=bNb10tF1uDi7yf2DZBh2rQL5VTPh7zKRem3YKwTX754qprddlDFntPbPtEf8fg6n6apHsV6UDb8ZGhk1R0+jTByz62DOLuJJlF9YCwI1IbLm6MqEK7+bgLi30jjEeQIsByL6Rru/QQ0EUqSgQvqCwcnjPJh36rq2N9BBG4Yxaaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041180; c=relaxed/simple;
	bh=sGgycT+mpNCkH2JnwzDPQx4pHB2L2jOIjKF+X+CHwhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ie2YE+4QlocgmnQImAt7IJBA9DN9wpcSoEa+FRKnQQEc8WDvN2dwlInTgjoIkd/un1LrChqvuK8W++QimI4uGjsP8yMmztVa7lcIhH0jaiRkELdkSiWp3J3llPcs0uYD7zk5X0H8yCt0NuQFarfUh9N56U1RUKFYlpzYDy2GwOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbaX9OTY; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbaX9OTY"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-650221149e2so4853609d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 03:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775041175; cv=none;
        d=google.com; s=arc-20240605;
        b=OjCvyZZl9bXmp96LwVShV3+Lt2MhuONxy1EAeiy+AqIqjvaw+BxIAZMyqvGI89oVqu
         USLEAVisvuayDWvGO7PXaOFHpWbfG4XcuG1KeFqECJvjo3CvsVbURe09edngcCE/LcsV
         FJN0M1VIxL2g2n0DwR4vIXgIFrjUovDKnZJUMZQia/eWnAJ3jKV1zm51hy9SueZL5vIf
         c1FPHndQ2pSF4z1B2stzyN1VAcQ1wJfdAjyizCjWIxpGL/fpiMEge0N6Ik8GrCfZq775
         m2WLvZqmVb41bw+pXXi9yzN4cAgXygKAdC7o00DPowFYs9W/vgFqFMZO87+1W3FXtbjY
         eGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prDRjsvQitzM3d/m6LZdIQroZZ3VCwxh26Tj6uaS8LA=;
        fh=7FrVB8uLggAPSDds2btAWBnzXtuWsguHLxJlXT50e6Y=;
        b=lRUTI+u0Drmmb7A8Xx7kLQno8lRTp37MkvXkZ+Fcu8uWQ0opBQu6sZ36sdfzpnqLf/
         9dU/GR0fFQ+jBUjoJg346qBJEMKmH7XXPMsfa464knbZJddkw3NM6sbOj0pT8WmwfVmk
         IrYhMz/Tsses/CmWfrfMYwJaPHoSroDi3WaFxBVeRKErHeWaInijzNdX5NCrms3DEKj1
         9iXnjA9DjXKRi3OaWl4uoiAXlTTrZcXH50GgSPMjEi3aYWb8dnOreKjbyVY55qYkVkYB
         5mZwPso3E5W9zAKFzaRWtFw+twFF8xCbMulSi4gZXcPSQSsab/xqWP83aGOu08gUy0X/
         C81w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775041175; x=1775645975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prDRjsvQitzM3d/m6LZdIQroZZ3VCwxh26Tj6uaS8LA=;
        b=PbaX9OTYGVOSfFc3QendJdxrRTa4Dw4ytdUiOc2qiasdeqLUT8vx5zaMVMoYxkKl6c
         uLocEvKFAhmAFx60NFezb5I22lP6DtwLU9Lq9uVqNVl4IhNYianhKz9rrNeBOGIIdT9z
         ADV7FPd9nglO3MEu1D4acOtiJ9lFSNJ//Ib+TRKkJ3zXaeG443jQ5KLL8ZNHazniMdPM
         zYlvSsBXPbVHL+w+exwf7NRlKlClrkib0GXzVjWHUe4XX8mEs+R7zE8RE0eYsEQX/jAb
         BsqdRUF3Ti9B0fa1RbXgeDYRHhM0DoozoQ4buyDZqzTuAQNpMU6NFhlOYm6yfVVNmkFP
         nusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775041175; x=1775645975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prDRjsvQitzM3d/m6LZdIQroZZ3VCwxh26Tj6uaS8LA=;
        b=A0QoaZv3PDgqZ3YVtTpjgRzswGAjSSrU8AMexm81YLlSIAhfrF+NHAzEyYQEX5nupO
         4AcuSfGDnmfZmN7B7RwuwOepqLYjQs6jmltQW1fSqnDq1dgiwwEVyEtRQMeARFMS1IBe
         oT2TD4k6UUtw22vkoG9ZVqCb6KrcS2XtvOztp8gCONi5aze+seqWkt9b4FsKmGl3qd1h
         vs8SWzu3AWtmJrK3xWyBzgAsrnKPMC9FuQKFxIIrynIZ+PFtvGXclx7iQfwJhI1E+157
         MO2UgsfrGaGJ6tvtIjrraJ1l8DbS8vJ58mvEAQY//YyKI7e8/LPD4b5EDnPk1BXYIdGt
         tPdw==
X-Forwarded-Encrypted: i=1; AJvYcCUFHr/q66QKzx5o/yGiFsiz93fooMIxj0DgP6AhsfEsrpA/9ruxRbhKPkOJnztMLfmKhJ+mekWfkzREr9kQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7x/d5tmEzApPjpl9cpGUrqGzw1LopJnibO89nLlKXEuiAZAAi
	DzqJONY0jjfPBbpxb6RXlMQewG9MLw9l/iX3kErrN19IdTUHPNobRzaqX0GMyhJhDbnuW4XayH9
	9wb62pOWsXNWRFP4U1p+IDGVqTr2DRaw=
X-Gm-Gg: ATEYQzwlIjoRFkJ2mTJdwOHCCavn+95AbenzaOaodoNQkhiL2BDiX0SqO/VEE5xa1lx
	Yek5oaYQM1qxQwdBsWo2g/j5ftrrheROyFtk3CEekVml/oZgXOy6UfD8fhRIKAIHpXhdQVoipUd
	q4U3N3up6dO+77VjgrHDbUw1aBHx5p0ZCpN6GIZ3sHqf5mo3vroe5ieGoSsmrc74HwsGPUqSa0C
	X/9H5686zJUGChwKSWtFVusRnETFWfwEz1OZxGFdKas3qv4fDgNfX+IuJ6ccTYQ9zXWRJDc2+6v
	Iz61+W5FxbQ7Z6HGuHYmwp+3pQBR6NgHcqJioIuqFnbCC0T/TEbs0xnIaFsVL7VibffTjCD6rvZ
	1fD+cf+Q=
X-Received: by 2002:a05:690c:c101:b0:79a:3df1:69aa with SMTP id
 00721157ae682-7a21098f808mr31057217b3.25.1775041175262; Wed, 01 Apr 2026
 03:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org> <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
 <acvmXDBm1xOak_Uq@infradead.org> <26d2e8f0-8b82-4192-9edb-e31f3975bb82@kernel.dk>
 <e3gspf7vh2h7r5llbc7qman7tmqiyr3pd4nrzpu3cyuqtlolxy@2kobbzkgjr4d>
 <CADhLXY7N5qbXn0K+rTE4po9Kdt25vH4wcdD6fT22Dbu=CpJHzA@mail.gmail.com> <gsfsr3o7lkwrpzdbkvfcgpr3fudimmzsinpupikpo2rqto2mn5@w2fsv7rlbi4o>
In-Reply-To: <gsfsr3o7lkwrpzdbkvfcgpr3fudimmzsinpupikpo2rqto2mn5@w2fsv7rlbi4o>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 1 Apr 2026 16:29:22 +0530
X-Gm-Features: AQROBzBSpmdoPTSuzpIXcHD0Qhwc8nTiQU0hVaX7z-5eHvEHGRCTZq8Dtz3aANo
Message-ID: <CADhLXY4WZJhFUp38g2Ym07UpL1DoJHr9jfy-xArieUvzUtfxbA@mail.gmail.com>
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:17=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 01-04-26 14:02:27, Deepanshu Kartikey wrote:
> > On Wed, Apr 01, 2026, Jan Kara wrote:
> > > Hum, I'm probably missing something but I just
> > > don't see how the proposed deadlock is supposed
> > > to happen.
> >
> > You are correct, I apologize for the incorrect
> > analysis in the patch description.
> >
> > After looking more carefully at the code, the
> > actual deadlock involves sendfile() and a
> > concurrent fallocate() on the same inode:
> >
> > 1. sendfile() write side calls blkdev_write_iter()
> >    which acquires inode_lock_shared().
> >
> > 2. Concurrent fallocate() calls blkdev_fallocate()
> >    which tries inode_lock() (exclusive) and blocks
> >    waiting for the shared lock to be released.
> >
> > 3. sendfile() read side then calls
> >    blkdev_read_iter() which tries
> >    inode_lock_shared() but is blocked because
> >    rwsem prevents new readers when a writer
> >    is waiting.
> >
> > This creates a circular dependency where nobody
> > can proceed, causing the hung task.
>
> I'm afraid you're using some LLM for your analysis and it's doing a bad
> job. Please verify in the code whether what LLM says to you is in fact
> correct (and if you are unable to do that then please learn more before
> submitting kernel patches). As a hint, sendfile() for block devices never
> ends up calling blkdev_read_iter() (plus there are other bogus things in
> the analysis).
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Noted. I will do proper code analysis myself before sending any
further patches or replies.

Thank you for the guidance.
