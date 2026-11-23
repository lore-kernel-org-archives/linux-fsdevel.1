Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440928;
	b=XXzWJEhsWGAYpzri1sGMdNzGNAAQPegRN3oW+e2BqJgyGS6RhcMdk24b6D9HFcStPCbe
	 N5X9wNDtA1qyJMXJNg6jqCa1kaiLjnFhwcfj6QBYI8R0ZkxDJ0G/1FlAUFMoMbNygZnDq
	 L+0RlhxPf5tq2JGoqWd24fYF+iVpR0GDiiqzrfmJbbLvSn71GPQ2IylZUoSTM+ZjC2Evk
	 gCIwup4WVzxQYdp65zMZ8dn9H0J876Fo1v2gvbHjafb9AOkYa+Aqr8gEZGk+rHuvPxsnE
	 ASZLOPE5BmgCvRXbA7sM3IZiBclGo+PuXFxDup4Sia9j6LcpvId3PU4sMcgVgVxKDWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wA48BtGM3vO5100Jfaf4088EYVNimRYHtUBWITFpY8A=;
	b=slWhcoVU8A02ANiqrp2Uh1zQyXnyowx9AMm2HIApbBzAgTrDHIpv54eb2zzEprjWptMd
	 ih4E5Zg/tv+f+mcc1pN6pHOXQyriXycgemFwPeC0a4r53GfzhdzeGRo3fznxCj/Q0H9yv
	 MOsj6ZM8qoLKm8AQJKcnURn1Vi1KRaU1Lip0jGTY/73Rf4S2V+ZTWzX6E8imv0CXwMtsY
	 TBDCfZUObfpzzNT3Z2W6CIsY0VyT/0dM8h0XmDd3KYTS/eOErSWXdAgbIUZYamka78reu
	 /5+Dtv0RCL5Nn25oXniDycy2OzZ8LZBWiio9BQ1hAIbvL9qdgbgnY3SXTSx5sRi3hSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CUalyFmo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A541606A321
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 13:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A541606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CUalyFmo
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso3952488a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 05:35:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795440927; cv=none;
        d=google.com; s=arc-20260327;
        b=NbP/ce4Q1DLPW5H1vSVTUm8GNWSZ15eYB2KIp7dH8gbi5nuT3cUuxBO5hlXxzwpgEu
         Qx0Aa6S5+tL59GTK485wsd+DlLBVSs+earwm8y91mCPDFVpHu8AL4JNbXGktgMKvNyJO
         fhXQ8aP2TSJbl+AlBv9Tp8IMyNsyFMeBdCskT28CseAUvfeaaCxeW71jXmS/fh4GXpy8
         IoqgTrDB2ZFF4vNkIz0nSC7vhS8Vzb0QfIdpdpYFxRnejtlNPuDBoYoRVOvDk1ZRdGyn
         YeK/imPcOup2lg0ZAo8pmW1zlPVgr30FP1HFPfuJNq/7bwVJZXH7LUCdEgDuBsVs7Gon
         rFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wA48BtGM3vO5100Jfaf4088EYVNimRYHtUBWITFpY8A=;
        fh=CCmHGUbWdsmb9Twur6NPIuA69RtpPZO5nRnmPDc+eK4=;
        b=UcIgxztrzRoNBMwuRyuolyKQ28+Y4cGsk60v0lj1KCYHDp8lskQARnxOdLd8zpGUDr
         NP53QCLYY9cPiWF+q/qbbeTHYBnX4UwYlFCFuUfX65445WOnKqCrvZSq9aKYWRHeBuLd
         Ilmg/MwFe+UMgMxb3+b5im6rUevYeqXxeymkmdH3n4rNt+0NPpdwLsFe8NCQXgYDuQ+m
         YZ+GPfj6BCgKupsfRogzP5aIuOpwjkZC5uPOgMtR9fdfhGWplvdw31y9RcfP0OJgiyPJ
         xMBcBytGEw4sCAebbNuRFqB4yHfPyn4fpZ1OMYF26V+YplAJdzGwsLSfUv61efN8/uxz
         bqRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795440927; x=1796045727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wA48BtGM3vO5100Jfaf4088EYVNimRYHtUBWITFpY8A=;
        b=CUalyFmoReb/83xqvr2Uap9kVXJPiulZAZ9BuYFqHt3BZvwosq+NJSvwCx7EXaJ61q
         0UImgM/pK6aJnaecMJUvuPZ2cI7g4pQe50qM9Pea8hpjQVdlAcsrhBAjR5pkLoL6krP6
         nRENxUXoYZaxAwVNugh+MZ7YZxx2ccbHZqMsfjTLAWxmMDno9W5bQVXg6ZykzS6zofee
         MuNz4LKoADJSq/Wy8NqZgyRU3Eg71INdz3RDm6YrbcXLD3QD36tPN1Wy8wpv41odHg+C
         B4L+HLWFbiG+tetJRVhqx1bMgUVGiUgvZsZjbnHTLfWPYdIp22KPI7gyBEnpYFSEFiNv
         Y33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440927; x=1796045727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wA48BtGM3vO5100Jfaf4088EYVNimRYHtUBWITFpY8A=;
        b=tmC4DBbqLWYSkL4+Gj1phLyNYa67NPQt+VRkhMzWwcv3ZH/styhZN8uVcaO1DElZJa
         x+P6X+IGNCb4kVSxIHxmv/EfNP24pj/4LAS4d73rEQEP8fAOzsUr2KkK6u25JwNJvQE6
         3mkL7K5owm2o+6zFRjDFpJdPA4l4Ym2v5PXsIz3MJzH+SdXSuATUFEXUu1M4Nn6Vzk7E
         SGfwBIMNEnTLsrgA2Xoewt+GHwIID4hTgRdE6vzL/F/7fTRATCYyHiJHtwQcDFFygIQ/
         eDGGxw8UVWmAtyOOKqgeSakicSTBrSo0JkRol6pzn9WQgzs5qPOqREo+adqDZmChXDPM
         R1bw==
X-Forwarded-Encrypted: i=1; AL+hErGxjmzOK1TmLCezKzGJ43b1B7hyl7rL34ubz6QJzQ2153GS1/LWuE5bVKu35HrAoFVIcMGAL3nSd/t2nMwf@vger.kernel.org
X-Gm-Message-State: APuU4Z+uox7vpGFlsI++9/iGB+7RJzhnBGUxdCQDeFB9jUmAtMPIj4g1
	I7hMsXXhpeBsiE678ktiwIcUkpacTC8OpLFmTyHL7xJIi3NMDSzmzRPFuvuyCug9ZPoletlWhqp
	JAA3cfOQKNbGJto2iZFI25pln8F+IaV8=
X-Gm-Gg: AZFdTZdLQ5IJ/Cb1LziGkTFpH13Hg2HERxEBNcbSUtNk5VfAX+anEYFEJv5+wbtdKNU
	fLJayWX4lyWnjDX+VDyCaljUhLFfnccJhHiYSwrw3N3XcxnkOQuOGLIOMbLm5BleRmXEHhBs1L8
	67a9W3SRvSU2rrH9G07Xs8Ywl+xmrK26WccT9JMjs/v86DOKN4CAgU050e39+Boy8tUO3VOngNh
	2NcdXfJowmxvBAtg0IF0UuI+sSTih6M7o8kRC2WLtRxDsUGByhvON7wJLThKHkGE4FI2hXGPiCD
	ga4oFbGoJ4Ua1PSw404jkwOhOtXInDtZf66UcFIe3/AkNR2tnRYQCuCsAJ/Z094gO8+lvsVvftT
	fqxtOSPBUQ5YACU9doz8g30UEfi0LDm371IOaw0pgXdIKxOy4+978yTDJkYM0kr0S9uwjmA==
X-Received: by 2002:a05:6402:1ed4:b0:6ba:7e42:d88b with SMTP id
 4fb4d7f45d1cf-6ba7e42da5dmr4190054a12.12.1795440926543; Mon, 23 Nov 2026
 05:35:26 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122000856.536902-1-koray.fra@gmail.com>
In-Reply-To: <20261122000856.536902-1-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Nov 2026 14:35:15 +0100
X-Gm-Features: Aa3M54oltothA2ZyBgLZ2dfkBmCeGTagh_PAD6Wp2_FkqMP-qy6jOW6gmvjqNlE
Message-ID: <CAOQ4uxgf2KE=Ag13EPAu5=KnrFwt7zRH=im-qmLc8+i10Tjd+Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add f*_xflags_{rw,ro}_mask flags to the fileattr API
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 1:09=E2=80=AFAM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> This is a follow up patch series stemmed from [1] and [2], splitting the
> _mask change for the fileattr API into its own separate patch.
>
> The first patch is a preparatory patch so that the code in the patch
> after can be formatted better.
>
> The second patch is the actual implementation, which introduces:
> - fa_xflags_{rw,ro}_mask fields to struct file_attr
> - fsx_xflags_{rw,ro}_mask fields and has_masks selector to struct file_ka=
ttr
>
> These masks have the following semantics:
> - rw_mask:
>   * for filesystems: advertise which xflags they support changing
>   * for userspace: specify which xflags it wants to modify
> - ro_mask:
>   * for filesystems: advertise which xflags they support only reading
>   * for userspace: ignored

Nice!
I think this API description is very clear and coherent

>
> (ro_mask for userspace was also proposed as a "verification mask"[3] but
> I left out that semantic to keep this patch series more contained, and
> can be added later if needed.)

Not so easily added later.
We cannot change the meaning from ignore to verify without any opt-in
later, but we could use the combination of
rw_mask |=3D X
ro_mask |=3D X

to "verify" (set it as long as it is already set)
all we need to do now is make sure that the API returns -EINVAL
for rw_mask & ro_mask on set.

>
> This allows userspace to not have to do a RMW cycle when using the
> file_[gs]etattr() syscalls, avoiding possible race conditions and
> simplifying their usage.
>
> Patch 2/3 also introduces the missing FS_XFLAG_PROJID flag so that
> programs like chattr can leverage the new mask API.
> FS_XFLAG_PROJID is kept out of the legacy FS_XFLAG_MASK and so it's
> defined as part of a new FS_FILE_ATTR_XFLAGS_MASK group of xflags that
> will be used moving forward for any new xflag (like the one proposed in [=
2]).
>
> Patch 3/3 converts fs/ntfs to this new API, to show how it can benefit
> filesystem drivers too.
>
> The series has been tested across NTFS, ext4 (with project quotas), XFS
> (project quotas and extent size hints), and Btrfs.
>

Judging from the number of bugs reported by Sashiko and by my agent
on the COMMON flags change,
I think this needs test coverage for the old APIs, especially with old bina=
ries
chattt/xfs_io that do the get/set cycle and re-built binaries with new head=
ers
both tested against old and new kernel.
Sorry, but the UAPI issues are fragile...

This is one of the changes that would have been very hard to audit without
the LLM agents. Hopefully with the agents it is doable, but need to guide
them how to review/test for regressions.

Thanks,
Amir.
