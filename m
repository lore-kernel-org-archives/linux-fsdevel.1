Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC62D0C84
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364020; cv=none; b=pGxRqfNhXPMW51Hyp12codePAag0qwDDPrRfW0TzXUHlvJ+O1AZ1whSpR0bNYyBFAh6nVw2jCjpCk30KgxLetCjbNqB7HnJMw4bDJBj8ESpCNYwxlxMSLw0C6Fovm5FcyMzlyiXZ+OHW1124mroZhRM5rwSvifoq7k8+C8Lott0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364020; c=relaxed/simple;
	bh=0tmlIj+AW4saUEYr6iZq6ttoIEdOF0dqz5pgiP7+iXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZuMCvi3Z0Vq+WnUwUidBmL11EDZLggEpy6tJQB1oGBBE/Qzc5ewLN7ElLweXjDKdYvpZs/UaeoldQAm6kY8C6vO5V+Xs4oUDM+IgFNamWxNZ2mLS+vNkj7ZSwR4R6k47SApHOYdTLD8oQSC5hxcOp39oO5lv2UMpHwp19GB1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv1ncjLK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv1ncjLK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso14609835e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781364018; x=1781968818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdUdJR3hjSlMBuPqq5j78SxOJ6CXwJNJeYAG6P57jTA=;
        b=Nv1ncjLKYf7ZH0lMjEe56xJtttiJCD4Tm24iFAjolZTsodfc9use1u2kME4HQtFqaW
         9frOS8OocpCp5CIIt5rg63kEsN82eDR29USf5lobRSTqeKaqro2yI+iIdD5kOufazhoP
         gsHqrjrCf4KL1GPn5ZTihfMB4TPSXb8jeeoboejhJ1kV3n0CqysrhyV5DYHHEQE44CuZ
         pe1Yb7ZR47C05OYJGAj76jDQQyDSd6Dlv1UXmyGVHVEbtkNfpbJBThwpku+0e9kIbcpa
         atqWXp8xItdKFPIqXvYTLABklgsBLxBB/SnOgZHa6P3B6h8+ZgXpyytp1O8rNtCvqgjh
         ddoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781364018; x=1781968818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdUdJR3hjSlMBuPqq5j78SxOJ6CXwJNJeYAG6P57jTA=;
        b=kD8Qxcro7Fdt8U98lxp9ZLKo875n8l7CTfPTEOPFukg4h8XT1A3bonQ13T6gasoHoX
         qbRztr2WI9UO676qmuz4XU7CBCohT5eOnOaoSJ1h4oLXZN28jXTudro+Tn2cznuoT3Fw
         Jw0HM3mRqsP+7JxH4MdAUOFwCX+kxeraN6GC5QrQc6WGnHBbf+4MV/7wXvV5RbydP+9G
         e4Ji7wm+Do9wWb1y0nJia1SJTQIirBuA3DRU6p807DUZK22xtdR9ctmgQsfxWEa9Uj3c
         dTcZ/PdAT/cTCi58sBYI4ipmtwypoeRJX2qLXLwAng1CMUNasP821SS1XNPtc32WhfWA
         ELlA==
X-Forwarded-Encrypted: i=1; AFNElJ+XIGGzTyEFBDXIhBhR/ucSVE5UaAX5bsBOfUyxzxsE0+WF5RZPHSBl6DiBXF35ODsgMgokDgrY/uB1N7hx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0F47LlPlfe6YXAW8EBG5wSQZuPWktEe7TSHWnKT/b6xLN0g6
	aIYA35CPXo3yyQA6vs/YqJ4uFt9PPFLrt7eOkAXT6++SzJ6AKjmi8ak=
X-Gm-Gg: Acq92OEU9qntUFaZ2z3R8uWzH7mIW5eaYYEGfTF/kk3Zrcu14nEqPuxpMI5TyuCi4QB
	n5lAjhPwtiXEQChyDCXljEr8hjCUy4+U1LAJQVt63vMBMxCOk3ZY3NgngiRMWFiymGnW5/Jh0u5
	i2srT8B68TshgmF7LsOOHmfH17r6TP2k6NhucdITrqB+2oi7WitzZahY7uSTj569kF60Bsr7dcA
	Ea1XSJafYfTk8gSMwN7WGHteqMaVC686Hh6uPcFjnluCU17peNAJKciQx5eEgYDZwWCFKvef6BA
	LL93R0VrP3px3Eur8E2jzAE91Nx99fDt+1qAN0mpvekfKl0x2U9pFbYcFK7bXrOr6ALev67vSR/
	lcWcA9YemN2WZEwANoo6iI7N8z3NCp+zbiKvmppXzikWthbOCtcAmoMgSAKnuruBq2sQnPTLuOI
	AhdEnfHS/WFfBcLHJOD15mN2yQO1QMAfffCgx3tWzJQV5lVNvPXDVYRCASTvfwMZXYFXgn3MfyJ
	4M=
X-Received: by 2002:a05:600d:15a:20b0:490:bbc4:76a6 with SMTP id 5b1f17b1804b1-490ec4fb51fmr69260685e9.21.1781364017856;
        Sat, 13 Jun 2026 08:20:17 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-95.brest.telecom.by. [46.53.134.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b7d2sm91066515e9.5.2026.06.13.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 08:20:16 -0700 (PDT)
Date: Sat, 13 Jun 2026 18:23:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Wei Yang <albinwyang@tencent.com>,
	Zijie Wang <wangzijie1@honor.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: only bump parent nlink when registering directories
Message-ID: <ac6b0e86-468d-4806-a9e4-60df0efdfcef@p183>
References: <20260612153031.536525-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612153031.536525-1-kwilczynski@kernel.org>

On Fri, Jun 12, 2026 at 03:30:31PM +0000, Krzysztof Wilczyński wrote:
> proc_register() increments the parent directory's link count for every
> entry it registers, while remove_proc_entry() and remove_proc_subtree()
> decrement it only when the removed entry is a directory.  Regular files
> thus inflate the parent's count while they exist, and leak one link
> permanently on every create and remove cycle.
> 
> For example, /proc/bus/pci/00 with twenty-two device files and no
> subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
> and disable cycles, each creating and removing the VF config space
> entries under /proc/bus/pci/<bus>, inflate the link count of that
> directory without bound.
> 
> Before commit e06689bf5701 ("proc: change ->nlink under
> proc_subdir_lock"), the increment lived in proc_mkdir_data() and
> proc_create_mount_point(), and was therefore applied only to
> directories.  Moving it into proc_register() to bring it under
> proc_subdir_lock dropped the S_ISDIR check.
> 
> Thus, increment the parent link count only for directories, matching
> the decrements in remove_proc_entry() and remove_proc_subtree().
> 
> Fixes: e06689bf5701 ("proc: change ->nlink under proc_subdir_lock")
> Cc: stable@vger.kernel.org # v5.5+
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -404,7 +404,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  		write_unlock(&proc_subdir_lock);
>  		goto out_free_inum;
>  	}
> -	dir->nlink++;
> +	if (S_ISDIR(dp->mode))
> +		dir->nlink++;
>  	write_unlock(&proc_subdir_lock);

nlink accounting should be folded into pde_subdir_insert/pde_erase
probably but as minimal patch it's OK.

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
