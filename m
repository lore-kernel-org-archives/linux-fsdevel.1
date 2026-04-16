Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FE25A642
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350877; cv=pass; b=Cx75CmCflclP58bP0F3WrKcSWW9T1QMof5tOpOLJMBi/1jybNwm7flhpQOK0nptKXBHJipegPvhJhwQoR0wiLEexUSLulMNmnoIHjgt6bIuAFTCOHm8doyO1G6cswtdP/fcbTkTc6HZJK30GA6wvf9HXiLbBPoK1T3cB4CnS8Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350877; c=relaxed/simple;
	bh=auL9+eH1IwmtO44xx/ePZJbRQVviMJtv1TC5P2gV/Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr4BVoLYNrK3a4pKy1RoIqTewANScWy7LSQKrorpF9CypuKzFCrZ5DFktnf/CrPwvZ/33k/dw06KPJjdRJ3i7QOsAyflhEYWFmh219s9fdMkyrQqEESIZetYASnx7hQ8vgtdZsvPwGeahEZawVIXGPJY4SzddFda4+U/4iJo82g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K28Ptf/1; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K28Ptf/1"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb856a674so8679556d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 07:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350876; cv=none;
        d=google.com; s=arc-20240605;
        b=TY7sstq3CbyVZBHzgyyVLj1qTE/62p2kMMqMliYdSUxaXWAqdjwsZoUe08CI6jhugq
         b+gmyUDTap96gkByoiqWNUepfSeBNrsjb9eXJGTGCX+x6X0/nvM+Qf9sniY3fva0CssU
         61VYK4tnkRNx6McV1LeZrwl6rxLnoLyuPbMQwGCipyTUlNK6KXte2OvaSCUwB4+RV2Aq
         xPJYIBfC1tFhSJ46NFmTkOzV3EMGX0IV7S3jLfQD6au1pJv/oHgsWxFPuCScC7kupwyU
         Go99HgfowCyZbjpwpUcSylnQyW9f1YdbeVMAWaNd84Bcu4GrHxU4vZcvkcr14JLEfzsD
         GvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C7bjyixnwyKu/NLnhmeFwrCQf1szr7CfKhuLlD7iQ9E=;
        fh=Wj8z84DLc3RyBHIK2h1MYCqfaFTzMMbZr8/6yxMM6Sk=;
        b=X45jjBZsBQByWDlocqMvtJvp7uphJ5bX126zmXLMlUFCm+oe/o56ja0Ewy4orlN9XI
         qkaqOcUSZE+AGVmFRIx6BmnH5OGDvGPIEBK9nygqpGeLsontJs20Gozuebs8JgwIjW47
         WlZfjNqu9ki5wCzanqHdTqGeKyO8uC2EpRuTDyXT+UX/hWvkb9FIKwlt1WGH7+nEL09W
         1/QccY+Uoiu76wZaflFeCnsIfyTVvzjMW8L1XQgLsKiFiDgxkk4FBrgV/f0pNLrxx7T2
         qwjUALmOUrMmSjYrYvnBfkjAl2rGdDRf5jne6a7OdUkTgPFvubckx27Xu+d/pbXAn4E7
         CNDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776350876; x=1776955676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C7bjyixnwyKu/NLnhmeFwrCQf1szr7CfKhuLlD7iQ9E=;
        b=K28Ptf/16gCk49O4lR0fgtkgt3hD8pYrxw6sa16/cOACTL80DYoKhmUkF4GtiZu+Cr
         nHEfXg3x3WC46gHHq1z+4GHWQXisKZOWEIKcAD63ZhYfAv+ykVeSFz7zbPwxIRq6JiLK
         H5WRMtPamV5iWIe+FtQzBGBZtvmPkDdTJo90Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350876; x=1776955676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7bjyixnwyKu/NLnhmeFwrCQf1szr7CfKhuLlD7iQ9E=;
        b=BWiV0jSTNc3Q0CWWVyB6D7EwhFwCXd9GPBc4TKATbI9kd5mRCvo+33YGsll/EkFlub
         DXPzm1pnvopnwNBUlJzAPJ6ENoy6Z8fESkJ5B1KGd2y5IE4L0Mk9+o6mwFx+AgV3wmFG
         ndLbvTLg9rW11uZkrjLVQKVs9C12Ot4fCWJUhi1JODB54UR1+Wro6pCW+W5pOSc9ftgL
         f08ycvmaMcExyt6fpqhUhE/rWcu5TgjQ0gpiL6bJ8CRdomfGX//mNu0/UEFGhO5mfrhE
         58Qznie1Kzcx05GUxPpz/ONYQMvZmd9TTxqwrL6mBxzHv84yNB47wba9a/ZN84u8Lu7W
         qvGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uVOeV9AxeD57u8KrFSDJGD2Q/C2HB9kZtbnR+UQ49aQ6yA6DivPETbp5xGFaH72MWuUyyTXb7L8w3dKek@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfnrL6Fr+G+WRyzvhmKxBOStL7cuO8TwQxb1q5WwBTnlXyZfY
	XJShnOSlmdQJaZU0jq7E9uP9BDkVbdWJ6NPMP2DDtVXRaahbUI2Cb1oMqC0hOPPBH1TaCJM5TGA
	roHZuZesjCXcM3VyXU2o4VfcbHxcBYyF+A9uDJs8UOg==
X-Gm-Gg: AeBDievI9I4QTlUmEegJtvUaDwtYcHSY7YqlBlRzNbUeW6pvqlSyFHq4OTEK7M0VHUG
	cKHIdoAdM1Wkbu6sNdklyHBMD+8ATwY4pMhP8Q81hNUFauAYd/hnoYhGf+7/9wXWvhTJ/LXcs/0
	2BE8WxSJLQhDckKo1n8m+WoNgzgnsSYIIdJzB8Rl1UrUcyUnjYwii4b8xE5Q+gEoH9RLvrZytcV
	k9/Ft5vN6+KIyiuTtXYANj+5i1eItFNIK0A6NApzzMpPMg7/GgP112jw/mNXQIih+dSTmb7Ps03
	B+uSrGadS7qxPy8Stgg/gSo2H+zNQRbk41LL
X-Received: by 2002:a05:6214:5693:b0:89c:869e:4972 with SMTP id
 6a1803df08f44-8ae75ec1517mr55383536d6.10.1776350875628; Thu, 16 Apr 2026
 07:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414082723.350538-1-ksztyber@nvidia.com>
In-Reply-To: <20260414082723.350538-1-ksztyber@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 16:47:43 +0200
X-Gm-Features: AQROBzDzu9FreDfOHSlvA_t2SUWXnsI5wW0V2gEy9hJhilqJ7kIc3lWiSU5YZfk
Message-ID: <CAJfpegvCPRU4VoB2qorFkj1Ha4adeFLjTj49yAdSAogniATCPw@mail.gmail.com>
Subject: Re: [PATCH] fuse: reduce attributes invalidated on directory change
To: Konrad Sztyber <ksztyber@nvidia.com>
Cc: Jim Harris <jim.harris@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 10:27, Konrad Sztyber <ksztyber@nvidia.com> wrote:
>
> When the contents of a directory is modified, some of its attributes may
> also change, so they need to be invalidated.  But this isn't the case
> for every attribute.  For instance, unlinking or creating a file doesn't
> change the uid/gid of its parent directory.
>
> This can cause unnecessary FUSE_GETATTRs to be sent to user-space.  For
> example, fuse_permission() checks if mode, uid, and gid are valid and
> will issue a FUSE_GETATTR if they're not, which results in an extra
> FUSE_GETATTR request for every FUSE_UNLINK when removing files in the
> same directory.
>
> Signed-off-by: Konrad Sztyber <ksztyber@nvidia.com>

Makes sense, applied.

Thanks,
Miklos
