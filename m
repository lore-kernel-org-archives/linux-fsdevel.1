Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64777383C64
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079784; cv=pass; b=Hp+NFw2l2dgXV3yKqc+h1FkmF6atmUBALl+xf8DJVyRoQDEMfYcahi1JgbfGLGd7KAvtTfs2NOI/TuwjqUAyBYxgiuV3ftpDvXB58ALOrM+rGeCdBJrkYqbtZT4hhFntNDcAq6z5aHOiGgSY/wYXxPZOhh1VnFTmY9dTpnqHzdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079784; c=relaxed/simple;
	bh=4cNtNZAWWq+jGeeWgIyl+McQ74gysZrBI/pMSmDn30M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suXfsimIZ5FBdKzYda9R8PFEhIdTOXVWu0c5yxH84bShbv8iSFiqwU+MqTjveBZ16nA8akNW/xgPoBX8p+YAXiwvZWz+MQ+KZTMJLAxgs72NGTPRYLmJ0qSu9a0aNVkq9rTrxsKkhUHZkCgZ5mVwBwyheSVsk510NN+vv7ni8E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o5fnqchZ; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o5fnqchZ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5176465a4a4so87573951cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 01:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781079781; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtbmDHFRU5LeKLCTyKLT/1iO8VtfOAOtWdr/33QokH69eIHLtVpTDDwZBZcIGztQmE
         xQZRJFfBk2zT2j4JP5AfuWm5485H4C9uH+7A3HoGQ8Z/pr1yRNO2td5EAlmJ1pOmkaV9
         ZYUm1Y9hja6QrTDUvK8qZETJAccreKEelg7RnL1rng69fGUakEjk9JlHfNvZ2E+HIXb8
         dJ0Qnc+LoA4AefRvk164CZmrtjyPJvwEF5dY0Lgf4yTmWYgZ+d5anptouAHRkHhztW6D
         glvZHIin5b2H7CRFc1xJuvSo/N6CmNcUMF8m3DaQXlWgAQdt9Vs1edNvbTgz1U34oGEJ
         rfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wag08FDWRyT2U0JBvi5dpn7zBxyQeFgc7pRrkMGY82M=;
        fh=tCeJNOxy8XE63pjNUSGs8mhzrAMS0KiW9rB8clAqLMY=;
        b=K2Gkvaq4dEPAdBgSkI5d0Gmmj0Idm8cgloWPYR1sOJLm5kjyR7cIL4QrpKKP+3ywRe
         wA/fzM1LWjXH4ImYYSgEtrhpL8T3CY8On4NDCHsyD+cQn284YggqJHleOs57kfDWQIVc
         jP/KvHimZQCDZMWyRpJm332hRQzuPkEG3ZPtsgf4yPd0EVnDjjEjtqMUA4a2PqG5byOT
         N3LWj6nuB302EjXdT8gZws3Ev0+ak5r/47Wuq8tiSd2Exbnuo5uEefThuVxcYqmhwqgL
         9yZAz2eTGJjQGFaKjstEcKWgXSB6R8mABkslG9Bp/YK5NqiHuyID8NpCceOyAPT4reyg
         CyEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781079781; x=1781684581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wag08FDWRyT2U0JBvi5dpn7zBxyQeFgc7pRrkMGY82M=;
        b=o5fnqchZHzh1ZR8kF1TVGtk9MHYMwlhWgUT+WdZGrvoYVm3jheTRInMqqE3LVHnJVx
         9vR5VO0l/iWl8V8s6XXBB1MPKMoDhKpKI+4UQmhgvlZc3s7hOa3equQjmuxEAymlLHO5
         xtuw7Ux0c00WwovfaSThCfHwSyr8GmlatFLhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079781; x=1781684581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wag08FDWRyT2U0JBvi5dpn7zBxyQeFgc7pRrkMGY82M=;
        b=AzC4MNeeAWxsZoCimDJ1weLvyuatqDELFIdpdQnw1OCNM5lMQjYQQCTT2J4tpyqzxS
         Orm2KL8b1TmrtsHOPUxLiK7WorqOfF8+AmgekzLmy8jclP55LSAik7bxlRR2Hawiqiik
         /pVy8D+GcDwrLfNSLvGSEC7JzdI8uJGePv950zIWHMDWPCKzJXPH3GIETAlF3fOI6Q+8
         J3UWrgYaNxHACZKoAXnAUK0uD8Eu53KKEoYAJ1N59ZYynOn0rbHb1TZR8I28AV0EI+0m
         +E4w7hZrrLyTqWVwcA93BPVmfWfS7FAbpJD0L2IGNF6UvWBoAPaKIC6ppsely9iVqmUJ
         HrNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ga0X5v8fQKOkvKg6eCVjVbjjhsm48Lz/+lReR6dhw22pa8Y1kcp7FH7k3/Bqzl5W/lsA2Fr4OcOl/zJMY@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRswPvTrcFvb4shYt4ddrbLbvMvJE848+vzJ7dV8u4vmDALyL
	HW8HvZx269mwOoGdpGj0l/ctJpkg9fmgp65UMJIrCmp37m/MQAKUpyFVpGOzqzNRhOV4HOS0coc
	u6cpHHCyzHAaJeXq/mDIPPtCq34F9vWh0VLXBfgYQDQ==
X-Gm-Gg: Acq92OGjiCcSYvn9WacbbY4TLgSC34dvAFT4MtPD/AmjVmdDjIRM+JwuJovn5/WuKwN
	4V7nW6yHOgCUYd+SrEsV4cN3zBEzULE3YuV66vNBBuSebEhwgK+yy2XeqXoQaKGiI1pe1Fwuqes
	WcklCXYaWxRr5T2smlODeSMdG6EN+5tpNdZxXJsijRwLLk8rotZZ1bmJgkeuHRD2tP/yautnyHw
	iyl29pvudmz+FML+XZrF0dsn0tVOsKZS4qXOAKwHLBUkg4HP50RufwTiJDFeAybxRrixF8Y2MhP
	RwgIxVVYujVkUL+PpepJB6bmmtutPe+o3fB/+I1xs/nXMm/WRKs=
X-Received: by 2002:a05:622a:4c07:b0:50d:6b06:a453 with SMTP id
 d75a77b69052e-517a12d2d82mr287271101cf.18.1781079781442; Wed, 10 Jun 2026
 01:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
In-Reply-To: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 10:22:48 +0200
X-Gm-Features: AVVi8CeomsE3hVw5JXLSytVgyxPdlTl65ZBd7heug3uFquccxMZA1_dt84I2azA
Message-ID: <CAJfpeguWuuhmA0sPZkGjefhg1G8VCo9A4xi+SOF+R6GpPw1iBQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: avoid 32-bit prune notification count wrap
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: stable@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 at 02:38, Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> FUSE_NOTIFY_PRUNE validates the nodeid payload length with:
>
>     size - sizeof(outarg) != outarg.count * sizeof(u64)
>
> On 32-bit kernels, size_t is also 32 bits, so the daemon-controlled
> count multiplication can wrap.  A prune notification with count
> 0x20000000 and no nodeid payload passes the check, enters the copy
> loop, and asks the device copy path to read nodeids that are not
> present in the userspace write buffer.  In QEMU this reaches the
> fuse_copy_fill() BUG_ON(!err) path.
>
> Validate the payload length with array_size() instead.  That accepts
> exactly the same valid messages, but avoids wrapping arithmetic before
> the copy loop consumes the count.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Fixes: 3f29d59e92a9 ("fuse: add prune notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Applied, thanks.

Miklos
