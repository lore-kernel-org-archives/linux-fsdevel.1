Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D2238D54;
	Fri, 20 Mar 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031430; cv=none; b=Tr8qX3frFI6/TsOzPqU5fvgeYZn74QhbU3bGpZ71E65ugh7KrgPUneUVeiX8hlFWXmhERh3yaz44FgrlZpBi2d/W9cKkT4IeXd0NtdXnUZJoyHi2+RfCNErdebmFsCvg/Y/XK7Riqy6ooYfCd7mUxh1K7L8VhkFcgDRr/kZZORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031430; c=relaxed/simple;
	bh=BXhrPTMp5SAW5SFj+5dGmJxJe5K3FM9zsd/MS4hRC1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIxndyKwzxIxB9jctUQLX0LeLW+xrWoALGTldo2VqKLOJT6aF1uVQrH/zjQQbi8LufalIF19TA6s2gwLkwDEIKq5W5eH/2UNpsssZDOVWAkr+dRSedRAkyMsR7+kBd0CFxgms6rQAP+9ihkdGbn0QAKprv9q8sT/ud3C5J3SRN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyoFQLzR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyoFQLzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2880FC4AF63;
	Fri, 20 Mar 2026 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774031430;
	bh=BXhrPTMp5SAW5SFj+5dGmJxJe5K3FM9zsd/MS4hRC1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyoFQLzRa292e71WXP7IHk08Y+QIu2Bm2zJBSnHe1eSVC247P6as7AUqVwKJqVU8A
	 xT/KsiOLgO0zmWZwlJPKuYouVk7rfVa+owphMvJnXlEAzZ1faMdLPnxw7di/ppzWPF
	 YGMLbjfvKzp1tYD52JtCkaV+PvGDIM1svDhSWm22GyLvDxJC2SvRAe3admvxVRS0LH
	 CA6KXOPuweTxa2TxkLFdNh2JefnbBWk2ZjN6fWf3WmrWV/BHF26habtBoymOsaNsdm
	 /3KXA2cBo7Z2Tkk/n+lDtXWO/GGfapSz5wobeL9+7mW0K46eK3i2KaM53Up5EOR365
	 7obDXP1wrci1w==
Date: Fri, 20 Mar 2026 11:30:29 -0700
From: Kees Cook <kees@kernel.org>
To: Marc Buerg <buermarc@googlemail.com>
Cc: Joel Granados <joel.granados@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Octavian Purdila <opurdila@ixiacom.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Elias Oezcan <elias.rw2@gmail.com>,
	Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Message-ID: <202603201128.E07B1E0332@keescook>
References: <20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com>

On Thu, Mar 19, 2026 at 11:50:50PM +0100, Marc Buerg wrote:
> proc_do_large_bitmap() does not initialize variable c, which is expected
> to be set to a trailing character by proc_get_long().
> 
> However, proc_get_long() only sets c when the input buffer contains a
> trailing character after the parsed value.
> 
> If c is not initialized it may happen to contain a '-'. If this is the
> case proc_do_large_bitmap() expects to be able to parse a second part of
> the input buffer. If there is no second part an unjustified -EINVAL will
> be returned.
> 
> Add check that left is non-zero before checking c, as proc_get_long()
> ensures that the passed left is non-zero, if a trailing character
> exists.
> 
> ---

Please don't include "---" as a separator here: we want to keep your
entire commit log (including the SoB and other tags).

Also, I think the explicit zero-init of 'c' would be nice to keep just
for robustness: the compiler can elide it if it decides it's a duplicate
store. There's only upside to including it.

-Kees

> When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
> possible to receive an -EINVAL for a valid value.
> 
> This happens due to a check of a potentially uninitialized variable in
> the proc_do_large_bitmap() function, namely char c. To trigger this
> behavior the variable has to contain the later explicitly checked '-'
> char by chance.
> 
> In proc_do_large_bitmap() it is expected that the variable might be
> filled by the proc_get_long() function with the trailing character of
> the given input. But only if a trailing character exists within the
> passed size of the buffer.
> 
> If no trailing character is present we still do a c == '-' check. If the
> uninitialized variable contains this char the function continues
> parsing. It will now set err to -EINVAL in the next proc_get_long()
> call, as there is nothing more to parse.
> 
> proc_do_large_bitmap() passes left to the proc_get_long() call. left
> will only be non-zero, if a trailing character has been written.
> Therefore, checking that left is non-zero before accessing c fixes this
> problem.
> 
> The problem will only arise sporadically, as the variable must contain
> '-' by chance. On the affected system CONFIG_INIT_STACK_NONE=y was
> enabled. Further, when enabling eBPF tracing to dump contents of the
> stack the issue disappeared.
> 
> Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
> Signed-off-by: Marc Buerg <buermarc@googlemail.com>
> Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes in v3:
> - Add Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> - Re-include bug context into cover letter
> - Link to v2: https://lore.kernel.org/r/20260317-fix-uninitialized-variable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com
> 
> Changes in v2:
> - Drop initialization of c to 0
> - Include checking that left is non-zero before checking against c
> - Link to v1: https://lore.kernel.org/r/20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9d3a666ffde1..dd337a63da41 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1171,7 +1171,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
>  				left--;
>  			}
>  
> -			if (c == '-') {
> +			if (left && c == '-') {
>  				err = proc_get_long(&p, &left, &val_b,
>  						     &neg, tr_b, sizeof(tr_b),
>  						     &c);
> 
> ---
> base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5
> 
> Best regards,
> -- 
> buermarc <buermarc@googlemail.com>
> 

-- 
Kees Cook
