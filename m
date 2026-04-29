Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA03ECBD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459149; cv=pass; b=K0xx7lHCDoCT4GpbBwtEbp0bmE5hSJc44EZT5SL7T6Jcwqv2EXuh1HUheKFNx7cxF9kLoriwadfiXMwvdlRWq3QKY0JDO21rF1ksQZiCqFI/IICnaLbf7RJqy75k9YmcSGqHchiE2wfORk/7hNuK7BcVN6l57OV3pJWmcWMjAxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459149; c=relaxed/simple;
	bh=Z9tsSuHSkDSWGixPHFfe4+4WvZp+mB7T5Yz1aRjO6E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNYVCR0f4Xm+iIcyci+/s/H4jSL8GAV/g4XlbkZ+sIjnaIepqRO6cxY2/AfcO7HuwF1CZIJXeU4mXQP/Cw9ZnKzVM6GUS31wvIxfgHTQM/kehdXOTALtQik3l8XTWx/0x+9L0SnIHPw6xzwxDaWD9PJ6svd9mESLhy6yGHRjKbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BcZ9MuMQ; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BcZ9MuMQ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso130111286d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 03:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777459147; cv=none;
        d=google.com; s=arc-20240605;
        b=FOIXsYzmyKuvOGhObZWKI0Zqp85QSVxL99RNd11crEADgcFse00pwTmTPxOZLbp4zc
         hpCVtOlVr19cwjzqPLrhadOYM6KugRSQhoyx736q08Vx97QlE0j4LwjRIDCl3ToOSauU
         PQG3txrl+UoMHiWoODiCJlxhjecfyyCa+7PD40Hwc9AdeUGnXhkxOYRIxe0EOCQX5uLV
         PsO4svTgMdxXyaG5Bil094J5/3gJ3lBHne1qDFEemiDSrbNck38QmmaVBoc9EYm9gWl0
         MNOl/dXCuxBQn0ERoXHozrx55lqDc7bFwKRc2X6acVbI0COvKKg+Avfe+PwiIVne+VPU
         qI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZVQ38JXCQPX1zKNdB3s531A3ZBEl2/YN5m92yOfvAjM=;
        fh=+PCXOpEwNFguUMwQVaYRhIP1MgwQlEqYD2iMqmgtYGE=;
        b=hI3PTErL2BFS11P7zG2GOk/JddeXbTRJM0ORt46jZWo707fwpzWRgKWjJdH+FFQGnF
         u+W4DK6ECTP6zOB0NUSnnahYhSeQMnb31jLtrwc0OcX2UnSE+r9M0unypRmkWxXk4/Mu
         ND9Liel1aSN15yG3X5RAYO2Y6yUscqw97GaKKxzowq9jgQv9oAfYGyHuSRoh+COcMUtK
         1b6IvJVZR+nEWcFdSzpit+6wn0F8ticMxxtfrSBBA9ih8FmwmxJ0t08vAgskgMrwK/Yp
         dbRHD6TNFrd5gsfUuUiOTGTXVr59s71yAVlLEWg8O5ffSnzNLbAZ81oloCMUIWlj9VMI
         nGHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1777459147; x=1778063947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVQ38JXCQPX1zKNdB3s531A3ZBEl2/YN5m92yOfvAjM=;
        b=BcZ9MuMQ6Q+2WG8wSzqCSgLQXhW4YW+NW+ONhw25jdpM35y2i1nUU8bqi+ClwG5rBG
         GiWDlE5i+VoJAfMDk2ZbsokMOKMJlcfiOjm+utsp4u0Kv4AhvpvJI9qb7C+vh4ZwxgCD
         Ne6ZE9nMD9CV5I3xJDybP47JYVGxa3QNvHPHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459147; x=1778063947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVQ38JXCQPX1zKNdB3s531A3ZBEl2/YN5m92yOfvAjM=;
        b=Oh5zm0qS1WSPQo6NKl60TZqsmvGzfZYPDDtpYbUeDQzWydgLPHdYym7Qo8sj9Jyi0g
         98ot+dKi/GMye86Zoobd4kYx4JAxY6pY83oWiVWm1vbO36VT1FW9uZIiQTRg71gxXgZy
         Db7QHk/+ddTdmeX/lhYxdiMlCxF3rwFUu/aETwJt9Rg924BehHCs3NBeA8XiMlqPCw02
         J8DHiHhxsa4uFrQDA8ImTLXfRNL65a4NLK0j+Vlf2F/32jIDbk7xySK4tHJcfZLRxsqe
         vB8epbMkaOSX6X3ccChzGYz3xHQFlG5iAw6K5BHwODFGZv1pD1QRS1i5mlK1nZXfEI+W
         akVg==
X-Forwarded-Encrypted: i=1; AFNElJ99AfCFiVMNJjrw5QB9DCNd4YhDPaqruU9LEDPxkMiuPqZ08vBecVxjbth8qDWG7FP1djt85gAK/iXWbHPd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4snrIplgi5+exTEkPj2LwzMqK8z4OkxkhjEftXYPdRVIvUNa
	qEB45JGPpwXIIdIhtKQBDDiMLfv92NgoSAcHOjx4L3wWFSTxUE51MqgMyWnS3lPKtMizFtZ4zxM
	fv5V35w9P7n4gpJvDhf4OAvcUG1yV6JNuQYQkPCcDrjoWaC09w0qf
X-Gm-Gg: AeBDievIWPMkGMVISYqoFVpvvmgppHQ8dMUH+5uwZ6LkAo4MS4WRN2WNQav7591iD0X
	fnffIlUfY5tB/+9J84SYbZBM7NbVWRHBQRmZYHhCmna/jsOOUkeXK7mMkwXFAE5sD/CSXCTyAfe
	Gza80+1nc8jABIGtwSrhpsJnmDeSFFGQEAWC3GfsKhWgsPlGeoJTA6WXvqyhPHJ0m0oZMvxBxRk
	n8n5+fCltaIBpYOpgKQNr/F9XGAUjMYdmJ78+AACOtNQAjHA9+eKvw9vv4lXB2n5WtzHYvJIalp
	M7i4Naewpr9Ko7zttL0/JrU8VLZT1SlKk/Y2+f/FQ23RXOxPteM=
X-Received: by 2002:a05:6214:4187:b0:8ad:d530:34b9 with SMTP id
 6a1803df08f44-8b3e3208c6emr120424996d6.34.1777459147103; Wed, 29 Apr 2026
 03:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428233028.2747981-1-mochs@nvidia.com> <3e889026-de19-4238-ad5a-6d7b31845603@ddn.com>
In-Reply-To: <3e889026-de19-4238-ad5a-6d7b31845603@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Apr 2026 12:38:55 +0200
X-Gm-Features: AVHnY4JVx_Zw_oX_K70r-oCxF4tHsePbAIvh2QbkJRti-_8qcVM7ZUwCq-I-Mso
Message-ID: <CAJfpegti_MFgBie0=gX0RfZ7yQTtfzUMaUk6o+qunO9cuOeE4A@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: back uncached readdir buffers with pages
To: Bernd Schubert <bschubert@ddn.com>
Cc: "Matthew R. Ochs" <mochs@nvidia.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 11:29, Bernd Schubert <bschubert@ddn.com> wrote:

> Josef and Joanne had spent quite some time to allow to use large folios
> - maybe we should make use of it? Attached is a totally untested patch
> and that ignores all of Miklos' comments for now. Also cannot be that
> easily back ported

I'd be happier if the VM infrastructure for folio arrays was available
first, then used in fuse.  Not the other way round.

Thanks,
Miklos
