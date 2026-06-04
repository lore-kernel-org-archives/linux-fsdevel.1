Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3147B438
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582651; cv=pass; b=isUA97c6tFd7oDQHxS2vo6omnRUU2GjaG/Bqom3rqSwN8rh+gVTZSLbVyF7kM56nEjhPmW3QN7ERfv6jAOmJsW5cguIpiJ5JzrPlmD7I4JwOEoBEw/5o7Ue9sSFkR2ChNyS3m5NmXDXsn0xWFlYB2JmNC1LH9fGz7+TAwZDHhnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582651; c=relaxed/simple;
	bh=g4s8q6wCkTd+WvxFn8JlUgsNJt/EdkDuJ9t+wJpILjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LObLP3meQ0ncKq0SRxbqjBHnAfvq+YZJf6KHykDBWzdIaKC5heWcYYvus8CdhxEOgJLQh4B8cIijnywDsdDPjhGUv2dCCGbptvEw3FwKS+eWNkXfFliSKStlToOKQ4RD4L9j1M6z4MOm41Ofmo1eoN/2eZSUsM20cXbsL7SzSjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=c+YzDh5r; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c+YzDh5r"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517760dc3c2so4439341cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 07:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582649; cv=none;
        d=google.com; s=arc-20240605;
        b=IDLlyGhMijwG2icdtljpwO2sG8D+yDHvyQQwMGjTyxrtx7i1eEYGLFwWhatWLpNiQH
         nxP7/Nw2CcjowWI34ZDBwRDktTcFBt5aTYMkSkhH0SxisR81t/eYqDU+X+C5IzTK++F5
         OJnufBPoLupX3cSaY4tI2g910pmggNaglSaUwKh+4AMhETpiC3YMEiR1lxhAMnmsZzvz
         E4eeuL6nDSeseXyNsmXfuFnqnTpQzWZP28CL0NMp/vXWc3O5SpnvI5llS7/E3GkP1rqQ
         lr1+TTC97iNHWphf+Qh8678ymTIvCmbeGaJGxiHhF2XMu+bGEt4GBNNSNmneTa2ReCXz
         LlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0YcKMZOwZ9iXobTM6Q5V1uLTk3dUBPdkuRRogVK0zIU=;
        fh=upywKarp1Lks7M02kLe6a2QpZBtAFMSpIcsUWlbEZok=;
        b=lDLA4hRSsmIsVMTgrHAHHVuTee+5647XCYdo67YJpdaiwOlTG1NFG7SleMY9/Si2dH
         fbiFCG1fps9AZPeS/ndJvtXZaUgN9+ZBUWc2PIp9jy3tJY14QSL+rYs8y6doWUPzbbG4
         6A6SqkqUzIaUxZsB40HNjxFT2CqaGdpgHj93LP2BCzgZ8oiLx8STqTLLyG/IUYQTgDKS
         6DHBgHxx7Zhpd1xQ5NgD6CBC4JxXlDyrrXJacaTLH5Z+ywWp0WDTaz3cRNlnHI6TWQAK
         uO7xrn8O76E6iRwjem5TnABrYNXYJOeSRVoJnWb14TNMmkjugTDUIidom4tgJU/hLAsD
         BJxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780582649; x=1781187449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YcKMZOwZ9iXobTM6Q5V1uLTk3dUBPdkuRRogVK0zIU=;
        b=c+YzDh5rVCl38dmGnEej4q6e8zZ5WYtf/+Q18A7taFvcwWpYNe/TQtRyhlbOErHKun
         ujQdvhAppWdtSucYzyBvGOj4kD2jQX3Cz8rOFgNuhYOvK8V+s5DlvR9LVsO01plH+LPI
         34q1tfnr2yxtBoZJdclMB19OIWH2xS7u/TE7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582649; x=1781187449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YcKMZOwZ9iXobTM6Q5V1uLTk3dUBPdkuRRogVK0zIU=;
        b=IUpEKzLDOS8EXHF2D90dMFMIRPjk+4Ookaa7GVwqxebc0C6g/sFVSrLvaa7oyd63BU
         w097vuMGDijG3U03RSwi0OTv6CmL5aeG/j2GrSGe7IDRoAiHk0cVOfIcKXSsdcPcZMH5
         Ewdc7/T4rr+uBY8ZUAl4HZJ+7zmMplph+jW3L3xsgB2hIWEEprmhXhpEIcy9qmMTnMXi
         YO7CITYpsVsi2fw+WWVNL2zTA2eOhCusWzksFDsiKUoLNt6TVJWmeb6h7u4BYoBTZoKY
         aq4aCAwOL0cUPmWFPRqcvcMOPrZ5tqBtJR/N/jzU3NSiRki9eHZvR7oA5W+KRs4jAv1A
         SwZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wQIVsNkYonvAS6DwdtwhGdX5IxU0N6IK4OX6g5S3FAu5y8h9Rgk3dbR04wZ3EBwAnRgiqK43rg1ltLhdn@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWHCeWuyrdFpSKlUtWsJe/Bhnwqdcjz7kSk1J2Dbs2TcRy8Gq
	uO37Wzm+pVZwHcUkr9xfFr223wafzU8ACv+umIuPg/g2jfpKOk27OMLe37jKc8pAAAgmTHXU/IG
	TSU2GOC4w55wFZqkZqIF+ZQDg7Sym+nFd6ly6ygSBlg==
X-Gm-Gg: Acq92OEDRvOTX46IhsI5jkY4kfkMtNWLPlwqJ2hpYhq7ltbzBZjWMmXv/zlAsye/ucJ
	zPa090z+D0HKvYwu51s45GxdB/ELSLYjycuBL00x1P7w/zPzGyvAPQH61mlp5xoX252o3xuLP7c
	O8Z0aOWwrWZLpEvMEB6NaI4n7EwAD2/p4X4mp0ntgcjn+OQNwHPnj4gDvNz7qdHXZYu82nx1Rvl
	0248MrTvDC7aBmo79Xrxnk61mFG6uk6ZKRGWTmQ0SCxYtUA0xrtdgUxdnLDTcIqikVJk1UCKnzO
	tY0vg3bfNUc/p9b3IJf6b06RcyLRnmdlVv+E02ZzxIGjkyQ=
X-Received: by 2002:a05:622a:1c19:b0:516:cfb9:2856 with SMTP id
 d75a77b69052e-51778683f95mr112927071cf.31.1780582648812; Thu, 04 Jun 2026
 07:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com> <CAJnrk1YQO99GUfTF4n9SOrAVncLYraA+mc79Fvg4g6Fum1m7VA@mail.gmail.com>
In-Reply-To: <CAJnrk1YQO99GUfTF4n9SOrAVncLYraA+mc79Fvg4g6Fum1m7VA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jun 2026 16:17:17 +0200
X-Gm-Features: AVHnY4LvKDF5pRQTNZRq4yOjJPUv7iyIYXVDPDNxqhKwGjyI_EEQPBIoVtdu9wQ
Message-ID: <CAJfpegv7AL0+j77EL53iEMgpHN0nb6ExuB83m+UMggMJkvQqzQ@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <john@groves.net>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 00:13, Joanne Koong <joannelkoong@gmail.com> wrote:

> struct fuse_backing {
>         enum fuse_backing_type backing_type;
>         struct file *file;
>         bool error;
>
>        union {
>            const struct cred *cred;      /* FUSE_BACKING_FILE */
>            struct dax_device *devp;   /*FUSE_BACKING_DAXDEV */
>        };
>
>         /* refcount */
>         refcount_t count;
>         struct rcu_head rcu;
> };
>
> where that would let the idr just be one type and would let us drop
> the fc->famfs_iomap branches in
> fuse_backing_{open/lookup/close/files_free} and the corresponding
> famfs_{daxdev_lookup/daxdev_free/devidx_free/teardown} functions and
> let daxdev piggyback off the refcount/rcu in fuse_backing. Otherwise I
> think we will need to also add the recount and rcu to famfs_daxdev
> separately once unregistering a daxdev backing is supported.

Agree.  This is more of a PoC for the uAPI so John can experiment with
it.  Will clean up the kAPI once it gets some testing.

Thanks,
Miklos
