Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4661B87C9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411907; cv=pass; b=ft1l2HlYf6qQjUKh6hrzfxruhOFBBlY5FCXcrruzI8VYcS65ulzrcfioBeRJkGGvqhSFBRVpUymB0SS8LPHW8J7bO5zp8h990GkGBUSXZKLulmlTd9plDYGUZ4Hm2MosRdOogRgC3P6eenwz3ItRRTpBMLmrN5RqAoUlXO5tToQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411907; c=relaxed/simple;
	bh=znnSf0bs10j7eI0t38PX7h2UnPZZQeY6rPY6Z/F31+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FK9N4x2596a+QOLFb5aQHqfnrxajgQ00Y08GNSQikD+47qNxR4I2997nfm4wakGN0oHt1nQj1eqT183PYvHg5C0aWaAXX3300faynCvu7TywF0QLovoBD8SRH2s0naWieULPJGmbu5xwQgP95sFJRXE9uovSNLBPi7dsTdA1yhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvnFbQxG; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvnFbQxG"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso2132844e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 07:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780411904; cv=none;
        d=google.com; s=arc-20240605;
        b=Xc1euvakAJahLq2dJCVut+BOHoZ1d7EbfLYwsEsfa7rXrrWlPuDOrO2MY0bCOq1fMh
         oRbWBmjLiFLJvNe403RTz6x0lRf8CRd+/gYPIX221b2f4zaab8qcTM8mdqP1syT8o6Yw
         T78RurphcQNWWp6PBygACteGN5hmxMMqPvTuOIeLFy9tAEhEvrF0lA+E/i8ckcjWz/cF
         EA1gWQO0FlPUfitJR06WZBwffTvtp43GWwYj6gH+4COTnaRT7JmN+sDIbMISXOLailYj
         LRHyg748M7W02TPsP6po36ygXMq75rOoDYdBZV/E7AAnbjVnz9vtNauf9O38fjbZPYxI
         giFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=znnSf0bs10j7eI0t38PX7h2UnPZZQeY6rPY6Z/F31+w=;
        fh=gTNWdqxKEdi5mtnb3DFjxa4REAO6EI0nkXVhK7zNqRI=;
        b=ANWGdHA6AT5ziqXTdlTdU86bDCB/XWms0hKDcZDaLTK8aBng+skIHHDO0vCsj2VrlN
         VvfsusAEEp7T1mais4ZMVop2rR143ypYLaApGOpm7BS+TU5HuZy8D9LvH8sXHk3yJZa8
         lDU+NC5+Qm0SHZDWD81upAJsrnX5+t18j5LBbTn8gFTHeup6PW/GtmWxLTekVFhRf3Zy
         zt5UqJdL/sU2OCzfdLLMjG5djhaxXKatDIuvo90dSmmPLO8bPfMRx5Ao4vMDhXvYyc6C
         XssVVRfD2UA72QTwOo0Vemhg52TTHPYtFwVVKmI9ez5/eWWQHOeDaz2N1D3MSOo4AfVW
         mvjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780411904; x=1781016704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znnSf0bs10j7eI0t38PX7h2UnPZZQeY6rPY6Z/F31+w=;
        b=EvnFbQxGBFZM5HLZXY0+wVBHp+lLo5VK9ySSx3DMoGvSBdl8MJ1ilKcVxnomwAwIDe
         rQp0PIoJxe91hJPSR75uoUMPqjyWi8lN1I9NJzf00VTN9CAqL/dzJE2UQIOwewlzWRRO
         nJMYQ6RtyXNadpZe6Ea2vxywwP/FIje6dafQsYAzNmgXAlro4sjLM1KJzVyVVLnpvm7H
         srT0GLwkLQnTmu7N0T7AlJ6WMhRr97TGhoamWLx8dA3M2h7vlXh6XyapecSkizpgOfRs
         qMNpzyjs11PQ8IXcjgZX8vGs5JN4kw7lASX46kHYnrtaMEblYr3816BdVtAvJZnWKp6P
         VvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411904; x=1781016704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znnSf0bs10j7eI0t38PX7h2UnPZZQeY6rPY6Z/F31+w=;
        b=G3KO+e2CxC3biGwLr3jcCd7zsfwWwT9aUXyzXpMbgZtaFhB3FS6Ju1www1JFCIe9L1
         ddY6yQBbSqmb4VRZLhCqdq9Kdk/FnKMzuiuPyJ9nBfyIXaVVmN65BQvArUCWNfLzCJoT
         DruSck5WTdlPEmkjwdfkk3fMljh02q1zNlH3xZWqBEMxVnadK8MkB+D634VNlJZl6GP7
         lAeA/gSvr1N9XLXYFh2xQineyK41ZuDohekkh9nFUSnp/dvK7HNC0fqZ/qGUJB50a3u2
         TKKKr9fuENBuIAvQu/tEBVwImK3txkIk7M9BeTU9MT8F90ARlS03oxLyeWXtwxu8CX6D
         csBw==
X-Forwarded-Encrypted: i=1; AFNElJ+0Aj8XpzawOoHJv/7wGMBapIVxmwURPTYv8cJARwkuoMl/k5fkIWF2hLNrO0OHuVb3dUn/TQAAorfqzhBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxTk8qTgwGow3tUuiRSJaHuzpi4+xW8ozPxSHmSQqepExxrIgkz
	/ftA0sqrl3bKEszkFvRXinFck62oLZhcsax/3NMwQL7UkDV4w+OeWCV21urSUxtHCuyetJwlSGZ
	ViErns8DunNrz3hEp8L7BQUT1f4nQXzxpwlLu
X-Gm-Gg: Acq92OH05JP6cEmXEfK0hfmf7HwTdNiUKTxTepacfCA403s0ELR6GuBCDPjHNues7Ma
	A95m7omVoCJ63+EX03oSebUkvS2qnbDW34LTUI4cT6SmJvV61Q+6fmMim6Wt+SXFUKCQLRWQwAn
	j6uyEHlZE18FMPp1DezLWXLEbfrzmzC5fw+4X3P3Y/ONGswH/NtP17KJls9DRCzOFYHKQbR4w6n
	EiB79rRBTG1CfSUkIKgUc3GLtQ4mjlGaV6kLFyf4ut6ZHTM3Sba7zSprdpYQOJ5D5vJvCCtVbTE
	UbZIux+TEB7fGTh/3XY=
X-Received: by 2002:a05:6512:234a:b0:5aa:79d4:7135 with SMTP id
 2adb3069b0e04-5aa79d47198mr698365e87.0.1780411903891; Tue, 02 Jun 2026
 07:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260602141434eucas1p15746f013244db658407ada4f3cea7b89@eucas1p1.samsung.com>
 <20260602141427.2301354-1-m.szyprowski@samsung.com> <CAKYAXd87d8pycHVc7GLu5jTemowzRaLOSVfHLaBXYkUtetUN9A@mail.gmail.com>
In-Reply-To: <CAKYAXd87d8pycHVc7GLu5jTemowzRaLOSVfHLaBXYkUtetUN9A@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 2 Jun 2026 23:51:32 +0900
X-Gm-Features: AVHnY4Lw2pJtYhVRZj7pIh_citfKI8ZZwXwWcbA2tUP8Q1mn9jokAnPwlHjjOEY
Message-ID: <CANFS6batPUtAt5dPhLYVgceKFODCXpfNOuWhVSHKeSFoMO4umw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix missing alloc_workqueue() flag
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:38, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jun 2, 2026 at 11:14=E2=80=AFPM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Commit 21c05ca88a54 ("workqueue: Add warnings and ensure one among
> > WQ_PERCPU or WQ_UNBOUND is present") added a check for the proper
> > workqueue flags (WQ_PERCPU or WQ_UNBOUND). NTFS driver lacks them,
> > what triggers the following warning:
> >
> > WARNING: kernel/workqueue.c:5855 at __alloc_workqueue+0x688/0x70c, CPU#=
0: swapper/0/1
> > workqueue: ntfs-bg-io is using neither WQ_PERCPU or WQ_UNBOUND. Setting=
 WQ_PERCPU.
> >
> > Fix this by explicitely requesting WQ_PERCPU workqueue.
> >
> > Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Applied it to #ntfs-next.
> Thanks!

There is a patch that was sent earlier.
https://lore.kernel.org/all/20260514135408.297659-1-marco.crivellari@suse.c=
om/

--=20
Thanks,
Hyunchul
