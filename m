Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044D4071DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489060; cv=none; b=iaJsKuLt1H/uDI80Uv8eP8BECfBVrgZ0Wir87/U783u+By9Vqg4M3x/NCqpKn7vwNlGfNbGPeyMtpXplcoigUXbXaohZMofZx/D6G+YBdOywKTy7aC1ucvnTTOpMYDmNUIuaNn5t4Gl2l/wxw/Zp4Dx3kaLir0mCyjct2elBkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489060; c=relaxed/simple;
	bh=cJFv5mLfQ+9Fzjda7I53xSLIzgCeDtC5OhcBV6QuJ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egFfKoGNBLpJcQHjud07u1ZVZutBu26Z7+GPsSGQtixeC4Lc0p/fwstTegkmRTifTVcpAFZRlf26t0fQsblMTohmBAufdh1Wbq1Gs4ZiyY+tv4Y8OtWxTDhmg2PxWv9JJk38ppGrZppomnEneUerIjIW0pbvQsNDL7McaxIYmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=fS188pRZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="fS188pRZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93a10f9a2easo94271885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1789489056; x=1790093856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXoaSOzLcSniPHeJqnrgZd+b23tx7/MvhGFOoQXutdY=;
        b=fS188pRZsdThyEpLvlNZN99q+hwl3CD+Kr2Wcvt/OecrNMB6fo474ehP2cESjPm/GR
         ruEMIrrjiBE5+BG/jlseEmTdlx9lOKKM9IAPmrK/sdqftum3P1otF9eO0XhT2ITE9d/o
         KC2XYTJutZa5vsEHhm69/g4W7CH9TesEMUU9dsBndWo0W8RaY/r4g49ULSc6SpQ1M34V
         FpgwcjBi+gujZZJny/7+PkxWQy/tZWYRWAVo6hpzF4P/tDKoAKUe9tdOzHuvcIB0LF0E
         YGHtdrmbl89RPPk2qN4bPBZvcO/iMoYthZo/+vkJW9VEfehRrtCfcOFcehK7mW1C1YT6
         RkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489056; x=1790093856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXoaSOzLcSniPHeJqnrgZd+b23tx7/MvhGFOoQXutdY=;
        b=u3oBKymSmdIABrMuAJBuY5CtjKMSszCSfnvfRrWgZ9G1ORJPHtwE8/sllaDWucoL2Q
         UIzHDaZj0TDzfMrptLgmw811VcTX97bCUPQmt5ZPAI2AG/unchSBfZFxtAmgK/+3KJXl
         RTsh7HYNjOFaIQoEl0OTXGE6+SytbkdtwGY2LFObGug9o9F2ydSnKE8h+RD2C130gpTK
         xziDvp7w31oE99FI0nhPfdJgyC28f8PDESvSSAV4PT8h/5PL10zxqyG93r4Gs3WMRLhN
         hQzBzycDxDab/D+P7rfq9whYVBQGrQru80ZckMyv7tnGNk8o1DI6lpEKDC6RG/M5ufPb
         2Hhw==
X-Forwarded-Encrypted: i=1; AKwUvBzQAC7Uu+qx/q/k59MEdChCPFM/QZVt3Ym54d5wq0IQqbutDCrpZTz64leKF+MhMZUnR7aHYzV9ni7Bo61j@vger.kernel.org
X-Gm-Message-State: AFuF++nNy0hMzul5YvkG7IYNF2iQneqbea8HoHa/GIkTGkwcG7+D7Mds
	sywBIqRFLdiNC/7GYg1Mh+KXpjLw5oaTeCbpzHxMTSeaLoIG47ypIQ/+pyZks5+EJag=
X-Gm-Gg: AYBFou1evVa3NCcZ7o3mK1CUsvc59Y2eJMscMsQ3KBLBNjL8yBnAt9BM4AOaEW+6+Lc
	kfkBd5ytMzcurJc11HAxEBs1JD11lvnPpyzvBQqBt6T0Ktr5zkW5PpsCd82664j2E11X5UXzHpV
	ArPWA78bk4IIIys6iWxLUnzq1vEOSjJ/77zeIBzunN/IUSP8ymAkDgBM4SIatDCoTRpaQL1gTF1
	JOWK3VrjW1tCiLgRtn38mjLQETnysAwZxQcZXZ+OKIWPjT7SItWe6jUZdpuvlUuuvLc+KI7yKOx
	v9RCw5xotaZT+jY5SSFjW0e8OOlXlytVBCUL+5HGSSpPcyYtJzPJRQdG6eMS3sf4WJRjV7VGEPS
	wwH4nWb4DDvzZbeaI0f+sZonltnW/O9Ui27f/gHTTdGEz8mQUg+9Hg3jng9yUuvP6AEN9ff0Y3o
	DZOs145U2BPmQUNKrpnd/kVDUgwN15LHOCaD/nYzewtUeqFaJZHhtn2KZcRxPvZLX9DFsWDw==
X-Received: by 2002:a05:620a:2607:b0:939:b7f4:c7dd with SMTP id af79cd13be357-93a3477ff9cmr603922085a.47.1789489055702;
        Tue, 15 Sep 2026 09:17:35 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bddd5e1sm2362876d6.3.2026.09.15.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:17:35 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:17:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: akpm@linux-foundation.org, abuehaze@amazon.com, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org, brendan.jackman@linux.dev,
	david@redhat.com, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, hch@infradead.org, hch@lst.de,
	jackmanb@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, vbabka@suse.cz, willy@infradead.org,
	ziy@nvidia.com
Subject: Re: [PATCH v5] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <aqlvnm8AKp5f_UhG@cmpxchg.org>
References: <20260911093209.d9181d5950778897935f6bcb@linux-foundation.org>
 <20260915160042.1265958-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915160042.1265958-1-dipiets@amazon.it>

On Tue, Sep 15, 2026 at 04:00:42PM +0000, Salvatore Dipietro wrote:
> 
> On Fri, 11 Sep 2026 09:32:00 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > does any of this look real?
> 
> The mechanism seems real, but it only shows up with vm.defrag_mode=1,
> which is off by default.
> 
> With defrag_mode=1, a costly __GFP_NORETRY allocation that used to fail
> cleanly can now succeed by fragmenting another migratetype's pageblock,
> which seems like the wrong trade for a caller whose premise is a cheap
> lower-order fallback. Johannes, do we want to keep it strict?

Yes, avoiding the fallback is a good idea. The user already
communicated they can handle failure and have fallback options.

> If so, we could add a condition like below. It is equally
> applicable to v4 and v5. Happy to send it separately or in v6.
> 
> 	/*
> 	 * Reclaim/compaction cannot run, so defrag_mode's strategy
> 	 * of enforcing ALLOC_NOFRAGMENT cannot be fulfilled. Allow
> 	 * fallbacks rather than failing the allocation outright.
> 	 * Not for costly __GFP_NORETRY: those have a cheap lower
> 	 * order fallback, so failing beats fragmenting.
> 	 */
> 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT) &&
> 	    !(costly_order && (gfp_mask & __GFP_NORETRY)) &&

It would be possible to remove the costly_order gate here and just
bail on __GFP_NORETRY. But no strong feelings.
