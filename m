Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724602;
	b=G2cxKhgJBGwmstmAG29vW57W2IvV+JM6ltLmyFdu3yxgCskT+In8W1t/o5Xq5wx404xn
	 k59ABgpVpkdINK6uSIXnJ8GZsPSpDbLMQa6JTNWTMS/gp6NeUy26PQx9kwXrz45ehB+WF
	 Uk9UvhVuLbG/a58qC/qAvVPlJuR4bMqY+6+jNJSUH0sqH3NG72EDX6OwJbmNlbwOK37bK
	 0p+I8dwZlnbt/yG9g1H3wb8Q0VlJKS9Jp9qU6AVqK6bZw3teNPIfkwAGU+2EVHyA338Be
	 qDFRrc4b9iVCdjZvoXiOD5poWgOv0pMTeD+DdmnezTlknwD7noBS8D+MCy8SZf9Zc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nwNmT3+N2K6C+WQBtWD0mcJtZx8RSgDfIN1Kq5hD7g4=;
	b=x92g6SjBIwj2T3mvHcQHYp84mSARWHJfKJRmjuCeVuyj35huvgckBZpB/D6t4uA3i6rI
	 QOiwvJfR49R32NIwWB2VLkpuOnikBd6l8l+WPMObxTzQOk0oQeYI7k7LI92MTiqiDSdFR
	 yNIGcTTdpZF6tTfi0r5GHP5FDJIvMm03GPhpWZqFZzU6JZ7/KHRNJf48JV+iGhw4Gvu/Q
	 t3gd6XRa5hPaZLXEwBGy+g31tt8kI5mKLKe5Ga8c0GcSOEB5ArUAaJPrsnllFtAFTPiZ3
	 bKkHsXVA1XjeF7tH9DRI7Woi3qeMvMJKe62QgMaheFHMsBfPzgnUQoC49J57JG0r7lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywB1p9iP;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B178606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 20:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B178606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywB1p9iP
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49412eb1474so4857017f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724601; x=1796329401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwNmT3+N2K6C+WQBtWD0mcJtZx8RSgDfIN1Kq5hD7g4=;
        b=ywB1p9iPdGEmqVZlkXKOggU5r1cO44C0Wi0MdMKxLdnecPUPgaerI5xVKkpNtv7nnO
         4DM2RT2c4FO2eYnhgZvBT6hJfJ9XWZQqXyaHhuSYwvNo/2g+sZDEsrJpu2DkMlFGC1nP
         B4tYXQApvotMYA4u/iKyWF2HTeYCDeYuzVgM7LQo9y+5qrFykHDB9/RRzS2IAajn5W7F
         DlFcBX1D9ptI0E3SJCVe7esdLI5zV8ekdGIKqmPuyO5hwLAPyBVDqSxCzbh1+qojhimM
         +srEKo82XpEU3CEFwh1cP67/yK4kPYhznK3LHYXTF9VZxBaa3FIck8oGpj7BxlBEWlkA
         5R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724601; x=1796329401;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwNmT3+N2K6C+WQBtWD0mcJtZx8RSgDfIN1Kq5hD7g4=;
        b=nOemrRJCMiAwfYcR3lKuWiXpETedRyEAT5VeC5aVBcFtTtgc7/DxeMUqRdVk7RpFKe
         8Qf0BR7acUG6j8/KTxPob5jqhT0YVKHBJ53eyMUQfSV1bnZGuaMZl7M0S5rFog49CJGu
         kE0jLcxEnUW1Qju2YAUjwSvMN8g01IRRu9u1vUuY4naIrj/WHrjIlpas4muiuRd6AMgq
         3uROA3pQKodngGbGhc37ukjjFS4oLFWrF5DsQ1+PIV7jzDnBPLgUOZAwmZglZVaXJquj
         XgadJ9k+BlrhpqtkBU0I/I68nFm9EDnCg/tMAy8sV9M7RreD/ULRiGMXwjIzwbtElNLW
         curA==
X-Forwarded-Encrypted: i=1; AL+hErE0HSzgz7PfYjN16C2J87o9WUQ76W/1kOEi8lT2euwExJGq1dvekdOmbGxWdnfbiD7raf7RhPrKzcGD7F7h@vger.kernel.org
X-Gm-Message-State: APuU4Z9KRTfCeUHszcPxUqj44ZPs86QhU2Vr8ByLdQWOFz4uCRxeDEk2
	/h4n/oT8+8aY6L1QKe2a9iD7hjfWH55Y7Z/h+6wW91CXD2GGYjDc831C
X-Gm-Gg: AZFdTZcVd593thqkedGhlzPMHrmT4czkt49chk5hRRmvOG35VWAkazt7n8OcoJrfYnY
	8fFZtQ327OX6ktEpxW4q2bbdFSvn82r0cXHJnMp1DrOXWYidbNlc87lxiuBDz10NN2PRh3bvg36
	qIHCzPul0ZvMzQC4buFlnXpxTV1kbfM9mMaFu3IYjGslvEy07XBv6qQR563EH7ETMIJUYCsJWud
	CcGbm4rr4ceZ1KHFsJdDQBeeGVjE83RYFO3E7wBWTUEKWl1S6EVvNms6paZPdWwemW3XY9DbY3P
	mtfwSPghXjlyjWDV6vyJDjmfI8WWSyjpW/8uuwKG16zqFmgtv/E94HKTmE5XHzao1oe8UB+q041
	v53vZEhSpvf3x657SIXeEPbmK9HvhhGIbWajwGyrcXwpAY7Y5tpQGzeYp8I/vOL5mdKjPDipWKk
	H8LDa+wNIH3hIGMZv/pq1ieQJdXe2uGKph5XQOrNUxGsnhOGKaJVx/hRL6bwxTMctK1t+7rtVBE
	qtlr3W7ZKvyIM3hquOvp8aOjTO8tbfhUFzyVaWaRDpHf5Ta4HCsz+/hGfnMXwEt9Bp3VqUXzchS
	KRCvTJjft2wQd/ZKCjp7awovgK8enHVAFJWgOjFzdjfCNw==
X-Received: by 2002:a05:6000:2586:b0:4b7:760c:70db with SMTP id ffacd0b85a97d-4b7760c713cmr19227429f8f.4.1795724600577;
        Thu, 26 Nov 2026 12:23:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm43021525f8f.50.2026.11.26.12.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:23:20 -0800 (PST)
Message-ID: <c5bc383d-fd32-455a-b946-e5f232c7fdf3@gmail.com>
Date: Thu, 26 Nov 2026 21:23:18 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/khugepaged: allocate page tables before locking
 the folio
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-2-azpijr@gmail.com>
 <042ab922-4707-4c96-80a2-83a0378646d1@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <042ab922-4707-4c96-80a2-83a0378646d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 5:24 PM, David Hildenbrand (Arm) wrote:
> On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
>> try_collapse_pte_mapped_thp() calls set_huge_pmd() with the folio
>> locked. set_huge_pmd() allocates the missing p4d/pud/pmd tables there,
>> and on ppc64 with the hash MMU do_set_pmd() also allocates the page
>> table to deposit.
>>
>> Allocating with __GFP_FS while holding a folio lock can deadlock in
>> reclaim. For example, memcg reclaim on cgroup v1 waits for writeback
>> that may be waiting for the folio lock we hold.
>>
>> Allocate these page tables before locking the folio. The mmap lock
>> keeps the upper levels around, and an unused deposit table is freed
>> after unlocking the folio.
>>
>> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
>> Fixes: f8a01513f574 ("mm/khugepaged: do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>>  mm/khugepaged.c | 79 +++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 56 insertions(+), 23 deletions(-)
>>
> 
> That's a lot of churn for a corner case (powerpc with hash MMU).
> 
> What about simply running in NOFS context when allcoating that page table?
> 
> Apparently pte_alloc_one() doesn't consume GFP flags ... but we could add NOFS
> around the allocation.
> 
> Any reason you went for this more complicated solution?
> 

no reason, it was just the solution I came up with. I'll rework it with
NOFS then, it's a lot less churn.

-- 
cheers,
jose a. p-a
