Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237244;
	b=b+FFHiXHBFqiIZuTK2T8rN04lqW81Dd5pfy1v5J9PfdLOh6cfh2uou4WzczaIeFFh5Na
	 ZiFYUX8fxHX7TULdujvusBHRq8nuzF+LUssRQiT+fGmJz2qTMa+maw88dDKnF1ZYTtVg6
	 zK/3qx3vwfLw2CyhzYza22xaYou9LDM77urUIcQH3xyi4h24hYhdgKKHBDFc1h6ZvCJ3+
	 1VZ0nkPV5klVJ98VPTjjKN9QipQw+szvSbvfFzpKQLmCCBILuWLsMmTjt63a0a1zKV3Ts
	 oxFcbb7QULnh26PnKqNnPtY2fC5t6W6zLenEYUw3/AOzxXbgJXLS4UVtofUdzcOhl8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
	b=IXM6Ehdptp52dFAC/SRft29pTBYo0M+SaWNrMUsBpoGV6mkHdeic0oyHlHwdYc9DhvVy
	 rH6odIfnwTq1Jh53WXf5CDBA0p9JVTuS4wWb8dNmh1DDl0VSBNlHIeTOGeaURHFb1ILho
	 36V9TZ0cNCMr44QgkMBk7Rwmtp+AbOFrKI8Z8SwhvylqVWPgd6XFdG64gICTImGtrzrKj
	 hJNsWNKbhMoc8MupXilQ7dLkKMg6sneCpIQbMs3XQKnGSDbsWgBEsJXfQCjzj8qkprXtk
	 cqlVb6OsKR7JmJljM4AdYfW/7C2FH6Ji/cNEBTqoLxGkdYdEti8VakTG11LZYxoj7+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=FXWQ6ewc;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7674606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7674606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=FXWQ6ewc
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c45551fa84eso173150166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793237242; x=1793842042; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
        b=FXWQ6ewcYH8Z/hLIkNQzCLuCWPzSaYfc+WvfTKDINHzz6s7rbVE9BJ2+9zIQLx9hcf
         5QhEQRLk1p/wOOpcVFwFqvrOTiRdB9drepMbsO+yfRcHtioZaMLr2crqKLoflECJwLsn
         V4wJZMikH6YAQ3/HUqqdUVWr1EG1fH1Kmpi5p+WwhySvjLryewMk16yp8r0+f+srRosG
         iBpd+vnvF1qQrgNM9OR2aoNMnGP5IPFEMd3OWprxewqYz+6WifZnH/aZyCKQzXvy2h0D
         Sd3hmGrbh9x78UvmNGcQlqVIooZQZrhPh2+RFCNKawphmZ9hpaptmMuogQz3pxM1Kgl6
         xqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237242; x=1793842042;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
        b=uVLwK6vf8Wo5HdJit3sLDhHY3qE8DzWE0CZOrZIDw+0X8VtnIUSRRM9Ncx9ceWU5oL
         G81nGtC0DXq9dfXEYpjXnbz8zx0RrRKl5qkqebrd3xbnsi6DPDzdJIf+I9XyAht1m98O
         hyuaGqV99fesDuu7eDa8SRNpYvEt8aZnY/LJgsu8OYhuhvNExtHX6cj6Sa58Atq1WpLI
         0q/PKggHC4ElYpA1undalcKAzbhjqMNWbteTdcKr0GkFF27ZeEQ7w+abL4MgcE3qn9C9
         mZf9F/QqAG1F23oVFe7HLKHRPH1gZc2+TjTuPwwfk66gl7L1GJntUgrU8DqrALhvvC6l
         4Knw==
X-Forwarded-Encrypted: i=1; AKwUvBw9Rwzx/TgLIrHWvKL4Ylax/LjT/gdqldkBSVIWVH+15HTY195ltVd6m0j5D9x1h3ab13w29nJKLSPxsLPq@vger.kernel.org
X-Gm-Message-State: AFq9FYISlr4B56jvtyiLl7kvov6PrDlw1ljrrCTKK4UsZxtzL24kNXAK
	zcZKHuMOi7+7VgoP6zDGZixypUkBqeQ2tyHTZlJwTvxugMScbLiR+YRoyQbNWjvnl6w=
X-Gm-Gg: AYBFou1RMEuenVYzL9FNZVpLKR+FqwWeUaEGW4RWDPS4igAd+tNW9CDf/Fp3mh487k3
	ub72awET/RuXztM/gkyTjPUKJroPCPFVSsTH5v0gM7UiRzynrrHacGciLqmvNs1VNjrIxsb+NsP
	xtmp6NXnWM/7DNvUdT/DLFCEDnirhyDtJ7HrgHwqYIkPMSb0jeP/fR8ZEsJ5oLoIMw0UQDVrCZB
	go1KelqVN9TdUyisBnr/c/Ma9dJlFOk4DXaUbam4MHh1YOzrs7NzRJumLOHreQEHHNQhbDuwxkB
	Qz6lJlcMs1jbdiXBNsTEP0sy3DtJe6qz0S2A0QufgcbMQnsBIqDV15pwOuSEVN64DF4nnryaqib
	sIDWaVP8qwyBojhJ5KSXxYwhzgb4an9P4QVnf56PsMyAlQ3bJ9w1HKy9KBRHpVqdoHxUFp/GP8L
	FQ01jSj0wASx+a+/dqP9yB8aFmL8Hgm55oz3BTGBHWZMwiLyspMAQl6nJiQGM6g/U/pVSo14LQX
	I0eYIMcL8ZQTvAoTzWj3VClFqAyQnTHFd+Zfr3iTdwR+bj6Zj9FouJN7vk/zFrJjoG0osyMagbU
	NPAiFH7lsjql3FXlq6oT
X-Received: by 2002:a17:907:97d5:b0:c29:c079:676d with SMTP id a640c23a62f3a-c49bdd744a5mr330020866b.3.1793237242153;
        Wed, 28 Oct 2026 18:27:22 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964488e8sm2081290a12.31.2026.10.28.18.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:27:20 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 17/46] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:27:18 -0700
Message-Id: <179323723859.453251.1630776487784216917.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
> bits to the folio. A shmem read fault can map a clean folio writable, so
> a later store only dirties the PTE. Losing that dirty bit allows reclaim
> to discard modified data.
> 
> The assumption that regular files are read-only is also obsolete since
> commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
> for writable files"). In any case, transferring PTE dirty bits to the folio
> when removing mappings (and while the folio is still mapped) is the right
> thing to do.
> 
> Use get_and_clear_ptes() to collect the dirty bits and mark the folio
> dirty before unmapping it. Update the comment.
> 
> This was reproduced with shmem using MADV_COLLAPSE followed by
> MADV_PAGEOUT.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: adjust comment; simplify description; cover file-thp as well ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
