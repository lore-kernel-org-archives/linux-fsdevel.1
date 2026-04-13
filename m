Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4283CCFAD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086619; cv=pass; b=HWD/L0oh2MAjMbwPDGXSVDiGi38Os6cFGBsnJnawoW0BhzAudqVzYsA8YdTdH46/gby9cy524MyTMogch4xqkEmde/mKSndkd57mMKnT2j+CuRul6JYaAw1U11VOapHlM66NXyqNeZmpwMb/nRdwUNmRyoUgY8CvEPnywlXsKew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086619; c=relaxed/simple;
	bh=QzKaeI6WPSgIttkMhnDptsTjXALo3StAeaiI70Jux2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZtE++mGNBjhFJYck6iUK1sVufwfqN3fw/BtCCONR5et5WVEY/ZDMA8JPRt+uEi71D4VRlNZPQhgm+T3cONjS3PO3cDFrPqGAa4sarAfjpGNc5ihe5KPpKVOybMy4l2eAcsoWyD+FFWv4ChOlr+WUfEi4bFyaySpclhkbrDi8l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fp/+ZUGg; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fp/+ZUGg"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso51959286d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 06:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776086615; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7c0B2X55BLuZvqsuAMQCwTDATUPT9/+iLFAbtke5CFtyciZZWZih1nzmpyvsExnOL
         NDsztWAOiGPOzv8uKiyrmEqkg+kc286FW+q4vmxcKxAKk+U174sFOAQMU5YxHYvuTceY
         JgOgFs6somOY01SsAVH6ePmNfoJFNdwdsssN47wXjcsU3G7RtDdWCO57ZxHiLwNt5bbj
         GQCVmoh/ZCQX1pp9lMk873XONYQXb1xoqH+dv2/YOUZz1trI5Z8mcTzkbEjVu7DogMkE
         85u02U9H2fjWlxLBreWvcOFek7MtAaZ4oM+KHRC8dQK/XIP6aWYtyviwv/ZUQhlPqNbi
         WLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gAv99SspK/11UuQDDngxqfsyB9YfX5hNcxtclQz1Ioc=;
        fh=o+hmex0fCZ/pQySN02kw62Z5SkTKe73c61XkNLhnWl4=;
        b=EMQkRcCAQhYA75QcwGl5l8U8tl3umbmZgsZIGzHJLRujTFdcSwqwl1EU7NPzppaG2B
         XBRNCg/tWjsxTiV9Jp6TlgrYzaHQWf+ClSl2zDQO/lIqcDVaENtUcK04YLtxLzP9AXxv
         M4ek/FsfKbf5Tk+Vkx7y8yrNAC72mbOH6lqbwT6n+SBw0KbC2GKWvOI6teKbpnJwDgST
         yXrN7FUXM9jbUezJvOCBLaI+UbKAempc+H5G8pZCfsvQYXAYiSRBMRKB7H7AoN5daa83
         uJg3Jspq5P78Fcay9iRJS/o1xxl766Yirve36h2U5xTTGPTNc3y7H6+JwK2iB8ynkb2f
         1UHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776086615; x=1776691415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAv99SspK/11UuQDDngxqfsyB9YfX5hNcxtclQz1Ioc=;
        b=fp/+ZUGgoEICn7wPBRmttJA31MhLPi1bQQuLJWfefrytc3DLmqi1W+K9saVP5ld+2c
         xcwM8PmhXh37BtKZ/CBB9BiEuI6oXh7Tnp4WtV04wYsKlpokt5NUo/mzimejRa4NGr4o
         T4hw1FjkU90B65WHo8/g/0uHFXJjHD58L9aa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086615; x=1776691415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAv99SspK/11UuQDDngxqfsyB9YfX5hNcxtclQz1Ioc=;
        b=fs1yp+onyS8iuXRkV8eM82AkhuU1ncxrTfLs+Rct2BfKUWq3udvCN55B6e/P4Ie4Ck
         2Ld6uoqn0HV6kl9BmTwy5yRYdRkBnGETroJqsWtoBtXlBF2ccfP8f7QYSurY5iOw8taf
         WgzmU167wzFt4yT3cttdyLcIW4kfZQCvuqRl7M4fyTbu+mKh9PYAxfMHfYMoGlkQ8ZGb
         eBKYHFDhNCBQ8JCX7OGeMrQochPx0GLe2h2UBmaZBL4J2w8ubAhLB+1Zaodwe6eKotTc
         iE3km0+AeTpEjhTVg1GX+7tyst4TVt5Ah2txwhreXZqe5GcC4mEKh5eUMAVN3cYfNnAH
         IzVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K44/XY1ma440RnrRC4Q8YYZWDcJqCqkvbn2y2CeRIjzkEyinZEIlnU+Hz4D4EgRGFLyyttPdyLYBnAJuX@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVdzjU3KbxPE5wEJH2z7TG1YO5n14wmbzJbCjb/UOjTuYRrPA
	A5mNZ9e6H4zN9Rk/X5irlR2p0a0/Au/TLS4rtW+U97MmAqJqQC6bjGOR2SqKjhMSUY3jcfPfRTq
	NUefssNBXrQBzAfp2VbjK2XXGHgDplR/QadJsSTF9HQ==
X-Gm-Gg: AeBDietB/MTPsXOhO1Fq8JznX7DZZpeX+MWydyGN+kUhM7s57FUMD+ezeqxfzCDYkTI
	4EcxxknkPaPD69nXm4r7ZxO6YU1/zgilcz0/PhYPG0PiLlseKfkqcDX/pZlRhAw2CANsspOgTG8
	C25i5VbA6berp0TWZuFWo7wg4GZFQBdYu8qFAtNAnU/Gi5hq0Pd9j6tqaqbFWAFX7tZNeD/yHN2
	oOA61IksnqnSurDVh7hrLiZ9SpljWwOtU4l6eC5JDJH0V12wOpNedhECdXQeVmCKw2SQ61T2j6K
	6/qOd7TDFHZVeQtLturPdQOn3KLnTl4mXyC4
X-Received: by 2002:a05:6214:2dc6:b0:8a4:21d9:bbef with SMTP id
 6a1803df08f44-8ac8615445cmr224575296d6.2.1776086614742; Mon, 13 Apr 2026
 06:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410144950.156160-1-mszeredi@redhat.com> <CAOQ4uxha9ki24wyW1z2AtQJ6kSPgGbSiTaPw7DcBWkhDeABoDA@mail.gmail.com>
In-Reply-To: <CAOQ4uxha9ki24wyW1z2AtQJ6kSPgGbSiTaPw7DcBWkhDeABoDA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Apr 2026 15:23:23 +0200
X-Gm-Features: AQROBzCrFsdiJjLrNRjajLKEFNFFmtYMjZIyp8WKcki80yobWJU5CO6v7xxudkI
Message-ID: <CAJfpeguziBrBhr_iXXsRCkw1G1iOx7NH9GUDDsCrrkr-9th0tQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix false positive on permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Apr 2026 at 15:50, Amir Goldstein <amir73il@gmail.com> wrote:

> Locally, for mark iteration, the fix looks fine, but fsnotify_mark_srcu also
> protects lifetime of destroyed mark and connector and I have the eering feeling
> that some of that code may be relying of the detached mark to either
> have a ref or fsnotify_mark_srcu.

The fsnotify_next_mark() call in fsnotify_iter_next() does the same
thing.  Why do you think this could be different?

Thanks,
Miklos
