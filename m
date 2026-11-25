Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605131;
	b=u7ERYqbttW5vEl+UPpB20RR3HmGreT8H51pZsr48W3CBitmNQPKWq/24xFQEgH6GA04o
	 Pi/HPuugcJnyqNfzlMjM1wsKZp8TNv1SUU8YmoQNe98OqQcfpUEcoUWy1JW2TiERUlDn3
	 QqsInHYVoIsGRg2IGp/peXBDOFZJV9raUg+IAZf9kjdSDqRZH3tclEeGIcOR43m8RPmf9
	 +V1g2ei3Sufc21ZN6ZBkhv9L/oMCIhf+itbPYdmsbN5dXAzeKeiRqqVTjKWWo2z5unfcJ
	 ZDiCoj+AvdlQlP/ZLnyvwfAPWIcEnL1I6Pm9YG0CilLhGfWWUuoQJdtY3e4Oc9Parlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cO/MJUe6DrmL4p32qaNL83dldbBryQjDhwfZKwkiD1Q=;
	b=3Ul9w/naDQivQ/hHenQYy1biNgJ6J4c7KfXSh4URzosX1Pfd5tP5A/2Q7q6yUJcWx8Qs
	 XOS2ArTD6hw/EYTKF2d9ksVlf6yzkcAD1UFOdvNxfQbpxk9Grjyhq7d5wl6E2KtFDRN+b
	 lhsplqS6mmhHERhvTcXpWxOrrjlPlg5Dz6OCQ/X7jVGHjbUYJQgLGbMsbgbWtYEJzuGKC
	 Yfz/q/JezFkVXO958zabuBXJDC8BYaVF+g1emKFq6E59ZqVESPhPh9cQvo4uQRnhWR6Mx
	 D7PLz1ZpIc82wLbwYfvpDmCt4fq8/ZD6TeST1Uy1zwzPj0ewPgvoBvuGOm6DilbI1kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnbEVzJj;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EB606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnbEVzJj
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so57720475e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605130; x=1796209930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cO/MJUe6DrmL4p32qaNL83dldbBryQjDhwfZKwkiD1Q=;
        b=QnbEVzJjYRe/AzphwY+E9dvTy8aFSuuCm8LK4GbCNDfreXhHWXwk1VAEzxiw5HxOwA
         OJnpz7KMfUHOFeoMIyABqLyzB+QRBxc3MNZoBfUnVgWy6dKGo/gaa509pVG/zt+/ICkb
         9ZBvA/ESPfVDbyhaWgqulMk1gFYxgHE5GcvOQ4jJ04FvmqDv657zR6jj0JAoF42ZjhZI
         x6Bwu7EcuYxGPrY+btCRUaOiAjEOF0jq+QzLQYintnAOkz2shvu15coU7jJmcgq0AgVq
         IO8CFfSSXgEmQPY6TZZnhdUbKZ9OX9Vzbjs0zaz2XCE0bnkHReahLby6Ys7y0GTK7pyN
         cc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605130; x=1796209930;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cO/MJUe6DrmL4p32qaNL83dldbBryQjDhwfZKwkiD1Q=;
        b=NRxmP0J0IoG08v7rHlQFBTuizpt+vitI/U3t6LYlElshp4I/Y+z/rQa7LgvUhnSjYd
         BY0f9u3ucIyZZJtg6qrSMDoa4mD0RMYD/Iwt2yqAzgqoX/Wa0f5ybUcRRPvYFutJ3ZCj
         2/pISzbykap+BOLVy2P+YyKQ1YwDSvSNnz3lFbrIolBrnlvBPHaYsX++IbKuPzQeM4wT
         XfCRkVj33/rTW3B27+44ZKjUoPDsYB/Aa184dPX1bbm/3lHH9uMnl51Citl601UuczcQ
         r34d64qjnWAOyu2jpMrPSeUlMgQuiPy3MVa+LY526doW12K2gQCx0OAbDlCUc3qirE42
         ODhg==
X-Forwarded-Encrypted: i=1; AL+hErHK1uXMztAqQjM4WGQNtLf9q3RrIdg5+Eg/4jcp8oSzesbgosC7x0SY6BMJPwfJiOEcj9B5uXfHAA1CKQM/@vger.kernel.org
X-Gm-Message-State: APuU4Z8bycLfVemnYtS/+iqdpnytkw5hLj48+bPoMr/sCRkcw3Pu/Ce3
	PtAjMl9jwV3RYwXtStNrkvLE2gQOrWAivTUqxg8/cdeHqVJAsVm+7m/0
X-Gm-Gg: AZFdTZfxf9FS1iTO2g48xY3eZmptEOugqsne/pyvtjCv4cfe2WNmDF8vPQlvzWRmtRA
	qJ9Haj7FboVTQ1sY8MusNpX4QotcnyOpBWzR/fuYVX9/xiuqH5pGiJwTtw/zPiyYX9SjiM25uy5
	rSGChl4speOz/Vi85kr2PxAbO9uA1Xs3UChkpGIydCVEIMMuGD0jc4fsu0bhw/Ki/uLfMtjjevU
	VybNHTQQEngwx5DWvbfZYXBx3tzSj+Mcrr+zYXMAbLWrtcj/6vg04Ss+Zmh+2T4SXMMaXBFi7pc
	D/sCIc3kCkfVEJsojEiWRdbXupO2XSmuEc7sBks/1Z/pS+f1Z3awC5VAoC8cr7p25BWukKjEfx4
	zSsNaoQu2G2r7K3QkRlMcAgbyDnHIHvXyWI/0/LyERufqW4EqxyWGndSuqSTpmkUYYeMPFksR4Y
	aEwZmNYovXdrV6BrwQHEshFUgKF7xYv2U+YFkfeRZHeIWIrrmsRYN+5XrEt0zicBZcxJtJi5XY5
	QWtyAVbiad6ptKoLxAXm6SaOsUakhwdNNu+N/CGxhtaLYNjQ2ciAAqYBALOFeSQQWns1Sikk/Qd
	UCix+NYSiuyV+1TGc8GiCOYq
X-Received: by 2002:a05:600c:8906:b0:4bb:a60e:a316 with SMTP id 5b1f17b1804b1-4bba60ea355mr25237275e9.12.1795605129542;
        Wed, 25 Nov 2026 03:12:09 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm802287835e9.14.2026.11.25.03.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:12:09 -0800 (PST)
Message-ID: <66fd4450-6e17-4a1c-be76-38758a62073a@gmail.com>
Date: Wed, 25 Nov 2026 12:12:06 +0100
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
Subject: Re: [PATCH 4/4] mm/khugepaged: use NOFS while collapse_file() holds
 folio locks
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
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-5-azpijr@gmail.com>
 <8c60bed8-6857-4361-91b5-c8fed8a083c3@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <8c60bed8-6857-4361-91b5-c8fed8a083c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 11:55 AM, David Hildenbrand (Arm) wrote:
> On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
>> collapse_file() keeps the folios it collapses locked until it is done.
>> With those locks held, it calls filemap_release_folio() with GFP_KERNEL,
>> and for shmem it swaps folios in with the mapping gfp, which includes
>> __GFP_FS.
>>
>> As when splitting folios, allocating with __GFP_FS while holding folio
>> locks can deadlock in direct reclaim or compaction, and __GFP_FS also
>> lets filemap_release_folio() wait on the filesystem.
> How is that possible with my fixes?
> 

it isn't, sorry. I'll drop 4/4.

-- 
cheers,
jose a. p-a
