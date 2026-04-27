Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695B3D34BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299477; cv=pass; b=hBYsGh6qVmjWkzM+bDQHAMVRhHxatUOCxPU1noUdYxFsLb4pEwjvGjf8oFXrOXUnRFX7l4Fxaec+JVOvwrBeCKvbyjg4lfPiKt2RdbPHbJCVIs29hYE+wxpEdIKUqkmDNkgTZ+V3+digYw9vcPeBIRecv2nSaE65psIFI4WH4xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299477; c=relaxed/simple;
	bh=dCas8RQKsBsKm7RPEue3wRPtJ4lneFcySX6TUqGbvVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZo1as4Kb+WtIp1eWNbvsC9HwMGG6lheEIk6FGLm7hREBvv1i06DCULRfJguUyjYoxzUS3bD9Zdto+CgpsiwleORXzQ0qaDhtETCiwhCDzKdLFVcCDz/MbAuMmUr8U7HLcQkJmk1ATm6nkJ6eCfiGuKTCvYu+uBQz4+uwJcWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV7XlqUV; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV7XlqUV"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso9893344e0c.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 07:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299475; cv=none;
        d=google.com; s=arc-20240605;
        b=LTAqBUXMRWU7C238qPQWFRjhU2ePexbcMk7ksTq44spVjhUBdFb6zLPkWehRKMo0nG
         v/WYy+w5l6ElY54C2Bn6b+CES+8QvGNkdNFp47r/wAheqy/9aM/YqJcxDjCjWvSAF53K
         1vH3uhjYnJzesi4IJ2HI1+cvYats9ekXfl5cnX9Ime33Wm3vbErsqc4a55kRrAFlPbbb
         6m8/Ip/T/2zxfoCNMOdoXNHHPg1rE5WF0X4sHR1crZQMKdx1l4l0HxXaXtSDqOREp4OD
         J8OmFsXeAAIN8FasjY1xLFSAUPVis6QyBpUpehTHtO3MqjnzaXxSEjBYfpxlfFytNYYQ
         HyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        fh=wywHasVvklEHKN2GeDyE30ae0YEpphFg845ZFlJnPYk=;
        b=WnVFHS9MKTEg3Ho/SvS2GJKVMfaoFZSUORiKaNvVu+eEwcxTIlosuxq9ZEJAETr8JA
         XY9vuyO2NSWwV7b9AgUoPD8324E0Lp6+iIHw2AgTr8al8Hr05y7NzIOpVwoBRibBLylN
         QgnoaYITR3whT9JEe1En+oslEGbIojolF307YqfrutufJsJoKcXA2GmP476RcdZWp82O
         U2aP2h01RXEx6f8JC7cxPo8V3MFDyfUCwl6ApcQL1V4k1zR3Ptzcj4RyM7DYNrtgQm66
         Jd3hff8x5T/k7cuDEWGs6NZJ5UJtlPiN4wrIOQQq7MHp87ZReMrDFrZf0+gZTeLWXWPC
         DvDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299475; x=1777904275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=UV7XlqUVvinNvlG4ozIHjmCDkWLWkXqWdHVlwKleD4e0udKlFPCyhDThue+4KCSFuf
         4PPkqV7PBmqSm85u3fIzULTAc9+wtQaK8rViECu4uoP52DqNbn15+/ac4reFdyXrn/B1
         s3/x0N6JxPqqHQ+SvjX5nH64ret3FMse3JDW0UFDRIL8eY4pp1TNXlldauyddtT20e1L
         qF3CPo8D4Y7Ek3KN8fARmEEs5LMSb+8CfKYUV0BkpMnaU5nmr2gie+0EpOmT51BfojAE
         Cr7faIb0pQuMBU6P/HjjO15sUUH7oPx7M3XGM8FLv2JB+tutyWbnxLL5ubYguDpuqSMe
         bJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299475; x=1777904275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=CmYy2pi6s0xUuDLr82tQEaU2QPNOKRlEOtui6FTFD/y2j+Dd9/byYSwWyV/ApEZo4v
         KgM+wPHejQKXntj7J6/tNK0NbGpczlsAoMf3wY+0MjppO418dARVC0XH9dCho5L5yRzv
         f8YRjJxh7X6cUMpLwBSx/yYawQeM6oyHVNOJUAG2CA0DLcszbMaiksvNWT7HgoM277M6
         ruPG/T0NRymoxcJN6LuWA28UmlAaN3vWFJEIhROk/tb+FsOI5dRDdNgT8bN4XWE/tbpy
         MWmkW0xH9M7bSsKwaEa5gWOZ/HqMW2OA9FlcLEgG61XglZASjahZAQpAX6PfUp613OHY
         L50g==
X-Gm-Message-State: AOJu0Ywv+J6OJNj+CNK9ywgGKhOpgIP6yfcg9iilOWm1vJiZh1yb8wsw
	4ATs6FbMVdlAdwxJETE8woghQ0Rgw/gj4Hj12ePf0pCfmpynUwgfWF7j4tSiXUf4nWPCMNIQkQ+
	mZCzqNobTIui21JHTbFhv0tDrSl4l0nk=
X-Gm-Gg: AeBDieth3MDvI5WZFQ53TGOBP3I0noe746kzKLowCpeKrNzP9bY5cisDkEJIm9/ciVj
	dRrwjRA1a0OgnhrD+lrNEi7x4Yx2mSXGwpo3T6tXyHGMoyvdiDn5cT8azRh+RLV5kVVGQasjkrY
	ONedyp3UTFc0qeaFR1LDvArjU9wSOz5zpzfqMHbmoZaZHHYNOYrxP1uLDfJcww3GPYK3AF74k2i
	3+IhN6eVUxSxWSN3AcxICzA1xki+yptI7PaMV9Rl3dwBAnFEET4Wm7XQFm8qKvDqeNpewiyJVje
	xsEGIdANhepZC4oybO1QxoRL9KUTE8dbjspE2DyAqEPC0wWDzEIL
X-Received: by 2002:a05:6122:8d3:b0:56c:d5cd:1e7c with SMTP id
 71dfb90a1353d-56fa58856b1mr21307327e0c.5.1777299474612; Mon, 27 Apr 2026
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 20:17:43 +0600
X-Gm-Features: AVHnY4JD2JZaiwDyyuW_kBt_sHjEkoUZKURjGdK7nlj6KmXsjRIqpl4zFGzklnA
Message-ID: <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Florian Weimer <fweimer@redhat.com>, brauner@kernel.org, 
	Alejandro Colomar <alx@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Dorjoy Chowdhury:
>
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 92e7ae493ee3..bd78e69e0a43 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define EFTYPE               134     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
>
> This is what POSIX says about EFTYPE, in the Rationale for System
> Interfaces:
>
> =E2=80=9C
> [EFTYPE]
>     This error code was proposed in earlier proposals as "Inappropriate
>     operation for file type", meaning that the operation requested is
>     not appropriate for the file specified in the function call. This
>     code was proposed, although the same idea was covered by [ENOTTY],
>     because the connotations of the name would be misleading. It was
>     pointed out that the fcntl() function uses the error code [EINVAL]
>     for this notion, and hence all instances of [EFTYPE] were changed to
>     this code.
> =E2=80=9D
>
> So I'm not sure if reusing this name is a good idea.
>

Thanks for pointing this out. I had started out the patch series with
ENOTREGULAR and it was discussed that EFTYPE was a better and more
generic error code which is also used in BSD systems like FreeBSD[1]
and MacOS[2]. I also agree that EFTYPE makes sense. We can of course
change to something else if everyone agrees.

cc Christian Brauner who originally suggested EFTYPE for input on this.

[1]: https://man.freebsd.org/cgi/man.cgi?errno(2)
[2]: https://developer.apple.com/documentation/foundation/posixerror/eftype

Regards,
Dorjoy
