Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029126CE11
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323492; cv=none; b=e0FYlLjUPKmnDkTXMA9a9dNUpUqfgy0+x5Pacf1T1MkC/mlX8n1mHFTgylaUBwitjZVptMwJ28OJf3aABLauJ9lhj57CT1xW0R+aLpx7DxABCKFjr1ZvxW/mSg138+Pb6R2rQMIMzwtVVH1MICb+81iPGFxlA+BAgha+kuk85Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323492; c=relaxed/simple;
	bh=2ilu1jQHox2wTnDUggPiw1YzGE41A4ol+N4ZXaAB6KA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CYp3XOqC3oMLOPECN9ezbrRPPfTRISIev00h1pv875cmTq8hxC4VTWIGxqTNDKtJBbvmb0OUUUfYDLyFihDIlnW9f2cU6h64hIVpYeeFZpIdNRiFTBTAJqu6B/BQyWTA31ZM5c1xD6f9TYItfpNu9mAPXGr5I7QuM4FMx+xBny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk8rrRmP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk8rrRmP"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76af79f029so1067954a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2026 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323490; x=1775928290; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oGf/F8Zl1olrj7LHwmAzkM6a8hyoOTJaO/XdIoQa0M=;
        b=kk8rrRmPpX7wAXHUbZx/ke+qQGAuwWtLhIiRmt5/bjDkrdTaLaP42RRuL8RM9UnR8d
         iRp2ZawRGYlV5yhKaZmcviKkrYAGB4pQSf84bpqtiD5VN+amsk5ARKpN4Sg4e2VhUvEI
         MBb5bz7P6wruAhSAA6Q1ZK0SNt+sAGsfQ+rwp02WiBKP3eBFVA6FNoQ49OquAdamIX2Y
         qcGVIIhbHlf3adsicex7fvdtjycGxax5n0m5XaSGvMNfIsYflUQjl2ly1/dhNIqV9/2Y
         B91W/A7RMtYE8VXS8ME1KD2Ct9/ZoXvU5Plm32bNXhBxwVQeskDJT/1pdAFnLHkO9omW
         a7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323490; x=1775928290;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oGf/F8Zl1olrj7LHwmAzkM6a8hyoOTJaO/XdIoQa0M=;
        b=VhYlin2cmur4/AYccNJ3uTyQJQMDrdEvboEK4gfl+21M4JMFkGWDGu5JOq0zY1HqNr
         rk6hNJRI8woHCRh+Oz1g8d3R02c16CbaOGQEN6snLPYzG8btKlK23gYVQTWxrcgEgiFv
         1nTxUiKG8VJryX6EqUKBb2xi2DpDHY7bkXQ/ivXny1yD1sCKTXUBOsjW8cccwofapwmu
         84y3HKJ8GtKijwKiHTLxBoANrvEYJCQA7OLtcNVi68ZRf2ctL44ciTyH844phOA+MLxa
         5wjcVtis2yptX/nQV9IclPr2xM2eY0zfCw2ePu6nHLXjUQlW7YeCnIyDDetZ+ZbKIcVE
         846A==
X-Forwarded-Encrypted: i=1; AJvYcCUFa0qXVxIHahU4uO6Ss7W2tvQPJJW/rzaVZ3SdBCd9MUrxTsgKR9VsJJxHQ1Gas0GFAjzkhRWBJTGkHThl@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0TBYZQOeKoOOoWeT9wYdycAiXT+88Bl4fxP408DSY+klPfc1
	Xv/OJ8VMl6HAnzpPUoC4AiiO2NtM/0miWSEZyCUzl9MOBQ6c8WhI5tYX
X-Gm-Gg: AeBDietRg2huk2vzb1ATuVwzxDGdTQbUvKNGckqCgPJ167nB6bgK8fUcfLFBLYP5UyT
	uXHWwcpoCEEI+s7weDes2g+sXg1a+rFQkwIf4LkGDrb+hIK427URljpYXkiSuPW/4G/LPucQZgV
	bW5Gk2UfK8ST8bbp44/WYJxn7zXCa9cuhbSZ330kWf3ZHMwPgk2VbY2fbSDGP0Z4V6BDMofx5gS
	X2tGnpzzbGzVBCB/D9XdeKWDglf1YIhJyas0GUI2nSzJpwWqM5u2eNWd+JrZmZTx6MZsLmAtZNV
	VGY043wuSYynXK9TdY3NXZpG+5R0OGx0d2b8EPh8bO9ydG8MWSSfLjV7JE6RMg8dxs9HWQBkFWl
	kQ29ZB41o6WmHlR3MWlLEFnQv8fqo9zTB8a8XYYHTsbN9AcLbL3gQy8e27RXgZTmlfQl/a/gElM
	LpAV03tcpqeYdIfHnBu+QF/A==
X-Received: by 2002:a05:6a20:2454:b0:39b:8dcb:f37d with SMTP id adf61e73a8af0-39f2ee01ce5mr7551700637.17.1775323490281;
        Sat, 04 Apr 2026 10:24:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657e703sm7990160a12.22.2026.04.04.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:24:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de, dipietro.salvatore@gmail.com, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <adCQTF1PQnlbNMO8@casper.infradead.org>
Date: Sat, 04 Apr 2026 22:17:33 +0530
Message-ID: <5x66n04a.ritesh.list@gmail.com>
References: <20260403193535.9970-1-dipiets@amazon.it> <20260403193535.9970-2-dipiets@amazon.it> <adCQTF1PQnlbNMO8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
>> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>> introduced high-order folio allocations in the buffered write
>> path. When memory is fragmented, each failed allocation triggers
>> compaction and drain_all_pages() via __alloc_pages_slowpath(),
>> causing a 0.75x throughput drop on pgbench (simple-update) with 
>> 1024 clients on a 96-vCPU arm64 system.
>> 
>> Strip __GFP_DIRECT_RECLAIM from folio allocations in
>> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
>> making them purely opportunistic.
>
> If you look at __filemap_get_folio_mpol(), that's kind of being tried
> already:
>
>                         if (order > min_order)
>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>
>  * %__GFP_NORETRY: The VM implementation will try only very lightweight
>  * memory direct reclaim to get some memory under memory pressure (thus
>  * it can sleep). It will avoid disruptive actions like OOM killer. The
>  * caller must handle the failure which is quite likely to happen under
>  * heavy memory pressure. The flag is suitable when failure can easily be
>  * handled at small cost, such as reduced throughput.
>
> which, from the description, seemed like the right approach.  So either
> the description or the implementation should be updated, I suppose?
>
> Now, what happens if you change those two lines to:
>
> 			if (order > min_order) {
> 				alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> 				alloc_gfp |= __GFP_NOWARN;
> 			}

Hi Matthew,

Shouldn't we try this instead? This would still allows us to keep
__GFP_NORETRY and hence light weight direct reclaim/compaction for
atleast the non-costly order allocations, right?

 			if (order > min_order) {
				alloc_gfp |= __GFP_NOWARN;
				if (order > PAGE_ALLOC_COSTLY_ORDER)
					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
				else
					alloc_gfp |= __GFP_NORETRY;
			}

-ritesh

>
> Do you recover the performance?
