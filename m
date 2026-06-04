Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155F3C81B6
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553581; cv=pass; b=e1PjE7rsJvqtn2Nf0af4BRGEVHd10slTunbPPQCtgET5UEFLmjlM4xnUfr4vHFGMyhQ8k/Xr4/8gMhQ5qT851qvILt2588sacUpYygTBV6O+YR5ovc4rIYAVpd2DMcCn8u6tpVpnVEPw8YXa3l3dIO4nKUjZ45RFPIJfxlZ6egQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553581; c=relaxed/simple;
	bh=Pr6wlWNtLQMgQzyy9L6pkNg4ant4ewsf7oEzgRwNQaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxYIBj9YPlZY9NrYqmpXgGMgIBYuYxf75Jtw0atTjs/TS9Kh4DbMyTrl0l+58G7sPpACVCPc3XbEa1hXGXmXuUeLJIyzHLyDIt7uzIiFrvxgOCklG3OKbbjbuPfmPanIMliuIYbxnkxDs3c8jd4zax+1vCjlL1VM11R45RA9rNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CFT1XhzR; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CFT1XhzR"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5175eab3a93so2825111cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 23:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780553578; cv=none;
        d=google.com; s=arc-20240605;
        b=JBZ6bT1iKSOesitqYnHwzioXwlFb+/6AZfSIH5g7LR58BSt+vobd2WT/WQ3d90qpmy
         YUboCczo21h4ZREOabNapzxtHQ2I0A9yPLCjBgPplRNmiPmwWHM1/OTtKe2TQRWiEuDI
         /HU3XUpwmabgp5Ov3ym4hJweQbyLRTleFFn1bpa6HJrtf92xS9+pN7GPSHRLbtDITXA8
         veymqOMOO+NUd7OgLrYsfs3iKOKX/3bczWFspI0GNtxKTAFn+JVbTidb+E2qu7ymMYH3
         hAVyL1lDMqxje+q77ZTJBteYcsMVGOLnV2wcQATw+NXT8/RpJc8DkJZ9BRmJsIiAmsM/
         WE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I6AF20u17yK8lsLHY26JLuWUs1jwFfZ2TsdktDqCk5w=;
        fh=8usN+7jQxeyRcCKX7Qk6DNdcNvpw3cnH0tNj8uG14kk=;
        b=b908+LzV+5vUqcNaIUWXyWWx9LZIoXUy4RBBdn7qJ9n9CrnQ10Eu5fKtBk4/mtqvrC
         zyv8N+RbCFRu9QPiz6wmkXlyXFbDccuziog4xxe4/n7a1i6uxDJWSALawvjReQiqRtYD
         FE2UenvS1c8pvHQg/Om4CEVxG2yiT4y5uTYWkLhWE45/uk3WbBXKh/mFBBx7mUt20Jwy
         CH7RCtyKSdOEeD2S9P43vzuDsi7xe4CRZG3PmbbMYzeooOmgF/aL2IhknMo6FV4Wx/RL
         RF51dGE0OB+zOD/7pWquWlfDo3zUtDTR3YS0A9gQre3+kdGouv3zO/+JlYxfQFSt/Jmu
         TTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780553578; x=1781158378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6AF20u17yK8lsLHY26JLuWUs1jwFfZ2TsdktDqCk5w=;
        b=CFT1XhzRZyF+jtK2jp+9SepUtxyW4QeRs8DDVaeQY3LXrDEH4Til7emCUP+92Blpcz
         VGmZU92WAhz+nTBwUbQIN3irmp3C763QXs0o5dKGHXZOz90ONdlzGhDEngUfMvTowLiv
         y0NudOEdbRAMWbXOSOZQoviEUZOqsBJP2YTQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780553578; x=1781158378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6AF20u17yK8lsLHY26JLuWUs1jwFfZ2TsdktDqCk5w=;
        b=QI73NnuSGIMOUbjZjANZxmoKdgUqekd3McMubi7rRDX22rm5bBi3IQxozo8sMTrA8b
         6dLNybYSFtaBOzh0M3dYNaIacTIGSdJj3ovgNN/S6j9DUnwdqWvupLaJr9cWxLG4ZNBq
         jt/EeR27UemJ3zZaXUpA73Qw8qOVY9Dn/wQWacdCj6meFJBMJU880Dhahmin7BWt6i9L
         1nakEqSfwLkQKeuqOywz7N89mI/P5UFasPENMmCtwQb2lpxLyOsK6NnW3Afh8QgKo2Bg
         pHe/VIgNpHHrYYcWGeNPLBuBuo0ZoKQQfBXHUxlL37bkpPTsHzNAmSVbuS7E1k8wTzJd
         4nFA==
X-Forwarded-Encrypted: i=1; AFNElJ9wFGA5kg7LvfJgQrw1Ra/vvB7eCrm1mV2pO+DfIIJB1Wdc5OeO6zvpSXTLn/KmUc3wPyQgA2Ba/TICbsmg@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIYzKoX3LzmxsJ7IDWwwA3w06/dGi1mEmlqyM1bgJ1AVCsHAV
	L+dFP3AhNf8NGLrlS9XoeiH/qvVW0Q4Ao7Dd4QyGlBQoy79aj26nkDR5eA1RSp265Cx0GkfGvCJ
	UY2xWJdbHNUsCaBrXJiPV+L+bij3wgpFKCdh0gCJ/kw==
X-Gm-Gg: Acq92OF7J7YGbutFd2ac38uzYJlu9PNsL+c1GwouPr0YQrNc+Vig2T2LQCDD6uCFOu9
	LcEH0jBUFCtGDMefXbQYpaz42WhBtTnLmDfsqvWELRYNlyfmJ9X0sOfchS8FCAecThFjCbYHRpX
	wJ+DbpQgwusZVwnuorKVLW5/3h2fX+yoMKW7CPfHdwmmpqST7vkfHyUXAGQy0kxcE6Td03LZ88V
	v4Wq5jc8yeB8TUTn33i4nmCWpmPslmwXiyo2Djyr4RVWU9exUqfQrxTdQ+An9RPpwjFGBNnKkXW
	efGVKNUXnuNAaw3A4np/IpOtUTBlS6yK+49dy8AdBW4ErC8=
X-Received: by 2002:a05:622a:205:b0:517:6378:e671 with SMTP id
 d75a77b69052e-51778746f36mr88994211cf.55.1780553578434; Wed, 03 Jun 2026
 23:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601152327.2069787-1-mszeredi@redhat.com> <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jun 2026 08:12:46 +0200
X-Gm-Features: AVHnY4JFCN46EUQT35mtxnUuo1ifXK0J8GC36CfQAJf8_uFrLKrhycYqfsAQQHA
Message-ID: <CAJfpegt5Q0nmK0JKAfa4Bp_SydR1qiqu7pB0JKkXSCFOYSVDDA@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <jgroves@micron.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 15:21, Amir Goldstein <amir73il@gmail.com> wrote:

> Considering that John wants the daxdev ids to be allocated by userspace
> I suppose the number of daxdev ids is limited, same as with iomap
> backing devs, so we could probably start allocating backing stripes
> from max_daxdevs (1000?), to be negotiated at init time.

This doesn't belong in the kernel.

If we really need to have allocation policies for backing IDs, then
just move it completely to userspace.  I.e. pass the backing ID in
fuse_backing_map together with a flag (FUSE_BACKING_ID_SET).   It
would make the open/close more symmetric, and is a nice flexible
interface, so we should have done that from the beginning.  But I
guess we opted for the kernel allocation scheme due to its similarity
with file descriptors.   Oh well.

> > +       res = fuse_backing_id_alloc(fc, &bstripe->backing);
> > +       if (res >= 0)
>
> 0 is reserved, it cannot be allocated

It is confusing either way.  The (res >= 0) is expressing the fact
that this is not an error value.  If the condition becomes (res > 0)
then the zero value becomes an error condition, which is crazy.

Thanks,
Miklos
