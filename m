Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC038237C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622059; cv=pass; b=ftWODEN7Kk1BmiSoemchCKuj9f/5t+WRo+VieMMkmS3jOgUWHJO/t/n1u8xpDNJoOqq2cEnWrd/j5eR9gdigOVYvXFglSGPZPXqAdIf4fovCaeJPXv4+Nx8RmETC/9+KPrmwkOj9EOxCi9LOYbsUO74bEi1MeI3WMrzOImuqLYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622059; c=relaxed/simple;
	bh=jO46bD/DahYyJouYnkfmKNbZfEuWSP4xESEaREtQLrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqH+4A0hD+7DiSpKVdG3Tc50KPN4TFH+DMHDPItgEqakDOg0qfxuBdGzWF7Le54XxX5xdPKpmKOJMeHEcicXRXdbCWi2q+mT16ROUcXujXnf/E9tw4Fm6ociL4wAl9qJRzJRpYw9cYt7p5bFZydN38Vm5pP4fnj/LkMI+dsm3lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRGaqeZs; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRGaqeZs"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67e24b8ef55so8521768a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 14:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778622056; cv=none;
        d=google.com; s=arc-20240605;
        b=TJr43QUWROhF+6JfWmecH1cDA8ossRtMfzEbLTC9dO64+8KY1Bv+Prlfn7ALyPOMC3
         cuZgSdtmdB8y1ni5NupJniMa/oCh/0iO8hIoJJ1agzNY8rmc7IAlc5XttUsWKtLkfykU
         MgbR02TVflmfRLpfU3Z2zNIEZlhIOu/Y93wWJ7I3yChxUwvHfVcWdilsTAGkUOJv6hyI
         n5RgtWjZRw5XBOpjP/NFwJlSqc9elbrDuFttI5zixI/e1sIIAWyBSk/20rafqH8PxFzn
         3cLfgy9982EmRVDIswW3KR2GonUw3O0q7Z47t6KkRj/Fzt7xTswhbwFcUme5eJQnDRhk
         UX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HntkDOW/alaXL+qx4nXenVMcscOf6fVg+5VtXbCPfAw=;
        fh=GbGD3ZaBrAaAEYQQJw4fQbe2AaHPWsn7FZl/nq8tvUg=;
        b=Sv5+tEkL1IKdA4wS3ICXAq/V83dXJvAuUtk9Znq0o0BP/4pYR4b0LZWFyghOD84Ed1
         QQLyCpV5GK3eYfXiGSUG3pSXyL9YtYJkkRHzx7gwK6uV0VW0no+uXn2+5/RFPAA4Pz5C
         Mr41Yd1BKyj7I2EPgcea51B2+AmXISOwbqf9ZqRl3yE216KPJNPZwSQphz89+Itm73cs
         JDJ8C/HD1CMjC5C+5wGC2YE3JHFvZqPr5JJull1duuxSY5VCYLqYby2z4QPN4WoU5Mr4
         qZAQyrk28CJFe8+jyi/+IyYDe7Cz/SgcJ20Ps4zJIrkKozT5jrfrzU7hZCfQPauGd3nR
         /Znw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622056; x=1779226856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HntkDOW/alaXL+qx4nXenVMcscOf6fVg+5VtXbCPfAw=;
        b=lRGaqeZsFC23dnkdLbPhZV/aI1MQe2C4WDW4Uo4AxuGJk2AQduAYNDnpvYfBY+mtOA
         FH06D6E8esY/ibN7sPVKhityoDouN5V7LyDDw14uPOZUKVzxUBXgoMTJKhmi2jd0sZ/V
         GQGATAHykEd93kdE3m+agPPPPT8aVlbIF5NkscIoK702hV3XT+aEam5O76Jte8l4eJDE
         14HNfbrC3bgKDTk0uhHYAWqFKQyJrF3D9k7vC0F1385yvB1ba0NTiL8zkp+ZQHD5HMXI
         jEr14oiWOvd+lchH0m/q91/7hPAsgwh/v+8LpkQ25TSfgYoj946/zd2NeKRqLw2gviBY
         yMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622056; x=1779226856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HntkDOW/alaXL+qx4nXenVMcscOf6fVg+5VtXbCPfAw=;
        b=IZoekWgUF1sf6C7ZZb0wBej7bWrOVCJ4IdDDh0dOZ1Zupc960LscmMJGAo3IwNzT3a
         XIORJnXhQrp09LFOue7yL8irNNJJE4oQRAAerxZiR6R5JfLZaFenXMbxoBBjK9k8UtdB
         +Ep8rw6VfNNVRH27b+lE83NEP4vVcNrD1zVeWbutiyDGzAbb71A4oVTIg5iO2HoZyBW0
         A5DcmUqmjDp8CEhdCaFYkvPl+eV9+av+92Mi8uOem0FaNyzAk4lR/Ue6it1mlSO3fvpn
         YAmRAPJQXu0AfROHq8CL10e6hrPZijq/4OtWF8s1DjeeAyL9HO/g6C+dts1LkZ9T1pIa
         E4Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+3F20/3MGHzb5DfuswjSIsa+4run9sOgCaXJKe2K5/tLV8mdfwH3VzxsliVncAfCIV5sUXKVyvy7JpH7LV@vger.kernel.org
X-Gm-Message-State: AOJu0YypPLzgaeKsDAHcRrJPG3Y0ZVR/Ob+pMNj6nOMODS/MX+J6vAUK
	gRSjs6TsS+DIPFxsTvifAec3KE+aZzPlwhQx2AnNcbpZkz6viCJsV2B1PnpXRkxmFlpUXeZMPtP
	922dKpwlTrlbw6291PfGzzfHS9SgXRsY=
X-Gm-Gg: Acq92OG9KIKJQ5XJfmnJ+wLYhU9beBsz5gbojRScYGcMXEnKm+FI71oqTwxo3GeKi4h
	B9QU4Uid+z0I1jLvD2HkLYXhHVsNREVSyZQE0JPu24NyDWRvDbrgjny4ToSVn7yX94C1aXvpjZw
	JUEFFmmLYA0h3Z7J/mAHZbjALjX4KtnFNVTewIphoa8BCSNnu7GFqLbVG4+QNm+4ORn/8g3wAGF
	Hk2UYIFG+eB20kf3l4KJdFclgGfeO0jSCucJpGaxaH3aHN+zveJ0+oVoeVXxqVN9Y5JM7K1ynGl
	jK8jLEDMJbLAzTSMo02cWSsqb/qVHPRnMFQp9EE2
X-Received: by 2002:aa7:dd0f:0:b0:67c:7697:1ee8 with SMTP id
 4fb4d7f45d1cf-682557ef49amr239151a12.5.1778622056246; Tue, 12 May 2026
 14:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
 <943cb464-78f3-44a7-92a7-57a1fe4fbc10@linux.alibaba.com> <CAOQ4uxh4yKEBdgbkfZTVyYM1P8ahALFVJzQCj7ASkrH746_4xw@mail.gmail.com>
 <CAJfpeguR=x+Kf7jd4zyeSoUtbjaPRLhXCRh9wa3c14x+M77kXA@mail.gmail.com>
In-Reply-To: <CAJfpeguR=x+Kf7jd4zyeSoUtbjaPRLhXCRh9wa3c14x+M77kXA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 May 2026 23:40:45 +0200
X-Gm-Features: AVHnY4IbE3Bg883Q__tabvfXXxiDKtTVz49xRXuoaDl21VgCxTESGb3OYv1l38Q
Message-ID: <CAOQ4uxiTowEnpQR3-oBXM3Q5uxBf5PXeNu+Qda8CVeD0fTHfXg@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, fuse-devel <fuse-devel@lists.linux.dev>, 
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.de>, 
	Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Tue, 12 May 2026 at 09:53, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > The problem is only with  fuse_passthrough_mmap().
> > Depending on the workload (?) mmap may not be important and
> > we could fail if trying to map cross-backing-id regions.
>
> mmap(2) is the main entry point into famfs,  so it's very important.
>
> That doesn't work with "traditional" passthrough and needs to do the
> DAX mapping that famfs currently does.
>

Yes, famfs surely needs mmap to multiple daxdev and this is done.

I was referring to Gao's question about dealing with non-dax multi
backing id (const mapped) files.

Thanks,
Amir.
