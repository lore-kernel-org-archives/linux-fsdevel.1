Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90133546E0
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Sep 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788673862; cv=none; b=Y1pK6roK+X8ZpQXQEiJclnPlpwSa/WlEkZT89ZzRvkeiGHtP4PqD8xeVcAwLNt7fqr0YwRBrsDcnQOcPZfEDNmRDEWzkrDL2otJlFjPeXUa8LlE5BhiX46sHKS7RqLHH9hjo8zUo19ISvRnxOBZ9lkp7/rgem+9K65bPP7+xiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788673862; c=relaxed/simple;
	bh=viWJnjrbhyky0K4g63DpQdEAEtLqeMnC3TLX78qmwLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCdlGKOf1z88lTDh4TWYve2KvSItqZLi1odMItQPJF7F3TwlsXEXMI8e29qOJ96Pj8mlGFhYwylM+SU2MY1D0qU31kf2XRn0BJMeAzuwSFFrGcNC2fDV8HGU0HqaNcz4nWO2cIG/DX5t+GlKKkZYQ3EWf5jERS/zZIMnpq/ek18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdCSwfLb; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdCSwfLb"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso14508375ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2026 22:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788673859; x=1789278659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFG6XNGVyqJ8z6Dlrx8ujL8nDyq9SaEpffEn7E3UykE=;
        b=LdCSwfLba9JKVGcSBkmiXnSngjzqAwDp031bVN/XJvK6Mi6oAk2BGbw0ZFynSOU27I
         5bHaj9A5ecq6myaVdx9W/PCQtamhjV9tp+9AZlHfi2pLVQo5N07F4ouO/jgazB9rP7gm
         j5++faPym8//sLqlytPm2u9R8bErb4aG5/KEdxYFFjNiMSYm8nMpyYylpHDG+8FgIDlp
         cMAkOrvYZ6vluCxO2hIlvEAj8ktpY0hhnMzayKcRoV/Ph8+PnwVF91Oq+mkXOqJYouPF
         9vUPpjgOkZMeZvnwyh1B51Tn5iwqzEXm7S35lTNNAm4EvuqCx4tkOwnRSqSb+plcYQM2
         HyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788673859; x=1789278659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uFG6XNGVyqJ8z6Dlrx8ujL8nDyq9SaEpffEn7E3UykE=;
        b=NzGvxq87OhlcLy1rnaERaZIvJarZheJHK6VW7otnxkPiYRrlELwJfd6E5gPC2ybipq
         FdzYNdlQ7qQAm/JT693KPgxRO9mLQ01GNiP4kgJOpw6q8CqY0Oe2kYhIN0MfceNgO38x
         5RP/+52oNTexo18GNYyEOw9AFrpKP6+88rxqemnnLFKMYS316tFSmPy93L/RkPF4K+Os
         3AaBETdqVbGERbZ4QpY/NkHdP2TAfoIlK4U2B2pbEoVR6PwEiuaUBTtc9b6mRQw6NZPv
         nWAi0Vmc8ed69Etq0nfOaHZg6cI6xSlD2Ypo6jVTZHiPQaZyv40gt0Faj+QrmxT6ewE0
         bs6A==
X-Forwarded-Encrypted: i=1; AKwUvBwJh0cJLkXzFEuiTn4c+WqGZnIfBaJBNHN3FalUG5vUkj1auotSIyXTJsYEkjZVAxtee1VjZsB0uPwfSppV@vger.kernel.org
X-Gm-Message-State: AFuF++mPBbVkACoIeBSQSjvT6Mmpgpqq3Lr4e38OgU2ZN8tbVAi16BOv
	VCN3puoxpvfWbXYzlNeMD4RX1dztnCvhcCFRY6vrpxHjZ3jHrYq19CMo
X-Gm-Gg: AYBFou3MDDRq057bJu8A+8FRTO7lY7NO0G1L3Tzm5Jjw3+96/kPL4JAorscu9QNS39C
	NmGiTI34x8txn6mPcNyn0myM6zCEk9V/9Qlv7+g+3U1RDzuAlJsXwcwtQ3K4etDOTLsBVGfbYuu
	k4r0vj7e88DDrBRwG0Qweg/Ku4D2hd/bEfkrtwIAHwHZyXPUe7tMb+mSG6gvHW97LDUNPiF60IG
	7/fMeE3AUN3uDPNWCL0Jk/OeWazQf4dFEFDbbLJvD7KFZHjOyNlmgWaW7SDvpAidfWptSe2Hw6v
	Zd52LtQ1Bt1B4tS7CZNYprh1ktXZFo4tKQhqq4A4dydchZ1XiexuTL084Y43leDKwtXqW4rTYXL
	WNPYTmPRY3u/DPdnjogtV5qVFg9hHkS3CtTYFylaaZPN144iRiZEUbVJbdTPoPAx5Ch5yKka6W2
	lcON2sCAxpR+NDg0irrM6eqyx9XQi4yoG9HkVsyQAy0MYnSM5sgNi4GIF7oJqm0Hk0KpwvNRxs
X-Received: by 2002:a05:6a20:914f:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3da3a03e965mr23968702637.18.1788673858878;
        Sat, 05 Sep 2026 22:50:58 -0700 (PDT)
Received: from localhost.localdomain ([111.199.57.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45e15604fsm2225263a12.0.2026.09.05.22.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 22:50:58 -0700 (PDT)
From: Gong Shuai <gsh517025@gmail.com>
To: joseph.qi@linux.alibaba.com
Cc: Srikanth.Aithal@amd.com,
	brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luca.weiss@fairphone.com,
	ocfs2-devel@lists.linux.dev,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [PATCH] buffer: fix NULL dereference of bh->b_folio in __bh_submit()
Date: Sun,  6 Sep 2026 13:50:32 +0800
Message-ID: <20260906055032.3005936-1-gsh517025@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902013357.2815214-1-joseph.qi@linux.alibaba.com>
References: <20260902013357.2815214-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit a2c924c240e7 ("buffer: set BIO_COMPLETE_IN_TASK for dropbehind
> writeback") added an unconditional folio_test_dropbehind(bh->b_folio) in
> __bh_submit().  But jbd2 shadow buffers have a NULL b_folio since commit
> 5febcba29792 ("jbd2: point the shadow buffer at the frozen data
> directly") made them point b_data at the kmalloced frozen data rather
> than a folio.  Submitting such a buffer during journal commit oopses:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:__bh_submit.constprop.0+0x87/0x120
>   Call Trace:
>    jbd2_journal_commit_transaction+0x932/0x1b10
>    kjournald2+0xb2/0x250
>
> Hit by the ocfs2-testsuite fill_verify_holes test running with
> data=writeback.
>
> Dropbehind only applies to buffers backed by a folio, so skip the check
> when b_folio is NULL.
>
> Fixes: 5febcba29792 ("jbd2: point the shadow buffer at the frozen data directly")
> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---


Hi Joseph,

Thanks for the fix.

On the OrangePi RV2 single-board (SpacemiT K1, riscv64) I hit the NULL
pointer dereference while testing other patches on top of linux-next
(next-20260904).

The jbd2/mmcblk1p3-N commit thread crashed in __bh_submit() when
submitting a journal shadow buffer whose b_folio is NULL. On this
board the crash reproduced reliably, roughly 3 minutes after boot,
under normal filesystem activity on the ext4 rootfs (buildroot-based
minimal userspace).

After applying this fix, the same kernel/board combination has been
running stably for several hours with no errors.

Tested-by: Gong Shuai <gsh517025@gmail.com> # OrangePi-RV2

Best regards,
Shuai


>  fs/buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 427d8a817cd5..f46fa6413032 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
> -	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
> +	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
> +	    op_is_write(opf))
>  		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>  
>  	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> -- 
> 2.39.3
>
