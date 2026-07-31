Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78E43BDAE
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512036; cv=none; b=Hea8LwWoSKWDQoaH45d23ixBdQNa1zYEP4spz6Ndqm6uO9OzlffhdwRdHdClSX8erN+KdryQ8HUhHYtnLAYD/Mz7CguWgjmUkrgOMNXPsCuOGrDZd8RzgPHPcAeX17+2IpVun+ebQrhkGVBC6T45x+vDKSDQegn4yY/YoCjUR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512036; c=relaxed/simple;
	bh=woNq/l+3U0zz2akwXlegxA86rTMivcRmcH7/T5sMXMo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FMSWtSiOyUHwkvc1qxEFoOoT025TEAx7Kz+xnU+ENMyF27AIoKOdjVUShRgxEwwVg1uPhhstddPdc56g3KlzekXWNEjhYdJKUK0R7IWkT7rG7QRHZzUaqOKRea/PIWnKRq3BJcyZbUdhDLrp6eMLidIkJUbCawSy2wVYNTtlHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y3u1vViB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y3u1vViB"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfad59921so6684151cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512033; x=1786116833; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIaFXgBtOm81nfXrtruizv0xq/Lkj36YYTwsO8jgCiI=;
        b=Y3u1vViBio+nqrIXHc3PLM8T7DOvrochPqB15/haNdLZ3fXpwy0nU0obhbmwqe/iX2
         l2MK3TXATohJun+/SSNLSvnA77hZG2imJvfgezTMLOv4lpazgEOov++Msg3p8ZEl9mMD
         BhJE5AT9BBTnQkKoBvXfUsHKW281dkv8wLQytxLkMrLdO4HsokQ20EySQRQ5YT7F3M3w
         eC46HBMOhcGZJr0V3ApkDpMTFNMTGajV4sLrP/UHDJwxs+vPWsC28IIqHCCb2TsH7VeQ
         sE8uvaZkAP2MBwHpT/pgq1LPxt17ovYV+1WGtCO5XWfK57b1mdqAS6uDlbwEhNS2wXp3
         Y/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512033; x=1786116833;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIaFXgBtOm81nfXrtruizv0xq/Lkj36YYTwsO8jgCiI=;
        b=J+9e7OL6HHxsmM5FmDMT7UoKL5bRD1ON2uQ0E9N00Bw1BQ82aaGQRf9yZrDJo/cPmm
         LUK2mkfVu+/7pzgkIatznjS0OYAEZkKYq/XB8EsJonppvLYi5gSptbSpgiW4Fiuh5dO+
         yMqZ7JDeX3RAUNLX7Al0VVQr7geVtumepCMnu6TpXYdD95PBhHj+d/qqUhGIlLpz7E6M
         UorZw5vIwXtukDsc7SLu1FB9E8834LlmoaBzYNd47Gzkd05xOfI1zkkSzTG5xwF17rJ6
         P6q7x6T7tz8qnbiSJ61lB/1zS285ADyQD6eqkYkg1/kybzXt0kk5CyjHNtTSFn1sXtcV
         bOQQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9e63FVoISwTyaFkgylxsU0WEFiGcV7bSWoFzovvKZdOpS20q34foDrRvg8ppB9uK1qt8/BzB+G+t/wrRY@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbGMSKFq3o+1OhS9l8tWM9dBeKPcNK8wSpfHJI1dF8ApK9VLg
	qeZlzjzVJuCWXtG5sPSMUJpAWuT2r/ruFmPl2Dc4wMOa0zoToSm4uYj87UAKyE+mlw==
X-Gm-Gg: AR+sD112eQowZu6JS+Yk/fstreYb3oTL6+ebCKIh1dD1/x9PadeAgjUHIBW8vHG4qLk
	oApN/Yp6NCuGoWe9UgCBTiuU8Zy1zotKRIbGIA2YgKvmRRAUsi1ux3J8eNGwMlttGLFxqQn5nv9
	CO0ACRm3lVvaJuMJ1y6CXYtxxGbWJWvJPj1ZTqVdqZsHkC/wAaCkqwySSd4+sb8rVzhFARjBgAB
	TKH3vb6VGPSkHNMpc/esQXTySvqkhGO0JZKTOuVgSeet5FQXMdOIMoMYxDDAUa9z/mz9iD86Tyo
	5UJHdCsjqLGhCezQUvjy0SDwxRdurUAs7faPGKyA+jFXU7PeA6/hiN9lw/duaQhHqItG3cJs8j7
	wxmSpjEWBF7oNqMynXEn6OEt+hdpznQxJP7EFZ+8j62Hay0LMLztuCJsdY++Q4Y6g3Hf7qA6qHK
	3BHsU53b2yttA6DyDfFRMzgfb8dl5OGHOVauVTTzL1BwZRM14XW3afN01c7agVg8H7VxfMvHX/C
	KeisHfXziCdswLp3r3QBgxyff4qZlh5pw==
X-Received: by 2002:a05:622a:181c:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52b566f6f4emr11298121cf.5.1785512033469;
        Fri, 31 Jul 2026 08:33:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ebeb909sm9993881cf.29.2026.07.31.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:33:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:33:52 -0400
Message-ID: <f3768f73f951ef02b4fc3f89d53527eb@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260731_1130/pstg-lib:20260730_1437/pstg-pwork:20260731_1130
From: Paul Moore <paul@paul-moore.com>
To: Carlos Llamas <cmllamas@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
References: <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>

On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> 
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
> 
> Do the SBLABEL_MNT check before the inode security is initialized.
> 
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
> 
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.com/
> 
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into selinux/stable-7.2, thanks!

--
paul-moore.com
