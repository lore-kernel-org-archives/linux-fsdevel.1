Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BED30F543
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715026; cv=pass; b=a90AVRhzUIJIv/x4FiJDkbfrGF5Srwu27fJoicHhXg3k97QFBhl5SbYDRlUGQ0ucgDLPD5tp1SEYZuy/Habwe4iXsF/NBaZyOT4bBHJGJPf50aMXUblPuVkokwH94RAPgpTnXyInQx2k5RitMoS7SOkZrxVuSKA2y4P22exlGmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715026; c=relaxed/simple;
	bh=vq2F2qrDqHatZB2Dv4dRsCFDd4dtpyUMuWrMGYBfF4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCh2Q3xfS+VUT5GFAR8RuRqH5ik/Z+tt323eGHw8/zmrcjTty0nPgE0QzpoyNl6pGRakv6jn4mEx9FLQh1eF7KdbRoSVmEW7WzM1xvpgOv1aUpv1SMz1EzvOdd+Rzd8dJVsxJPdDAO6crchl+j88SGV3TnbJCR/kO6raknZJ6M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBsz6enz; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBsz6enz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so12190721cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 11:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769715024; cv=none;
        d=google.com; s=arc-20240605;
        b=Qb5simea5CG89Cnh4Q7sRrgBrBvX2toadM/3+M7+hLSigFdpWs3gKx/p5MrA6v1mvJ
         B1H8pZDDXVbE2sqX10UKTxV6xqR9pUaMuxdm/QK8TWfUZa9WXiPhA39AYmba9uNXECLP
         lJ4UmJ8nRtIFvN7akQYekQoyfjW5+4kdIZC7pBSWvdq7vpGRXdwNFyndjKyfO0zIALGw
         fo9/oJBMsewE4hmif7nLsAcoblaJIBOtiuUuUlceeSGxfxzfXSsMT5bbVK2IPbevV/na
         CchNCs5t/ROL6sYEXsX8IF3PKx7wHnXw1UT3NFtTptFA39+25umV+v5EmHB66HIKQi1x
         xsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rS6c2zfbdFe1Dnm+TAVqS/GK0MPUYA5TMw3KDH4UG7k=;
        fh=l/lRu67kruntsoEq5sxzDxrbF/nZlEcE4CdwkK+C10k=;
        b=Tb2ZFfOPuufSF/m7OWA6XPqJ4Mi9lZvb8uKie6mI2TdXv93xTeIJnIPyy3FpJUK8Bb
         AIJFYfvA4zVh9KqlG06AZ93bfybMOgQRlHDxuSRRH7MfTMxyZVXQ2Z7R4xFnC2QFGmsr
         94EWSpCDuP2BpgC6fQBixGmArIGOOmTwwQgFlR2hW3zAtAr1L5nP1mh6+noHUqKVWC1R
         4y10lFfkNQR7c1O9AaSPASZ+SJR28beaiOLLd5rbkRpahkztlKFUpQwVI/0jZWAujHw0
         YOgJxGy8gvcDAUx9rSlXts5u1MAC1yZVmxwbpDoLSTs0ehEFFifgzn2/PiblUTg7980n
         kgww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715024; x=1770319824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS6c2zfbdFe1Dnm+TAVqS/GK0MPUYA5TMw3KDH4UG7k=;
        b=BBsz6enz0/2e8lc0dYJDP0P48fcOxPWi6nAllcEyF8ZEq11461Gcr0zJaT+QqqwGIi
         3I8KcTDqEsrEvW5sYdmuiU/2OkgKvZicFZbaz/Di28qFc2wppDabjfZzPtlE8ETf9LYP
         2f8bb8q7u/xX9w3WlC7bX6z8hc4IVAHnJP0vMNBecuHZ1ZpViZ4+XzVf1QOk1zJTTLpN
         UwONcKEbXy91CjWf7cyjEZVRHe2cOmL3S7TNYqM+ATesgZVCjVTRZENMpo/gysHKV56j
         joX6BsldDEfoamx496n9vO1liskZ4sWaTTFZm8Y6Fz+pem6aelKP6a/EzxTeFX9eZdIN
         FdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715024; x=1770319824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rS6c2zfbdFe1Dnm+TAVqS/GK0MPUYA5TMw3KDH4UG7k=;
        b=FC07VTvVDDIy0gNcyp9G5vxRcmcc7t/bNv8D6VHbGTVbDn2XQSt/yXNfjtrg+wrANL
         l7e3nqhzenhLupBdUjSc6+3M0UAIT0K57tbbw/KmG/xmp8UYmSO9+0kB706q8OJL/I+F
         yjYS9XiyoXEcJk4/TQ1eZk5Jte+kgG7AwZoOT/CX1p4ntHeUkXTJ261/aERn+9tRLYw+
         Kd5p8bIIeRfYgVY9tZJm581GDXcshPwKMUdDg7mGVf7fs9iW4NIf2ORoT3M/BSYGW1qT
         Md846DxVfu4Efg+LLhMKmyPZFF2uICBRYtNa6gtk+KkiQBPa7jzoKr2tqanJCjgk2Arr
         5TdA==
X-Forwarded-Encrypted: i=1; AJvYcCXYeRJf4yRtkbk4MP2USrErswWAKm2pm1MCPSmtNyUFlwaaZFu83oZRscdSfboHouwnOgYZfLB8cGsWDF66@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYvpoKHuu/CyPN67CmE6w2IKy5l1OdojdjidGND2rngsPALhq
	qjnkmoPePyxNRqOHWeg29//U8JU1o1f3AccqHJz1IP8ZgcnlcBtTJHXfmQ32Z1/Y0RCOMIiSII/
	oUbpNHaWoKrHCNCPQ7HNWer5N8Th/mFB6yYzu
X-Gm-Gg: AZuq6aKhGt3tiQ02lcjcizYp0A+g4XFD/XBjsHsiyw8GvvEIQdLTpJM6RngRlaO8MQ/
	GhcTNtnl8Zli0/hMezfHV2pbdeHgWMP3fgDrkAVxm7nq4XPPLlojO4ZPAY5W47Pud8DeGTR9+cq
	kQqjAA7fY3ueBE1qcLUkQ65napyT14mkrUsaQms+tH+5zApaFEG4iAV9j7msQV1bNB1MQmdcIRa
	TFN7AAsUqyv0sDXxCa/+BV4waD568DFL2PRcSypz+mDJG2RZkFtwSzyZEdhICyf0AReabZ1B1W3
	wnUW
X-Received: by 2002:a05:622a:1908:b0:4eb:9eaf:ab4d with SMTP id
 d75a77b69052e-505d22b27f7mr6636321cf.62.1769715024207; Thu, 29 Jan 2026
 11:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-2-joannelkoong@gmail.com> <8e23cfa0-5648-4d07-b873-b364148bca60@linux.alibaba.com>
In-Reply-To: <8e23cfa0-5648-4d07-b873-b364148bca60@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 Jan 2026 11:30:13 -0800
X-Gm-Features: AZwV_QhZ0uIJjJ6y7dNHU6d_a8vepbGZ-Icqv8UM1tf3rOS4TXUiLPTkgcf3I1I
Message-ID: <CAJnrk1bFVPW0MHaz+oos-ze_Ns-9zOHir8OGTKfA7CcYAe=_nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fuse: validate outarg offset and size in notify store/retrieve
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, luochunsheng@ustc.edu, djwong@kernel.org, 
	horst@birthelmer.de, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 6:08=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
> On 1/21/26 6:44 AM, Joanne Koong wrote:
> >
> >       num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > @@ -1962,6 +1965,9 @@ static int fuse_notify_retrieve(struct fuse_conn =
*fc, unsigned int size,
> >
> >       fuse_copy_finish(cs);
> >
> > +     if (outarg.offset >=3D MAX_LFS_FILESIZE)
> > +             return -EINVAL;
> > +
>
> Theoretically this check is nonsense.  The following fuse_retrieve()
> will ensure that outarg->offset can not exceed file_size, while

imo this check is useful. It'll directly error out fuse_retrieve()
with -EINVAL which I think is the correct behavior. Otherwise,
fuse_retrieve() has the "if (outarg->offset > file_size) { num =3D 0; }"
check but this still sends a FUSE_NOTIFY_REPLY request to the server.
With that said though, if you feel strongly about this, I can get rid
of the check.

Thanks,
Joanne


> generic_write_check_limits() ensures that file_size can not exceed
> MAX_LFS_FILESIZE.
>
>
> --
> Thanks,
> Jingbo
>
