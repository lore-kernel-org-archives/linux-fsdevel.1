Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793217565;
	b=aD+WidDVwZPNq+zYPQ6jFaosgOcrEFGyAEmllGqM+9URV3OVQCzfUqJjJUx6oJfGkqud
	 gMAOfbk4poN+W8ARD0oIG1FRmkvtsb0DdMKOFgZ1Jwvvx1uAlzx9eYrfzbT41PjBVhYXm
	 ngTobZMf8YYcygqysqa2+22GwaFU371g4Daj9pd4esgLDzVPIyymGfvsD/prJ3VIhn3sF
	 QaIsCbr346g1fdu2E8CvshgSQvRJp002+sJEOq/xUoKNqFFjtMC1Ntx63PtOV88OAJjfd
	 Pt0vMrCOo1iNZoGiGxPJO5SjNCvdJm4atW4W3bspHuqqq09ue8UgT4iEdNpA7XnyU3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KNPolz4ZvstX96ia0adxYWJ+Q8YCwfoUsBDxmY4GZ/g=;
	b=CqDoQf1AEWd+szmz8IjZijESD93cSLHzhTzfXE4b4sUftaKw80zrpNgzpk3RD6iKtbN3
	 rp0XBbz860bxoSBsiZl2CvlOa3pzuB0TJVe3cOGBEdbX5sn+WQLRpjTFSvMjJaOp9vr1s
	 +UwuDCsMOMx4Cyk/3GRBsiyh2dVVk0tjlwztADFHBjq59R0fOW7pVOCAuDSC4vxCELOLm
	 cVUXCB+gZ4GIMGHh7l8KL4f66nUPgxSPos3DzbVIPOjny+7ICm3jgRj69eKps4dpIP8QB
	 VR7h4yx533jHv23jSNblhROgX+YmPyCiXCTaLluRj6DCbGIyHhSGtyHCUXPPibr7wzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gCjriWQL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E8606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 19:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E85E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gCjriWQL
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533202fe429so76681cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 12:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217563; cv=none;
        d=google.com; s=arc-20260327;
        b=LXFMJwiP2QPDU4Gv1IpToKa5eN7KieXA5/25AoNRyCsiRbrOqc80npuE5Tj05olvWD
         r5JzwPOfXYWbsv4fq0dGgLpnEgdr3avfuAQ8cd5NQSpMCrGpdgwHp7tFJYtM6LVM9iag
         ktXz+HbwSu0skcqIzjUk244kkAlC/kPn4wjg4rJcz8ihVtjIpLASg1kVZVzyIXBwQCF0
         x8txg764CSOP3cMqgtxnq0lfu1m0ZbRJZcGoQN7wR/3ZGOjI+FQ7E9tLg2/VbRppRg6T
         DE7DgjwbTRwo/OMOdOCwXI6GIOYvh3+VPvKJY+oUEKQi42r8MJPNmsCfGOqxg1VLmRy2
         gNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNPolz4ZvstX96ia0adxYWJ+Q8YCwfoUsBDxmY4GZ/g=;
        fh=cPiKbBqsNDeYaT8xBjRsIhA5aATvhTkprFQGObILEOA=;
        b=O0VJo3k/QhboVh0STVdNkw6xTLq4p+e8Q7xvgh62rOLj6PmLtH4md7HuCikXyxws4T
         tvFIwRdgudKRX+QlM0pa8X3MLqCNx+xMWziwUohbWOHBIXDS32RUiCOT/WhlraUeg543
         Jl/GITdDHzodavO+0mHKoSG0jDITw3c2FcOPxM7p7S47Cq+wRMhng5DzgVkuf+YFWhi2
         4nNyCdgTgHINX/qW2YTTiS3+Cy94haG8lBmFjcWwbCw5NG7XI6lMIvMkB0hOHcoHqHLa
         ZUg+AirV7egWDk6MvCpR9FgExzb+00DnZHPkvf1DW6C62dZ8SMzE++nzmQc3+z4FAHrZ
         EUpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793217563; x=1793822363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNPolz4ZvstX96ia0adxYWJ+Q8YCwfoUsBDxmY4GZ/g=;
        b=gCjriWQLQo2QvHH5JTfWBFdwWXcomYNyjYW7ZcE4DfNTnnabubGbcuv5TLXSpg9Cgc
         WX5X8EXcCS64I8UTPo+5tYP1xFIrho21VEn5ITbIPcwa5MlX3TNi2HEUH9xAG/uIh0p+
         /CFb6qZJ28eo8GCSMNw6be/XK86w47lT+ZGGezFfXnuvOGdoWMuP3bexz8+YZdjw63Gg
         BiD5nkw10JRLzR/s64bohuksvrG8P3Eqhk/p/8lpvPVBBghyvYaWQjQbi7rtyWc3Kz7B
         pFh1x3lH1zeYVdHOjyLbVvYJgYgUnAOIrVL0E0kuocfo7/urV+TDqxqpa/APfSlLh9vL
         GC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217563; x=1793822363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNPolz4ZvstX96ia0adxYWJ+Q8YCwfoUsBDxmY4GZ/g=;
        b=QlnBNx89uhFO7i4KxrA+6jGaBHEDjTy0iJq8zTUeuZNKMYGLh1odStktf6USe6c67V
         CZjyI99L2dh5V39dpePCxEDWDJFO+TvzE5bwA5bzxMRHCewJcbDBonjKItgCiknCY/pc
         c6xGQ3cF/BwMTDXJ9UxhX/afF3W00bLqXY+fRzN7XsdLU4F04tn5D7Sx2dQtvUqnTNyg
         0RRncTRQyl1b/dyw6lgzzzAVS9IResVvGmhJRjQJYmfbyUu4KuY1yStY7WBRjb1eyIS/
         PmjqbqMDLPJUcynntmQEyP5EFrGePo/70cF/jt1EPsxc8UWDyG/WnOfa7CfnpOQvaYmS
         RihQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhM/2TDq5u7X+5po6BG1q3SNUIHuxGbj9BxR1os6ZPYqwLVn7lR/GxgLKpAPTYVOkrmUir462KdLSbnozy@vger.kernel.org
X-Gm-Message-State: AFq9FYI3ggtwIUe5yDo14oQZ771nt92R7Zyc/+uxdKb9Doy74GypqRVg
	SmaNHG+lhobzqF9D+K2SuniFwe3/Tc//awpgsoN3teXfh4XkRevwI0p3l+48TEd4OadcugbDt1L
	hJcD2Xqz/+IxsWlHY797tDQ0sFkhhgfnmc/QumeOg
X-Gm-Gg: AYBFou2dtO4J2ZtqSWAVb/NUw0DXYsT5qJYMR8OpkwPA6srz4Hf1ex97JGDCBJMpvTL
	0db4iQoQxiAvSyoHmIsTP2IcxtDjclXaNUiP4QPcdyUVdnDHmLxsQtKJSrD1i7z+X5CqGX8agD4
	vlJeseGip2RGx2AYopfLVJjUaZTc679/BON69j76UgNw0VMCUZavxw6r2SYi7By8B3ya0aD542x
	NC43fmx62szez1vdt40mE6t7sg5x1i/NpsJRbol+aEAuZ174yTJOEM1mHtpri1d8BZ1gJk4dMQz
	u6uYlGh+2t3ZIz2cdv77CrF4y7W4HU8aRPPcgZ2bR5k92+V+x94rOCgn1mXhuf3lldvA2EaFp+O
	boCv29lJvX5Ju/ESZC2SE3iat/bJv0WNVyrF5mbc0MxzWs7lT3CvEvrMUtbVpUX+uNA==
X-Received: by 2002:ac8:690d:0:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-5414d92c15bmr762701cf.8.1793217562021; Wed, 28 Oct 2026
 12:59:22 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028051312.1505295-1-surenb@google.com> <auHK3k-W4gfL_MhI@pedro-suse.tail5790ac.ts.net>
 <auJO9al4lmAczLAu@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <auJO9al4lmAczLAu@pedro-suse.tail5790ac.ts.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Oct 2026 12:59:10 -0700
X-Gm-Features: AclHuK9-6O7OXV5NH16IYTfE9EYxAq4xHV33LgQLBVE22ks0KWFvxZhPdcny1CQ
Message-ID: <CAJuCfpHAFXDXs4ZBrd8C=8hkQdJxcWCz+DER5BG_Ki0ndGpf9w@mail.gmail.com>
Subject: Re: [PATCH 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	jannh@google.com, liam@infradead.org, willy@infradead.org, paulmck@kernel.org, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:42=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> w=
rote:
>
> On Wed, Oct 28, 2026 at 10:14:19AM +0000, Pedro Falcato wrote:
> > On Tue, Oct 27, 2026 at 10:13:12PM -0700, Suren Baghdasaryan wrote:
> > > Pss metrics can be affected by map count even if VMA tree stays uncha=
nged,
> > > therefore test checking VMA tree integrity can't use them. Use Rss in=
stead
> > > and pre-populate the VMAs so that Rss changes if a VMA gets skipped o=
r
> > > double-counted.
> > >
> > > Fixes: ca5480fb53fa ("selftests/proc: add /proc/pid/smaps_rollup tear=
ing tests")
> > > Reported-by: kernel test robot <yi1.lai@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@inte=
l.com
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>
> Actually, now I'm wondering: isn't Rss also flaky if memory pressure occu=
rs?

True. Sashiko's findings are also interesting, so I'll need to figure
out more robust ways to test smaps_rollup. I will post an update once
I figure it out.
Andrew, if this test failure is causing issues in the meantime, please
feel free to remove the ca5480fb53fa patch until I get a better
version out.
Thanks!

>
> --
> Pedro
