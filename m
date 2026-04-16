Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D737997E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341960; cv=pass; b=G0hyhs5lwDViYNL2GTNO7a5gIc5gMgDGc5EBcWjKl5pEfq3YTVvSUGsaujai6702Mo2qaAmo27v5OmctwXF4LwPW7R6tOSsESbFxWN3QDPPwKN/+Rx9dIqDLF2RWckljzHnc8jXxr5zKjt0qAt7uI61g2M0DEMGcrUf9dMEAjRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341960; c=relaxed/simple;
	bh=gyQTUb9OJbxBVF3f8APeqWgjZlIGeOOoE25FOhzZ3WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF6YdgWaJC4sti3XmPCeSuRvojmExHIvSM8jmVJNyyArg3qI1kJSt1FxjeoclwawBFG3EIvnkKZ/NfPPQhcVMOews6dwOi+uWk6tGIhBVeesApu8HjdoV03NXVtMHXpxwx3PfciKOKf8EG3OfJRJccqyreP3wHKDTO624cp9W4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZhMbWZsL; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZhMbWZsL"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d876329bbso80916451cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 05:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776341958; cv=none;
        d=google.com; s=arc-20240605;
        b=Ac4IX9YUzaNMP3LAU3D15hrMNDDNjim4bdxbM0Ph1vEO/xmPxSMae7nxI8XPGQt8a3
         Tld6ocCfm+P4EgVc53PCRl2lzqBPqvSgegl1JVMN2v45wNigg9R64ryQJNg5WTlf0dn/
         B+f1PT140sd503IK9z3mVdSolCXo8FR7zQqRVpMernPgCLrMUr+kDHcXFuAXpSCT4nvK
         G6rn3KCoBbwCjy1SOYLs38FiMfYs5/8I9jn7tjC5MVUr4rsyzWx5NoVOLuyBosbH4Jng
         7oeCtpsGlxrxdpGu1xgBDm0wNkqWEJEOuLdbaJcctikWLlPqa3VpNGAEYmTUJBIWa7rF
         AOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gyQTUb9OJbxBVF3f8APeqWgjZlIGeOOoE25FOhzZ3WY=;
        fh=5z/M8i2NgjEKliduc43XAQVHumR01AwkTr3rxibKtoI=;
        b=fhL0drDf61XDayGAuOQdJKuDoddc4ke1YLe4Wpe1phFTB+U0jb+jBGLtqRo2p/Fxoz
         xyhnJjy7N8kocJm8gEIS2C1kTedOb0CZursy7dpOLSx9yG3yD51+zI34Wq1HRXUTmT5s
         7LvYkA5w6btRMAPAd0oAt7CV8WJmfIly+e5WvUBFIxvSXdxDusxtiVpUxnFjW/dNQZGb
         bbwDNOH0L7KKwhxTGYtB+9Avb90KCDQ4p46d6F3+x0oxWXygruK3Eg0m4Eg+jVsa+h3H
         SSCjf29DTrUUt7b79bS9ziMuKNf4R0+PXjKzXm/PmFyoSJqjwgPJkd8yKzCR7LxN/ys2
         XKlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776341958; x=1776946758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gyQTUb9OJbxBVF3f8APeqWgjZlIGeOOoE25FOhzZ3WY=;
        b=ZhMbWZsLgS3QtBgLeTMjivQtdGlpZHOhWqXbJpFXRpi+UEm7NunNDx1oaPlr9akwGW
         CjDLZqiTTcaoTcOzwiXBkyEfTTA2n5YZVawQYdimjEWVkN2f31biYysXl8n74S5yMl7c
         CkVLRGY9RCHZiEUaOJh6n9O1/EQylUZ//5Rhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341958; x=1776946758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyQTUb9OJbxBVF3f8APeqWgjZlIGeOOoE25FOhzZ3WY=;
        b=GvrzZxgScGCr+UvWAzIiggSms2B48h3F58QntYfXB8ASa+PhpggMTj/Uevu/EVNEsJ
         OIsVOIAHM15C9SpM+TevCMOCXxRKby45J9LXp5miZbVuUs8HlYBBublxDASEGem+QwK/
         huIPrlFjPHrI3C8axlNWJ4nto8PefZh0TUPuFCfQaZfkqsc1UaCnC8Q4DUi+VrFRlZ5m
         GJncFZr+4P8EA59jlNjjofFD3crrB386adLoUyOjTGMn1ihR3kBFvvwKEbCZRnBlxADr
         ulfunKyOfTzsYjIsUUSaSdOvWK1UXBrC/5NnY/zJsoOIv5+sQKA3QPa9riE4NGD+HRQe
         5VIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8la/tl/Sc3pTc46tAjldUkWyTSP5IQCAAmzvXb4n5UC6bkHqObUjufP9UvnRQkyagQaABAEJsM7N91ne/m@vger.kernel.org
X-Gm-Message-State: AOJu0YygL33hYiqIvaXSswjOv1nnMUW5YEnT2AOwwvUTOmq/wmubxbjQ
	Je1UlS4AW60NbI40i6c2h7Z7hWdcFvUpBTZgQW8QWF1JtOceA/5pNDc6cHLkdukdjyd6nNmI1j2
	F1qOVTBz5psccmZLjdlItN4d2C3soYmB9AyGhCrsYzg==
X-Gm-Gg: AeBDievlsEVDwEJFR568dapE+C0cFvz0QBK5ANr9zU1eFUNmdxAvd6S6MSyRSoaZekx
	i4rf6S9+0GgfZJwW/R69zVZZU9AaJHesp1yrAa+AH/qch8DO6N1zFwHxLKmZhoK+n5tG8FV+UCf
	VvaO7ZLhMIAXnd4puHZTX8Em6XJPDOFyxqrJRCgYxUObN3IeyCQE1UvpA7Y2jvt/xgUSaQEWtCm
	HKeDrysElpS0N8uQBUreozllI/xT/XRUWka6M/wrM3Gq3/WYgP1LiLD2XgH7AzWfZz1TCcL2jq8
	g1T/OltXw+pVkvqe4uFd5gh+E5U191/oXxLK
X-Received: by 2002:a05:622a:4ccb:b0:50d:8b23:4948 with SMTP id
 d75a77b69052e-50dd5bc09fdmr392505811cf.46.1776341958345; Thu, 16 Apr 2026
 05:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409030457.4632-1-liwang@kylinos.cn> <20260410023433.18969-1-liwang@kylinos.cn>
In-Reply-To: <20260410023433.18969-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 14:19:07 +0200
X-Gm-Features: AQROBzBpOUONEf1aVKwKvd-Terqs46gEArDxiPIKQFCV8vs5Lollco6EWbK43qs
Message-ID: <CAJfpegsMcfp9xZMdT6LVCmvr34GGk0rvJwZs9brnEg-xV09bvQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: drop redundant err assignment in fuse_create_open()
To: Li Wang <liwang@kylinos.cn>
Cc: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 04:35, Li Wang <liwang@kylinos.cn> wrote:
>
> In fuse_create_open(), err is initialized to -ENOMEM immediately before
> the fuse_alloc_forget() NULL check. If forget allocation fails,
> it branches to out_err with that value. If it succeeds, it falls through
> without modifying err, so err is still -ENOMEM at the point where
> fuse_file_alloc() is called. The second err = -ENOMEM before
> fuse_file_alloc() therefore is redundant.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Applied, thanks.

Miklos
