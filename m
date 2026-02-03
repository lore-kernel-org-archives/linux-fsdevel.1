Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBE2F9D85
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105341; cv=pass; b=ZIReCUabCuXhUejOp2vsTdAjxx+sxMu3eJ8Im+W8sdrt86Mhee2zMmrofrr6ef3lXxRN1Gsa75QFYLLEXJ2jeH/G6/B7Ss4GN9x4Gu/E69TOQ4lrVeK+0Jc05Mq4PCRbOwG0LMvLVeIQUd8KAH6uT5NrjDcP2WNPICgYJeHZoQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105341; c=relaxed/simple;
	bh=5zgTNmIhWhA7m3p35BJNZXqQ9Yf0FUGNgnoG2L5QPnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owW2k9PPvWMOmvPbeYt9KLLj2q6XvRZuY43CqlXmaCkDQNg/KpfuSRd+ox2AwHX7b6mndYXff7RgoGzqBhrFLHebeowx4/KpuKS2H/PRh2ZTLSWWMqKWSaIpgvWpZ0eWu8kJsAezyktIsgnDVCr4rx9ZE8FhckurXvxaFsMOV2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Nwbg6FFD; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Nwbg6FFD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6a7638f42so784516885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 23:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770105337; cv=none;
        d=google.com; s=arc-20240605;
        b=RZvCODSmj6j/oq0RvX/0NTkz3fWgskgVKkD7SkXb2kKKLSJ7tm5uvFuT5FrPoZH7GO
         fW7PEC/2SqhUVsTsg2eX4RR6JiJC0UoQUN1JwNe9qEE7TcjzkvaF4Appug2xKbOCykvv
         YtReU8RnjpTR3e/7e40SnE1TC9LERZ2ep2xav/rUqkhQTMH3d63hrZnFSP/18f9fZR7e
         KmoR5ZX3pnj8fUWUMbU10uIHmil3f9yrb3PtL0jVNI/iuWTwjq3DKJE2R6SivOG38Qgp
         dvk4pXMFBfkwPk1X277cH+sVeBuOn0JpZ1yQzRY+Ug60CpN6m2Rx9SKCDOW30/RokTBd
         ArUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2flPngwIq2/P8XftOg0x7gWZfQP34SqklAmX8Cn7V7I=;
        fh=Aj5k/PPns3pA53EwTXjlXyOqYicOpgmM6G5eJZ/JOVE=;
        b=eD68H7DrLawpepGHNWSkTy03saYJ/ba2DGv7m+2kupIMW0y1gcDDAk2dTyFd6ASL+B
         byKY1miKSuEFzKSNhHADbFJ3nB/PBvgt58TwX4jSif44+3e0kjh4cGAKPXvFGQBDFHm/
         +zzOx+Y5zFP3NeFTLB9ObqoVNjngQ7qcKkj3miWdTL3+E5OPQeO4ilVCaHmNNNupuNq8
         hxhzH6LEKQEB/USIuVAgasy2IH4RGxQWCswGnib9+OEEijUaa1YmNvVbA5NBcRIbo2pv
         v2RgpO8+xwy4vqTu/97QITCKX/lKuOH6Hz/9q92bOnYNtX9ZexFRh0mGWZ88zmkmbZgP
         4HEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770105337; x=1770710137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2flPngwIq2/P8XftOg0x7gWZfQP34SqklAmX8Cn7V7I=;
        b=Nwbg6FFDVULL1lPmwvxbyobZaDL7Svr6YuM+kWDBqMqQIedglRv7PaVpiO4zPE+5Wa
         xCekdeSqgoPLF1yIkYHbYTfUBWIWAlkmdYMwhdmC7XinMGzwGd9J0H10oUqHf20Dlbj6
         U/PoQIJX9ldu+RiYwQtJUFwbyrjjh7XWrhAnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770105337; x=1770710137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2flPngwIq2/P8XftOg0x7gWZfQP34SqklAmX8Cn7V7I=;
        b=DNQxX4rZYTl/BvXi8/khaDlPe1l0QmhrYz3B0E0X2DeT1S0mbHMdku2KeDz1aZfC30
         Mm3hE9nPsyQOgL1ZBg7grJ/YSOqiqgEVh+ZUJkNCv0zpdcoVgak2Ag2/W+7w+uxJXWrh
         flnIm66UgDEuMXZMiYMTItKGmy8g/owe6gravxlOD2dP35XtYfJE3TrqQqUY0xnsFkW0
         T1L164qApseSE/vrIcwyyVgweSl+bCfm7V4P6izOJegOV7Ae14J+JrsdzdT6UKiv4p1J
         cOqedWDm577EF/cIvXUzx9mLYetHC2xWVG+uDJAuPuOwdVaIimgOqclqjugC+DZffgJi
         BDLg==
X-Gm-Message-State: AOJu0YxfBQnRoYyWw/kCXjjSOUXp+tVnfZ05qS1jl4f0rRvGX3sDoNh+
	PtysvPI+bBH20rujoMGWqOh7ZCkktJCqXwHzdOwH0lYvhK4EwqSKJakZ2I3ttunSo5CM3NfTAh3
	5BJ2SzbzLx4fytbnNnClpNhTOjB4Kts28DWHczuHOfA==
X-Gm-Gg: AZuq6aIe9gwmyMo8qfYPVBP8O+zWymHhI72ATm81+BsB0pAN2CAXZe/AtL+PGy8naOX
	YF+u4VLcqfapu5tZv8nw5wSS53Vmfq9bVIBQjOwbGZB5avZcAULme2rPLTQPU6FkqUrh2n9vIQQ
	A/hzmGmMGOL2gYAtvmbK7DBNgjXQnJ1vwhgsn9Z/xS9E1zvPNner4PCwj7l/3hRgOojpmcjDrN5
	fXrBSTybX1zuyFojJG7PTwgIsPKilPAz1ceDLp2NOOlxw0qi9Wbse5vV83Q0ykg7yIu1cY=
X-Received: by 2002:a05:620a:d8a:b0:8c6:e579:a81f with SMTP id
 af79cd13be357-8c9eb20a843mr1684415485a.23.1770105337168; Mon, 02 Feb 2026
 23:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 3 Feb 2026 08:55:26 +0100
X-Gm-Features: AZwV_QgDSZ1OY6afRC_yJ2WaAbGd4p8iRqWRedeDCrLhcISoRa_U_8EF5LBMiMQ
Message-ID: <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:

> All important topics which I am sure will be discussed on a FUSE BoF.

I see your point.   Maybe the BPF one could be useful as a cross track
discussion, though I'm not sure the fuse side of the design is mature
enough for that.  Joanne, you did some experiments with that, no?

> I think that at least one question of interest to the wider fs audience is
>
> Can any of the above improvements be used to help phase out some
> of the old under maintained fs and reduce the burden on vfs maintainers?

I think the major show stopper is that nobody is going to put a major
effort into porting unmaintained kernel filesystems to a different
framework.

Alternatively someone could implement a "VFS emulator" library.  But
keeping that in sync with the kernel, together with all the old fs
would be an even greater burden...

Thanks,
Miklos
