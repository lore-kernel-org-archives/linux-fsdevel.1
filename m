Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399730F7FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109364; cv=none; b=E2M2UPgQqhfVFW8SbPPz12QhcE2iXpMAwjQkSrr/MAozg7QWXtTf/hWSzK/pL8Qr+RXqW3BCbmtEbzimS19Pi8K5jyWFX63Lrr3k1svPTRLnE0oxazaIIPfbiJKlWCuInzFoHsTd49LG5P2sGkXXCTrSiR8alDvRMqQ4QKdtEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109364; c=relaxed/simple;
	bh=5qF/vs72KBtna1aV3rs4NbQuGzDEr4hxwsxEq426ZqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orZKxDZCuc7BgWO14YgF4v8893ygBSowI1fjxnC1H1RDB3C24q36mdwYAqHo5TShaPlY/3O4lTqHQKqCf2Md/nb+jhxdUUipI1iDTtNU/GcK7DB+hWYwffHJYwq1TKF7ShS33S8HLVrQBw5KM9DZFidwEw/A+qmwxgBSjSU5dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VeBYTpJK; arc=none smtp.client-ip=95.215.58.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VeBYTpJK"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5qF/vs72KBtna1aV3rs4NbQuGzDEr4hxwsxEq426ZqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787109360; v=1; x=1787714160;
 b=VeBYTpJKXIx20O62DhA+jw+OtPFWz2TdY3wmC3NAB9KCKOq4Tqg4oVtvmbWjYhuU76RY3G+l
 oYxvfL9lPejeLq0KQ6v0yGLn2XUAW6MmiKkW5DdPyD23TAZj9c6fDxVEijJ4OY9n+nNwYLeFVSg
 w8zrIV0XOpA8ALq3aMa1KDp0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: from [192.168.111.29] (223.70.160.239)
	by smtp.migadu.com with ESMTPS id bd93802a235b321d;
	Wed, 19 Aug 2026 03:16:00 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <9a92b4c9-ad33-492a-b206-2b0862585c64@linux.dev>
Date: Wed, 19 Aug 2026 11:15:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/oom_kill, proc: replace magic number 1000 with
 OOM_SCORE_ADJ_MAX
To: Song Hu <husong@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, liuye@kylinos.cn,
 mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev
References: <20260811033609.3992348-1-ye.liu@linux.dev>
 <20260818010433.65169-1-husong@kylinos.cn>
Content-Language: en-US
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260818010433.65169-1-husong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/18 09:04, Song Hu 写道:
> On 2026/8/11 11:36, Ye Liu wrote:
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -230,7 +230,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>>  	task_unlock(p);
>>
>>  	/* Normalize to oom_score_adj units */
>> -	adj *= totalpages / 1000;
>> +	adj *= totalpages / OOM_SCORE_ADJ_MAX;
> 
> One thing this line hides: for a memcg OOM, totalpages is
> mem_cgroup_get_max(), which can be below 1000 pages when the
> container limit is under 4M.  The division then yields 0, the whole
> oom_score_adj contribution goes away, and a task protected with
> -997 scores the same as a best-effort task with 1000.  The -1000
> exemption is checked separately above and still works.
> 
> DIV_ROUND_UP(totalpages, OOM_SCORE_ADJ_MAX) would preserve the adj
> weighting for small limits and change nothing meaningful for large
> ones.  This is an edge case, so probably fine to leave as is -
> noting it here since the line is being touched anyway.

Good catch. Yes, the truncation for totalpages < 1000 is real, 
but as you noted, it's an existing edge case. I'll keep this patch 
as a mechanical replacement and won't address it here. Out of curiosity,
are sub-4MB memcg limits actually used in practice? 

-- 
Thanks,
Ye Liu

