Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66D5B21A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088854; cv=none; b=hkiRI/JX2wwcatqLO709/NKadiKNHHfR47h1xfCL2bp7Sbq/dxM2aND72JIckKxj+P7O9yRBQbXXWPPruaqRNBMPhuWN3TsCKo3GKq5Odx1KYgkxLktsSYs4AcQk6NChe3sS02DTBzcN1fJg/ua/eNHtisgwpiv2XesuHQ8J+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088854; c=relaxed/simple;
	bh=avzpMIpWk8G0UsinOiaW/I+zSHwJiOsnpz63IET9gm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKo5YztG5Phw4IiXx1LsmFsX14QRDeb1/jqH5uQR5wwCsmFAO2VfQujZj1ydnYvL/FSN1AJsrA1y7Ltk46ckBClIgPuI0TAsUTRKr/GgeZX0rmmROwOhaAM3Uw952+++y/+mOwET9KsPt24/1r6VpLBzvHVrc5adl3YwQJesCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF3W6/jt; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF3W6/jt"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66bee06ff74so639000d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787088852; x=1787693652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3sDmUeEbcal2gxd06G7R/9k1xkDLSkoYHHtzuG733R4=;
        b=kF3W6/jtJwvv4A0H6CNDc2vwexeyPGmkzPlmKMXuLoLpQh/DyCrEcWXJqQfu/Ty1dh
         RJZF2DJvF4X0+kbqJN7bEGy+A0cm9HDKJOHD/CGbhpsVBZ5sQWXkFFXP7X/LIYUPSlEX
         jHsZxiHyMuup2x96l1R33XK3s8pH2xWrbxkQ7Npts+qabNAuoPxaXglnbJs+oT7g2Xjm
         Un11fCY4a0Drnj6Vk1ZiegGjLhDm7M9lPDPHy8ZT4bzbF5c3R+cOMJfNsZlXFACYgI/f
         wK+ThaZzLvlgguNvVXuAxIg1vvTV/mwPe/BW+iMj9qf8OZkRBazuKDdy7cvcxjLQrwsD
         siwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787088852; x=1787693652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sDmUeEbcal2gxd06G7R/9k1xkDLSkoYHHtzuG733R4=;
        b=QG/LeQyaPmtQOxLGL+jKT1gcryKqMHa3zGhjH/S9WO9RxrFODks76dwAqMANemQxSi
         uuBPCk4JclIbQLfxj72kzOwwY64/eCU1MIJM4Nx7D22IL/jDfCY2xZ9+Rl/MO+w3ehP5
         sTkeetrzSyzRfDCBipwGE6cXQGQ3CSegH6gvhoixyuDVAo19SRaMDPEsSXXzyQnvMshn
         rsWFtl37rZgAFMGkomYx9al4huxyeyjbmwHqMTbDJoNzbUXWhfqlBlNgX45gx3Be1IG/
         HbdbZVq57pd+m9pPIKIHfiDKDDYWbBW06gcnEsEmno0qJLtmXcUy4p6Is+Ov5EQXtDOT
         BsNw==
X-Forwarded-Encrypted: i=1; AHgh+RpVvzZgoUpz6NrvNHFQKs/KPrAXz43Ucp0XAb7wo5lh3BodFUimIkgHAygUY/D5GSYdwd/p2pGCdF3Ie5y/@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1FgLDUQF3PWrYGWkHHhXGFjOOGmkXO4Rh5fC9edVqg4025yo
	164ZQI7lbzYbr16UWuSiFCvn+kor98Uw1D9/QY3aK44hpS0nn7eMap7i
X-Gm-Gg: AR+sD12XDI2wbv27Ov2B0JZcqvMK8dNh3lrysUZ9W640v3WUhB7nqTeOAgr8Rd8X4lM
	ti+piKI7XL44dVAjyctPYNWohjJyNmvnDdwCCT1DWnG8HXHQ9kWgr//k+954C9SmH9sFBAMIM5z
	vVLXBrRCFNLl15mcrz9j7XSnEwJpQ7VVzBFI2WDvSaNSsaiwF2wkmDiMCMD5VgLPoe/WOJBNWkC
	ejEQawYv7l58rfdDu8HeNuKUOKgi4ofmTyv7y0nzTOUiQf/Fj4xu8e3BOchFKeNJmMiJHkMKomX
	zbyMw78LF3wSZbRN7uZLuogVR0kdcuETJXxj7qAtilSuUf2jOovR2rx/uCaIYE4rAS5mPgwjiXj
	eWz6WlFDxMQAZAMChr1cYII8uDgB7mS7ruU/Gvw6VgtaO4toXP2ozTh88kIWUd86q5B/rEBRmMT
	SGbJj5Y27tiDlcwsRWK3P8hERlaYF2aB7feBN+O3EYemu/IzM9H4bXfDWzP6oR82xiM76BG9QNt
	Il13+M4xY4glYlm5G2amCI=
X-Received: by 2002:a53:e911:0:b0:668:9b6a:653b with SMTP id 956f58d0204a3-66ccb537d3amr50318d50.3.1787088851823;
        Tue, 18 Aug 2026 14:34:11 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:5ffe:d5c9:845d:50b5])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb19e096sm52049d50.19.2026.08.18.14.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:34:11 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:34:10 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, david@kernel.org, 
	eddyz87@gmail.com, kpsingh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matt@bobrowski.net, memxor@gmail.com, 
	song@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for
 linux_binprm
Message-ID: <aoTMu0_CNLyLGh45@zenbox>
References: <any3wCj66dWbwgwT@zenbox>
 <20260818082441.4091-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818082441.4091-1-tasos.papagiannnis@gmail.com>

On Tue, Aug 18, 2026 at 11:24:41AM +0300, Anastasios Papagiannis wrote:
> Thanks for the review!
> 
> > Would it be better to handle that case transparently rather than
> > requiring introducing a new kfunc / leaving that gap open for NOMMU?
> 
> > Either return an error or perform the copy from bprm->page[].
> 
> > Unless there's some reason I'm not seeing.
> 
> My understanding is that there is currently no way to use these kfuncs
> on a NOMMU system. Although CONFIG_BPF_LSM does not directly depend on
> CONFIG_MMU, as far as I can tell, no current NOMMU architecture provides
> the required support to use them. For this reason even if I write that
> code, this cannot be tested.
> 
> > It would also be better for portability across NOMMU / CONFIG_MMU
> > systems (the exisiting kfunc is never registered, so a program using it
> > would be rejected rather than able to handle the error).
> 
> As you suggested, I would propose to register those kfuncs
> unconditionally, move the ifdefs inside those kfuncs, in the case
> of NOMMU return an error (e.g. -EOPNOTSUPP) and allow the programs to
> handle those.
> 
> Does this sound reasonable?
>
Yes that does. It's a small niche anyway (I don't think a lot of people
are using BPF and NOMMU anyway, and BPF_LSM && !MMU is unsatisfiable
unless RISC-V or some other architecture gets JIT support in nommu)

And when/if (big if) it does, they wouldn't even need this kfunc and could
bpf_probe_read_kernel() bprm->page[] directly.

So an error is best. 

Justin
> Thanks,
> Anastasios
