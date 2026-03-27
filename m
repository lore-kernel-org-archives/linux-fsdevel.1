Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12382DEA61
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573618; cv=pass; b=rcPJnHSql3Em/8Kz2bTdvljcE4MCNaNLxEYHjkOCk/ZnJICtB03FY+rLt7XtEJ2hlzJNCzy61z3UpbAuE/IlzL4/jJ2ljU9p7KNlXTeYHGCjruF09SBHfMA068WAmwcNw4RBVIUlNSYLi+KoHdHZGcMrj1kIuB7gS41hFjHJYPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573618; c=relaxed/simple;
	bh=KeWbF+sH5V49VasvoUwepM1LdJoATosJLZoY9VySM00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMyn0dHaANu6Bl3ciwHVfHD++D8T4MBHqqQ5mFb9uhcinO1MMGpaRfMela8eQjQbGVat84qGrPwCCwhEx/iPJTqrjktVWTQK83nUdMWs3iaQto9HNdZWMmU5XbnYnhbuvOsvWypmmMIdwL992VMEouBAUlorixbpVasv2Ov4Cy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cYL8cSf8; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cYL8cSf8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0b0064027so10170455ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774573614; cv=none;
        d=google.com; s=arc-20240605;
        b=YkgDqnxgsNmRtoxkGblTSERqBNUEKx9tiAVSij3YjpV35xfavghhcrxA/Vt4ivLI3Y
         OO5AGHcLlo4L9xzjAg93zAcKcBZa08vrsbt7y1dmw0aoXTZ8jQxk9HxQbWIAsD3tR2Yj
         DUeziVc0STm/8e3+KZNKsikd8x4m9ERqQhy25m1Ya9Xd8Xw6EaKN/+LqfW0pNaMv+/F4
         7CwKS4hIpoV8hrylfQW7fwZQNBuiBQ7UGKYuuMXPA2Q7xwXMoLTMg2K3Fyri+Kd9LlPQ
         5WiK/fAFhYp8XoxVuxXBhycizSQOzE6yi6ehYkD0xOcqYElYcsYmQxb4qsuCVSsGa4D5
         rcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        fh=VKTTNIRYh7C8k6IfCiNSmSKfWuiNSENyauvje2+tTPk=;
        b=BVGQAJ+iZO60OaSLgxZeoQ3s/F7Ev0qZwc80gE/gZ6M2UB574eSuwRvzV3Cf2kWbi3
         GC0AIKvpMRULluwWSpaIMc1OpAJ/yiQAZes5VN6AT8PV59Xq65YgwXyj8eqtiiL75iyC
         hRcnmNGyPLPJJi8sk4YRdJ/5YBrwv7jJtQWlrEeCEuvjpkcVfA6xJVB/HLbS1ecz2/+I
         UQCcdfRMCS66JcxagqW32IYe2Qo/33AY+PHslP3SnS8zhLyIoh4UDgWu0wOua2DSXvtS
         PG7y13ZLEhSPUxo0bK+vdCOcfE+a5c3rsENla5YDTQ9ws+1Dox+ju9ksji6h3XHS7IWo
         3PQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774573614; x=1775178414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        b=cYL8cSf8NDB0HIRMHK4tAVG03Ua0EQnoUA01/dFQOnZPLqMoShmKMGruN+aMrYYtEp
         4ZbB9vLpk36qoIpjixi01Qg91rrF1GfkGBVOJSA9j0VhKca+cJnK6uKzeV305tYZFFqD
         jrOi4AbHQhpjC4MBYDC6jXgWbkujta7SSQ5LN+yRr11Cxf1iny012RHgPBI8iaqrfk9q
         RLSPFP/hzk05SX3kP1A1Rsnsx/HV4DINpDS25aIHT6oCcUopV1gRVSntM1DJzbqiXZFE
         iXtopPIeAGyYBmm26xAxDJ92j9KLM5NY92jzoAHSznQ0wx8UTlj7D/fRHGg/NFVbnoJ0
         5F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774573614; x=1775178414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        b=AP7C2euXuY9/ECINdRQbDwKMIaNbY6TkHy+7ZF988lUC214msx49YM0RP3e8Kf0AWx
         ocDxXFUehlIQrwYUBi0oR+nZAOROQIOofZquJfeyrAjx1288FiNIrFluVNOMJcVFAwvB
         kOGh23LVYAiE4cr+8SLs+TqYmcqe/hUabruRszcTXdfz1LiIuzXvwgNfMMiV5o0YXQJ6
         u3hsT5j1TDkPaadpGD+Cv7j0yFtIeJkaJQywNQ6j4HnmZIse4WisfUysCXGCNooERbcQ
         O0SVfIb/OpDhLbFo2VVne1kRQAKO+VJk3EXZuiOln2d5kWZ/w+6z5RDtVgiB83YrO6CU
         YnNA==
X-Forwarded-Encrypted: i=1; AJvYcCVZcRa3DtzFpQS2U84r1d8gce9KxTd/smPWhDKvFh0rRkMYdKfotBE+Mg6s04G/UNKZo5ALy7oYDwMAHU2k@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5X3q/xiqmxthQRFmrf7riaq1/Ux1Yvx5EgecESWEvn1T0MqR
	sc+edhBrRHC93iUw7Yus1nHOZcvE7tLzCcUm0NCnORlVhQsvpycFh0SgiB0c+WINZJFEoB5x9+p
	1+kkNlmfeeW3ypTbjvFe69pqT8sPaW+W3TJ8WZq9j
X-Gm-Gg: ATEYQzymqYLA6ulJC1nWPa0Oj5vNZMYlpfFn42wQ4s6oQjf8RtKFd3uoSQlM+3GpD7I
	pB5J0WOMD38EccbSKGQeb2XXT/t1smNehHEwLxtS/l8jP4eQ2iHH8n+kagFEsYh73fR0IYuo2Sr
	iVSmT2IiPBFBz0lNWxGOQXlgiYJApip4hwKOW1nb8RntKTWULtFNalAdoF2q0dFkbAjiZl2049u
	LnY8mDy4BCHJrwnX7oyfwdR5bbFoeSvtfs9s2V6tWIe0+eIzZutUbQqFD+7E80rU9+mW4bDfKdx
	bh14KNc=
X-Received: by 2002:a17:903:4407:b0:2b0:6621:cedd with SMTP id
 d9443c01a7336-2b0cdd31a51mr5581795ad.49.1774573613689; Thu, 26 Mar 2026
 18:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
In-Reply-To: <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Mar 2026 21:06:42 -0400
X-Gm-Features: AQROBzBKwxHMqZrCazbp_EEoFhocvn47dYCOH9CjcWVrjXYp2B_xhHc7YALOkis
Message-ID: <CAHC9VhQUU9L9OTtyo+2mdi0P5jCk1RXnJBxT1+YUyywMSfLuPg@mail.gmail.com>
Subject: Re: [PATCH 0/7] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	john.johansen@canonical.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:31=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi folks, especially SELinux, AppArmor, and LandLock maintainers,
>
> Could you please share your comments on this set?

I think we are all aware of this patchset, but most of us are fairly
busy at the moment.  This patchset is in my queue to review, but it
isn't something I'm going to be able to review this week.

> If there are no issues with these changes, can we land the set in 7.1
> kernels?

Given that we are near the end of -rc5, that is highly unlikely.

https://github.com/LinuxSecurityModule/kernel?tab=3Dreadme-ov-file#kernel-d=
evelopment-process

--=20
paul-moore.com
