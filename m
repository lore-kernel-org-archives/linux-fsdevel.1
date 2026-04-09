Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FA3D88F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743450; cv=pass; b=XCnMJfySngUGmGcEKFZraVKoYVcFSfARdw7EWPqEPcarDmqmbCxqG+P3Nplpl6A/g7JzB21nmHxLyDtgd+rWshNKJm20yNtlrluAB8bERhUH8i3PUTu/2t8HXISetg+fHYwlPzQdkY21ke87zoJAZu2H0OersPNh7AyHVd5DpT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743450; c=relaxed/simple;
	bh=gqUmfP4EYl4QgkwnCetuwgSQhMe5JhxTNpQBw2MnZMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwOMGClHLOkVZJNUiEmUn36zhWHwHdWze4KTaGOlK9qRToHJT+4U7YOySydLbzL1/hU4o+J5JGgRF/UFRHS2MWsDNMXcjVQJ/p2SrNFSKYzWJFVP8WnJb2qDhNhJzAhDsf4zcsTNxl/5U2Q1TyA9jbd6d6JEHOIAkmypn/Uey0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUEkHA+M; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUEkHA+M"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66fb5f2183fso1562062a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 07:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775743442; cv=none;
        d=google.com; s=arc-20240605;
        b=MJzZ0Jl0GJiN8SRfceDQIcOFzsKlLEozbMGnXPRzsQZHui3jSaqUe039EBa5Ynhy6x
         F2zrVsFztpYM1JpORREv3hs4uoT2KVVNolECw4tajaLF8X7L4QzcX4KoniZTPtWcX07v
         5pzzB6CUHWpUoUDEmq6GsGQg5bf2ve59Dj67wOwb67mN39mYd6YoG8ZJzBQe4/Pgm2DI
         hkyj8lkmJkThQhWeQ3VfECrQdnhOgroaPvwCBQQ2lE6VKO/oU3qCQgqklTyDZ36AF6WG
         E+0UOBHffdn8GiWg2NxdJ2fc/9dkDOnwVeM15GHfbHD68nlpbCqu7GwewRr3RZ5gv5Tm
         XQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqUmfP4EYl4QgkwnCetuwgSQhMe5JhxTNpQBw2MnZMs=;
        fh=jCqA67vYZzwlnE5XOI/6p2l2QHEP12didErNLJu0aaM=;
        b=S53Oy1v5zzL36GsQnNT2znBjxDgi53bRmJV5w3VuFhbYqZu9Ahj5It+dNjvhg/xELX
         BEDBO0daEhQ99mUu1jr/kjVxvlgmWSjinYwXVvWdN/DdYDmtyEpfQcrNtmxEX7otCqtp
         uX1V3Y8FSF8cSAqMmmshg4FEQWTZ7HejqT3JlC0lXn9iGcits9L0bn/mDVQC/uS4Ze54
         i7Lzn+HOSG5KtdicKNHDRzG3ZcH9lNaQ1NGgXadictyu0rnVvwYDo+GMF4RtpcCwJHcf
         osT2V7yke3OQFmcJ3xYzpE6Jv7bzKJZNlG+Mg5dqw0x1+tr3I+9ZIuf6hWXHvFJmE8D5
         IZ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775743442; x=1776348242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqUmfP4EYl4QgkwnCetuwgSQhMe5JhxTNpQBw2MnZMs=;
        b=VUEkHA+MpjLxMu6ejZntX7ZMU0g4EaXS+Yx2a5VNh7NA0mohemlYp3lkLlsAxHs36t
         d7ixjAj4vmvRiGTMoc1F5klH73jN0W5GjAItyflHVOG1FYRdLS0UtRNL/Cjo1RWQRDdY
         fltNHEZjD5QXczxESDvjowp+ZLTF6PX8bCZFwHBY4PRP2tj38vufp2L2K/6EI046o2fS
         6PryS+ZibBKxF5b2fcO98PJiE86XwucEy/PFJnAN/Yx+Oz9UjnG584jWLDhO5c6ovgZr
         Tz9PPMW+3m1Yw529NR7G2sYLNX0s+NEGxcQVQeIpaBlUFoB6WkGcA+y9Tc5klgpg4F/n
         Iukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775743442; x=1776348242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqUmfP4EYl4QgkwnCetuwgSQhMe5JhxTNpQBw2MnZMs=;
        b=IMxJ/1I7ZPJJ6QKXszZI+TQ9vPs4c6f3j9xm16aQBz7cVAvfBBo4qAs0bgMYd+7dK+
         fhGLxfpwcjDEEocEZgXHSnZsFJBNm7IvwK+3hT+YlcEOPd6Xs/OXOAlgknGU3pxcYreY
         qt5HaEJIMrwX5Lpj4saxBcmBt1Q00YeoO+WoJNTa+BGK6EYWzWqWejUw6Db+xyjB3FT2
         0XYtlsEjwu+5AA6buzMx8FbaYetLK2AT+1izZnz0DUBu44kzyN8NU+LhPsV1q17eqr0W
         UtnFtgdpNEXOys1s/TUHkDZYVgDsJtcyIi7lv3xNlw6+qBZH8QYjGLrEwWvKJ5I3FQNN
         JH6w==
X-Forwarded-Encrypted: i=1; AJvYcCXSYfHUBH200EM+THBQNrm+0DrVwmfBddVNNKlSA0hkldBnzGswSNDRoceGSXhSsaWTF9iGOB8pCo9Sm6/q@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWE/YYmKa3aRdgLeUGVsb/CCLFc5zFyvljnWk9wBwcY9lhPlp
	3f4fGQQtNlPEprm7JRkW0AobbucszNxA+o3P00mjTTGLF4yvnUbmQwB1opeQmTuwJDsqi7aS5ub
	xUeqWWBsNSBHy6LaTAluAAEK/fpwdLxs=
X-Gm-Gg: AeBDietN6WgDoH/kcjjsfjPTXU3igpZVcyLJA4zoNGycSDTRvCIpw9xB7xIL+s9I+QV
	JyVNLUMPe3VeCqBBHkQ1zL4Ww0ZS1JQgr4Ji9R5/1TO3db/ke75Z0Crl0mW73j1tq31nO2AUBZM
	LX85zfXcERd9fWZcWQXLpSuXi2R+AQXzb7mILRJpDIheaT5fK9qeXfeTh8QFO/hyhN+YeLh+0sh
	NqT6zG3aVClI/l9IsTP+nqWRmcLiYrAGYeRPCGhso01t/oPdPdEsdBcLVp8UU7E9qRYLB+XUXGy
	2Vt8oCueZJ7V+NdZWyc0cBJ1QuViITItWmKsuu2Wpg==
X-Received: by 2002:a05:6402:430f:b0:66e:c7e3:55bc with SMTP id
 4fb4d7f45d1cf-66ec7e357d9mr9096793a12.23.1775743441546; Thu, 09 Apr 2026
 07:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com> <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
 <87fr55lpu4.fsf@igalia.com> <5c13b5ae-ca74-4fd8-97ec-39f24ccfd5c2@linux.alibaba.com>
In-Reply-To: <5c13b5ae-ca74-4fd8-97ec-39f24ccfd5c2@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Apr 2026 16:03:49 +0200
X-Gm-Features: AQROBzBW00Cw63h_SOIyarS0DPMRFfif399CKVOAyHMZMLCTm1-921EO6sol8i0
Message-ID: <CAOQ4uxjRN9hCXwxmy3rwsR-vaHN0d2+i+U1pOC7WgSwSdWCC7g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Kevin Chen <kchen@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 4:27=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
> Many thanks for your work on this.
>
> Just FYI We are also interested in the kernel-maintained filehandle,
> which can dramatically help reduce the memory footprint on the FUSE
> server side.
>

Hi Jingbo,

I might have told you this before. I don't keep track of who I shared this =
with.
If you are implementing a passthough fs to a backing fs like ext4/xfs which
CAN open a file by inode number, you could already use this library
that I developed for our in house passthrough fs, to reduce memory footprin=
t
of server:

https://github.com/amir73il/libfuse/commits/fuse_passthrough

It was my intention to adapt this library to also work with LOOKUP_HANDLE
to support more backing fs after LOOKUP_HANDLE is implemented.

Thanks,
Amir.
