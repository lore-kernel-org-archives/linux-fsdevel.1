Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468B3D16EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422983; cv=pass; b=E6ClIuODxF81W6JZ7OK2HHATPjRAtYVOwp1b69m9pvH9dlm5FDrkSCkFpJiu1Dfu0pwtWsmS1cBh0E0SniKXCpgrfSB7ga6LsfhjV5WJrl1uyGwGgRWq9ZX8avV8qRtGUEfVvLwoS0TtbreiVKegLuOj1vgDjWsg/YZ1qWtBkEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422983; c=relaxed/simple;
	bh=GE2V7iGy1lJ40QSGCJ1aOi34U1nb6hDAIOvSeMgLVLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZszJpyLO1K4VFhgBhBmNWE+Nf6NCyLnb0d2RR0L1rmkHKW6kYxE0EYXZ9g8Q6605Ycu2+vJKEhHuKKWW3TLQB9KMNrfS5ctswc+5eFDymljOJ72wilXnJnLMeraUfAqMpzTflL0jMtNXbdUKMVRRIzwCeuzjl8T4LXCEalNUhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxqITsm/; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxqITsm/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3746187a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 01:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788422979; cv=none;
        d=google.com; s=arc-20260327;
        b=XQcWaTLnp5GGQo0BN2l5EYXhOfSwQsrQG9NdASryTlJ8PYoMs6+AgZyr7MiNV9AQuT
         /2OuwwZzLV2+tThirBWhO+FdhBbL6xusHELwokb+1YwZsduic9kTKVg9kYIs/VMks1mr
         UOWoYaF4XlObcTmFKMUMsRKTgO6aRZE1dIGGiUJD6BKtkxTJz/ojPnimmxSGf9prNDyh
         hiwVjBT9ouWoyktIKJjjhdNihcljdjBsf+WrXzZ0L5T81VOqfh+6JPzNC8pVd37T58o3
         6464TiIsp+L5bcOx6IqZQGkHHcNybFoUGVTIqFlvuASs5XeWB+d3SRyUX8RjJYj/wbgr
         KoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l7ege4JtjgFHRNv7kt3LuaCil6zWlhJKcEkBUtmR4ro=;
        fh=/30tgysxI1L7m12hbQQZH0SopxmfdXO4GPtMa/zpclE=;
        b=fk0lqBFYa+gT34yCIXTUy+Imq/Ptl0alGc7ojJqne30s61zyjpnTUkEf7HHDuA0RS4
         YIFdWM/o7TyZ+1qKaMUhkuiiB0hxL7ZIQTDU9MafbI2wbYEsxaNTF9Jl7SdSnvpSF/6F
         9NjzyAdmEF7s5to8oDeTc9UrChevCZAKXxRPwZPxel3VC/LHwEMme0LOpcfikM0mfYK9
         LmrEcjianwrPmeBj+hcos305yfmSBRWhlXYnUWs3fZc2q9Q4Wi7vcpav5bQSKTknAZU4
         xXeB66p5rNXmc5yN4JBqnRybiIo3PIXpiz9/QftV7lBdM5DQhTpXlzDOe/v0n8deZMid
         ocfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788422979; x=1789027779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l7ege4JtjgFHRNv7kt3LuaCil6zWlhJKcEkBUtmR4ro=;
        b=CxqITsm/7UfBXHbg18bcCPFkfOa6SH/nMvjGYaavL2DH9DmbVSoY8Pf1sl4kDGA0L3
         AOblh3QDq24GfTJNpSvBuMxXHKAzgzjGc2YurPDzSbUAH6wr3lVJosD7yhFbtc7IVm4b
         6JlcK8Pm9L2fDp8O+oBnLgH+XZCxlqnhGNGjVYFqqKqfxW8+ESrH8N2gKsBDpM44ckzy
         cFbGGqk/UkXL3ji2oRSRgfvjUqzn2oYyVfUpQDwCGZ63bnwzsE8H3727/mokT4XSS/nI
         cAKrd0rpNJtv4FpKEg7JBBK0pE0qzOzL1UR6los7tdug2CxlGJYfIY6l3+Rm6EbmdXvw
         XUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422979; x=1789027779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7ege4JtjgFHRNv7kt3LuaCil6zWlhJKcEkBUtmR4ro=;
        b=lhInLBRrskvYXmJDl6zd8Svg+kxa5fc+xGeItRAa4kHbU0tsMn7q9ccGsqqCOONf2z
         dYPfXgZnpfgdE+e/w7+6yH2lHCIe4RZ4e7kvf2RinSuCqFU8OhAubbhJvouxpGSjwa/k
         9h4TbyODBM06drALoQElI7dDyjU6P093VFpvO0p7RHKct1PGAQMqUxNz7bACz10CA/WS
         bsk+3dR+0tiP06FhGErYnPW5Sxp0Jz2xa3WOEwk38HFTf3aSVISUJM57ifTC/J1etq02
         39XL4HzZvSwPXMRA7K/GQVJwPDZU2hEkKjcPGUoYa5dyr7rwseoFD+g8gbgPNT6eWSTU
         olkg==
X-Forwarded-Encrypted: i=1; AKwUvBzFYIWW42s4REpGPMVCjUmHzJhCbYzgurXeev6oDJ38S94chHk/bfjRmiVDeiErBKKHj9TlzQw/f6RMd741@vger.kernel.org
X-Gm-Message-State: AFuF++n6lVrK9xknP3WuiDPTX0BYMpKdlMgbw2cyjibTvF/Yaql4anrV
	RyQsY4f1ImnUGBDYDvy6TvbS7vVT2LYhlJY2JERkCZNkliGVI0EHCswqpTKfiAsLdRiYqzG11Qt
	qW7juHjCMpUUy9hXFuZqidBJhAb41jL4=
X-Gm-Gg: AYBFou2PrcnmuSGcyhmmSZ5PXFWRvDrK/Qy6waukiLghsVwhU1NNsI1fYQIk5DeEE26
	em3zqfuz3Haef7HonA9q8bV9eSG7ickoqIsK4tbBDnPkofdzTDKF6TSh9Hj8mZ31oWm6X3caocu
	Xz8lQlSykKzTbBzD4mjxWKcvcUe+OiR1mVcYdX6DyfvRWzdBfVmZF2ty7ODRnl7f8tMv4ecsR/8
	VWQ1kJ+TpfmTITGUHfaiRwDj/OLO9F8EmAPbAoVphNVCQYLkjEMvvBcbokN81lYVBG+K3ZgB+ko
	+ViM7Qc2ZoBmOuRwwPDcNivyJeifnKmZ2Xco7QNhKyYb8t2N6HKddf7e
X-Received: by 2002:a05:6402:3815:b0:6a6:774e:8a56 with SMTP id
 4fb4d7f45d1cf-6a682567105mr7784290a12.4.1788422978844; Thu, 03 Sep 2026
 01:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903064504.1052841-1-cui.tao@linux.dev>
In-Reply-To: <20260903064504.1052841-1-cui.tao@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Sep 2026 10:09:27 +0200
X-Gm-Features: AcwNN1XMHTJAxrMSsCyIoWLDnNM-q-2UafNwLmU_5tyYTmCFr10VFZDEo8zUcyk
Message-ID: <CAOQ4uxhZOBv93_y4K0mc4PofprdPfSN8c45KW226LR-JO_BEkw@mail.gmail.com>
Subject: Re: [PATCH] ovl: reject verity= together with userxattr
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:45=E2=80=AFAM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> userxattr forces metacopy off, and copy-up only computes and stores
> the verity digest for metacopy inodes.  With "userxattr,verity=3Don"
> (or verity=3Drequire) the mount succeeds, verity is advertised in
> mountinfo, but no digest is ever generated and no lowerdata is ever
> verified - the option silently does nothing:
>
>   $ mount -t overlay ovl -o lowerdir=3D$l,upperdir=3D$u,workdir=3D$w,user=
xattr,verity=3Don /mnt
>   (mount succeeds; after copy-up the upper inode carries only the
>    origin xattr, no metacopy xattr, no digest)

If metacopy is disabled, then the data of the upper file is in the upper fi=
le
there is not supposed to be a verity signature for the upper file data
verity signature is to attest the data of the lower file, so this report
is strange.

Moreover, even though metacopy=3Doff does not create new meta copies,
it still respects existing metacopy xattr, which may very well also contain=
 a
verity digest, so the statement "silently does nothing" is inaccurate.

I admit that user xattrs for verity digest is an odd combination, but it do=
es
what it is supposed to do.

If you want to report a bug please explain how the security model gets
broken.

Thanks,
Amir.
