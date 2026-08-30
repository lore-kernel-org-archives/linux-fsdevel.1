Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4814A32;
	Sun, 30 Aug 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788059592; cv=none; b=KunSkxUWFNFuB35ct/Yau34hHF4hAZ0FMijNYPBu9ZD666rVNIATI45H3LiS9sbKP8j+O/0HUgdm6rciyzDhOwGmSGD/vKKYobQ4lZYNPKRa62wHggzJkARvhXlw89sduAkF2+vEE3l8iTVdLoGdrhZmZkzHhxBcPp5HFKue4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788059592; c=relaxed/simple;
	bh=Jt42XwCKxrCWdlTrphsUA99K1wgfWWSHZk5UM+P2aw8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BcUG4jyYAz6AZubCo9nTg33h7IMF9MzJ/xVr2AAvvMkXtlC2H3/yBu61kZ2dsPIMcY3Ctx9VEwWLXaKHE1p9uWgOwbG38nDiZLpQul1b9Ur6dU4iiApbvly31TPe1Rif3kGtgEaEaYVbpWJ45OzrIbsrOVkL1hrzyaYnTiv7PlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oLJ8t3tU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oLJ8t3tU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5A51F000E9;
	Sun, 30 Aug 2026 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788059590;
	bh=4hJJJOup+wIKIbKGSzexaljQV4pEOoVPh3Fa3fwUWmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oLJ8t3tUEgYSbjbEH9J/2AuVNTaOnRHH7ymkB5tvYAspfhvx/Qzhbaryl4IEYOSg7
	 QvxmIT26hMnQD67CKvm9JDtBvRY1bkt3Lhr9Ky9SgIO3DA9uxx4FUnYkUYXgyPX05K
	 y0T+/a0ipoOAQnU5MyQwYFwjx+k/hFSdb+6dtIzE=
Date: Sat, 29 Aug 2026 20:13:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Ye Liu <liuye@kylinos.cn>, David
 Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] mm/oom_kill, proc: replace magic number 1000 with
 OOM_SCORE_ADJ_MAX
Message-Id: <20260829201310.648ed330984b91b1c135d8a3@linux-foundation.org>
In-Reply-To: <20260811033609.3992348-1-ye.liu@linux.dev>
References: <20260811033609.3992348-1-ye.liu@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 11:36:08 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> In oom_badness() and proc_oom_score(), the oom_score_adj normalization
> uses a hardcoded 1000, which is the value of OOM_SCORE_ADJ_MAX defined
> in include/uapi/linux/oom.h.  Other code in the kernel (e.g.
> fs/proc/base.c oom_adj handling) already uses OOM_SCORE_ADJ_MAX for
> the same purpose.
> 
> Replace the magic number with the macro for consistency and
> readability.  No functional change.
> 
> ...
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -594,7 +594,8 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
>  	 * exporting for a long time so userspace might depend on it.
>  	 */
>  	if (badness != LONG_MIN)
> -		points = (1000 + badness * 1000 / (long)totalpages) * 2 / 3;
> +		points = (OOM_SCORE_ADJ_MAX +
> +			  badness * OOM_SCORE_ADJ_MAX / (long)totalpages) * 2 / 3;
>  
>  	seq_printf(m, "%lu\n", points);
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5f372f6e26fa..08bff7a55db8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -230,7 +230,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>  	task_unlock(p);
>  
>  	/* Normalize to oom_score_adj units */
> -	adj *= totalpages / 1000;
> +	adj *= totalpages / OOM_SCORE_ADJ_MAX;
>  	points += adj;
>  
>  	return points;

AI review suggests that this is a misinterpretation of "1000"?

	https://sashiko.dev/#/patchset/20260811033609.3992348-1-ye.liu@linux.dev
