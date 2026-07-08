Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EF3B7747
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522540; cv=pass; b=inmJU+UaJNwVkG3AOa8O6sTQgJZGcIprzpI++xrY7KEz5+hpPc+09BlZn1sLhWwZ3m5+LWqLg6ICv9t6xVtxJujH7yi1s/R6NmLFohG6Y+LaTprKVxcJEN7ctDKoj9tjIj7KGFE0580v+X9jT+XHoYj/hqYb+ZchLKCSiVEXv8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522540; c=relaxed/simple;
	bh=n90YfTOdmUl7zWpqdxsCFHko/DVT+Qm+JbT9gK4fWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBic805e/1kQ+WVxSdUsAm3EuQn6m1gLfGgx9ACxyJK5y6h93gm1Q4qk+Ioig6IOuEVsH8SuROZhuZQF35YQT33juh0+c/ZY2ZWrYuiMEUUn8Ku5/5z883I6H3rPZ43/LvDdQGwIQvb4QmCgab5t+eVy7yXutE7oqsF/LOeeOIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Dz7ZCOdl; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Dz7ZCOdl"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aebd77cbb4so640289e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 07:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522537; cv=none;
        d=google.com; s=arc-20260327;
        b=I6M4AS/tJMWJou0pLV9/yZEm6ersyqu/X68t7yBZcXG8rk7XJFpcyvZMXhdbM5o9NU
         7blIXUj8tj0DtXeGs+gEl+qLGKcsPj6+Einy3D25p5NuIkO1IgMqBaLyTLJQQ36L1tN8
         DVh1UuUeIln7Tbpy3A6GvSa4LOaGdjYC0T+1OQrPqzIprM4o6LIAVtFQXFQHjZDs9U5d
         iTNNCBbPUB7cogoDn95YPrOg9EThZehGP9564vlyvoNcRFM1j+5MPHOHXuq7XTWl2O6I
         rGxps88N7Zps5gS9/w/gRFRhIByxDYDRjNS76z29aQFAbjyorGJNlQAUAangQw4d+hxO
         u4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        fh=7/mak5NLz6H0V6t5zzwD3+NvCBGKAOfg1cu4h/+Qy1Q=;
        b=o1IXaiDBy4T3DN/ImDPSPlRL99WoYqUHGj8vmBGGYkTki7jANcNZdZ8i9GYUyNbYnp
         YHcE/yWTa7RvA34tHPyxDHw5HL4fDxH2EwA++m2x6mu5SqAniskJymwvadXW9CspuvqH
         NoAM0WPr2SS7YN77yn4Fd3dc+kmU3of/YKfDVHdgmPGVxe9eqWaZAc8hfkPUVvpKVJWv
         adeys7tpsew59bHxjksYgKT7G9Wi2/7ltcjqyIDt4beaBLw+zwWtbSl/yf5zLyD21SVh
         SbOXaTDGEvxFsEA0+StRzb5vD8JtkZ6P+E5uKLK6+uv3nfJ+2ETSLhbTD7/XyAgT10XL
         a9+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1783522537; x=1784127337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        b=Dz7ZCOdl+uMJPCmheUkJ0ljOMgnz+kZe5+lpXto5XQi/DgnTD6D+gSU2h8JlTknTv7
         gYmhy4/PpfyEOwPTZTvy4pMpJvA+UR/rp1pAVaHy2d6kbh18MujqcTu2xiTPaZ0Sclot
         vPDEHclRmjR54QG7iR10cgcRGV6w8Dgw5Vb0RTh1UaYtSB7svNvzGyNw9a1YsXjkCeJc
         1Yl98bdfdRvTgZZb7DHiUojDOBP9rr9QersBRD2rGFGocQq+PWJmy8jjrEN67lPz1FCH
         2ohZeMAaO5Iiqxiozac+wmnKX48uALopXjma/FtKZ/w/q3BTkQGuVYtuyEnev2VsrTpX
         YzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522537; x=1784127337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        b=qjT7gzxOSFHgNTMMac/neJO7WXAzSr6oDmwLCAiv2L41x2envdjKJ3osDpS+MK9UgH
         trzdvvTUHCgsQILxUSoQlFJEHTozAYOr+U0Ml5aMJ49sDnqAlNkmRIV07P7m/RwjdoSq
         K7QY51I2URFbl/T5utpi2aCvnmKj+VpW3MO4zMO/UaYMKnJa38bagAsmB8Z/xIr7PIBP
         XZiVGuFeAyVIqVjqQHk0mLpKeR4Z2pNR23uL0MzxlDLwWlpHXeIzrL2WjuYBdogEpyt/
         mcxtkz2syvIiO9BKSCWakHozBOgfWZ4SaF4PndsuinbK6N5zWvjZmSMUYgTihbVCDt+S
         /1+w==
X-Forwarded-Encrypted: i=1; AHgh+RoVoIcGVEwSDftjmi5IGpp/R+3f5hWZJlEyRPXSfqtG7OccskHP2vKtGFA+62OxWrIttrf2t+nyr6cNTcRj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd52dcfHuPuEvGsF40WmVbhJ+JgLKUXhcbzpPU45EI8wDxt4ZI
	+7hAkawNZcRLBzKCFHuzOLD9Xb/QQx7JhohQyWOkEsNNfyR5SLYB8WmdSAxqLrGOXRfOK7Nrk61
	4WJnXt2ErZMIpTWtLUqZnG1eautJsVybSDqYnQdie
X-Gm-Gg: AfdE7ckTS4pJ2tJERs/AOV/0Rn/iMMm0v800FwYtQiXpRJVNIrF5mQDm8msnRqs9qa0
	xAi83JjG9ueuRIM7Ci7T55PGi6llBS6reTGpk+ISqsa5Kzx8Hlu+Oo8SeHL1InOJD8zBV1ghTlP
	ORjZxhgWfuLkECA+pka6MM1thf67ZsFXuVAqdKXqinkAuBSFXeeUYtF7h92wH4DsagSQoJ2jeWF
	W58czbsxeNdExwwD/+CC1P53IvuNKUXqzvHIU7Csjk9wWlR27CSNdguSJMLhJiJQWxH0w==
X-Received: by 2002:a05:6512:8348:b0:5ae:b5d0:9da2 with SMTP id
 2adb3069b0e04-5b011462b7emr693309e87.38.1783522536822; Wed, 08 Jul 2026
 07:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708093446.3370200-1-gscrivan@redhat.com> <20260708093446.3370200-3-gscrivan@redhat.com>
In-Reply-To: <20260708093446.3370200-3-gscrivan@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 8 Jul 2026 07:55:25 -0700
X-Gm-Features: AUfX_mxOfC8JmvatfXCPy4TV9OGzLE6zGNnyTgpXNYag_FZ0rPhcjgOvQmXLouo
Message-ID: <CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source file descriptor
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 2:36=E2=80=AFAM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
> backing image file for file-backed erofs mounts.

What=E2=80=99s the use case?

In any event, this seems to have potential security and API-oddity implicat=
ions.

1. That capable(CAP_SYS_ADMIN) seems critical =E2=80=94 otherwise a task th=
at
is admin in a userns can get an fd to a backing file *outside* its
container or to an otherwise inaccessible file.  It at least needs a
comment IMO.

2.  This series appears to fully round-trip the struct file. That
means that f_cred and mode are preserved. This seems strange and may
have all kinds of accidental effects. For mode in parallel, if the
program that mounts the backing store opened it for write, then this
API gives a writable fd, which seems like an odd choice for a
filesystem that literally has read only in the name.

The OVL variant has these issues to a lesser extent due to the fact
that it returns an O_PATH fd instead of an actual open file.
