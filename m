Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686223;
	b=5E6Ohs8YpJyLLqkEdCds9bDqIzGJnQMj9f8aZb5gPtAuPjCsIC0M0peNCB6qnCtNN4iK
	 WZApOM9I5sKrfCDYkgOQlzojVuWztAHDW2NRJ8QmAbDLvPfz3E9HmwCzJqERXCiJJrewg
	 /8SXiTiy6igKq4Nsoo5wOImHbOLN5tjshguu7wrAZYkC+vppb/6IDysAr4IrMrh2ypIyt
	 /WVEmLdHblDTHSV92O4oMDnUH0okv2yvRH9BsuHxd8xrLU1ZftAZgLuMT/IpW2DMHPMnM
	 C/24FPsExjjmfq0yvu7HsfofN7ZpfoQQZqV8A6JM26lF4uNugeNjrJJ4rmYgp8kzTQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=ZCi4ttrWWQASeF1sPChkoEBldIkxl44ii+iYdI68IA8=;
	b=S8l9SGfFMBRlwpIIaLpcHyBxduQ5DdtpHP++XbdVfJ+D8yW08BiBdQo3kMRxmYJUjPJJ
	 IAn6kIBImIeiLD1xnKR9NOUqoHC12FC8SHwmIhal4NONfx2ibEaqFPEz8Z6cut8Ko8ftK
	 hTJwkp1xW3QHBch+Hj8PYQHv5KYCcANLC+0RhuSQ4ixu8C8U1Lzzvb2/zy6nYrXkvXQMr
	 P3orHAsoMXTtEaWc3rsT2xN7BR1+Ib0pz0bY4vdJdzc+KTA+Tu9HW5as4l0B08RqXJm4z
	 KhwTeohAfo9QUSBC0lzHQMmwMkxlJ46qgcy2tBnkrv3+aZU+ISWXWv3ceMNgjnRXO/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M5pSj2rL;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3A606A8AA
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE3A606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M5pSj2rL
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1010200a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686222; x=1795291022; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZCi4ttrWWQASeF1sPChkoEBldIkxl44ii+iYdI68IA8=;
        b=M5pSj2rL7/XmHVxGodQIkRrkhyJGom7e+lrSa8Tc4r65/JOyvj2hfEOUFEVsxY2zkR
         y3Bm64q+qYfbc1jkOgXAN5XLm4oTPYuS/f8qLvwJ28JiuN4OvREKsD4VRCBE9X+SQMWT
         EDC676u3b689aBT9Gyyg239YFPDYLCEsgeU1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686222; x=1795291022;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCi4ttrWWQASeF1sPChkoEBldIkxl44ii+iYdI68IA8=;
        b=zmrzi9/9p1Zz26LDr0vTmGdNLBeJ5wVQkygmc8MtGd9PX2hDlUvPK+ZU8Yqh/hODnP
         FJG9u7NyejpQTFOPOGH90HRM8VtlqfrqHOdOSaJ3SniK0m2WAy6JB4jZ3JA1QccT6/uL
         uUg/vYsjqN+85wqDIcGWTXGzhcr/d/oBLE/fIfzDGoKo/z/9As1OH5uicThzy3VXZenT
         fz6XGcw71RVjJc1c6l6xW/7aGJR+fsXmg2cso4Dbhx4ohxiI5NJQo9owcTEO+hrk2bzj
         ePBYUjR6gnc6qf0LOh3CQaBOZ9pmFs3a3FygAiXyac6iSqhe0Xvf7SrRQHHgV1CiLvjG
         QbXw==
X-Forwarded-Encrypted: i=1; AL+hErHLQ/XbXgsorvyygEA97q+5D+imnlwHkmEoo1NvYY2Kgqm3LIC7nTe7VBO1vE07CsWc+Jduq7RYsK1L/xLj@vger.kernel.org
X-Gm-Message-State: APuU4Z8mYEWPfecjNoD8KKT6eBKURmMAGhXX3yCWIdGb54p0HE9JSZty
	7njxIyd426bwMc1J9aGSkmRAK7U0O+Mu/bVZOhURLvuo90AU5IXvG1/ZLhciaDLXl6E=
X-Gm-Gg: AYBFou1L5U8frrSLSeUC87Zko2Px7NXjfs0Axxyi+8/BHB7e5ef2BoQZ57gSVrfu3U7
	jYQpjcaHTigloXaquzrJGe8NTkXLokkGEhVPD621auS0RKCo2AQ9Ambep/XgSDDHD7pblyLnx/C
	GzLlmOFUzsU/1FI4EYp+l2hLI+u+eANReSLY9pIrqGLnC2L6S0jytOEEQe0vfTD8pxYAc58tKsm
	cA2BUcYqeUWco5AMYLt1GvfYCle80o7T3mzR6ATK2a9oRsUK7WTBbMfEpMkVknOHdeTuP7Moagu
	hqEp3DK9vgCk7g0CrwlDZydpg+1WurVEqWG7HYVGOiDVbInG01gXlZLHXIS2m+INx6u0J1nQlRu
	ksTFhETNYmIg0zCWQE6kmLIo6/JA9BLIkg1xVFEx55NDVGfwT7Js4nP7FCyIezR+fnxkQuAhni5
	7m6PrkmeRKBFSQ1DvK/j60skQhXVy5DakP+W7ZTqOyWsyJLp+WWmIzbPVBxoXwSIoGCuxIvPM9X
	ZPP25Yesb8MY/HL/CW0XS/DIgcWdw2u/pj5rJ8F8deryLNDhpiO7EBEJ422OqZ5IZ9jBnMKYOVX
	b5P/Ri16+Z08hhOdohHZbXc2YmczqEBq/FKmed++Q4Iu3rcFKvFPdSAnqPQBIJFFM5RdHUgWPYn
	0RxhK9Uf3wPsOW+4+Ch8TPNyGCa8F9GL/6byVqp3ZkNZz62RJZO2fTL4Jzu1VQytRViXYl8Rl0m
	UL67kYys8XZzhBv0kiJE5eS76TecvilaPhhS3uAR8KTEQ+tfyQc1E/8g==
X-Received: by 2002:a17:90b:2642:b0:3ab:2737:3396 with SMTP id 98e67ed59e1d1-3b1b0b9cb54mr5682263a91.65.1794686221931;
        Sat, 14 Nov 2026 11:57:01 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm14709280a91.5.2026.11.14.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:00 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:57 -0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>,
	=?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 08/13] mm/migrate_device: fix ksmd oops on a migrated
	KSM page
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-8-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-8-50a2ed382b61@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114115657.f63de4714929f7af@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Lorenzo Stoakes (ARM) writes:
>[ ljs: tweak commit message, comment, also refuse device coherent ]

Alistair's Reviewed-by on v1 came with the argument that KSM pages should
still be able to go to device coherent memory [1], which is the opposite of
what this does now, so it's probably worth checking that he's happy for it
to be carried over. Going by what ksmd does with zone device pages, the
change itself looks right to me.

I've tested the device private case. Without this the process hangs the
next time it touches one of the pages, and with it the migration is
refused and the pages stay merged.

[1] https://lore.kernel.org/r/avTu3LmscsttRVRp@nvdebian.thelocal

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
