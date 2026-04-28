Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E92D0610
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358235; cv=pass; b=SUWVkSwFxY2E0xwg90nI2nD5ra0NSDFuLDFwSrRR35ENavKQJMyJfo16E36JOVohOH2aCq7ToDwVZ/13pZAqR/XK5j2Oy/VVN5ErkWYPYie2e5QRVga4yIET8PUg4qu5L4PyheqhgwUg8Zze0HJm1QSxwZc18TD+ltt1VrPL2b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358235; c=relaxed/simple;
	bh=9f/HgdyaIn6AS9q6SEksu7Eb+huJ4qwSgxo3Pixslcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GnRqi3w4l3tClbYZ/a24kobw1/svhdIpWGjepNYqQMMgvUusMQkvOP4qWWjOi+ZzDY5DyXn51w/dtYjY5+r0+GkYhCHkeZhEU9gM7NY6P8wbh2+TE0HOQPC0pYWVhw7zUxmRERpujj2fwvI9dF4P6M7C7oR7wyxyA1GtM8WGY/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8o6SRad; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8o6SRad"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so8246482fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 23:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777358233; cv=none;
        d=google.com; s=arc-20240605;
        b=BsG9AWnmquSll/1ED0wWfgtLK3waO8YtKrzSMly8I/rDnxSsbAnQL2kQdg5VJyLzYb
         b/bw9qKRR+bGMI8lOAutYeGmOh6tyR0igA/CDtZVgufKP7NWgPkVylho7hMe+1vxLsfc
         YgyT2gZtCIFLLOSqfTahhRe9pjN7754yyLG3W6WpsuLBxQ4TEDSJPd1KCsz1xUnSmSku
         m2cJcGfcVd6iUk5tcS+9+zgPSAPApupVAmK+6s76RY6IhJFYEIBdizkKEljLC/U3ewba
         ONU1VF1EXJFkiCdNaKDB0PWUqFBu0ioCG7WH6R4DOy7vjsMOpvJ7oOKtgvr3rPQyP5kx
         YH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=dMCPLcVQP+6Y/HjNXbs7EhK0hXID0jVOF5g7HNDp/OM=;
        fh=Hf/uCWbCm3WLx16/80PfKDmDGrlQo0Pz9jCD6Xun7WU=;
        b=DexfVHDxRuAaWKP5bejmTU0xpxSh9K2n5JEUMqYoNccUTmZ2g7Gx8+KkXcuoq/ss4w
         nOjj8YWozo73oKY6jYMV1yu0xBRDvAl153Uh8x1qU+HeLdRcOeEuI6V9/wmsGeF7GVr6
         DPUnDYWA3xdSlg36EEV5SJMO//Js4nXIycvV03YVowjV307earPZg6eL+8dCLutUBdtA
         OLej4K80fHP0RCipIcS8RlBZVLxOUv749n6V0veQEg/Anm1yTb9JGMNU1+E3+14A7HdU
         lbgTw7B3VBkFXlkpEf9/WK5rw7eTAeshqGqISfGUqx9k8nZJSZnoXixwTOpagYErJjN6
         cUpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777358233; x=1777963033; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMCPLcVQP+6Y/HjNXbs7EhK0hXID0jVOF5g7HNDp/OM=;
        b=k8o6SRad5hEzPj15ws1w+QTIg4IvAlOJWEAYujcFhFPTSXYloVceh2Gqwpu7cXX8IZ
         ZA6gFnd5a8Gi+xqInEPN6Jc8WIdQf31zOKRKwaYBx7Pbz2Smnw4/4F60PtmTCncIROP1
         pWQmwRFYbTqZrZZUpO0YVuWVlqcyLGJCWZ/tbBob604vf9ITxyI/K9B2E342Oge+DFq4
         qOGj6jXct0JY2i3SjY9cmA7D1F4khqDbBGVdyLOwYusA2hZmyidVsrzfmVGjEvMGfaE5
         BHu8eI3cI3FLO5aXjppmvF8dpoirMObQxdOOahU7LGfYrz+MU/nz9bTW1Hzp8ZRIfIor
         cRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358233; x=1777963033;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMCPLcVQP+6Y/HjNXbs7EhK0hXID0jVOF5g7HNDp/OM=;
        b=lX5xvyZ+vCsWDIQQ4XeZBcsUVHIcK5byYVRxda/VWVPbyuZ14Feci3iEdLNDIQPlol
         mK5XA5iFJlGnTTtHwQjy1FbmCWZHG4tHj+v28MUf3o56mU2VnqRMeag79IHucJ3/RH9S
         w4+oV1iKKxUk6CtpcuxXPGiwUAvzDe9kSpgOXEJEOLfbrp0CT41TupfhGz3LJFg3Kqpc
         qql5y0k03hiz3vzNVXKIfarLRzlKJ4xXPCGmMB/jBKudjVXty+AN80YFEwBUoD9nUAtV
         wT6PlkdMV6pLmzVk68RanKauzJ6LZ5xEp8Fx9J96n+Q+dLMD3tj2dXRJqLoZEfODJmWH
         /pTg==
X-Gm-Message-State: AOJu0Yx2bBeZntiW17Fi2PruXJ8YrexjJWOxJx8ZGLQD4NiE+hS2Ngi1
	tdoBtv3fW2pusYrmqZ7p4+wHw+ti9kd71mRtYS6YwOkCfop7KKTiKD+nR+YpeRrPXJLSdmPyrjf
	ohoCcPc9aLi6ne3Xp/kF5Y+nFwU1Uo7NTfJiR
X-Gm-Gg: AeBDies6EgdUvlUlihy+H+M/mMKRDkbzwFFTYKX+zyy2rNriczmthAWnb0MK9fmZ4TO
	ovASo/eRPRdDZoVgULIVz9YkfeTKaHnQGdncjZ7mWTkYdLMCPBVG7U02tRfGEsgCkcBWrtpVf7L
	GCqlqQuXtQbHHuT6vnx1RLGagwgIsMadCemmXYzJXpQ+Xucv+YbGuJDckZYOdmH58qWb3ZBCCuX
	/DP64IJJPCZGkQ/uey2EXPakTV9t+AjhUVcTXYx+tSc0DeUekENQmQWmFARmC4ovtVNoxRUggAA
	Cmu27te+d15KqJW/uA==
X-Received: by 2002:a05:6871:c8ce:b0:417:4888:328b with SMTP id
 586e51a60fabf-433f3bd6a64mr873272fac.20.1777358233403; Mon, 27 Apr 2026
 23:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425220844.1763933-1-mjguzik@gmail.com>
In-Reply-To: <20260425220844.1763933-1-mjguzik@gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 28 Apr 2026 08:36:00 +0200
X-Gm-Features: AVHnY4IdQnQtsEyAOXCSIIHwHdUdqUZwhga1ckmHNdIbzV24RdBNKM76agWndeg
Message-ID: <CALXu0UfP6Q0Okod9KmrpFsfg5L2HtRjvGjbycFu3qWd8HjwMsg@mail.gmail.com>
Subject: Why does GNU sed abuse /proc/filesystems? Re: [PATCH v3 0/3] revamp fs/filesystems.c
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Apr 2026 at 00:09, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The file is a mess with a hand-rolled linked list in a desperate need of
> a clean up.
>
> The code to emit /proc/filesystems is used frequently because libselinux
> reads the file, which in turn is linked into numerous frequently used
> programs (even ones you would not suspect, like sed!). In order to
> combat that pre-gen the string instead of pointer-chasing and printfing
> one by-one.

Why is GNU sed touching /proc/filesystems in the first place? This is
not really a stable API, and would actually be a thing which should
NOT be touched by a "simple" userland tool.

<rant>maybe rename /proc/filesystems to
/proc/filesystems_only_for_admin_purposes</rant>, or stick an ACL on
it to prevent abuse?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
