Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB3E5EF8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147542; cv=pass; b=CXU2nAIuOde86qQ6KjWHWaaggpm5JvJJ+vK/qxuKEuBjewDOWqB6bcVXZnEtJq2C0IDmzx+P3cWYOH5G1bmCGCaByl6rm71mG5FwuEAS7o93/27H2T69MjhTtYIymEaNhxe0oaTYuJNMuDgPlXj/hNMooQHsjaJrgsRRxLDptNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147542; c=relaxed/simple;
	bh=3rGC5t73vzjsE4isLGN6gcRfLVqx2vV7zj/l2qnrfbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlEdm1o3rHBv8RxWgDZI4soQWbHXEwGBm3FhRf3QY4lZROKrh72X2/pLhKJ+p/nPyBFkFjiDpnGR67YCg9vEh8CC135XloNLFfGkEGhl8jwfs5AqdMFTg3YWJBOoEca8QMMoCAF/PwjBKLc2p7dB1qmiGqqgF7aTu+7wmdk7gpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKd0tRpw; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKd0tRpw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1544379f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147539; cv=none;
        d=google.com; s=arc-20240605;
        b=FHFBiTQf7jPvRpXYn7i6PsQSjvC7BmmhNIj8+jk8iCfn8pW9aPp4rKBodfMX5qC/F+
         v9APm493gAWWQjdZMJff+Wdak5WWrrNRk+eeUWJuLrjI7rd29Mje1YghzRbWki2GVTV2
         DuwyleYoL7DRuwRQec5FLUdtEiuoKgVcOSojmjkPtkIfZ1GkTQs7ejs4Qh/1EOwtYTKu
         IEbKnYEDovl2XMLVSFJRVWhE1JipKoPIk3SbVimZjV4CNo0QLVK02mMS3fmyu9ibvkSv
         Av5IqBC/DnVIiVZnXaO40LgO+q/Nh6ORjCREVb26MNxzkpcvElIaPG6/2cx9hJejzENG
         alVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vp4MNzcCedf5x2a4aXVZOAyoExIlbvVQis++ipw9Jbc=;
        fh=O4LSVu+tST4iccOM59zaG8C7Yka7TxhG3uRYsDttIJY=;
        b=hw4lc5VzxSjWAqq1mTWu0R2eAb2lk288EDnx6ctdC9Zob8tAd+mSiZfnIlxoSw4+XW
         MY91fxV29AF3TSb1zP2tfvZgvOQNyCkZvBofraMdnRpxRTKg1bPGgm5Atyi2Dh44ALWw
         k3wsBUeEoF4NSqx8jihWKmIxCfzas4Xcz7sT4oBMyzNr660CvH0odVEflXLtJwaxDFt3
         y5d7V8it3I92AvPxXWn4Ltjlbl2FvNj+R9QDJz+SHE+D5J2iDwB1l1Iy+Y59ljI8z+i1
         S0c2qM/IiZoHkFVhiyv36v7YTIE1kpG+/AGB1nVEY4OAJI5qteyDwx58NCcpOxM2RReS
         V4Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147539; x=1775752339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp4MNzcCedf5x2a4aXVZOAyoExIlbvVQis++ipw9Jbc=;
        b=OKd0tRpwK5qVV7VkNnB+9HEO22EeEFLIKqaZrSAn6Rbpg+sYBkMNEruT2IsWLnKOu4
         XisoLDB6lU3lGd3vrKiiYik/6lWDfP/A3decFfBKLuDDbXV+p8E29lYoWhzWiAbphpyC
         InZsTiL2Yrz3jvaUKM54crVEg+nMelkhklEDO4PqrovCBGKVICDVOTHR229fd0wl0jZW
         KRqX4i/x7ESSwsb5FCksjjZFuHaLYs/Iii5DfPrDD2sJdfpEVpmj72/jmPKXzdEFf5A4
         pbcWXoSb4fbmaaoFQpVzBoj6q1nP6WPGjid/K16J/tqwTie8yg6rXcAHrw6g56YJKONJ
         YYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147539; x=1775752339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp4MNzcCedf5x2a4aXVZOAyoExIlbvVQis++ipw9Jbc=;
        b=ba09dt5iDm3fSAqSbeFF6WIcQnRlUzEhBWOQBi9Jr4bd213jYOaObhD7vZ2AtBaQpm
         7/FHgQSOoTxEnoK8c7KbvxR2ZcjBsVOWCaLvj0hdcWYFEiQgN1YOpc9x+GL0mltIcvjv
         hgiY8RUG12VuYqTEdyiSBScBVIa+KtNwGPCIoJesTXnlctW6o7VPIXwDHy9PQL29kfvq
         1lCSvubuf7VpYNtjgrQHKKVJINeBGcJDqMjpU6J/oBrLZa9W2CzSIW1veqN0/of4tEkK
         YJM4JDoCXrNCnC8utsQ06K+l2wlst42n5X3umgjN02kOEXXKLWOTz7hLlbX5vi2qiZdA
         IklA==
X-Forwarded-Encrypted: i=1; AJvYcCU/xgVI441cvTKE/qWX9F+nY6BDuwLxHDhTauALmVI9EsUyhWsyFNyvuNX27q6K1m+f78KH/HduObLqU2nD@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmdrKwT5I4rqOCl8RmY0eHB2hhzMRzmlIEl41wN84MJd/Jf6h
	1PNv5xUAMoUA5jq8hXGk+SGCYwOfaY5bvls8l4S+9Jx9aQ5xl2bWMj152M/ntaZ8RmQU5oVQPD8
	ueQSoQcwDORlCpyOs/pVlJB3KhHiPylksQLu3
X-Gm-Gg: AeBDiesCohszspLn1wlobVaiHG+oDsgaR1lpSY8CNWk0r0uFo45sGqcr0jCvoPS8Uzq
	CVWY1y0PidRS7BDAwldtFo84a62zf+HuFBSLSsAQhHfgEyp5LPKV70NMXXGpiiz+6utsFxgCCb2
	G4YhpW55fVzv6pSAFjZBHwWdnBJWzBUDQbRkOVT9uMMDN4sOlmDz2iLM545JdWfmuSZm5w+llKU
	yU4CZ7e+Yf/WwZz009qbqFZFxeadwAPLczcWgDtRW0Uub8VaYju1iRZKqqbJN7HZ4Ur2Qosxs+i
	OlBi8A==
X-Received: by 2002:a05:6000:144d:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43d21199d74mr5350789f8f.12.1775147538819; Thu, 02 Apr 2026
 09:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401184915.747714-1-joannelkoong@gmail.com>
 <278724ec-0c5a-4b3b-b4d7-c5a3c0ceef3b@bsbernd.com> <CAJnrk1bH2_hk=mfbk0Ac+9UQV7bPHuD9CseWDhj623um7NmdgQ@mail.gmail.com>
 <33b0c367-d1de-470f-8e26-4c66a54cf48a@bsbernd.com>
In-Reply-To: <33b0c367-d1de-470f-8e26-4c66a54cf48a@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Apr 2026 09:32:07 -0700
X-Gm-Features: AQROBzA22XfKoWfe1Zi3PBMxICAwbta_mmHrPbZpD1WLQSerKVqwm8XyCFfVB7E
Message-ID: <CAJnrk1YFU7vb3DRhxqD7p7VZfiza3UY+vDhFZmX+ov-pU+HzUQ@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: fix io-uring background queue stall on request completion
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:11=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 4/1/26 22:35, Joanne Koong wrote:
> > On Wed, Apr 1, 2026 at 12:49=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> > Hi Bernd,
> >
> > Thanks for taking a look at this.
> >>
> >> On 4/1/26 20:49, Joanne Koong wrote:
> >>> When a background request completes via the io_uring path, the
> >>> background queue gets flushed to dispatch pending background requests=
,
> >>> but this is done before the connection-level background counters
> >>> (fc->num_background, fc->active_background) are properly accounted,
> >>> which can leave pending background requests stuck in the per-queue
> >>> background queue.
> >>
> >> I don't think it ever gets stuck. In fuse_uring_flush_bg()
> >>
> >>         while ((fc->active_background < fc->max_background ||
> >>                 !queue->active_background) &&
> >>
> >
> > If the queue already has other background requests in-flight, then
> > this check never passes due to the stale fc->active_background value
> > and all pending background requests on the queue are stuck until that
> > in-flight background request completes, no? I'm rereading my commit
> > message, maybe the wording is unclear - do you prefer it to be
> > reworded to "which can leave pending background requests in the
> > per-queue background queue stalled"?
>
> From my point of view "which might reduce effective queue depth to 1". I
> certainly agree with the fix, just not on the word "stalled".
>

Sounds good,m I'll send out a v2 that uses your wording.

Thanks,
Joanne
>
> Cheers,
> Bernd
