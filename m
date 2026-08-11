Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F342FCB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453104; cv=none; b=nNrWFV8gqETzzSWHAN+eS8gecZwW45nz0rrPo0tpKbIfQJz1ysZVgzjO7FSxeHrgJa4bCMGI/YaITqIjwAPBraKpSQKNRNIIJifCPnhVN12t8HGkCAVvz6hefF0PgZsfrHr8KqNlE9HydYOVUuDtgQVhTOg0IjHdYyZfE5YFrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453104; c=relaxed/simple;
	bh=JS1/e3NtMBcOe49UexsetxgejmOuLNrBnRooyabTsJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIQEZYWjAQ9CY1/RffPnXcftFeQHo/n1VqyQSHE+casgqSLAF/9PeOq/GbWjS/bGwVaAG0Ggi5ik0MO2pJ3qDu7TFf/3hZ+jQTHkYDzaHxuSkZmdY2FuTq4PrM9ygCHTdP0yahPXm/0YtXjSkG9uVmOq+mIIrfccRsptm+SdqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yj1CKiSk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yj1CKiSk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so17211575e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786453101; x=1787057901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wadoVsDULYZYXWQe9At0Wixp1lsixD+0O8hIBiY/5QA=;
        b=Yj1CKiSkpv5GHWZuelmXs/kKq+9bGIXQ6UHDM/Feyhy5LM7CA/DLo4DQRFPEKzlmuu
         +dmby/6aYbcZNKwcDVQiPyGGh+QwhQtAAQykKnTp+yOYfw/gftPxfnpZepJ6TbkXiEgs
         PAFb3wE8DJDhE21Vuy4VpqHPEOtuj/AnzQZ4XdNLE/TJiNPFBmPWjXjsqnMVJu7vzsrl
         2GkMcETyDtJ4LGBhNe8VfYWac/3IGumQx7JnG05Leavfu67Epzp0SzqTNUm+LMOPfknL
         T/QVRPUXFwuoZO4pravHj/maRo6eKMyMtm2HueLIDcsD1VebR+M75JIf9Zspx2LCLRKm
         +T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786453101; x=1787057901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wadoVsDULYZYXWQe9At0Wixp1lsixD+0O8hIBiY/5QA=;
        b=UzF84z+7fOJZSty8VGCVRIzvzjrbdew1FdvbS9tLIYAIFXg4cnXG8RsKiC/aAzUzHB
         66U3587nS+dlJv/RqQDdmGjY5RHs//c/VBilmx7QASeJIk208cyur73WVUwqd5OVRgAK
         lMKC938mEIEvZ9ekmQtWS2UaD/6ONGd3BbUBSSYu/KpJoog+GAfYUtaX9RLqlRxRM22C
         HRhdyNmoTIJIK84/0i1TWbz8G9+aC3rEQUCwwkpfIjsrfJZWi3eOFzYeFhKXnwT0VxeO
         h+/xxzgGuepS8358U2CrvpNx57hvTNvG/3IReEr9taarP3eqhNsitIQrpqsdvNbpZ/j9
         5JQw==
X-Forwarded-Encrypted: i=1; AHgh+RrhAp0VKZc2mpF8X8+pk7WsBehcO+jBiSH3Rxv77d3QTToKaQNX5MLHBfG6gSxUXui6+aeiZv0QuhDvuyHC@vger.kernel.org
X-Gm-Message-State: AOJu0YxkG+MmngoS3U4NlOPq4LwqLNKX3iM6nCu6etCKtnJu/iIJozcr
	NzhlD2DBLKVFrjxZ7WBkZ9RtyDdi5SR27zknqOIGvxEyOYgm10i5M67rarZDAM/Cu5n5ppwY2kh
	kSU7Qwc8=
X-Gm-Gg: AR+sD1287XijkN8oTp8i+EntygkYyjPRYwtwm7qFM0rOE+/DVPzLZWRK4UB12LwntPw
	C98LrCyDb0Jur2kzzO7Ykzqd3XNIJihPz1aLfrpLFK+Rm3dtLgBBU/E7ZcjoVQMb900SimHsHVB
	QnqvbHIr6GU0RZF8cHPOYaXWMI9shpTe/2NI5cBCbrPSmAhYpRC2TrmQ8L1o5qKpIewMG2FZVyq
	Z0pRiI/aRJiMixTlX7MRMBboT35ZFWsjTSYOl9G8JMowqNub0dyZkLk0bW6J4bEZY8Cs40eis1/
	uiM0c4LfgjgL7yG+L4ckfF8SRrITGNsUYNWBZIZfyszt2voFczNRpv3ElaijZLP6L0joFzZRU+a
	IrJXg8+6pR/CeBj8uDEG/2tzRXjqm79L2cvmP5qMwK1xcApAq7orSgjTac3zdfnNzokHOfKon5K
	/SnQLm6IONB0GTDt160gzVl30rO9dX8cNWg4i/SXQGJk4J1ZRyjdiCIz+2b35AV/gCuStAl5w=
X-Received: by 2002:a05:600c:3114:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4997844f628mr47773285e9.12.1786453101143;
        Tue, 11 Aug 2026 05:58:21 -0700 (PDT)
Received: from localhost (109-81-91-46.rct.o2.cz. [109.81.91.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788fd9a4sm53399135e9.12.2026.08.11.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:58:20 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:58:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/oom_kill, proc: replace magic number 1000 with
 OOM_SCORE_ADJ_MAX
Message-ID: <ansca1TVAXul9lMK@tiehlicka>
References: <20260811033609.3992348-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811033609.3992348-1-ye.liu@linux.dev>

On Tue 11-08-26 11:36:08, Ye Liu wrote:
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
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

I am not really sure this adds to the readability much TBH but no
fundamental objections from me.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/proc/base.c | 3 ++-
>  mm/oom_kill.c  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6a39de424f62..58be38942460 100644
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
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
