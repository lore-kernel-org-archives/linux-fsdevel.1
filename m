Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0E4570FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821123; cv=pass; b=VGwsu/D/y/u89ZfwBGZ+2zso1FRGoKgI5CVLyNWTK+5Os+35QD9q88He5PZsIByldIG8s9bglBI42VUF6vnmRveCC1B+MBdw63y0ncnP6vJsJO55rtgE1ofewpQ3p8OPJfB43qbBgoIGq4PXnyD1nsG/mjZCFV3qFoswmr62Yug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821123; c=relaxed/simple;
	bh=0L6BTG4czRYdQ6EfwGUAWi2A2+4jjv2ECjLUnPT3t78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+VVabICNO0IVcKILztYT4zlkE+MPteLZmdrLVS8GGnofh8H2HMDyFalYRN0bhovlLkIVlx6oQQiuBgnSNmleh1FnaIzx6aXXJIRyhgRCcWFtgOjaltIVRhbmtJlopk5UVWmc8wZ/6wBdYV6iLAxp1eiTz7YzWR8pfTdW9Ds5o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=st67UNQS; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st67UNQS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so871486f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 08:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821120; cv=none;
        d=google.com; s=arc-20260327;
        b=lZGfesIbzvBX12sRZMck14ZnfXWwCmgCs03o4VmvNrIzj6/B/+vBH0l7AzS8vbTQEK
         xrbfR7UI1e7pra4fZibiPu1Kw/8GsFCjo+5LiJLlc9jwK8tTtqTQrOfPB1AXz8zXzOGv
         r5cFYh8tylekV33Q/WBnNxDI6nEnV5WqffDNAnMpnQYn5HrQry9GgU6ncedHRuVXJ8bt
         DkUbXj1HgJcQNkSdQkhzePEmqGiXbjf8iYK4UEci/ve5NnRJ/mTTFneUuxQBh0B0Mjtc
         KWNpR7sUWKUPQ4fSZBVCMj9e4pIuQr4OZhAMDiPvHRoM8vr8Lf4UcrwjKXivzjrTzJCg
         4U3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0L6BTG4czRYdQ6EfwGUAWi2A2+4jjv2ECjLUnPT3t78=;
        fh=9o1wnBaYUxCmRLXe/iEQ5nGZzZYqpxEIc7VwImvhU5I=;
        b=fDa2679w0tobBzpDFTzWrWw+5SQZ3jIG+5LuJCwJTZvKq9C4tWL6K+/XvVFas5iqEB
         VmECfMw6ah6VBibPGVqkiJ8H+g0Ktd2xV2/Zk5rMD0ICOYMinQxDvfDZmUfqMXD1GU6m
         l1X4chfOfS+xGGEmr5CufhvaDToukOAJgY+J87eO3LmM6wn6eq8sHVUbCj7RzOUEaDBT
         EPAIvB/PHLj+nn4wAU3D+dhoXoVU0xC+SuzGLZjSOWQJrItAq7r9O6UsgZwZ68q/q37A
         uHbQrBf7Dbz4eSOZu6NQI500UwfYoYC9FG6kig3da6BvqmODdXn767qAirNSRK+Gxzmk
         J4HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821120; x=1785425920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0L6BTG4czRYdQ6EfwGUAWi2A2+4jjv2ECjLUnPT3t78=;
        b=st67UNQS/8r6rmiU+YUvwtlJvzpFQn7x8WMSetMvwkJwOMueKK5hIWeZuGZc2/QO02
         gwEl/Fy0YiYVF/fhOooqWvh5H2ujnEB00CFzC1U7dyvhmzh3G1jZ6pIn7gOEsJbBWRzn
         CfZLfby6qw4n8k9aXLV3FyM6a6Pl2f/xJSEacInlkj42pKtv9+YE8Zjm3U2Vx98o1YdM
         8BHkJosJiFgx6QdW4E/jiFgqPCfu1jmdKAl7kGvz6P17U0RL55ufV7LjZGlmIfe335gn
         hCwxGMj+6IlXQ3HXuzTTWPZytiJFGyIJISd7WxgHLbkhBNmpSPPks6AdqxViin/CrV67
         Gpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821120; x=1785425920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L6BTG4czRYdQ6EfwGUAWi2A2+4jjv2ECjLUnPT3t78=;
        b=W5o6Kn2LD0sjgHMVWolNvACa9NTN4kFMlii+p6S/CEC4PSOZ+0shIes0UtwKsLFNMg
         EAF3TFVxlp9ZVM8imm18wV84wgork9jyu9FS5nZeKN5MAREqezBzZipzgkBg5vT3jrwk
         tF0My1FOf7cM/V40WQeI1A/YW4jHn/vPX4fUJDYFReUhEReLDpb9Z6ZpqemrxxW9BBYS
         1E0g0sa9MD//iDaqYK8CtKROYZ6vayrQJvMq3J28OaXCYid+QA5PW/7vF+jSrepeIOzv
         BSN9yyiGtI4+Lfn/mJbWLBB6Q9rTt1PQWrxr2UD4KCEjOhyJgWYJqR6S9trcHzy4eLJ0
         oCHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrknskKNbghV7Kl2tdDcPz39lm/qmcWTD0NenZ4rc21g2KquVZELfIurxJbzfoPZOPxg6zkP1xVOqTXU0RT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7wIKxbbcVEcg0Kku24tSDEgfMWSlbPN3z0/iC3QiRIixAbaP
	nYDmiZDkiQ2+gQyZJfmGVhRSvtOm2rMxW8CcpzZ4BA/LvjdWZ/4Kx8PzAeQAHOav7Q7WNvXTxPW
	kR5+8H6XH59MJ2ylN//6Q/ZoaDGwrA/A=
X-Gm-Gg: AR+sD12iwDOnJBFyL7o0r54zxaOCM6INkVhU0S3KqaIvzCixuVve7lqTtH3NSUWY7pS
	QhbkAskVO2VDuqxhcaiYkffhFW9fSBTPNnNVtGgkfWx+LvrX5KDXSOKmPF4K0lX27z8xN5WYISy
	24DX+dekqR0P4vhC28u9fuUl0v7W9QlcMCP/Sxj7zA35hZZdXffNAhxnn2v+ef8+pqMmMZItHxj
	1VYmVSWw12HfyS3MXYOEKOg4ZH/cAdW0sKAZKhIIZrAfOQMH0Y7NZEMpK7vwN7k2Y06OFeU3q73
	TjVr4pWmgJyIK0nTWw==
X-Received: by 2002:a05:6000:38f:b0:47f:6fa4:58e0 with SMTP id
 ffacd0b85a97d-47f8dc8cf80mr4468005f8f.35.1784821119603; Thu, 23 Jul 2026
 08:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
 <amIZp7Ual_6Gu86T@cmpxchg.org>
In-Reply-To: <amIZp7Ual_6Gu86T@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 23 Jul 2026 08:38:26 -0700
X-Gm-Features: AUfX_mwHQ3blZ7P6gvbmhVAOte3aZtlO1MRJXjAm_VmD80Tv4wDddJ9EXfV6VAY
Message-ID: <CAKEwX=MxufM5aNw2xW0f1UcyfcCJbtXR_u3cK+coRaC+_bLspg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Yosry Ahmed <yosry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 6:39=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sat, Jul 18, 2026 at 11:36:39AM +0200, Alexandre Ghiti wrote:
>
> I just chatted with Alexandre off-list, but this path does not store
> an eviction shadow like the reclaim path does. That means no refaults
> are detected from dropbehind pages, which can fundamentally alter
> reclaim decisions, zswap shrinker force, and pressure detection.

I think it's a zswap shrinker bug even before this patch. When we
allocate a new buffer for the writeback request and add to swap cache,
we erase the old shadow :(

I had a patch sometimes ago to fix this - basically, what it did is
when we allocate the buffer for writeback and add it to swap cache, we
save the existing shadow and hand that shadow to zswap. zswap will
store it in the zswap tree tree (in place of the struct zswap entry
that is being freed).

Now you will have to juggle it a bit in various path:

1. swapin has to check the zswap tree for refault.

2. remove_mapping does not create a new shadow, but instead restore
the zswap's owned shadow, if there is one.

3. zswap operations have to now handle shadows stored in its trees too.

I think there is one edge case where we still lose the old shadow (I
need to check), but the rest seems to work.

It's a bit complex, yes, but I managed to find more uses for this
added complexity too. With this, I was able to add more monitoring to
zswap shrinker - you can track how many shadows are being stored in
the zswap tree, which gives you a per-cgroup counter of inflight zswap
buffers. This helps with diagnosing when zswap writeback is generating
too much memory pressure with these buffers. You can also use this
counter it for zswap writeback heuristics (for instance, throttle
writeback when there are too many inflight buffers already and we're
not freeing them fast enough).

I have not had the chance to make it upstream-ready, given all of my
attention being taken away by vswap and other endeavors, and the fact
that swap architecture has changed quite a bit.
