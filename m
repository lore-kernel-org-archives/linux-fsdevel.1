Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F97304BB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122058; cv=none; b=Vd6Ui9uAM6tlMFIZckh2rvR7/gdvhlAsM0yRjvPOCeJMN2t3TMTccxsgd1QmxXVLixRz6Ouq6akLVJ5ZKVJWiYyid2JfVPxmdiStJ9FBhxkjnv1keHVu4CyTlhvEhv/90DF+B7zc277X5FQ4+JOQaGWPQlvGCZ94AyA+Y5HtE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122058; c=relaxed/simple;
	bh=tKflbt8K9D5B+Ptk+13mBs1s4BzQwkr8d/j7q+DGvLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd4Hv1/8if1J9t/k/g7IkS2WAOACaT0ZeuuPES6XTp9558e5TFojSW4pWlu2HT9ujpful9Jv1aDmleNLKfldVmeOq7drZxmlwr09Yj59zwr8NPp/N50CUnfWqiH5TOwfYByL0Nr0lsNqxR7bO39I3TRlMhv6l/3FrfLKC5Ov22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SrnkIEo9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SrnkIEo9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so5646595e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787122055; x=1787726855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4WjkvsBQ0E8wD5Ds/jh+ZodB+Y3e1a9vvF6PPHb0eo=;
        b=SrnkIEo9Fh+JHXmhNcBvP/n9kMg7l8PjpxfLd/T2DJe1g5QKs1NtDSLB5pPqC9MIlL
         y4opi5Fsn8Hc4bIBomZ0WA9UvwvyQ/J7qBe6wVvbvS59VtmFf0iRBcnwLJadEaPizaFx
         IzRbXLrNF4a53Y/Tsa9rkDpoORknyJWbrn2m7+j/3EvoZjFqWzbJZAw7q7sDemupHkQn
         dBIGyK2/i7sRl1wDL+rntFUnjIVD4AwrJSDnrbTS3sqFvfg3oYDsFCiEkj4+2CusVRnt
         Pq2uOXlWp/ZfaqcfntMs+ePR1lEbjAOxKO81glTtKFIHYSEu6d1AKZe7gqdQR3Xp+i7L
         r0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122055; x=1787726855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h4WjkvsBQ0E8wD5Ds/jh+ZodB+Y3e1a9vvF6PPHb0eo=;
        b=ZOFYKnxCI7F3vwmyM3EpPXKuyWH9TPgifewYJn346rdec4mbJCiOrIC3YkJLsJiDs1
         cDS4FE0JPKkHUBeenmDyDQFCdVZJdGBE4mgMcHKrVhAn29bwvVqKFUY9s45T0DvfWrG/
         oc58UK7U4gX9lr/rr0PIl1uLsA7bnEp8QP/elwRVIsLtK/NbgHS7fxYy5e9xbPvbx3em
         ixQmfoRwNvsng3w+IfluFmPq5+vrfNR8YTd7QU6nT5YNf4RmDrzwV9eN+OkbtWZfH8aW
         F4S2K/nvAnyX3Gf+5R5OQHeMq+CmAux0J+e/hhFYm6aQNO0GPQ0rSB2Dhxy99Vxkkauw
         VKrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFiegX8L8cC7U8ZETSYmOjwfaP/yPCOmmE4EpaneECsB/kjispgrOjqLkBMx26dxmHNB40oY/kvi/tYVxl@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlnnXbO12rYvOmho1DANfhTGSzwipXHAHP/O9QioZ/2Z+tCDx
	8lCIZqCCIHr0dElMcUA7l0I5mnsUWDqYSJrZlc+uAsJ777g6tmSQv0l2ethEwfwmuAH2V3Nwy2A
	2F7RwMvw=
X-Gm-Gg: AR+sD117vp6pvZUafF8fj5T7+wPbMI4FF/M9yeIHupZJ1bJ0J62kOm4T84TIuSgzzvf
	Yrkuuqj5CoXwMg0/Onw6b8NLiDLW38upSKvWHYTSkB1ceIVmdeMC8V4jcvaluxI98zAhkNObAQs
	cx9AoG2XiB63sR8xGB784F1GI632yJX/kaL5GFbQdnM7bm/lO/2+ap7wQPm3pAb+eAHAnIldNkd
	EGjzP/DMcLaQNx0OicZfr3qUz5c2vRxm81YfLrmhbUzhmu/9p96nfIRb12U3cUdMShM58weKlOR
	vufyQG6trGhyjoDYlc3ImnBMWoEqAn5T4QSGl9eoFyiA1+oXRjIsftCJ6PoL5v04A6slm5sFOCz
	q+XhuZ8EAV45E/jYn+S0IpYCt6xJmWq6PI4gsYWWZ0xl6thB7N9o0DWBceKDxR38V2kbVQR2hOV
	IgRFEpwNYz/od1D+GG8OYbQ9W8Si7hEdJvg2Ol8hw40b1aLnIbHigVXsOa+w5DK0l+fpX3LPYNA
	w==
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-499aa14a6a6mr39006955e9.3.1787122055272;
        Tue, 18 Aug 2026 23:47:35 -0700 (PDT)
Received: from localhost (109-81-87-166.rct.o2.cz. [109.81.87.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9dff4c1sm28169295e9.3.2026.08.18.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:47:34 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:47:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Song Hu <husong@kylinos.cn>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liuye@kylinos.cn, rientjes@google.com,
	shakeel.butt@linux.dev
Subject: Re: [PATCH] mm/oom_kill, proc: replace magic number 1000 with
 OOM_SCORE_ADJ_MAX
Message-ID: <aoVRhVaG1vxyNAZG@tiehlicka>
References: <20260811033609.3992348-1-ye.liu@linux.dev>
 <20260818010433.65169-1-husong@kylinos.cn>
 <9a92b4c9-ad33-492a-b206-2b0862585c64@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a92b4c9-ad33-492a-b206-2b0862585c64@linux.dev>

On Wed 19-08-26 11:15:52, Ye Liu wrote:
> 
> 
> 在 2026/8/18 09:04, Song Hu 写道:
> > On 2026/8/11 11:36, Ye Liu wrote:
> >> --- a/mm/oom_kill.c
> >> +++ b/mm/oom_kill.c
> >> @@ -230,7 +230,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
> >>  	task_unlock(p);
> >>
> >>  	/* Normalize to oom_score_adj units */
> >> -	adj *= totalpages / 1000;
> >> +	adj *= totalpages / OOM_SCORE_ADJ_MAX;
> > 
> > One thing this line hides: for a memcg OOM, totalpages is
> > mem_cgroup_get_max(), which can be below 1000 pages when the
> > container limit is under 4M.  The division then yields 0, the whole
> > oom_score_adj contribution goes away, and a task protected with
> > -997 scores the same as a best-effort task with 1000.  The -1000
> > exemption is checked separately above and still works.
> > 
> > DIV_ROUND_UP(totalpages, OOM_SCORE_ADJ_MAX) would preserve the adj
> > weighting for small limits and change nothing meaningful for large
> > ones.  This is an edge case, so probably fine to leave as is -
> > noting it here since the line is being touched anyway.
> 
> Good catch. Yes, the truncation for totalpages < 1000 is real, 
> but as you noted, it's an existing edge case. I'll keep this patch 
> as a mechanical replacement and won't address it here. Out of curiosity,
> are sub-4MB memcg limits actually used in practice? 

I have seen containers as small as 20MB and they were suffering from
quite some problems - e.g. charge caching on different leyers. I would
generally discourage people from running containers that small unless
they exactly know what they are doing.
-- 
Michal Hocko
SUSE Labs
