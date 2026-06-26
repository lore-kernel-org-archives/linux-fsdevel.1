Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51913A5436
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487940; cv=pass; b=BotAleX+8ZV80Dm+5GnOffRBahyw9jT3CojJpEkKypspcWDRE+UBHj8sxPivIB+wIITt9dP63HNZDHOXNtZQy4kXrMi/pidE6xcjyRpFyo4AJZquQ4AwwPZFq1Jot8f5HeT+NjlRN13SKMb/6w1v3eQP0dKJoVsOxItBTkTD83Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487940; c=relaxed/simple;
	bh=d6Z0+Z5n5NK6NseC4Bn8pJynC7FdsRRtoEpWod8dOSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9oaPG6B+p63HqQCntCRt8NpSjeR2FA0Vq6+bmO4c51aCUhpre3sGJYyNmGtBzvD1yobIByzGF6cKY4X1T7PJpOnCWcEAfq8bUE6EJDeKMSRQ2k6Cyxh/7tLfwJIwXc0RyKao9h50j9bFtL6xQ9d1LvXOcbNqiZv2ufOMNTxThY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu03v1kf; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu03v1kf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso2109941a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 08:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782487937; cv=none;
        d=google.com; s=arc-20260327;
        b=RkuCcGCtzE09EbvZE0dCyHyHN+kxaEpIWFIJEP6JAKnWxQAD3sR+9/pbPOEIFXi+le
         23nH6UUb2J3/PhKAQz04SgHtug06C/xymuQW2lzD9qMWwYFYTLeXI2bRjynOBtp7b4cC
         xKgUPZCI57rh+ishw7wxpKRrapWQ9rS4ofndUZ5dXikfBFMauvMyvPcTIHa3bMnp1Btn
         hNpwbbavYHohN+5fEBMylGM1rN9LY8VTT9qoIDWGS9AysOsSZAuM4XP3UMrAdng5Mgq4
         bfx/IzqcIW2AT+gTRPWCFlyWPx6jJ6JRwE/JS5rdFzUhnemzY+shljQVT9wO7yblTOsp
         plTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6Z0+Z5n5NK6NseC4Bn8pJynC7FdsRRtoEpWod8dOSU=;
        fh=2QnS++/UfNBKZxI/DDxXNes6EhPczjt7ahs/ENcZTDg=;
        b=djT+2lthIx5AfZjUInvYFLc1Hb9Pl6mJXhBRIvAyG/H9ro0qd5m4gq31TpnRUCeaDl
         IhIxuWE2OtjRl+rKaFCRxpD5zlK+NTVOe77uyGZo/8Ues0q0jWOQdBPy92XzpMXPMrQs
         LX48j+9oZ4FHDNmVnAFq9JoQ87bBWj7K1v4ELW+Zo0C5VK4NeVjdTnxMWjISFkbBqiBF
         /5uCmCfgSiH+yxCjpvqKV7auDGEywsEaQNB5W5ktWMLZ9MGI9ldRZWh7F58qMqrr5XB7
         k8EcMDUYqIkQtuFJ0u9JhzAW4sWZp9rLyMfZJNKJZWg+CdKsJGLNZNk5waBLX4gob5yZ
         gQMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782487937; x=1783092737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6Z0+Z5n5NK6NseC4Bn8pJynC7FdsRRtoEpWod8dOSU=;
        b=bu03v1kf+16eRogg4fAHyPP7Y/2kGl2sTereeyns7IWELnPU7HACy+HldSa7n7mGaA
         5yEevLivaw2lg8rvVC6SB10pbxhj/FyqoRZh9vRTUYSs2c5K7EMI53B0fJUn7fjvARaQ
         DPLi9fCq/rN1MnNI9B+7jPiYiDI/EUJBcBwZWveqskrA0wZN7X8OJRSGvGoyovfDVvxH
         T53Yi4iugTefd+vtlJalgDXQNSuFy8hyUPhQbp/j/x/8nlHg65dncjd16Ah+HI/PB4So
         uiGMQhNO1I4x3SnwhFhXS2TKFgRjXPDUwMeYbj4xFlfN2QS41nAe4vbojcsBoPTkEzDn
         0CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487937; x=1783092737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6Z0+Z5n5NK6NseC4Bn8pJynC7FdsRRtoEpWod8dOSU=;
        b=InUFQOFIeE86Pewn/e0BwaU06thJL0gTSo61k62t8F5DpbbiuqGmSkhrEdUO+Rh3Nd
         GaF1y3UQBpKLy9ZDZdw5/p8l9SgE4d+c982dFtgwuE/GQaItESy2Ux395CMhesnqpSVv
         3LBlUhDkxneQ25HNzIinc9XMdcuJsPGz/WPsUPL1tgG6xuaUi8yaE8pLxqy5Y/XBJhnk
         7Aoz0fpSd9g4j4j4eM4eViEvb8x7P1G9upf8Ge/nZk5M5qchvDQ7LgoCHAmRkwGAx33K
         3QVpBeKT6/yikvd+gdhdK98YCY1kGXUH99mIISCWLQtz5Z++WqliP7kGVm1WXoj9ki5T
         Ihvg==
X-Forwarded-Encrypted: i=1; AHgh+RrhwO4TAGVIzW8na0c7NT98ErJ3lz5RV4+jaHJ5chfbwf0konsBWuTNZNKBsGfVZOHTfT0B+v8LP/cublaY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mkl/shcDSRv3V8W36Wy3Lik75+gxo5OCrIfBpQH1OY5OkKcJ
	kAV2W0mEfaO08jaKb/EYkXBpGr3y2F7IhxSRneYVBhn+J6/kG+Y9qi0A+gJrluFwy3xqV6DKJOO
	zixbzbqdFc2mwwlmN1Xvicv4I/0yZPUU=
X-Gm-Gg: AfdE7cl/qeMWkjjMInKkmIeAz6C/zNmDC7AL5JLMirrhBS5e+TtGcUPU4QYTBzRzLas
	LQVi4tJk2H3nWP30QoJMnCErI7mhX5Jk+5rxszlla9+tKyfQsr7qdVScIVVMuWMenHtmYJq9FfF
	SaxCSKIBnUlA6bgHNBQRFIaLe0IDTJ76TYcxvwZQKJQ9eNDBFVaWYyv3Fh74IGTNT2giz7lEBI3
	6mHSu9Vr28HjJeH04GLxOauL7VTdD3IvMzSHhso1EVRpJeDzz4VPGCLIDgU6O3zZImI0iG2sqy3
	JGiQNI+J/nUxLfAVVw2IDHzAosBtD4g=
X-Received: by 2002:a05:6402:e97:b0:698:3b7b:e491 with SMTP id
 4fb4d7f45d1cf-6983b7bec75mr281408a12.39.1782487937107; Fri, 26 Jun 2026
 08:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <716044027.2969861.1782392539951@kpc.webmail.kpnmail.nl>
In-Reply-To: <716044027.2969861.1782392539951@kpc.webmail.kpnmail.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jun 2026 17:32:04 +0200
X-Gm-Features: AVVi8CedWGX-p3pi_2eTFTvcU_acPiaidW9DsXKlfBbhRLV6eDF8I9cL_sbZqMI
Message-ID: <CAOQ4uxioUmS5O7fo9f0pZHTc_drzJCVstRipqSwGYKMBy3DUxA@mail.gmail.com>
Subject: Re: [RFC] fanotify for flock release
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 3:02=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Hi Jan and Amir, (cc Christian)
cc Jeff Layton

>
> There has been a wish from systemd to be able to be notified on flock(2) =
releases.[1]
> I've been looking at the locks.c code (I really wish requests were decoup=
led
> from locks... :) ) and the fanotify code, and this seems to be a rather
> straightforward expansion of existing fanotify functionality. Before send=
ing a
> patch up, are there any objections to this? If we implement this should w=
e
> also do POSIX locks notifications? And what about lock taking?

An event on funlock is very specific.
Maybe if you can come up with some more generic semantics.

TBH it feels like functionality that could be added to flock() -
waiting for resources to be available without actually taking the lock.
Sounds like something that would be easy to implement, but arguing
over UAPI is never ending fun...

Thanks,
Amir.
