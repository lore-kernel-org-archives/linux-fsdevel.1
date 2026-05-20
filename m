Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632832236FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237877; cv=pass; b=SuZskUlrhq3qgugnIvfP1oPJ3qH+XyvBWUIo3+/sPsTIyWwlj4X3EhVIr8yZmlFBMjJxD7qIY0kp2vUA/+jl5pRSv6d2LTA4wz1GbI4BH3i5sreNZmZUVhgUZw24lrGsdMNpSSqwF2Vz3E6tC0I4Zsx94w0z3bEw3AqqSZ0N9p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237877; c=relaxed/simple;
	bh=r4rDxt2iR8+4rJfyd6F737KFpN/+gdWxNcaDRgoc/BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q92YJh67LHoxU++VRpZxgq/8AAJq4YtBJz35Ji4zUKrRnLXB2hkpmCviz+nJwfFNX2ez+4d569N0hi32A5axoq0+aeHs6X3mApwhof/THjdrmDshKzHQGc9cEUniCKrj6KAmCEvKuhz685v78o28LeQR5g3cUSoqVulwXNEUxew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1m0H3Sg; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1m0H3Sg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso2189412f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 17:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779237875; cv=none;
        d=google.com; s=arc-20240605;
        b=HVuuVaE8p+JbEuXmzu9RVRDwh2+/jwwus+W00UjfTtCT22VqIGga+fArknmoTL4w97
         6WGgGZIXZTDZCtIXscvZhi0ZS8SiwfvJRIwWKY4TIDad2RR/qdCjeDefxGfyszDAI5UN
         Pm9WuMblSfx6FdO68Z1Kw+dCzjsIk+rr/hesXXuzUWVDn7rUr9uE2+ro4WW4Z+ndl15j
         VNeqSsmtSmzrJXaQAecp2rKvMUAKqBaNWPs70kLVFfBLb9fCKYvli3uu49pgjAOAAops
         meeAZbcjPe94MVwz9QvHSHj/O8Lp1fu1hB0MWVKM3DIdQiVE893poFzcpUIXD/Doqk0f
         9hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4rDxt2iR8+4rJfyd6F737KFpN/+gdWxNcaDRgoc/BU=;
        fh=yFSzH+Vl2uLXy/kd+sm6jjuX5GlXHs6oXfZOL/vJLoc=;
        b=PkFSbxe7hO08zGJyihYhFI8U4RqqhoqYQYYdqtf96d5VXbdw4Q4tP6lufFWxD8nU8l
         I8MjuSNdxjBLzFs/e8a1RpDVwErwsxAkeSTamKIOOtQXeDqyFREzP8So/fa+1vmIJ4Yd
         GSBZJdldM3bpwDtJWt8LtgoCPWBfT5n5ix1DYOw+i0qm8cKRyXvCmF/aPE5cOZG1FOOh
         AXyEARrWb5oBPxj25WTkqJUrxXULCYd4BUmP6Posw2YCA8Xu1KeBNrPP1+nYvNsJT1Qb
         lTNe4+OBP30mbP6I3Scj2DlnzycILrr5dD2575GJ4jeg5CEEOLNZ8Xk70y0IGcJWq785
         eMOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237875; x=1779842675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4rDxt2iR8+4rJfyd6F737KFpN/+gdWxNcaDRgoc/BU=;
        b=W1m0H3SgWzna9QSJtPsfQqVlN6dJG6EX606xa9inFwrA58VPQBBRJkApCvAuP9RYhi
         XVuf7ucCJ3qMKX8BcqfW2qweZ5kX1o/DXDLmzD/rjZJ3uUZjsPrfancLn+olQgBZu05Q
         cTstTI3ABgEfGytV6VpaqfQUVGM+V7nhCbgZciYsar3au6FW95YGI9CeffRwqeTEchSk
         MaDQ382AKTIXiIWmtaLopERVEQxgkiV822ecV8tHliBvZ/yhmGle2oD/9K1TjLRC9B7H
         6R1n4oSc3B4qumq8jOdpr/szXVjvz1IU22ZCFSEqaa6wRT5f8kHOgPCuR29LRXB7NcWh
         IFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237875; x=1779842675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4rDxt2iR8+4rJfyd6F737KFpN/+gdWxNcaDRgoc/BU=;
        b=eVrLbNez0I0yyOUL0U0yiZ0Y6Y3SCxbDXVdrm0TJ837vftt6/idkw42vLZUk/IPz+y
         nKqQlo89D9L230T9jmp2qk6FQMZyjxh+Zx56pUAHhFjPfKNOUgQU8QI7OO+ks6IZgLx0
         W5uBg4mH8gBOYCfwXigmEDva5PaDwT22hhszgivH2iA35NTcVPMf6KiYf8tOjRXdCHj/
         60VQ8Sr82GAXF2Tbe+7sw0Lcn0FCUX4Pw9OsFx8fsPr9kdTzcfDUOUnMroX8+AzxWGHT
         N93So/M3D3e4fYaUlDIZYJVwH/2dSiQn5+ceHavATX/HNHnWPOjAqeIto4mg0WBhw19a
         9emQ==
X-Forwarded-Encrypted: i=1; AFNElJ/E8rvs4iQw1zdxPhL8FvnqpUZsVcj0bujRoD4kfWYDBoJFeceD2k98jk6OPP3m4h71lgStnGQea6yNdE5b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4KcxOr69SLEF+C0KpVhM6wogWooAsxNFrcJlXaAueSeu3YE8
	itS7PjVY5wsUVpVsP2GA9iEv3f16/yHmAV/kLsIDPxzzH0SxFLN2Ie2Ui+n17IYWv1vxc58Cif7
	XOsdLdmArDUBhWR3n0eFUdmhwSO4Qq9KGrjoB
X-Gm-Gg: Acq92OG81w67oU1TlXR4Tg/Yqkli4i3iXhVLYwnmlP8R0zNz5N4/qgSoC/S/y6O9iBW
	KncFYgs52m8rEYpBtKVkiGzb3Qi5S9jUqMDOJLom+9KqmsvhT48/LWr2y2jZ771lHqikVIiNcPm
	KU8NHvNlYnu/3Ape/i9x5IzRkV1acxydc13aqENEjGnYAgUPwtenGz8//hi7p5Sl0HFf5eaiYsf
	BFjtbLdmj65T0XnvVKIo4yBzBTjtgpIs2IatHGAyT+itw1eqxD3wZQkFnaMbsmUwoMsGeIwNzvL
	bdjpol15nki/uPkG
X-Received: by 2002:a05:6000:2c10:b0:450:e5fd:e1a1 with SMTP id
 ffacd0b85a97d-45e5c35dcc2mr35813714f8f.3.1779237874710; Tue, 19 May 2026
 17:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-14-joannelkoong@gmail.com> <08e937f488a261d7bd3684c0db8d517a1f33422e.camel@kernel.org>
 <CAJnrk1asUJqskOidATL8SBFcgmWLxS=J93ekW5YdJdLAF1Jr=A@mail.gmail.com>
 <04f3c2ba632be1a36d4770ef4bda45c3e156fd95.camel@kernel.org> <44675f24-e7db-4d92-a7ba-ce2a3c324f59@bsbernd.com>
In-Reply-To: <44675f24-e7db-4d92-a7ba-ce2a3c324f59@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 19 May 2026 17:44:22 -0700
X-Gm-Features: AVHnY4LAytbI-3bAlnWfHqnOOqou7-gY2HxNr78Yr6UNHwrGC5jqiEYLHDsVjpE
Message-ID: <CAJnrk1YEsj6TgWxU0Sehfpc-hJvGs-Kt-wbtYUbDp1uXk0qmMg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] fuse: add zero-copy over io-uring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 3:55=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
> On 4/30/26 14:55, Jeff Layton wrote:
> > On Thu, 2026-04-30 at 13:35 +0100, Joanne Koong wrote:
> >
> >> This is gated behind CAP_SYS_ADMIN because zero-copy allows the server
> >> direct access to the client's underlying pages, rather than operating
> >> on an intermediary buffer that the contents of client's pages were
> >> copied into. A malicious unprivileged server could keep direct access
> >> to the client's pages (eg even if the client tries to cancel a
> >> read/write, if the request was already sent to userspace, the server
> >> will still have access to the underlying pages). In the non-zero-copy
> >> path this isn't possible because the server only operates on the copy
> >> of the pages and not on the actual pages.
> >>
> >
> > Thanks for the explanation. I'd suggest adding that to the commit
> > message (and maybe comments near the CAP_SYS_ADMIN checks) in case
> > others aren't clear why this is gated on that.
>
> Silly question, isn't it very splice like? Fuse-server doesn't get the
> access to the buffer, actually, but only forwards via io-uring. Splice
> is allowed without CAP_SYS_ADMIN, so why does this need to have it?

Even with splice, the server is not given direct access to the
client's underlying pages. For splicing pages containing read data,
the pages being spliced are from the server (eg server's pages end up
directly in the client's page cache). For splicing write data, we
always copy client user pages (eg the "if (cs->req->args_user_pages)"
check gating fuse_ref_folio()). With the io-uring zero copy path, the
server's io-uring gets the client's actual page cache folios
registered as fixed buffers.

Thanks,
Joanne

>
>
> Thanks,
> Bernd
