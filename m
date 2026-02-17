Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869036F408
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346397; cv=pass; b=OvxQiqzxHY7VaGaTiTPVsPqiF0oQO8XWROnhzhlx3HfNF7lZQ3z6mAulcBCCRRN7HEmD5FtncKneBxxtj4TAQHIc3u/54yM/BR2q0t8r1vAaqFChmzxgzz/+X4vAVYCeR13Ob/t4SoPxOhX7UhpTZKA798dxcusToOVsga59g+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346397; c=relaxed/simple;
	bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzsz+mcBsuEWdlyEsSs06PQ8W/DcZ6xGqsC4oJCbdREe4frQaWrFxszyRTf3cnTzYYhbn5XLpZG6wRG8DRC42hYivl2LPkzktlDcJ+l8kLAMP/K1YQbePku6/wpYfAWxUqjM70mvb6JNBgR31978LUxwcsmM2nEhudcwTmmOovc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FAjf5uQx; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FAjf5uQx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506c00df428so25285521cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 08:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346393; cv=none;
        d=google.com; s=arc-20240605;
        b=BjSH4N8RUdVX9f7NN/ePxgeQcGE1A7DgW9geEGDFZ7QDKJK8GDZEWyvFwhnq0uh46J
         bDM8rBh1S9yia+L78fxpuyLb2hYv0MjuNI0sNYxrkHvxiqFeOEdJxMBP7yvayna4jE/S
         F/M5F0lUOY1dodsodkbhMKC0bmmKBgjsQ8ujWxSvAo7SYwkNZG3gUg9Z/Ow/tQyOq8Uu
         bbiM7eeoelEFjzRtzFooiNFfscwpF6YkIIiD0JTGNWWYgwyhPU7aAXMlnvntnzbzdXWz
         /3yJGBqwjPGF7mG53OhhwI95shcMLqsd/x/ERFY18mCJL1msc8CJbi5fb6Athtki1gDq
         YM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
        fh=oooYcGAmbKuLFqhGnTOqZuM8aqgAkfyU3N1EDJEr3qg=;
        b=RlPJiPU93v77bQlVOc7mdlk4E0ypP89B2NofSPkcxo2UeSormwpFfKwHZan3LAqlId
         g3eYYzcttVyhAZ2O/CEOWR28Verey4zUmCYOl1Tp4fIrV6GawzOmSBc8c18YNjf1Q7ZL
         dTH2L+BE43iCq804Z14Xq1BMfY8h9ytW3C7rd7I5Qwp5d91085Xy5EiuKmpNFpHsvPy0
         zggRRPWEKjnFv2+G0rn3v/Xh3Wduc2kk/YZAnn9KleXXIJWyv4msHPfY3KgyfsPatVnZ
         GLYnBDA/1TVAon/6iMRVqCQRFQzsSbmO6D2ye7EJc5tUCkorlecLBrqQ/Tdu0VfmIOtA
         hvAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771346393; x=1771951193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
        b=FAjf5uQx9tpS0aaZJjDQ02d8SFGR6z0UnHHT0VQWik2LxgKJr57qeaWuthdla4HsG4
         HsIYO9tvpKaCPq25UUvy4h+d4ajEnkEL2eQLtmDFJBXXkgWaSHDbJHiTNCrsjpGxZHQ4
         OkGy1e5Zh3xTZoqrwkQ9RhXbpl9a5G1w6YExE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346393; x=1771951193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
        b=fvG6J/d9RABTR1H1X7zeJfTbKyPkQWWZ1qnWxiZvu2EqAF9J5dgE8BbZTqS1hImLdb
         cuHhHt4BAasfZySZcRRHR1fs/I/Do73MfSFmxhxhAwyD7hAFAA6OhPr+SoqQMwMEub4Z
         i03eoidmcMGuKglGnqvnR2KUDYgXZOM17oIzGFPilYJrDxDGAzKb03Nn9VqI0fZ4+Dmz
         v5P95THPP11auJcKhRlDn/iIDzzrngb3TTAMFmpVtQOWHXKly20CH9ChKlj13bJ45FzJ
         MmN1mWN+4F3SWMlYDjkMNRmKXMBr4noUofSgruq4lGXADhIOqZ3oA4R6vzluUaoFOIBL
         KShA==
X-Forwarded-Encrypted: i=1; AJvYcCVXbV6AuT2gga2whAjGfxKia/3RLF2dbtFJz5i2AngHfmBJhT+pWOLtQHmNIGMnnjwYkN8tjl7XLq8f+esq@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbCTyCDcuMWh9GnMDB6GwUimYIDOihFd5tMmyu/I9C689R4YE
	F8sz5R4Lxh2XDTaDPi+s6VHSfatWSrFNxrDu4+rdf8z/mtVNHYZOcu/b6WDKxDqwIxI57zSh6cO
	9OhzBQoO8AJtYJOt3cniwwX2Eio1UnrhPGFwATxwPyQ==
X-Gm-Gg: AZuq6aIPfuKbqlRN1Ht+MG+YKA8a6zsewCUoauiqtIJbt3W0VJSVWPBjtpsrKMNqEdG
	8IagPdSwRJ0oaflF1YV0o2+vJplKHWtk030u05u1+bFYthcf5Vsbfz8se8rctkPgP599SOxJjW4
	M4wjd/v0ngGq+virLAMoFqv9YoJfg9swNJNSJhnbiUf5PDG3+8+lNhendZnPnCdF0uhweFDB3Fz
	th5+7bnZElxguMX2jKChowq6+3I7rjA4I05eztw5bbV1uNbf7frFWn1+ycZJkuxwSdbepbawZ6s
	qQ2Trao=
X-Received: by 2002:a05:622a:1483:b0:4ee:146f:2502 with SMTP id
 d75a77b69052e-506a82a4d8cmr174569751cf.25.1771346393387; Tue, 17 Feb 2026
 08:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216073158.75151-1-ytohnuki@amazon.com>
In-Reply-To: <20260216073158.75151-1-ytohnuki@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Feb 2026 17:39:41 +0100
X-Gm-Features: AaiRm50ZJQWukD4STFELd-seNULmcITyjXX8VmFAZxxkRzbE7k8jrX2FOuh4BkQ
Message-ID: <CAJfpegtN2ufQQcPh1G6zzZzXF-PRcp942pE3Oxmqfo_5GVey5g@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: add FUSE protocol validation
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Feb 2026 at 08:32, Yuto Ohnuki <ytohnuki@amazon.com> wrote:
>
> Add virtio_fs_verify_response() to validate that the server properly
> follows the FUSE protocol by checking:
>
> - Response length is at least sizeof(struct fuse_out_header).
> - oh.len matches the actual response length.
> - oh.unique matches the request's unique identifier.
>
> On validation failure, set error to -EIO and normalize oh.len to prevent
> underflow in copy_args_from_argbuf().
>
> Addresses the TODO comment in virtio_fs_request_complete().
>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Applied, thanks.

Miklos
