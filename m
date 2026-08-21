Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB048CD78
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312840; cv=none; b=pU2VVbO9ySChdEZXoxRj/6KDZrldTW1LBnHMuwesMZp4YvmecJIUtbzCaDbGIJLEfhnxBZBQfhaRXHeDfPH0K52EmT88YfQUUKTx3MXF5ncJRH2Zu866SD9S6/hw8y+DbEB1B4TGdXFn86fngJe6lxO67V60xmzT/ySHEXXztIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312840; c=relaxed/simple;
	bh=1Me8J4kaERw5skMupjCtaNu8jrQLXOoLTO3x3rD2P80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umueAIw1XtunP5RyFFUqhWALI6mKoQBakLzkZeLgrv2ipnI10289UFRtbPnyd5nHjimH//dlA9Xp1McvfzO0MIlJMibBZVDLnDtISP85byBouvez9EEiWD6re5zlntyqIWntus8gXdggZAilCWdwwznt3wz5d1GPfOXliUk/lfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=FT6wv1JU; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FT6wv1JU"
X-KPN-MessageId: e0887a5e-9d55-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e0887a5e-9d55-11f1-861c-005056aba152;
	Fri, 21 Aug 2026 13:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=yFPmgGHt8SfwvN/uEXqWH/wUz0hJJxpKPqJOuk3pBBM=;
	b=FT6wv1JU6jQOf5bV++m8gzkkrFKXwb19IJ2LLFJJBSkHg6fo6QZPr/atwQOA2U3Gc/JRbyEPgBFmx
	 v+3vDDX3os3EBiCVrm5SvSDk6GHqU3UP2n+l0PnF/fPzssVg+pJ4b2UmAawi5AIgKAJl6bbsTrRyw8
	 Q9Vz8iPOzJBx8or66RWB/inyQtAzthl2KS85B740TQ3QOlB1AmjKWuMSJ5pra1vhuskR3uYLaja+0Y
	 kkEQzwTToLiECc4CC0Ut35dRnZgnp1of+SowzEf+Eum6ToNdkDYGA5fv6Fig+k6A2WdvHoWS0i8A4w
	 flrh9eH4qCCvVallyLooNYQEQsrzE5Q==
X-KPN-MID: 33|ilEge/h7m+/Q9upzrozFqztLXqy78Hd2ih5BIJCdjBaiAYzReanRBYnKVtch47B
 ejkS4yT9QE1WkDtKF6cBKjcv46OaiHcYjCL2addabmSU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Q0wP+J6rG6V1Xcmg6XTyqcjJZlrLvJ4+shaI9oPmFiccw69ASds7LUtEE1TGXUm
 yAxT+hnTa5XNQO/cyMcmLHA==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e061f711-9d55-11f1-bd1e-005056abf0db;
	Fri, 21 Aug 2026 13:45:58 +0200 (CEST)
Date: Fri, 21 Aug 2026 13:45:59 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: reject PT_LOAD with filesz larger than
 memsz
Message-ID: <aog5Kx6HB3jxb8cJ@lt-jori.localdomain>
References: <20260820222824.3165092-3-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820222824.3165092-3-Jeremy.Jean@oss.cyber.gouv.fr>

On Thu, Aug 20, 2026 at 10:28:26PM +0000, Jérémy Jean wrote:
> The ELF specification requires p_filesz to be no larger than p_memsz for
> PT_LOAD segments.
> 
> elf_fdpic_map_file_constdisp_on_uclinux() sizes its contiguous allocation
> from p_memsz, then read_code() copies p_filesz bytes into it. A malformed
> segment can therefore copy file contents past the allocation on NOMMU
> systems. The direct-mmap path also subtracts p_filesz from p_memsz without
> first validating the relationship.
> 
> Validate every PT_LOAD immediately after fetching the program headers.
> This covers both executable and interpreter headers before
> begin_new_exec() makes execution irreversible.
> 
> On RV32 NOMMU, an ET_DYN with an 8192-byte p_filesz and 4096-byte p_memsz
> copied a marker from the second file page past its one-page mapping.
> After this change execve() rejects it with -EINVAL, while an 8192/8192
> control still executes.
> 
> The flaw dates back to the driver's introduction in the pre-git history
> tree introduced in v2.6.11 by 91808d6ebe39 ("[PATCH] FRV: Add FDPIC ELF
> binary format driver").

I came across this about a month ago. But I wonder if this is even worth
fixing. You are on a non-MMU system, so running a malicious ELF kinda
means gameover anyhow, doesn't it?

> 
> Assisted-by: Codex:gpt-5

You are allowed to use LLM assistance, but the commit message also reads
like AI, so I am a bit worried whether you actually understand the
change you are proposing. Afaik, this is still required.

> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  fs/binfmt_elf_fdpic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 068c46875c74..e8a6e89b76a0 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -157,6 +157,12 @@ static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
>  	if (unlikely(retval != size))
>  		return retval < 0 ? retval : -ENOEXEC;
>  
> +	phdr = params->phdrs;
> +	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
> +		if (phdr->p_type == PT_LOAD && phdr->p_filesz > phdr->p_memsz)
> +			return -EINVAL;
> +	}
> +
>  	/* determine stack size for this binary */
>  	phdr = params->phdrs;
>  	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
> -- 
> 2.47.3
> 
