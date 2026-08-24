Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939D3E3176
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561366; cv=pass; b=rUhvQHYH21BC3Ml4rcajUk0VowOedo5Pq5h6XQd44Olt18bZygbXNFD/k8H8pkl5WTS2fuPFjmOJ3F3lHrSMStyG7PPDL064FuVzNFbqwFSsOmbl1ttF9CLis2RhTQZL5m5AWZy6OcxJWKC/cJRbNvmgSTI0e0zkRlYA4WvSOz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561366; c=relaxed/simple;
	bh=Z9RYA2bvbfgj/2MAhtGLxMm0w+xK2OQ4murwZgw+gXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb37c2/1OboNGX8A03noQZWIUvE3D52J0sHrx7xLHD7Rt0Pt6FgUHzP0Pvp8T4T65TaMYVaA6KNCYtASBPAtNTk6rFtW18TXdJgvsK65YRpBWt7tp7w17A841EQqNC7reBCUQNpaL/Qd1tDAS74cLI75Mre0A3IHxVfS6C1jRFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hKWlW/vW; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hKWlW/vW"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c04bf4711so27908861cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 01:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787561364; cv=none;
        d=google.com; s=arc-20260327;
        b=PDqysWRx0rA0kQf7YefVq22KpdyRnqMZ/Jv3POOgQqDWYbB2bTtHe6Fb948s8BtArg
         yliYv5QpPP72Pomr4f2Bxqlm0zoWPl4n5iL1jFfOi1t/jdXoCrhTdP9Jo0gd15pz8Av0
         VZ9WVPLscQCyoFmpSH2xHez7lKapUHDLcjuFNHhDZlbL/OgNejYcjUs6VXEtHyQ1Bqey
         3jMdvpaCIuKmodfAUIBD2yK3MGrhjsp4PTKNy4jrY2mT6L0sMxgoc0l23ZrCbCbgHI+D
         h0ylLfBaWQNBBrHu256UJSNkJyc1gfuHOybgpnTirUz9bcXxL8I47kg5KQ3m355K/5TS
         /lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mF+rKgsUqZmZbL4LsNTYF3CpXuL40SjdECiZ2OOEAQM=;
        fh=GCO+7chdXK3tnuIia2menWBOs5p5ZFKw3CcH/6+VjmU=;
        b=pOIwTkGZJpwu0hTAu+5r1Y18UCGbWYVPe9KLfBMHFLXsXTC/21TfmO1RxpYkUlb+sO
         B4+SmlDfOmt7/OMuSph8DU2I5hzpn+skYd6JVNJWWqWuHBqALNfp3s3S1Pvi0bMbtTSi
         sRiRJTGnwtbggQaZRvCVtU6RAbJpDNLRkXMhJatgojizqHF4fpTkMZ/E/S5pcDJzsK1/
         hjfDKSbPcAvIqFxyec30Ug6uNESskwdOxMvGPtCf1Yw7Mh91kOnzg13odzXI6ROD/rnN
         WfZOIWYjFstQQ1nwgqeRIuTeSzJ+V6Vnvi02ntp7sWMgRpFQjvc5x1cCOd8Q8EG0bf8T
         SL8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787561364; x=1788166164; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mF+rKgsUqZmZbL4LsNTYF3CpXuL40SjdECiZ2OOEAQM=;
        b=hKWlW/vWOh3+7sx6KgU9rcpy/7qfFid7jO8W8eSQHQQ8BROnwlyWcDWYxiWKqfXPid
         B45fmvhmxzk2bQHg06JhST4PLXW1KhqoLSeUZutmZI+PnUYGD4LkC7sdMfFEQq21AQTk
         UKJzAexc8j2v9MFxk2csUqRGTM7TGTOoafuC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561364; x=1788166164;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mF+rKgsUqZmZbL4LsNTYF3CpXuL40SjdECiZ2OOEAQM=;
        b=iLEySRwEhqftFdi7lMRjEez2a5L+m/DHkAsZnho2AFKNvUOR4NHYP2T5tyn2EotHuS
         CtNmwtNYLztLLsxdCCYy/dmjusZ78LyYs7STqKR+jSxyQzQzpvXa3+G+XMuJIN5rwo1A
         5knTV6fBePX1smyoHnlS8USt0Cvd0yzsLrYUTAInURjkYP8UugcvLrJ0YFtJVmDc32uS
         0MOrCosnkWoPqkFMNqeMV82U2P86QZLU71IDcSdBV+BiYXxpPq0i9RXsENd4zf9WCu5r
         4LBwv4rp+n8h2BDZbgA5DHUsa0vj4IksO83F2M4WWTyeYdeSnAS4cWK3aOmd/jjaQ1TG
         56hA==
X-Forwarded-Encrypted: i=1; AHgh+RrMrT2GZ/rkZUHt7l9YyfI9ftXwRxhbuE/rX7xNjdeLE5DQs4C/p9UmUSyzCubxC6QdvmRc5i9K7nkS/9Uj@vger.kernel.org
X-Gm-Message-State: AFuF++kuHXnkvzIsa1SuL/+6J+iBLFxE8047TKFp8PkZjQiLzQsrQCsW
	ivunJCxeYFTTTnqNNh5uPgiTUCYH4uKfTQovd71Z8MwnROtu5QvXoZp021DKJCMmXJc2usNU9sT
	DMwDzkmxjXZhiL+2v2eKihmn8Y91SxwzoVvZIhSBlUQ==
X-Gm-Gg: AR+sD12D8YwLXyPTIwjtZKGW8F/tO/+Ng69xcBKkgzH5gL/vJfJO0plAiXyJ0YFYTFb
	s2bVRZDvfSqYSCNZYygyS6MVbcaWAyVhkjQHhqCJi71MqDPMSnoTsHBYWIfInESUd2jPKLHhe7L
	Ssu+zl+z3KWqP9RqXr63h/2WHI8EpWV+xnu05SnKeJZAatN3s5BIYDpsBQmjuVV7EI90W6TGinh
	emruPjPR3WzLlbRwmE+OUDapnWEAg6QcWPcdvNN7XpLk64JxzH0jNdoHvPNzgXXNh1dgOvEzRId
	Hz3oqw2+4nVSvH+5DNYbPc7E5pKB30Txa0rWyWuo2H9LFQ6OB5SKquEo7DWOHoMvaaWEEMp30HZ
	x3td3
X-Received: by 2002:a05:622a:11c3:b0:52d:bec2:c34d with SMTP id
 d75a77b69052e-52e09cabf8fmr164046571cf.25.1787561364032; Mon, 24 Aug 2026
 01:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026082150-autograph-perky-e3cb@gregkh> <20260823224256.2724025-1-fahad@codepure.com>
 <CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 10:49:12 +0200
X-Gm-Features: AcwNN1XiHQpN2m96GZUh3u1EugIhpxhXIVCPyqEKe5enm49poz0eCb4nkcZT6lU
Message-ID: <CAJfpegt1WinKmP5nOGv8Yx9VLf4Mk1ojg7e3xR5iUz=7yDAh0Q@mail.gmail.com>
Subject: Re: ovl_copy_xattr() can write uninitialised heap into the upper
 file's xattr
To: Amir Goldstein <amir73il@gmail.com>
Cc: Fahad Alharbi <fahad@codepure.com>, security@kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 10:29, Amir Goldstein <amir73il@gmail.com> wrote:

>     size = ovl_do_getxattr(oldpath, name, value, value_size);
>     if (size == -ERANGE) {
>         size = ovl_do_getxattr(oldpath, name, NULL, 0);
>         if (size >= 0 && size <= value_size) {
>             error = -EIO;
>             break;
>         }
>     }

Well, the whole retry loop is bogus.   Just use ovl_getxattr_value().
That one could be fixed up to return -EIO in the "size doesn't match"
case.

Thanks,
Miklos
