Received: from mail-qk2-f1.google.com (mail-qk2-f1.google.com [74.125.230.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8B2F691D
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858736; cv=pass; b=U53Hl62WEz7+bRGYby+yi8zG6bBsH7ZOosTGbLyNsU4/6uvGjdVe9n8GD8kPDRAg/daSAPQTIPTSSOYscLHqWRPsxDKMb2w6OPe9YRdhRzSLl3kAsMwl6BNtYYpw5vbB8ytlkE45TYzhVLNMkFOdiCGChnW+l4p3SZrAQd7u6cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858736; c=relaxed/simple;
	bh=RQijCnM38kd84LmZ1RXAL+gIdYjwTqwiGYmr5NZm5cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiKiRcBlZCSSQ7BGoVCBuaVPzl07pMLsKO9l8Gy8NZer1cBj7/Zs1sCkMfAfeo0qm35CMT8/cVgJznyZbHYQkN8lgU8rVwcxU9+svowAVtxhEyhqvIjNAocOHWZGZqNEy/Pjs6HFvR2C8+O8WzFXoq5o0mkGQwXmXup5F1vemuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRLdDzwJ; arc=pass smtp.client-ip=74.125.230.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRLdDzwJ"
Received: by mail-qk2-f1.google.com with SMTP id d75a77b69052e-530178f21ffso21802261cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789858734; cv=none;
        d=google.com; s=arc-20260327;
        b=EdSGsWeKMpPHEOkGTutrrDKk1A0BzMYgWbRhcJKtpZHsk2POrDvjBj5JsJcqBFbVtD
         2V9agE6YqDlJ4yEdasyjxmNQoEZI42DB7CF42NaiWVA4KGdIXv8wd2tNR0iHLUpX+aDy
         qRNcfDp3COYvedvDBxSePvF6fvefYQ2Pwfk9zv1x61pd8ia74e3vVW/jW2WqfcdWHSjE
         hKEGj7nmeSsRuSbNTPZtrNR7LEvpXHEZpEYbLTx2N/XWeey5ofsY/V9Zi269XcdiNDIt
         9OqZOP7/X0W6KGmXdToh3Nb1B0I3JhJVn9FeMP5H+Kq9CT+1uui4jt+cZrN2RF5kXWTW
         KwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQijCnM38kd84LmZ1RXAL+gIdYjwTqwiGYmr5NZm5cU=;
        fh=+NkYY+iaMAqFYLkmAYWWjbkIDEnd1Fz8mCzkTV9nMI4=;
        b=Ndz69/mONLUCpPFVvu6xyex0N0NuiaWzJ5c5FcUIZdkl1/44Q7l5qtmIqe/kAkXgGu
         9AKWefutXJ8WXiVuwoWa8BYVr1WAprR6Ew9237tyLeYIL2RBpakbdcAkJe9hcVleTCBz
         SJvfsVRsSskhO5b/hOr6cmTZPRyNb8MScpeOkiv+S9DZjB7ozgOCAOFPsAE3rctiTXaY
         31sJXUeaHb7qw7esQGIpTw+40Ypx6wcj0vzV0MD7eS0anV+n2SM7DzMO7fMWvHDG+OX7
         lynIN2EXxRktaIzuDlG/xlQzp7nJRMnZPTQC5J4jiYIBfOrOLhzk1quWxqZUimmdZJ4J
         kQgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789858734; x=1790463534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQijCnM38kd84LmZ1RXAL+gIdYjwTqwiGYmr5NZm5cU=;
        b=YRLdDzwJnWsp6SgFZtEMKwiaXonQu+DYtCJ/sFoTbjRRWLh0cj9j/mWeFltSOIhuRh
         O+0dwqfCErdLWRjwW2d4ewNmt78q2bSmm3+J+eRtudrCiTOBKNqcGShVYu16bUQ96SvD
         wpMGKukgY5NxcsGoL8wO1L3FJi9p8GjGAOfIPPk5N4RLsMLSSM10mPtQW7QjziSpqKjn
         dfn+h2PQTVjmbJSmZM0mFHHfdik+Sa5iGJYT45I2FcPo1GVb9/Jsi+rArHQzr+yEp1hu
         s5s8u7rsvsdraooB4Z+1LwvYgvzsbZZ7VtFSXZ7wJji1KRdRGhmzn/EqTd2TADtvTmGT
         2+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789858734; x=1790463534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQijCnM38kd84LmZ1RXAL+gIdYjwTqwiGYmr5NZm5cU=;
        b=uEjIm+br0p5EjJOItTtTZB1bEHOUggols5NoI1ilqsbPWp4dcVavuKHXoY0+iQ3jlU
         QJjxbWlLQ5KbgS8Ay1JKB3lJ2ol/1MmEDIuY1w0/vgX1TVym+xO78yUIC01Oh2ZMGWei
         h8V0FFVfsurIjIAvzyfi9Dz6s5mX/cp9oyNN2hrLMg45i8ws+hWS1RjjXUVz0Ie0sMIb
         /GXObezURWIoobO8Ll1vLCmkMh3A2lqQO4DigWPs444rWIlwMjof9DulUjIMwaLqdbRK
         LjhTIVoT2zisbhlnqrc6o7R2FO3BOel1wQkvP51Y6GYfAPfUc1Jwyjo9TlwMK89UepBa
         LJbQ==
X-Gm-Message-State: AFuF++ndoG6g4ofL3gJjwpjCapW7ZnJgJiIe8K/83h37cn6o0BM417gR
	gpQvCXuZe9GswyqEtnA/KntAgrNP3aWoNH2mbW7up69WGRgDGBbU+Kbz7zdlPStIBqh3da9da2k
	gD81qMBXtNmfZxStg1pvoAVw05rDklZweO8j0LG8=
X-Gm-Gg: AYBFou1XuN8pa8RI4s241l3R+eSjTbtvQWFb8hVi2UTwfun/JnP9eMpNhRycLymuqrM
	DC7POTWGwDo7MFUw6h6abjTGgjDJbMTcerTeEieRv7L0UKtjjTXM/YrH1xgZBfPaLC0ragO+3px
	L4dMpM/bUjULW4KEjCC3NjSVA60qOM2HB9KrckE/A97D/Rfv5/BufohVqbECWf4MmHVQbiSQUKp
	3oFK2GwQXRh6Bpbjpscn/wQXJtxinBE+we0S0Y4jzWHrTviJ4+PK6Sw1/2luak5XHaHTQRi4pJT
	8Ye0zagFx5mIToFXVQn96bGUg1YCUbwRSeipicbf4nrIdRdrEyoyuiBOtVbx5WQIobcEbdkjVJm
	u2fSdGn/aZ0SjZ1dMNTl179/LTPh1YVZzOvFBKPKE
X-Received: by 2002:a05:622a:124f:b0:52c:dde9:5cd5 with SMTP id
 d75a77b69052e-532b721df24mr44243301cf.21.1789858734241; Sat, 19 Sep 2026
 15:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918062338.1039303-1-enelsonmoore@gmail.com> <iguoigeao5itgylh6kmzwiiuwk4pqra32vpqvyv2ingitchs4w@pctwdteu52mh>
In-Reply-To: <iguoigeao5itgylh6kmzwiiuwk4pqra32vpqvyv2ingitchs4w@pctwdteu52mh>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 19 Sep 2026 15:58:43 -0700
X-Gm-Features: AcwNN1XsokaSX4-T44Ybl-iAtEVcfG9beFAQg0T-pGbsVZXksgEBV3WUmfNnUZA
Message-ID: <CADkSEUhL1bH7BRS-cTxA7UHfqdGB=y4RQnoH6aV+d1L2iDQ+qQ@mail.gmail.com>
Subject: Re: [PATCH] sysctl: quiet unused variable warning in fs/proc/proc_sysctl.c:init_header()
To: Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Joel,

On Fri, Sep 18, 2026 at 4:05=E2=80=AFAM Joel Granados <joel.granados@kernel=
.org> wrote:
> I'm probably compiling in a different way but I don't see that warning.
> Can you please tell me how you compile, what are you are in. What
> version of compiler are you running?

I'm using GCC 16.2, which probably explains it, since newer GCC
versions have gotten more clever at detecting unused variables.

Ethan
