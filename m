Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDEA3537CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273064; cv=none; b=dHBsyq/bA/GUzTT10CrXDjNquNL3fxVEU73mbAocW4ut28hopBEhwHVvm1//b6FVJoluHGrVNy8va0gYMFSyRvyMQwnfxNq0ddYbSsdeAZAIadFhijURS1zdWTgnNfTDM/tHr0/91AkISTZ2lT4Iw1RowQR0BhDvJQd8OfKwDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273064; c=relaxed/simple;
	bh=fVmmdX/+4LVVHPEFdlLbGaow4Nn0CS8b4//QJdr5aMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M55n66lkSiDXlpmQNaQ1GJoQybhaT4cw1G1b+2G/Q/ucLBa0Og55gWflQrZvEmaY+0Uzp0/zfNfh151izdn6H0coHbd6kT1cr2kt7t2CgH8kP8Zeym0fwOiQmnkehINNF1K/aACuiW1xYyh2qhSOcwpUvEVXsfLpqAj22MQMl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWLaNmdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWLaNmdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5091F00A3A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781273063;
	bh=VJ0KR1x4T5QCfZmo4L/jQ8nfIU5lD04g2gOP1aJPAig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aWLaNmdZY4az5vVGPW244OxwX2PZfsGkPqq+gWPrG/a5BJOdMrsJakdF90FrysJ8S
	 3Ilvx6M06L0l9gN3B6zfAMsWk5GTXoq2HX9/b1DBq2mrm+i/vsRz45akCjUvn7UdAU
	 7xWVh0athSyGAjj6tZ5QIKcRic8d9yaRYgv8Hb+Ls5XiIrYSgoaQIv9WsSZ47yJVFT
	 5wvBZLo734GHHYxduq0FSn7cFIMRPobUbp2wLBYx2fe3vljixxnNXNH/9jX0UqsjAc
	 ajqwfAgDTrzqpeXDFI83JfCQtskJRNS1AtzCAgzA+ay02mfrrBDtGQBsJNBTeIjl+O
	 OARxuCGcBp4UQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6924a68e3f3so1787593a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:04:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+cG4en1dv4XzaPRvdLJKu0zQk1BkF7gkRLXctHFhDqb1ebd5krTGpFS15JaqKNNEvfNAN8s1wBzLHpjcIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OzchqMOoAEuvbAmyCQbjC1WbgabGirLCC4OI/Qbu5462Fw5M
	Q0c8NhRY8vsfyY/I/SIuRsdpJhzp5l2yJNPdIOYGFbIZwH2ngP2vpYUPy+JW6+51ABYXsg8VT1H
	Ytfs+sryyWleMeVWUHx+sxYPPS9PEFts=
X-Received: by 2002:a17:907:3f9f:b0:beb:8c28:254 with SMTP id
 a640c23a62f3a-bfe24527fe9mr157214966b.0.1781273062362; Fri, 12 Jun 2026
 07:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-b4-disp-c0e7d249-v1-1-7f517046abd7@proton.me>
In-Reply-To: <20260611-b4-disp-c0e7d249-v1-1-7f517046abd7@proton.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 12 Jun 2026 23:04:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8OEYeqVfKFyHR6kLJdLvfcfsdUSsNfXB-j93JyARJhNg@mail.gmail.com>
X-Gm-Features: AVVi8CesxnUjeZo139cjxvZL7PwdJGF0AbKsCZpexmPG4VUs1RozIFdMxQPHEEc
Message-ID: <CAKYAXd8OEYeqVfKFyHR6kLJdLvfcfsdUSsNfXB-j93JyARJhNg@mail.gmail.com>
Subject: Re: [PATCH] exfat: bound uniname advance in exfat_find_dir_entry()
To: hexlabsecurity@proton.me
Cc: Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index ac008ccaa97d..d4769a0f9978 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -1043,6 +1043,11 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
>                                         uniname += EXFAT_FILE_NAME_LEN;
>
>                                 len = exfat_extract_uni_name(ep, entry_uniname);
> +                               if (uniname + len >
> +                                   p_uniname->name + MAX_NAME_LENGTH) {
> +                                       step = DIRENT_STEP_FILE;
> +                                       continue;
> +                               }
uniname may already be outside the array before this check, so
pointer-base bounds check is not safe.
How about changing like this ?

+ unsigned int offset;

+ offset = (++order - 2) * EXFAT_FILE_NAME_LEN;
len = exfat_extract_uni_name(ep, entry_uniname);
brelse(bh);

+ if (offset > MAX_NAME_LENGTH ||
+     len > MAX_NAME_LENGTH - offset) {
+        step = DIRENT_STEP_FILE;
+        continue;
+ }

+ uniname = p_uniname->name + offset;
name_len += len;
