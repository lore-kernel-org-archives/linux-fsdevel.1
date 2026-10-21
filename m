Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792585542;
	b=u3lx8Ppt75WKgtaBidBXBlUamxgLIjwt4mdD/NHV6vll7uOj5GwiXQjigEDuGFBUZUMf
	 KpHnJRnQAgfgRAa3RTlNBL2Sj45/4jfxcW/R98gjVvmBCN6aXuI/KsL0W6cis5VsJ7YpG
	 o59eukiaOeHItqo9LUyDrDa7PBKJwB2k6DcIvHDHcfJfLO4DFAAwJS2c0IP6qnNtbNHv4
	 UTDVpNhalMiqm8taSwOTJ0wXxWULBGkfo2v3/LnnljIfePKIwQPydx7D5qmD8zid/2UuA
	 MNXNTZn6sCVUEWGnP79MTmu55X5gG66nK/11iluVLfwtyzO2e1UvG77YyL1sb6XzKfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
	b=ksVHTIv2F9IA6pUXtYAudJpv7cIwJ3vb9wZ2KgFFDPGQPp/9Ru1w8qWELAx73vbU7OLw
	 lcEa/BxR8RJCx6CufUBWs09eujEoG7ADNUy3baRrlWWKg30ybYZ+2BKw40/aGNRYY4477
	 7ss71m03eSp6XqeSBvn5TdVN29tyY5QtSsMX4Vp4QCXqwVhcPcoBEDZC0YzUekcfMQE8O
	 GlCjaoJBzHXMqt0H19SC4c3xeDo7mPIf9Vsa3HidzMFpXEBl5QfbPrNa87m79rsW/h+9B
	 txUid/0cMG8Bj78tv5YGxSygWA4K76S7jW/c78cDg1lJGjVyKWxlPqFpvQx6krZm3Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QcLGTjWT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C97606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C97606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QcLGTjWT
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337c7b9937so298511cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792585536; cv=none;
        d=google.com; s=arc-20260327;
        b=LlHRqNnleWR4WvqR/G6ZeuS/1nOdM6KvSA433jAabIuCE8gFLpNAqoC5WfLwQPKQPN
         2PpGMEs8JuRgxv/w5YT8QMqhfvLg5etkRlJbqRf6BWnNgcZdGDl/SMCpRd1bSAYoyHKp
         J59Pfy/N2QLQ8PjzSyHpVQzwIFNV7NDEqgzZGPZm0kToPAC3BhHw8Eq3r2TWiqgMaLcn
         zv5M2+DDGgfb9j0gbeYGTY9jR3HK3Z2xQ/c2Ml9hAyfnw1e9oR9QyUdgkHwVIFHIYNj0
         g4Nw1yaieB5d8tS6JQhJyblYl45LpSbdlYkjUCnwdSyL3U7WDvVRnj4hfGL2YeGNvW6o
         VjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
        fh=6ngsmEB0aOnNVkoLUFdh7V6D+6RAODhra408Eg+33h8=;
        b=Lcqf9ysW2DV6u6cvaV7yLMmvPG6jcq1fbOzGNKnp1679LkGczUynXP14BnpqtbRdaM
         ZzK9YBq7+IYqumeR0D+MHQWWgYIDeXyJc5+PTukQXBEa0m8dnMeNVEtUtgt3cPwGGruO
         RO6gVs9Uj8QiRm5Rgo10C3ZKrzb2ymfhTCKW+anpa2CHNsdxinSjD1ZCXVK698g/sRN5
         hD8mS1Y73PC/pCCgMd9tOJaO0cMD9nvlIDCgrmAcVBCRnG/u9zdeMNndu8Q/+XgvJoMT
         ZO4bH+3Cz32FSuhbAdagqiYaqK3paddIn4R9Kg1rzGXAe5DYgD8E+38BFOHbr4OM6JZS
         nP1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792585536; x=1793190336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
        b=QcLGTjWTwPPBYCWoIqz7nnTEZjKof43bbn+N2cXXqOUKvghC7g4YC55UuHTzzBduS5
         u5NxGvBekE6cVb/LRxpM4Fhlb7IOpgMc4uHIkT4wOmLyLzhaEbGsjLr1yQ2Zj1oFGmk2
         iSWCaKP/JaMI8hdGvcCTph5pCapEaH0Jp0OFxmzOrkDvmk/5UPPJA9OIV+H/A9dvClGt
         5UY6V9qOSMPL7b+v11w4uRNGWnVKqUMd3DRVJ9vlWkjb+YtddlzbRi+0tBQ4nBV7ApMi
         iezj3vkUKORHJyZp23cCr7TnO2fHE4VoaTe1WL/HsPUt+VlClE7d2SjkgT/+fLQjPBuF
         Owfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585536; x=1793190336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
        b=Aw6saf7kECOvlQNvPCsy/k2XjZjRdMpdvFBlCjMWNBjBqpcz81CRWADKVKVLbTJpUZ
         zM8xoLymFGQjPJICWO1wl6E9enVLz5r4Q6++gocrvQn5m9Unt7CLrlhguYl5CqsEVwmk
         zbdz0ccSElTn9ueFmmeblvj+xILLOGY7xnTC78YYdyxU6SujytuTkTqJworoLC0TEzIi
         +ZFqUT1pfEuLaJ8DdOWrVLlkY4hE38BCkk8Y6gRF7pw6LwMsnJ2vtr88Kh4buezzkKSy
         nd4D6hAAyoxaBAdK/lY3DyNIjQ7JJ7541BNrbqgyrWrhkfM2BT+rR2hAgNhQ3bTlPPu1
         T3Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwV+elxpwAQpCcn0CbodsxcuDG+7jElU6+LrMAHqQTSXATq8zVnhc/VSGpfGMWKTfrWNiiF+uz0z1jIxKY+@vger.kernel.org
X-Gm-Message-State: AFq9FYKF0p4tqHGfHTqazYdt7WQ6LCo+BYicINnzpCZANktTHMFiTneg
	+OXZfY9og6ZWsvSeI5wBaV1h/6uh0ryMZ9pZnAU0TzHqK/cCGtpw/Uz8+R8jkPUjxEPvHKXc+TM
	VuqNbTsIMBYAFM8uJZ8UMBDZmeBK8lGKyX25fDJM5EPYUfIQcILJEHCFpbpg=
X-Gm-Gg: AYBFou2V3MFkrHFiVWXXZLf/dL8LG9j1ydt0+huRLYTjeFNzazBdIrw4pce+/koon4l
	WnE8D2GDDJg6QBcowTrLAuxpFOG1QSGQw81/ASwyDrjmBRBeMMjY/dTtmXPchQfrL/FTSpkq8oZ
	SJUBLHOf8x7FRfzhbUzW1AHyIxqqdFgWcMbGJWClsZFfd+DNr1gfZAeommf/fjnqFpECubypJNh
	re9haEJ1oKvZNWiUzq7S2QihW0wbsTDo05Lb6kDneo32iVK0/eY/anQgBylb0AdssfZhSfJ2/Zy
	3RS8kNwxNVs2mZqBrZJxzHWqrz6RPN7KOmPqTCZpJ+UBe8GrNJxOa3uiO5JgKQjhSuAURZjgZLp
	mhl9MVl9UvD7pabUUtFQGxGtclRcB+fIAUX1bl2MFHXR96PUvEfhVjOr5DolpW1qhF3Zz
X-Received: by 2002:a05:622a:1103:b0:534:313:9b4e with SMTP id
 d75a77b69052e-5368512568emr39727821cf.5.1792585535104; Wed, 21 Oct 2026
 05:25:35 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020121159.2154649-1-sadrul@google.com> <20261021-miserabel-zahnrad-gepachtet-9bacbeb24a4c@brauner>
In-Reply-To: <20261021-miserabel-zahnrad-gepachtet-9bacbeb24a4c@brauner>
From: Sadrul Chowdhury <sadrul@google.com>
Date: Wed, 21 Oct 2026 08:25:24 -0400
X-Gm-Features: AclHuK8aD2JqJ1CUN-PK4H1g53g_Wt5nf2Vtd4t499zqOIAxdZ1WFXXEm-h8zAY
Message-ID: <CAKgcGXiE6U-oBJ1sJS4fDurqRweSTdgYfoewLaTSJgi7kSqC3Q@mail.gmail.com>
Subject: Re: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:54=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
[snip]
>
> Seems you generated this against an Android tree. Generate it against
> current mainline and resend, please.

Thank you for the feedback. I will resend v2 shortly against current mainli=
ne.

Regards,
Sadrul
