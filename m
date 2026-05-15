Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8543E9C3C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887144; cv=pass; b=MQwZCUvZl411uXf2/j8DRlCgNf4L1AA3utuaAx/3J2e3y0gpjFGwoJLl6ESXPL93GWLtxJuWOjzpnCGXh9dBDfkZFNM2RNuFEp/ha3HGCBKgKc1Fs1v/7CniXE0MtZC/WPkKNDS/fWNQbcTzNFyK3NTeGNa435FZ7WaCxGbPTkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887144; c=relaxed/simple;
	bh=4t1qdHjERyEpuXixa9HfcANiAsFz4suKXqCqnhTdTaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rstou+r5vO74iwNO6ECAGdwlVYPrjRQxlk6GgxVVyoLAM6fzYwkiYaMbvw6s8nte2R+TdPRXXFQMk47OaaMKWpvFIYd8saIV30nXhEjxNZQxpJXzS58QZhM9VQMT00X2FnWM4KkGrAJMJ5ZYkKqwqIqCxEZeasPHI/wQmZn09jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTl6SyWv; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTl6SyWv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so960526a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887141; cv=none;
        d=google.com; s=arc-20240605;
        b=F8BfCBVjhP9x+b58TnIguL3Dnw1PPib67Z9Vdd0+afZE3Jfq9a8/KTARQPg1L712zu
         bmB/5KVY4xYne5qpcODiYSjIshw/uWzRFHXAUNQY1mfItFQvDpi8rBy8dJO28nqAzJyX
         DHVdmsiqKCuOtSCCBSLLUoWOeqNej9FhK78IE+97c39OveN8mj6S7sVGO3btqaR4CXhW
         LDhpQ8AW2Gfw2OA1gPBoWNyF+fIbynDrWFUuex9636UbxGhEMUH12aB0Ai5SGSErQ+sz
         M8Vg0aOYt355Ik+X0Tjy7v/yAAHtITvNwTjidMHXL5K2bHzz3YKSrnef55kUCHvjBqku
         mR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aw2/ho0S7JWvyYsJMkYHUqFQO42K5fGKmFJEouhlnJE=;
        fh=5mdADlJSFlI6qYdsptXsJu5XYHygukZlibV5LjbZ5+E=;
        b=P9w0iV6gHfttwJHq4jZTgCpSw+T/X68WKskSqfKMps+R6+3uFGRNtBlLx5tofv2wQN
         cpElF5EtChtEXz1D3R9UXY+/+fe4cffes9UampZFPrp2Nlnf2rnKokhnvn/AqWUPkaLd
         XTDgKbt6igVwlZ5jukvT7pRryx4Rt6coAUMUCsgoetLtO+lAQYgPY3Wtl4MPmQLqwlIZ
         x6eT1XZ1nnLkGwoBwAtdqKi7lYUkJ+FEfOQc+4NInDM1p/Ix9LKxMS1nsSQaJOwSrfq+
         b9mSiforlR644TTVI6+Ed7Rx5jOuuRDxcGAjGxdrMryWiosMyS2KjBs55ltYnSCGAO5p
         Zt7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778887141; x=1779491941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw2/ho0S7JWvyYsJMkYHUqFQO42K5fGKmFJEouhlnJE=;
        b=aTl6SyWv2r6phZ3rO0wcU7kw4m5VYXv0fNg/lBImhhbwXohNlz9pOOdm0SJoQb9eae
         f9IUfZIZLvJYkWyc1tz5Y49kPqxYhmpHogdhEXhQKDFzA81nxoezdwD7Txmtz8CcHSuH
         LrQvebMOqUxFL4SsOW2o2t1XkGKbMTBTzX7FAUF/0SuaEORBDoxLMwr59wwIQG4GUN3B
         lv5DaLegQkEhXiz69BCoFbe98wqMgkK3+T4pAi2cPyc2gTT2qWN+jRgaK99Q/kIusjLv
         Z80VE4pyIW89dHUwGJTKp3o7YUjuABzoQMpOMk/tui+5rAac7NXwvbmJGDggJM+HY5ZP
         7WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887141; x=1779491941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aw2/ho0S7JWvyYsJMkYHUqFQO42K5fGKmFJEouhlnJE=;
        b=iLQtnEk9c+BR6jyY1ehW4AVfKQvEYRqDiHAtKtXdLSsknJWpOuaTuOSzQFsTiL3L1t
         dIPmbXQ8EVzd0b9dUj1fBRAF3/hVjh3nmZoHXDt8udyNyQ5gyp2OqArNoKbEoURT4e+E
         dU170uIaI6wwyk6t95s4APJ7LxrwoXUrBdkkTyI2fPItmFv+PyBpp/bEjG3pX/eg/en+
         JrHK8CyEQm3kmb573lRRUyZEWEC2CmapWjGT58Bc2uG80ui5LOStr13MXUyVW2Y8YAIa
         dquDHOSQLZ7lnU5QRZrA1zMRhMCfkAQcJZnuqRLm274cgi92QlrF4xoiL/WIuMooT2y5
         mDbw==
X-Forwarded-Encrypted: i=1; AFNElJ/znUd2hubFMAFKdlgWrKTEqxuNAWP6Bw9+1LIZoDnYwoHXEVwZr84h8223hoJSdCzmbNQ6v3OaO1gbE8HA@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtz9J3pXelYcMxG/xpteWcBZGV7Iz/+Ej2bI61TTYaF7Upk8j
	dkxMlt9m1E6h30dca18QFGA/0A+DgXlqqcLFAZV9Ang39P6eNP54VZAxr2p30SPkUN4LJa4AYkz
	FgzTzLfCt1WgAVSajNfNhTUp8tvsF5AE=
X-Gm-Gg: Acq92OFbNHd2wSZnwBBnsnBVQdU7KHgx5i9BQtic6UgvgseuRjf7uasqP4VkivSDk38
	9oBWyWuPydK3Jnm3NhVo0qbLIWcucod+4XKNRhF9Xk/hWXy9+c12Z1IO5C+2MuejTIP7is19ijh
	Kc56HTvyUCQhrwC7GXNOy6FOH0iYqE4AEIKz4XQLtgAFU+tSS6T8l1er5BiYit8M0H5s0DdUnLy
	VNPA7C0ka478tw4mlCF90k07u9ehGpG4bw7MZ2I2H5zLSKqhHOjYYcYEGj6qdjuRjOVyGJ26BvL
	aIzKZ5qNEl9Qdc/KbeePZ8+RlZbnq9pqxFXZKAyFGQ==
X-Received: by 2002:a05:6402:c42:b0:683:bdd8:819b with SMTP id
 4fb4d7f45d1cf-683bdd884d3mr3074834a12.25.1778887141009; Fri, 15 May 2026
 16:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
 <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
 <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com>
 <CAOQ4uxidwSn69A08Urue7S7n8wrGQcyGuvRL387pD+rpSFP-Ew@mail.gmail.com>
 <CAJnrk1ZJ1pVWn21HZATRes55RJD0F0+6SHbq-8FojPutQTiW6Q@mail.gmail.com>
 <CAOQ4uxgDGuFq=Szw8G1BMuhuBhZ029kf+FrVq6y2Oq+gaQ78sA@mail.gmail.com> <CAJnrk1YpbLMCM0oUWBBp1t-zfwneWhyv35ckc5JeNxs=SXFePw@mail.gmail.com>
In-Reply-To: <CAJnrk1YpbLMCM0oUWBBp1t-zfwneWhyv35ckc5JeNxs=SXFePw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 16 May 2026 01:18:49 +0200
X-Gm-Features: AVHnY4Iwa9Vr2d50AdztrDd0BqlZqVpCvmUXUuWFjW2z-409XGfRXr0s0o2IF3k
Message-ID: <CAOQ4uxjFY_Kv4ufxsQx+3NBVMkFbCce_N9LZi0Zzjy9z_nF2kQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 12:32=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> wOn Fri, May 15, 2026 at 1:17=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Fri, May 15, 2026 at 1:24=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > ...
> > > > Cool. Let's get this rolling.
> > > > I need to get my test setup back in shape.
> > >
> > > What is the test setup you are using? fstests with passthrough_hp or
> >
> > Yes. *was* using while I developed the passthrough patches.
> > Didn't run it for a while.
> >
> > > are there other tests in addition to that? If there's other tests
> > > you'd like me to run besides fstests, please let me know and I'd be
> > > happy to do that.
> >
> > Nothing beyond the libfuse test_passthrough_hp sanity test and
> > fstests with passthough_hp.
> >
> > >
> > > When I ran fstests yesterday with passthrough_hp, I saw generic 683,
> > > 684, and 685 (dropping suid/sgid on fallocate, fpunch, and fzero)
> > > start passing, but beyond that I didn't see any improvements (or
> > > regressions).
> >
> > That's the last report I have on record:
> > https://lore.kernel.org/linux-fsdevel/CAOQ4uxh=3DcLySge6htd+DnJrqAKF=3D=
C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com/
>
> Thanks for the link. I had compared my test results against runs on
> passthrough_hp --nopassthrough.
>
> Comparing them now to baseline passthrough_hp (no inode passthrough
> commits) on the tests you listed:
>    - on baseline passthrough_hp, I'm seeing generic/193 and
> generic/355 now pass compared to when you ran them in 2023.
> generic/080, generic/120, and generic/215 still fail
>    - with the inode passthrough commits, I see generic/080 and
> generic/215 now pass. generic/120 is still failing, which I think is
> because the backing mount doesn't have noatime but the fuse mount
> does, so getattr passthrough to the backing file will fetch the
> updated access time.
>

Nice! This is what I would have expected.

Thanks,
Amir.
