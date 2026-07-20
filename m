Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9863D093C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539344; cv=pass; b=TDn/YvANcLGaAY0gF3Q1LwaovN02nqQWy6ZB9cPx2BU7GWPA0SCLRL1louTMSyGmBi9PTkhQPp7YVo+hS77Whg4qz13JlRfmKyBLN+qPxJ9meC2OImD7ZFQ4X7fNpB6WK180lHyJCYCVE+fhEpoy3HhmB3SQZvE8Udcb8qccYow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539344; c=relaxed/simple;
	bh=v1G/U6rYwbjprWYcPlrHGKT0xVAuOYF1UYTXLhSRnAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTz5W2RvnmLoB0vudFNW2M0ccsRc6kTlN34e6HkDOq1+5NPRzw7i4bteN1+qb2Nd59R/3LVOzMffKnzgRDf1P67efX9+wNMc3Y97V3PjPP6FTvklaC9rwCCmvcGMNA6drZacZ4Gw8UtbCQB7G9bgMuypEhWt6s7qxsavT05DEjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aebP9PPQ; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aebP9PPQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c1372f84dso63043451cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 02:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784539341; cv=none;
        d=google.com; s=arc-20260327;
        b=cGnPZMh7qWkcD7rJ3ih02TjsAaXXx2QiqMEc3ZvkxG3y5W0zApfWdboqhO+bP8OuHt
         XWWq46Ih5pIDZ9r5gW6HxVETp3C08hUTW6S2xyu9dWbzdkasU+oVFTZGNwquT6Wnlda5
         5359lX5VUeYLNHg2FWH9wWM5LZKtYgFLZNr8CVm4zcDLISOh+SewkpeCyPxc1VIW61zc
         i+oZBq/9Sc7BEElK3UdeR5amGE12DDdCHcI/nIlPqRGucSTcaN+UzWU2VH013Sru27qD
         jvqJxE7KWEDiwy35WPcnQ0wzfsrC0KrZlfOYGrTsOIKsJEQabuQzoWFDYCZOhF00pBzP
         qxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ip3jHsFq/3cxVMe2s230B81UAfkN7lmSalsLm8p4Mjs=;
        fh=XLIZTYm40Ar2IRy8+jaYGz5c+XL55jEFWwNQSjOPiWE=;
        b=BJUUvWjukQw4C9a+Dz8N3CtBnuAMfLhNcemtQYbvFhMqNW3mft8zoHbdBDnFOz2Cgu
         I5DmHf3z49XH5Kgi82IciVqZ20NUVxgViY2NqgvZYzH29s98W1c6Q5FL9v39xLeihYgF
         5n2E0I+JGuQ0GyypHc1nLe8vD0IOKjfBRWQ0ekOhVincULAC21fd6W569xd8O+rweQic
         /teTQRm36wvvHyI7PDX4KCaZmLO0l83rE3wSLKzXC66ehFR0/D4EMyUtWULD0/n4c5od
         A5Pwqjk6cmU6To2XgaTTmADZv67hzId8pRbwreRA4jCFnX0e+PCPSG7qxw8eejvdyjef
         TQJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784539341; x=1785144141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ip3jHsFq/3cxVMe2s230B81UAfkN7lmSalsLm8p4Mjs=;
        b=aebP9PPQR5pm6N7/qxL7c65gZmz19yeADLMgDCVbA7eBNiQ1p0LOsj+dZU4dBMjHkY
         TYI/0bXSSPxHqc/Th0TyEqYLJLywLtNWBP8SfWlNyozVDr+V17Dw6OwyV2r5IEJqJ1Nz
         CXeTY+f2ynux3DvQ8s/P3CSutNxD05Upp2Ifs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539341; x=1785144141;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ip3jHsFq/3cxVMe2s230B81UAfkN7lmSalsLm8p4Mjs=;
        b=ozXTL7FoJeDcFyzb8xBnQlNWeZdOk72thQSlEYw7E5i0lRwvaEvoAE+lSYKe9NGJVu
         dUTYcompqyEZWtM+vbKHmv6PMUJ1rLhn4NXyv3MejN2K7g8LyGDTRxbudtYOnZ1jTuhT
         +y1m6K9wEAt44tXu6pM8uj371DknxcMycYeXENNqXYxT1sC9lmo00vb62zl5OUljpMDc
         ATh8KADJdNdWMoh15G/6/xf/25Ioek45pctBlw1Bh+TtBrqIN4hbm0RiokGz3cIHBoGF
         dkF6roVa+cKnsw80TLWli52toIfba0VQdct5F5PoPMsNhg0OkF52IgyoBu+4aLE9Xr1A
         hw3A==
X-Forwarded-Encrypted: i=1; AHgh+RpFdsCp0vBsgta59Eup1j+d/mCwzAD2CjVj77p8q88SJ2OQS85s8I//c8VxcLju4mbKieW0L9L7+LcbqQeU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OVjAU6AQ2NA+SA2eeEi1p+LFib70xztY/jCJMMvnjoCZhwVX
	4R/oOWDUXcmPH+yy+XDo5i3Ix3a5ZO8PaU5/7I3sTenrCQMW+YQOr2ps8msQNz6gpZnr+yJCEkD
	IS16Ux15Fx1kTFzytCuZMoBPIu2J7LCOyavOfbTYjyA==
X-Gm-Gg: AfdE7cnDrANkJSGWsIi2FGkZLSQuiqKVlLN47TXBizq/OqzuFTDSCi00I1PhjNA+nbb
	Ld/1+4bilCf7emWmD/BwGrERvhdQIU9BNp7rb+w/qmlFjgGK/J3/spmnVKgbqxUDDoKbdWx4MY2
	Q8Y7J87+H3xmIAndw8MuRUFu6uKbR3/d18RJrd6zCAoa3XVJTNpw8eNfUdmzm66/WFbx+jNFFHy
	a7c1cwk4NVhd6l9BluNcaAYt7Bkzo1qlTboiAyo2lwbcM5oDl3tvNo5ehqoQn40JZltkxsohBns
	Gu+3Fs6fKYyc2WUJtA==
X-Received: by 2002:a05:622a:1192:b0:51a:8c9b:64a2 with SMTP id
 d75a77b69052e-5213d0c7ca4mr116936831cf.70.1784539341012; Mon, 20 Jul 2026
 02:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com> <CALCETrXYHX+OSwm6vhzQqvdk9Fkbxzh_dGuVm2tjvPJG_x1XdA@mail.gmail.com>
In-Reply-To: <CALCETrXYHX+OSwm6vhzQqvdk9Fkbxzh_dGuVm2tjvPJG_x1XdA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Jul 2026 11:22:09 +0200
X-Gm-Features: AUfX_mz0IN3hn5QumsNu3idUZDFLnqeEUQTN9zg17vrQKR01GmrNXzVy6O1zEgw
Message-ID: <CAJfpeguxCOw4cURjPVOMj5-A7JnLrmy8zx4qE9uwxg7x_Wr+zg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Andy Lutomirski <luto@amacapital.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Giuseppe Scrivano <gscrivan@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jul 2026 at 16:13, Andy Lutomirski <luto@amacapital.net> wrote:

> This gives me the willies a bit.  It's very cool, but it has some
> potential security issues that I think we need to watch out for.  As
> sort-of prior art, NTFS supports alternate streams and Reiser4, ahem,
> supported files-as-directories.

I realized that we can keep the creepiness factor minimal by
introducing this first in procfs only.   That way zero changes are
needed in the path lookup code:

sprintf(buf, "/proc/self/fd-alt/%d/%s", base_fd, alt_path);
alt_fd = open(buf, O_PATH);

Thanks,
Miklos
