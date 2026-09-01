Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3623D7D67
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232793; cv=pass; b=ZfqOw3bil8sHCh4PdwFo5ARbgmXShsha/bVljODjiF4EtubGMlqIIny9adwkHV3ddnBtu8kof1oHHfR7IRLlpekaIK8MD5XDaE44GrTNqdvJSYKfGRWdnpsuGy+heKL7dMzIauxiN9/AIqmIOugPPYWiLJ5HoEbZodyAx5q2ljE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232793; c=relaxed/simple;
	bh=Tw92wCgtX64w4RYTjVLKytcgWHeN5opE2HHm0QpdkRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVu9xRBg3MBOC2rJv8ep8bbeQFp6ZMI8oDQRUdd3ZwI4I5heWYU//Dg12Uc2XfKJOplhttMQoK+StgH82xfiWufahmBQngDbgZkpfSQPfrJ/3iRIFlYW07fiIGp5AmHNtmTUBGLtzBOeDmQ92vOOM495o7zl6/p0XacyZ9aH6uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPB2EHR+; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPB2EHR+"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-85b293528a9so6512847b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 20:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788232791; cv=none;
        d=google.com; s=arc-20260327;
        b=BZ1wN9FsU0JaSWwNsnkDmAj/9Idlg2IAe892L0O5l9xDAfdAVsv7xt3byRiSMn5Y4K
         DsrzZk/KzoHHYeANIlBFDVS8fDh/a6iBS/24BY+nMFUwHenSeuHlz672/olxgGCLkX2s
         U9VKRoVRU2y3QnNfHNmqJW/VPBMKFTf3xlYPYoc+r+1jV7IzgmLddHH0hlR1r/sR+7b+
         WfN7oNMj0+jaTt4HAVsjuzI3zLh0TfhcoOJQazs5YjusGI1NoJpo5aeayL2m6ltVHPvH
         WG3P6Q63x+W79I4TAB47s0+C1UAKPWcgsE256nIhqXedg2haozniTOI9DJiJi0tyScWL
         7FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uxfDC7P3hjzDwZfMMU4ZVm/zbG7/WqTWINl4wOrB0SA=;
        fh=EBd7HyM38xy6fugU9QlVSSjHjR+uKrYasYNUzBTD7Ew=;
        b=fU5723/QbHx11I2loMBClLw2UztdWt7yknVxQqt6x6PVPwZaIn77aBw9WsjRQZnAaE
         0uaCeig1FDiE5Yi6/obEILL8J/ZpvPMeSL84rGmUektPY0rbK/LI1whFkWGSpjP95ljx
         ysRzsOD0M3jsRxpgGtC8NpND5N8E+vWkICac/wfIueAz2DIkKa3fJVEOdLpu8FUQnkZL
         LHFEsBLIU9y39/XTR6Zm7pl1lm7jjqzUdZVPJVsRd2sy3HLombvWJoB6smAfcm/lUHBG
         7r8YMB9u86u7MDn0ZcZs/ukR8HUvO7UAbQEK+oQrq+BzLlqUTl/3bu0pbyaF13lc85r7
         hDVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788232791; x=1788837591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uxfDC7P3hjzDwZfMMU4ZVm/zbG7/WqTWINl4wOrB0SA=;
        b=lPB2EHR+6igVUVdCc+ca0JhuA+VEPlYznluHBt0xJL+bvXkmja7ZXtt/XstECP/MHP
         1Ghu/9LSqj650L50NVqs8Gx7Bx4EkPw+8zLNKniSQ63QrlVchaglBkHNC4CHCMBTgy6D
         OmfkiSxAvSWIMzF3r5NLVanLlv2NVZGtq4uywe8USDaP6DRh4OM/hpuT0XybtI72p1Hs
         EUJWGqmmWuuSIc+F/WfmltcKxzr3WKeqzq/kqyRFeoiT1oZzvFafm1zqjyGn+HGmP+ML
         T6m1I72hjvSbmVs5+VSv1VFXDV+sfthcB1/0aKkiygCqtQgp+t/xe+2nQcHFI4Of/Pwz
         MlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788232791; x=1788837591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxfDC7P3hjzDwZfMMU4ZVm/zbG7/WqTWINl4wOrB0SA=;
        b=EEwZe2woAg4NXUZoaP5bzWBDk9p4M9wzIkMPZB4r23cEbKqyhppwzzsNStNl8Bc/Zs
         igvmddezZJXZo/gM6r/sC2pT3YcpxAWYGRZfd7c0gVvruBNsrLcMJE9hBwTmER8hANoM
         DpvmUlC7nWGdljYUzt8bJdaqLG+KnUuRMFWwkhFnygEQoavCFopGlTgN1E8F95No8p2R
         W5lLYcfU3CZCacTCCNACxlqm4BGV9ft1xWukiyeeOlyvBHRvB+YHDSQQGo/d3ksjhixb
         VCkIGb9AleXrxCTShi3D/4j6E4Wy35xrAkCDdNNnMtchqhlKgbVBWLGxsUyx4E0xIHID
         i+gg==
X-Forwarded-Encrypted: i=1; AKwUvBwguSoAhWS+Cuh/kLUlirz74iWkceMnxMg/TBOMqdK1mLh6CqfcIx1tvT0n/qew2dl58VJDmaafLBj4a5dq@vger.kernel.org
X-Gm-Message-State: AFuF++mHAWd422QaBWyICldZ/vxgrU0IRQaLOLypYUk1nlw1jZspN8Vb
	FiH3poxz5WSaiF6agViPgM/aFCbY6RPpDVmdn+1mDOcr6LmLruWmb3iKAxl7eRE5KxomTsjI67z
	fhKpbcDJO8mXyQ3qioWYFJ8nRHs1UZaE=
X-Gm-Gg: AYBFou1P6zT2rlhJMfNWM+b1E4Csjsa48o0S0YRsmTG15FxTN9fCN+lN431/5n/qBH/
	NhSczxNgOU4mQCLIEJzNAo5OWwgQp/Ed1ccEB9xzYf10T0/6U33puBe/p78nS+Pu47uUVSjHAW/
	v2hs/zgGoSp/GQVO+9w5FGbbU6zBaf3Ul+THEeE4+0ADCDZctqgU8evJfQDwBzsrR3srNpunnHZ
	uL1HFCUl8AsebZozjB/1bc/S2WXdhHzr1ncfbcaGsJtntrZCjCtiUV9FVISDJUX5NkS7w1g9ZTu
	Xk8Ap6CX0QEzCPlairxJyNKY15DhLyecVF7TTaH/6eQJGwiSNndMtywQ3/i5EOlKeC7Zp3DXFvc
	Gt3INgg5ZFQKVcLqgraSPdUXYsMG4weiVYg==
X-Received: by 2002:a05:690e:419c:b0:668:43b7:acd with SMTP id
 956f58d0204a3-66f8a41a3c0mr853872d50.8.1788232790590; Mon, 31 Aug 2026
 20:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com> <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 1 Sep 2026 11:19:45 +0800
X-Gm-Features: AcwNN1UzotP2OBEays5eiLg4A4d5qM5oPgXZ3iL75O9H0DWfs8MThC678FLuhRo
Message-ID: <CABFUUZFToRDtvewhqHOWjE1h+7o-cmb1D-z3Pe4oXTVXzt6Z_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping its reference
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:52=E2=80=AFPM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Once mmput() drops the final reference to bprm->mm, the pointer must no
> longer remain accessible through struct linux_binprm.
>
> The successful exec path and the bprm initialization error path already
> clear bprm->mm when ownership is transferred or released. Do the same in
> free_bprm() before calling mmput().
>
> This is required for eBPF kfuncs where bprm->mm is either NULL or points
> to a live mm_struct to ensure safe access.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  fs/exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index a14f28b15607..4b4d8f0627a7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1453,9 +1453,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> -       if (bprm->mm) {
> +       struct mm_struct *mm =3D bprm->mm;
> +
> +       if (mm) {
>                 acct_arg_size(bprm, 0);
> -               mmput(bprm->mm);
> +               bprm->mm =3D NULL;
> +               mmput(mm);
>         }
>         if (bprm->user_ns)
>                 put_user_ns(bprm->user_ns);
> --
> 2.55.0
>
>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
