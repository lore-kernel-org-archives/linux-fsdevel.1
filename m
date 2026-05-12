Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E94DC533
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566990; cv=pass; b=ZSqWxCBfW+9VbE7ZaWQZPskLonhqIoeXnyJ9Ntr8hAaTk6tvUj+N1Z7NHrWHx0zqwH+Y6Tcni2Iqzw9bCZ8buBYV3b8LJ9xASfWBuwu3kaEwi+Lc/+ItGiBuHtRQLO9VDofZ1DOrlREMH3fVE727ONw7UL071ZcTWzdUMaI0+e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566990; c=relaxed/simple;
	bh=GADmV3uw1vraeYNC3mHVOf46mFCFzRiCd41n4/XokPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grZkcEQIEb7bvz2ivOJ7jlyDjL8ZqP1prNL2EVpFIVIqgu/4uHDj6nYKTkU1BDKb5qq3Uj5id9cht+PUh70nvueUWTLYon5bXPOc5OJAtnNm3w6AnKl4emuxik5JezC8Bv3mNdM0FzinltWHGGXb6mTKNDM/Nf/xChB9EBDsJTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V/flzVqk; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V/flzVqk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e63771eb0so48412941cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 23:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778566975; cv=none;
        d=google.com; s=arc-20240605;
        b=LxexXMzUF6HPuPYo7F2zfLF0hZBqCQr6qtj+U8HRg0CDZ+Sxpvu9UjtkFPCvQ7LH90
         mtHZvTQnfxfy7JM8foTf5z/5gl+IUciUTX72Pv/QyMdgeQhz0Izi4Wn9ALntd45HMGIN
         cs5/kX3DRH4zZvgTZxG8a9YIPiw29jyomFzcUMR+i/R93DjHawKr5N5Mb/jlz23tO4nk
         YMTElQWIBjvur1xLgr6Dd40NUI+OtuSWfhngqNpiHO/8Z0z2AJ1Yx7sn1vTWfm9JRQN/
         IPBfQDD2zc34unPBAiU3n34FsgAHOU5a0cBiUYQPwBY6Q+ilXrzE7350x6s82SMj68G0
         QHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GADmV3uw1vraeYNC3mHVOf46mFCFzRiCd41n4/XokPk=;
        fh=ttIbEnhrJ95t0fBSS4E/BEff3YTXfhQ7/K+CXx0ZvFw=;
        b=XS+KL50RtLm7mRBcSOO66dTzPNNcBqLV9xaFdaMPU1h4ZfUkqwN5gOGtCtgWeIDO6n
         uk+/geG4iIptBr91SxL3j85BX9WqI0cG3LP+XJwOagxicc5/Jc8XQNzKsXiLvWehRRZi
         /zHkNLkw2xH5L4bvAf+i33Wcf/lc/LdH4tNCnBafG1BPLAGZK9dq1stdpAHw/93IPUhR
         auh+nWuyOvVlmjLP6Mg5Vg6Dp58z5b1LXPs05kB6yAMO+bGBULCFbNrBQ6uB0w8MZe0y
         tloxV4eQzaIzlp8kIAjHr+G+/Ayg/Bt/CuBvSmKiB7+BvFb7ohBuLckAjiLSY0F/yF7x
         mYLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778566975; x=1779171775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GADmV3uw1vraeYNC3mHVOf46mFCFzRiCd41n4/XokPk=;
        b=V/flzVqksrvESqVVNnFn1Xv+7ut68ikO/ANbwJQUhezb94kTe9RJIBlkJSi87i2CsN
         kescYe5qh+Gh58STaKlyiX7klyC8MkOagO4uZfteTh7wAE58qsb3/ZjaKmcJhioexIBq
         pcUFdUIpFcOmzPuggsSSCBI5HwPDLtFTPmI4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566975; x=1779171775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GADmV3uw1vraeYNC3mHVOf46mFCFzRiCd41n4/XokPk=;
        b=Fk5RkRSfvtmS/96LcFyBMg9lnTfLmqMbbIg4zqggigS7guv0oBXbN24guyUlVnSfd6
         tMpLVC1S1wVxfpWMAjwZEJw+uTQvg8AO8PdKXtmIe9OWPFDUVJgLf5oNq2SsJws6Ykmw
         NkWBW5JxBigko1odQgB1Xbx+oLSw+zmrM9T7Ob854bk5EHpuXMjKOFubCpkKLnR5TeBR
         KQAId/UqaNHISAt3TVw8/ahdtQ0jGFSrCAAfh8NAkXqCyt+CcN0CJgFil+QAif6dzH61
         1VXMaDIlwmYqp0luzFNIr8+LeITiTOHnKO4C/EX7hCZxMOHo0XV9QSL7lFnxAjQ+Eg1e
         qgFQ==
X-Gm-Message-State: AOJu0YzlyzWPVLBOwAxYCmzotLfzRPmw+H5GAgrXCNs5pvXq7a0hLtjp
	xoeijQ5ZLGZZLAEV11BQsJccqxPc1ATEU4DJ8cN4joHTkzfCtYzMW/k8v5+iduG/21W4cWnOvPV
	kRuVAYPg30L0C1UDxCpMgDLPB58r0r5tWsFqZHrxm0g==
X-Gm-Gg: Acq92OFHlrq/1irD3koKxW/AESFUOfahvhXSFikOXuCES21xwvng0iIWw532tlxumnT
	KuqMNSwyCG54SOaww5LsuEkVR3poSqpOwiEnrla5Dv79YBz8LRBru0xJwacbB2alxs60H8JXvBw
	2rjekFesnbg4CcqkrLNAdrVCJ6mp+Z8zbIMmy+YvjRxgCxp/23GEJal7i73GOZkFc4Vg86bI46O
	Vg/6YpqYS4o/Kgan1InvwM/PiYBtcl6/PwxhoL7Trz760U7zKDWyZRosN1K3Bpt4LclVC0h56sv
	aYNWOOVRITIrxRAiZAw/zfkxJj6LprN1kI19tlY=
X-Received: by 2002:a05:622a:199d:b0:509:f36:496d with SMTP id
 d75a77b69052e-51461e7ee33mr373212481cf.33.1778566975308; Mon, 11 May 2026
 23:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510145437.321141-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260510145437.321141-1-zhaoguohan@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 08:22:43 +0200
X-Gm-Features: AVHnY4JvwekfCFkgOpuTmimZLqSGTH8wKvr5NVVrjABvZCCc8nV_mYKcPRY9wx4
Message-ID: <CAJfpegsr3y7aTPYTZ6BB3fny6PXBUcG0Hv2jGwCD2CzrcALUSA@mail.gmail.com>
Subject: Re: [PATCH] fuse: use current creds for backing files
To: zhaoguohan@kylinos.cn
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 May 2026 at 16:54, <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> FUSE backing files only need a stable snapshot of the current credentials
> for later backing-file I/O. prepare_creds() allocates a mutable copy and
> can fail, but this code never modifies or commits the result.
>
> Use get_current_cred() instead and store it as a const pointer. This
> matches the rest of the backing-file helpers and avoids an unnecessary
> allocation and failure path.
>
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Applied, thanks.

Miklos
