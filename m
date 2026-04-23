Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEE1F5821
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928806; cv=pass; b=Vd1fRVxj2wM9dhxtGKzxfAtH2DVceo55FN6fUeFCef/tGwsys1I1cRx7Jkid5bk+8cbpYcf1ygB+O/1tk6xB9LN4kQPXFHA40ezAe4vXRya8lzg/XEmhKEc1FE8W2YfODcYKNHCAsJcgov/uxKf0GYVVjW/vLwYS8dGMvHIKDxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928806; c=relaxed/simple;
	bh=2spsZLopetD0AVjbS3xHfXfzVqbgmaAxnQzVgLMWgfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm0Dhqq2fgriy8yn8+vS/k44/Z9GUQLuXqDbeSbiMVMZDlOW1pTHRNhxy3zIMrl5sVl+HYPuc8uHZxerevBU58U36PKUqs+3sW0zJUi1njpgxXgG1z2gHtoYoIzmIMPebkM2I310IcAcow2OO1FfJz22zn0t5R8pfHluQSm8kBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NcrKsQPd; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NcrKsQPd"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5062fc5d86aso51902531cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776928804; cv=none;
        d=google.com; s=arc-20240605;
        b=Doi7TunNBpf4o5gQ/JkswT17224mE/jyGxmMAqJfeKaLFofv1LqKsu60/dMhZ3VScN
         yGkbpACCkn00fS1bGHi+yk65J/J42kBfaPfhSShBV7/DgxY7mBvt4KIDJAcWeEHho1Dy
         hU1+jS6V1Go6MiTbjYsutCKGU/iUHHJ1MdsfkBTp8tUZsGp8+kQqxCp6aKW1rqRe1bN/
         DgaCGJtLscHeDynZtqUGCVwpVsWJjHquj55TXM7yGB50baIDkBdIUaJCdd/AcekZ3KW6
         6JzUDnmS0VhFiwsUoImNINiRB8S6/R1ce5AqfRWpMcXlUmzF8S0nyRJcVfNH0mI1/d6L
         ifXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nn7TkZue/k7dxDzSXXMHz1GmsfN9RVY/OvzEMUDJhDE=;
        fh=j2ssPexNEdrGQJi1koMNu/hny+RO0tSFF9VvReo2o2c=;
        b=QXI/z18rLYoAa6gCwOjxrwqhA0mTzxEiBZGJ6YGF9T0WXq0TRJvcuHNaTS6+R9XfLr
         q2G5NK43vlhJav7X04g4WdSv6rV4ENqKSI/76GT0gVG8KjFHaQI2/XCHZFHF5qm2PAXe
         GW9RJzj8N0huz4XHUOWyc+nbPcdFeGv5Ay/pu5RSo9pO/JiLUtAyQ7NLs55b9iHP9rhe
         fAFUU8B1qqtI4Pd+KovTSmNS+KbUTpvJZalvNEIOSHQleknz6hZ4a9tYJWf3hm/VTeYh
         ooBYCMvsN59x8+gyuzGinvy36yF+oKfJutzcwwZPM7kA9WXl4UdK3Q5YvVxy7lteFQ4J
         d6zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776928804; x=1777533604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nn7TkZue/k7dxDzSXXMHz1GmsfN9RVY/OvzEMUDJhDE=;
        b=NcrKsQPd4XAgJTjiwBvBrHsfCyDb6ZyO14NmvPbjUQwwDeEV1JWtikEIYQATIVrVSF
         Y0KWetjZgrW1DmSHm2psm3tLNLu3hlK4kKEK2OlgCpjhIZZIhjpq8Wu0AXScJop+XaD+
         8cNa21hL9AtBdRFZNYuqH64pe0/J1QY25oWtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928804; x=1777533604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn7TkZue/k7dxDzSXXMHz1GmsfN9RVY/OvzEMUDJhDE=;
        b=U5qzrX7z4n6ihwpHoQuXPz8bUVjJ8QM/kooOkttokzL4bu5Q/uT027s2dVICbxGY+0
         4AlbrwVCrO9Ngc2SBjA9kVvUZaug5X10NrrGJq5dMdVRTliODtoQneL1KNLMdWp7Xn1n
         0jKGgovMvWJ/LaDUFGR5QEv82p1vmECumyo1iz6cpvyxwgQCxVjkBeg9oqygRQAVx0uh
         dqvuBTatBSRm2n8jBzaYeFWhErYtpuog6S5WsECq2pKM3UKEfJr86rntRh9GuNow97F/
         4hC9HQ6gIVgVJSID0rr43lNOonxmIGJMk1C6ww9If1qmpde4EZWlfgiA0gCVxx641EEI
         dWkA==
X-Forwarded-Encrypted: i=1; AFNElJ+hynLDoB8oKYUG4s82WkUEWeYVfYaxY8K/nm2XIaQUfl2ZYkRcGtTWPXJ48tX9tjKzyZl7/ZmflKDxVT18@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pBNTm71K7PyS9MR6A4kAyP10MOgUHxMYTJwOff7Gk2+rdmj7
	S1w3Cg/AVTb6Mu+RmuGRkARyRT0OFZNuzGoa8JWOp29wtneUVLFOI0BJGFV7BCAHhnzTu32rYvL
	1xSU/j9DSD1X4yXnK7nhjkW5+lZRmFg6VreP4CNWXGw==
X-Gm-Gg: AeBDiesGPPT1Av9WwTSZPghneiRch+y6bnatfpNcY2KIwQDLBDg/I9rhr7CVTf9fgwS
	kRt/OzbDf3ih3eEGYQP+Gqup5DZSpqxO510VpY9wkwm+9xIw+xuJoWabpRuqn6t0BED/Q5CCN28
	wNn4TBcJ8GHzR6otpNwUQdu1vPFF6rKhaujF3QAsZI2tkJUhRf3bg9HYXq26u4xV+wrBFihgvqV
	dD7t3FHU30w76qcdUMVsMvhKhHPWFNweuPHj3r0oov9ZpqHvjcq0/Doif7bV/TT8xsEiOx/8YnP
	vvsqIokvpTOO8T+rj8wy5mQSC56smBtO1OEUqDpgI8WajqdWZ6U=
X-Received: by 2002:a05:622a:790b:b0:50e:6135:f27d with SMTP id
 d75a77b69052e-50e613609fdmr176019061cf.53.1776928804571; Thu, 23 Apr 2026
 00:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-28-mszeredi@redhat.com>
 <CAJnrk1YGJY3EwQi3DoRwYxpGA3y7EUh8KczV0XsDA8KcU7S4tg@mail.gmail.com>
In-Reply-To: <CAJnrk1YGJY3EwQi3DoRwYxpGA3y7EUh8KczV0XsDA8KcU7S4tg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Apr 2026 09:19:52 +0200
X-Gm-Features: AQROBzCU6E4eTaZKcsGQ3R2cKLcCBvV2mAze12uzo2uAtN_K0dMvn87Cy-pJNxA
Message-ID: <CAJfpegtL0wZ5FCodbLCF7=W=_+MHNdSgCyOX6W5Q8iCmv9zSsQ@mail.gmail.com>
Subject: Re: [PATCH 27/32] fuse: set params in fuse_chan_set_initialized()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 19:42, Joanne Koong <joannelkoong@gmail.com> wrote:

> > -void fuse_chan_set_initialized(struct fuse_chan *fch)
> > +void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *param)
> >  {
> >         /* Make sure stores before this are seen on another CPU */
> >         smp_wmb();
> >         fch->initialized = 1;
> > +       if (param) {
> > +               fch->minor = param->minor;
> > +               fch->max_write = param->max_write;
> > +               fch->max_pages = param->max_pages;
> > +       }
>
> I don't think this actually matters in practice, but should this be
> moved to before the fch->initialized = 1, ideally before the smp_wmb()
> write barrier?

Makes sense, fixed.

Thanks,
Miklos
