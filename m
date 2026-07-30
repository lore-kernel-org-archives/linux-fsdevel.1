Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3F3C4B8D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445805; cv=none; b=iCV9Bc0RN36EsT70FGmYRMzfFVuj2KPxJYrtbEtaXYxb5rAXkQRKP+9zYgNxWeuJVGE3irr6KuLbE+oaCc4hKfSu3HFplp3Xosn+C/fyuRIWfE3+G17u3s5OiX7N4bHIpkT0zKOMnCOqbU9gkf++D3Q46lgfMcMAYTBXLux5umU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445805; c=relaxed/simple;
	bh=h4gAl5X4nGE0SU+Gh3X/MeeFPIcUPYTfpNfqjtezBaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=fMphIFiSTnxGV/99ePsjteW4ir/t6mNVjqTwumCXcCae2AzfXpCmYGBWFdV11WCPbuXwGI/P2S911JiiLuW0j8ao6QU2nePn/bLio73jiA4h/hvgg3ZZh5yE2l06hGhl2vWazhONqyxWfB7fZPUS3p9GUmViQdxEnkybMaQTYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fczzRw2g; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fczzRw2g"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c01089e8aso1518311cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785445802; x=1786050602; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMLsf+LQaJK9TyVbvhOADIYNpgfmalBwRgJCFWQKWPY=;
        b=fczzRw2g8JaX6smDaTZ1xAWIookwAoR0D/4mwj9qfdsvrT7xHZK7cUCTG/iaRkHggR
         P3+FocISR0RAqycHZjKdHWOKhym2LY4kDNpJitfSn1SLsP0xJldbL6dnOQiOH+Ui8UO0
         0s0iikmvOL5UJp8pwQK+3zogN5R8tgZiWKl76qP7zUMCexyqTjscuP09H47el/A5LOPQ
         bLAyklxxIuDg1PEhhjAUarpxLsz/dzQ2nx+5CRrhHNyoAb765r33FrSBLNFCzRh86N+G
         hs6CfIpW2mf0Oi0YshQ5vbz8SdmW0ePcRjHnZpBqKUUGsXip8dYktnA8REVJHQrMq9lN
         Y3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785445802; x=1786050602;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMLsf+LQaJK9TyVbvhOADIYNpgfmalBwRgJCFWQKWPY=;
        b=f95c0q2WUq54F2teU0F4d2pAkQa5YaMtpoqeaUWNr4NpZycUDBut9j2wvae4yxmS9w
         dNgQroFxVVwMmBdIGxhDyWH2X8oSZt8yXWTiTAN/LdnM+eb3gHw9FJ2ETLIb4NB+6R4e
         0ZlXsCfRET5SJxkebiSSC6fP1KQHfe42crJNU9WFvH/hbA7lryAK3HgaEkytNJEuC0fi
         Blwt0/f9baIYhP3DNu3vknQ58QNEtYAS8d29TswvqmLz0+aYQ1szitB86sT3casrO2JN
         UiDFQNv4DKVHReiN2qNgT2Xw2ISGmIcCrhZi34xcjB1hAiN+M65ku+NE4FvjZoQls183
         82hg==
X-Forwarded-Encrypted: i=1; AHgh+RotIhrNmCAQolda6bNz26iwYucy2WHwcnLPzmRU7RBJ8J7QsBYOPYPIxUf/69qG/7W5sRvQoaya/C2jDblE@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9Qi2nxgZQi8/Z5zNCKWkxxs7utupa3jYxTVuiBEb64vCj0gJ
	cFzIx7qs6i2PdOxFcJS+PTp1rJMNDNcrzKYiaE9gtsRQrXFyH7AFSk3AUEW5KnuNQw==
X-Gm-Gg: AR+sD11ejrVNvIz3Z0efBjT45++zQPLKZKElCKMEEAY13szH6zen6Q6sieBDybU2BOV
	QeTrcdNV87E+DQGRsdLgowU3g1WMu24yBwiOuTY9E60JAs9jyNYc+WQ34Hz9pOZaKr1cKbCl1SM
	CKcSnoRuEQT91pM7sGab3eWJgWbf9Y4a2j95GwswAFUmtTYv6NnejdC8DiqMvHv/+tRma22E1eZ
	LVBkhmK1ImgKzzjeJxBxOYADu7BV6jNChz1VwraKvEHetZDVTXeR69MO1SxIYKLP/LmwbYyPipv
	+MGGMSX0Plf2E9+jLF57TSLDgNH68HI2Or8nhtKYoJ1AkrL5PmADxaUHjZtomvzb5EPsXXrMNPt
	m57APwRkVMxbEUXfdVHgzhjeQekkLR4VuJP+XwgMbBghcezY0cILhdbmtC/vlaAqfQZbXnj4EMt
	eaCTKuRVet62YZc7buQ4WWIVb7FadqJ9+3PYmpqQLsPsy8Xh0+P/oi+bF5//9x6AtGKOzbob/fo
	cmAdjTzPzSnOUt2H7+vORB+OW/WWK34CM/X2FsewnLB
X-Received: by 2002:ac8:7e81:0:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52b3836970emr48411021cf.5.1785445802045;
        Thu, 30 Jul 2026 14:10:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9083fdbc35fsm1954776d6.24.2026.07.30.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:10:00 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:10:00 -0400
Message-ID: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260729_1758/pstg-lib:20260730_1437/pstg-pwork:20260729_1758
From: Paul Moore <paul@paul-moore.com>
To: Carlos Llamas <cmllamas@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
References: <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>

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
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..09a12eb8652c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (rc)
>  		return rc;
>  
> +	if (!selinux_initialized() ||
> +	    !(sbsec->flags & SBLABEL_MNT))
> +		return -EOPNOTSUPP;

If we're moving this check, we should probably just move it to right
after we assign 'sbsec' at the top of the function.  The calls to
inode_mode_to_security() and selinux_determine_inode_label() aren't
doing anything useful in either the !selinux_initialized() or !SBLABEL_MNT
cases so let's avoid the unnecessary work.

>  	/* Possibly defer initialization to selinux_complete_init. */
>  	if (sbsec->flags & SE_SBINITIALIZED) {
>  		struct inode_security_struct *isec = selinux_inode(inode);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = LABEL_INITIALIZED;
>  	}
>  
> -	if (!selinux_initialized() ||
> -	    !(sbsec->flags & SBLABEL_MNT))
> -		return -EOPNOTSUPP;
> -
>  	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>  	if (xattr) {
>  		rc = security_sid_to_context_force(newsid,
> -- 
> 2.55.0.508.g3f0d502094-goog

--
paul-moore.com
