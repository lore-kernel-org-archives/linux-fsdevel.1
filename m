Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500012;
	b=Myc6oXV11/d1XmRmCtMo5/+8f1dVnzdU6CT4dpjZ935GN9dGiL0sm5qFs1/kEEV7BrQM
	 x+Q0m6Jkv3TMy3cfA11wnO5YquT5hHpi3EikKFT24G2khXonmvZiHHY+CRPX99dzngbjN
	 Vq9zaPnRLofoUq1tppUXy/Mn1fDEDau1DFIACP/nSyStBYTk0lOrqhfHcoEhk6Xgmjq9A
	 JUIhd4nyjTx+zvhc3TYlCqui+AvoaEfWynXC2XV+tN/s/ypu9ZB6YegsfF24K1vC9yEV8
	 8gqG31Ardj7g8ni2ofcYP4LBSEnhJGCI5mpBqhXNCYwOxlMykG4bVAS452dCjqiVhAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/SNlzExwuTi3WbPB+pJy/Rdg9j690l3UVVEipCGae4g=;
	b=XK6RexmqfF27FzQvlS5QFY1mPCL8EMNOhi6KKopvLKzJKNMW1uRQQb0aR0xOPC2WTisI
	 aBPTuvhLfopc7PP2ju/PGjCHH1B+4MELFINlvNv0rY8u0gLCtcpm8WVFx6Ou36PVXDH9N
	 /jXWkAI+b+U0acXAsR6rYsXJ2tD7IAWT6N6yt8ouE9IRmQYDLAM97JsQ/O+baDzJWUDy5
	 FnEhAnygjGpZ0d2i1lZWSk+fEv+FQKkkjx0xCMZ9XD1gxF25gMx0kziINzZdcwWwPu+Bn
	 Ww7RpUdukQRpU9w5nv5+V34NgUIZSu1cp6QozTb8XjQekJWRJm564ouPoyTmo81pToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b="mscvbfX/";
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E7606A32E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60E7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=mscvbfX/
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67be9601f48so400856d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1794500010; x=1795104810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SNlzExwuTi3WbPB+pJy/Rdg9j690l3UVVEipCGae4g=;
        b=mscvbfX/np19cXZfqf03A5JubaZGcQnOdRPEso5ZtATeXHb8C7Bvj23mu7X64g/EN3
         QwAOJlPBVZukq6OpcBrzGmArUgoPeZw2Vt5kYDbU9kFGnmdIW4tgN52NieHN6bY0yI/Y
         8qGXx3lM5/s/FVRkcsAVaU/y70hq1jAH4meA7Z2HjyH023lPYtWE7cG6D4uT4QYoVLru
         9atHvOkISWTpFFYJHw2yLsCEH7KhKFFPJjGjGQiKyY/8mITUKqDsFHtqUfiHayOrFGpy
         HCBf4ccp+/B91i7vol6oNv5MfCIBqxSriklzVvFsQegtN3eVRHj0VXbRiRFTlwXd784N
         RshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500011; x=1795104811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SNlzExwuTi3WbPB+pJy/Rdg9j690l3UVVEipCGae4g=;
        b=sl+R+yhyzB3rK/mH9zwfr8Bs7wANiTAcnW7QkAIEKvKSfJ/7WWKndr6ghSqUQvrHjq
         w0uLSkq6njsucvNvE375ao/kW7ZvaIQ6vVW7ofQxMVUHum25n3ybN7tWgl4oIzgquwY1
         Gcrr8fWtRJ4e41tsZmiNDNAyWpM70w8Zs4jJyF6oskhuUj8KqGDcjC0zPHZ8uVp0PXN9
         vs2LHP6JwCMGFW6qAaFj0yI+YOedRnofwfvpcG/gQJND00TmId/jcW7d9elPqO8KiC/+
         yA3k59fmoEIwu1dmtEAaNQ5HtI5IgVtIWJGBui8m2QgHCBDmj82uqxEXrGpDvgkOkHl6
         G9OQ==
X-Forwarded-Encrypted: i=1; AL+hErFBwYQ++FmjTowNKf0+HtVbWFiW7GKFbhX/fSS54ipFtILiHwrEph9KNjGWLwAVPCa2nd/zEMDJWbzJYT3I@vger.kernel.org
X-Gm-Message-State: APuU4Z9Bk48PAp9w5X0csGuGKKcgdDlItX6YcPRUyZxCvbaZgqizMXne
	EJ1Y2WP72qcDn2QQUROx55Fa/zK4ID+wDNWivplh+vPwczyISzYbi4rBdUfCOeV+CHY=
X-Gm-Gg: AYBFou3nZ9k+trTvSRHhJmUIhvU7q+GRqfKOVta5pVyQnrQrdVA4RWFgUsZ3ESx3cp5
	IG70SwFd1p/krE6oQm5IaA2aCk+CfIiXMQmBpw3BIILwwOBOZ8VkV4QWak2gYqmZWKNE/f0LMT1
	3Lssm7ATp3gY37JrBf9iA8AxT86a8JAmpy4LHBbwZF9MRO96RiYUaqRe3hInMo5M8P1KxMueiSH
	Isu1fQePMPCY0tPzNsnJsIV2oKVx/DZmL1ubysXXF3oEF6yOt6pm69Drsf4i1zgbPAbxeGPkQ67
	faD52SXHR4OBDYofusOAlt845NBmRspdOFBDostDBCFpsrTfvXmj8pCaJ/9zYaK9EQbfeKxxrcz
	AeutgmVCzXp7uucFeQ9miFlah6HksGLkYqTAajPM1WU0jy2TCkY9Wl+yPBYrQWOuCjBbHzEMUeF
	GNkiXtZwSqRFAzrra9d213+YDi32pep9C+4jDKFYKNNpIHreOpGTq2tkC+ul47twW4BCW8D1BjV
	Y1qLWH59shwrK7ximN+P9i4IOVa972TTq/leyAgyxu4N4rf1EShW/wUm66R7zsCR+qVZP4D1APR
	SkTKlKeamX35YP9L/o8+Ag6g4yFd
X-Received: by 2002:a53:d711:0:b0:67c:1557:7b48 with SMTP id 956f58d0204a3-67c67fd9f14mr3153613d50.64.1794500010621;
        Thu, 12 Nov 2026 08:13:30 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm73138157b3.27.2026.11.12.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:13:29 -0800 (PST)
Date: Thu, 12 Nov 2026 11:13:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
Message-ID: <avXlpVZTs5_ytZtV@cmpxchg.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>

On Wed, Nov 11, 2026 at 06:13:16PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> It turns out that filemap_cachestat() can unwittingly return incorrect
> page counts, if large folios are present.
> 
> This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
> kernel if the input range starts more than 64 pages into a folio that is
> split during the call.
> 
> It can also occur due to pages after a large folio being skipped if the
> range starts in its second or later XArray slot and the call reschedules at
> that folio.
> 
> Finally it can be caused by pages being counted twice due to folios in the
> range being split or collapsed during the call.
> 
> filemap_cachestat() walks the page cache under the RCU read lock only,
> and for each entry it counts the pages that lie in the range. It does
> not track how far it has counted, so the counts are only right if the
> walk returns each index once.
> 
> But a large folio can be split during the walk, or small folios can be
> collapsed into a large one, and the next entries then cover indices that
> were already counted.
> 
> Resolve the issue by tracking the current index as one past the last index
> in the folio, and explicitly using xas_set() to set the current position in
> the XArray.
> 
> Additionally, add a check for folio_last_index reaching or exceeding
> last_index and break out of the loop if so.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: updated to use curr_index, fixed comments, updated commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
