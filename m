Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F53803C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075216; cv=pass; b=B/aai1OiFevKCiqEPY1hTGaKbXgcK4tzA7NLlTe0oWOy2/8wjYPGKE3B3KEH2w7jlP6gqilDpqm/GsdV3wPiB9y6N1nMt5l9rqC2Z/8jXQZ6YbxLHa2iU2R2E/invojMPjLt5GjBNbxzQbZDB5b7hrJt6AAROvzp7hKh/lnkl3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075216; c=relaxed/simple;
	bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heoXYKVHz/k1Ui/vvuiHTUobMaQBxmpE71hsR0xj3wZNp6awdQIGVXv/TRETJ+pJErCFAGzrOo6qynyrPXjCsrH87j4ORb6+commmcUOmjE1pIaWr7z16NXEvrl0krCJ3ABdiIxOJHKa/EnMpdngR+4z4r/9QV8V/DrZbKo4M44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBF+E4qN; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBF+E4qN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bcd3c190f71so2241373866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780075213; cv=none;
        d=google.com; s=arc-20240605;
        b=Lb1cg6bYZWHqgegbG6fGI6Ny7gfkpURXec8e7I5QIoYWMB21RK7TpeNvLJ59qJ6FPQ
         bFyeWwrTyppI9QDy28rALpFM+tMet2M1+3F3X+4yqpcASKU2Qis3fEL+EUoFwVWx1TgP
         ic3W+dH1Mj+wruC33gdGyHKDQUC6FharcP0Yu3UYSu68ij2X+8foWtc1AZgGf78nAReA
         oJ6hxiCAcdhSQwjEqS4jp16MwylyaSYOJ+KJYeSG/A/mKxGazen+ViBGg2XxFpMhsQo7
         B6AWOH4ueRUiVrWmoZlJeX076fG2BrIcPaV2eQaZawYNgDfDf1pTAg/wks7ItA49nj7k
         qKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
        fh=uSQWhP1Kk9mlKwMjlV1w45L5OzJlGOR7HM2Q/pB/tNs=;
        b=ShWGtu9L9KdzjAtqQwPrEtmYA/iDLnWV4SDBrFZtKpUt+AomWAV2BDddRVfPQoQxeR
         2Asg090QgFiqkis9eXt9SKBP6wfPpKHgyG6k83IH5L1WyddnXzaCZI/JuJz9ViqYuAc8
         ioN66YlUOGWEWFFi7Kc0ax4tYlKf752PnaZhcg0lazxl5dVc2QRLZdSTxbe/DgGvy6lQ
         q1bXND3yeTIYHSPWqXV1fTJU/fnmS+GhWUhi/HrOU7/mLXG4GAgxDDUOfjEgG+wcOUzu
         Cqtiwu0ac7eSGGfw7rtXIyp16/zEeQ62bJ1I5/PV8MMzAUc7+Ish52tzqJnzKwZSkcYg
         jBLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780075213; x=1780680013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
        b=ZBF+E4qNQjBF7tdz5XmYiAB2vJW/NSs0RStxA1oVuU9x5FIn+ctBf64izDCzWSuxyQ
         Y46zQ+lhkoffzWzmZ6Gii/7+nbduBSfhMxICMi+W/4CUFYVgWmfyFn3dKWMK1NzLaUOc
         N/Obp18jFP6EdyXjWnXgzsYwylDiX2/KZjS6XvjLvKWhrywbSBPw+spZNUqEBGRSlPzG
         5q6+27Ul0g/hdNTnR9C6lz94U/TbxgcDewn8Q1zISxzYV5GhTAU2JpGNWavKH2PELArq
         zvHmQdVcvK5v1ZltXHgdfzoD3q124JlDpoIjS+b0U4tbol48O7XtStF6tgbDlf4SaR0M
         7FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075213; x=1780680013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
        b=l+Va4U8DQR4vHIeZBr3Qj9rlJ9lgWPAA+S8CszHtmUIbAyeGW1J7a+KBv1LL5qkj6I
         xp2IFfP/2FXFRy45EyjDSFiqSnZZafF08HLmyRLRoKux0Bgdk33xhceowTh6wkq+cmpg
         FEfj21h3QSunziOg2ED2dvWCYTDWsUHcBW8krlcpMVxfzmfFkSfI5o+t6NV1WnRLMaQZ
         8hJnR9KbjHSWgTrfG2Di5e+oqQjjAFSSgGJ/mrOpC6haHAukMeuNVEvFvfI2QoJR2i4s
         TIRe+2gsTLzLmfVbRdTLpubE75IzvrsLQ1gsirFxcsFwq+wAwtC8sR3scphkaVJr14x4
         k8kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ipPID1qWRJ5hoEuDmjfpyhmphy15PJv0MQxoKWYOIMDJUapEUGqIdQuueyS4yQRilQswz08NABcvCIvSq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6p8YW4mWm/VaoGOO1NhOjqk+hW0BOQgTyEjRDaa+oHxLQG8JY
	AIhfjpfdX+pRqnED5OYe8kUOV3EXHgSgAd43UKaqhxeI4LIt6/iTnbvFsipJrPlAW2m0cj96KxE
	ZF8zKPQPLEYUatIaCEwzXcZEfoHm7Yss=
X-Gm-Gg: Acq92OE6vHZj0Y0LNfjp0YWO8S4ATkA6NFLeiyhiNLJs8ETHeP2oOJp45AI8UyLzwlE
	Z+LrcFRgJRPf4x0CGjEYbDgsO/9y/JC64MCwWVL1Rqn88E0sEgCVfipKXcqU880eWASwEP2Qj9g
	HKMA3FTBPM/baa2eqCsM449UK7UoXn0OedX3R5JX3j9yuH1qnl7PCGwkbwow1AIr0ujyqsnQsW1
	OwTOGHFR8F36wSbPt+dsS26eiU2eaGrVjeOgxFSFnlx2vZ6Jd8fdJzoCW6jbih+Js1bMQ5v4vJj
	GXAlzI2pkkTIOCC9QhJmvhiQjKIZyHm4n6G5wjqdsYcC0lauaQ==
X-Received: by 2002:a17:907:9282:b0:bd4:6da5:d5b2 with SMTP id
 a640c23a62f3a-beab0dd8aecmr26412166b.1.1780075213265; Fri, 29 May 2026
 10:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de> <878q9dvzh0.ffs@tglx>
 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de> <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
 <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de> <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
 <7e8f3a515208583d06c9b5ca18a3e007a8c6b692.camel@web.de>
In-Reply-To: <7e8f3a515208583d06c9b5ca18a3e007a8c6b692.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 29 May 2026 19:20:00 +0200
X-Gm-Features: AVHnY4LcAg9EMC0vBy9pozkVNxhEfZnN5xmOlqt1ph5yPNhhQZBBmhxfALKw18o
Message-ID: <CAGudoHFPXP+i3q4HsZqmZaRxw-UjXX_RiUosteVESO2uv-qhew@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 7:59=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> Am Donnerstag, dem 21.05.2026 um 14:01 +0200 schrieb Mateusz Guzik:
> >
> > So overall I think we are done here.
> >
> > Thank you for testing and sorry for the breakage.
>
> Just as a reminder, this has not been fixed in linux-next, yet,
> up to version next-20260528.
>

I sent a v4 of the patchset with some extra touch ups:
https://lore.kernel.org/linux-fsdevel/20260529171840.2576445-1-mjguzik@gmai=
l.com/T/#t
