Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504929;
	b=RoCLJ32kR7j8s3qrO4qrH0lRH5rZAgZTLjc0AieFXDwG7Lq9U0J7SHMtAiQbclpP423T
	 ZCRLPMx7RMnV5yDuXMENRg94CBvpZxrpvEV03/PAnuOpmAArJyfFXGIY8ofiIZozfIETJ
	 tU0OqUYrJJBcrx28jTSBFZVak85tyVyQ2k6RRcA7IS7r1WOXMBbcHWwZSnnwaQLGViEe4
	 1MoDU3oHzD/NB+YuhXO8uU7Q6IQndYyX708GegWVGsSIeHnZz13Hh0XNwGRHG/X7Pmwjz
	 5zFs+8uBD/Z7d+dPxt0Kq3lbi0b6B+2VFJcybRe9zczrWkCuf9I4JlPwXg20ZN9XEfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=wY/udgzoTMSU7LblXILhhflOgeGfM9mMJ7q98JCWr+4=;
	b=UbMhhPnEDUYMf2N0f35A65V/Es7Wya4J0OKUNBWe6c44IRpdp/ZgHjFKTRbqw3fdQ3RD
	 /2yQ5sVcbzOHYy/VkVn01gphSLmNKtVL0D/ZO7Aw2iG4OTMg+fnNK5/aU3krEx4106mc4
	 ihdD4E/t6AxzKqooUSkqlNcATA0evShbkd2KHnli+weoq2f0wGzJjkSxAyrsuAULoGlhj
	 HYWnst/jue/kJAgbOf9B43NmIczihlLBzGDKzi23apftlonJyhnMtHYcnZT1Eij7aaKro
	 74qhvj3nLmj5JqMJg4bW39THAxjYSIHDthrprlWGu5+FAEtNmUROU1CoTPCoxTGTazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=oEs3dmHr;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F378606A337
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F378606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=oEs3dmHr
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53669f7b518so45643861cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794504927; x=1795109727; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wY/udgzoTMSU7LblXILhhflOgeGfM9mMJ7q98JCWr+4=;
        b=oEs3dmHrtbo3BJbfZOVEDyiKo84vSz7vME9GeiDQFoQ1j5oKIGWHaLXsA6of593DNi
         LSHuyxe114XTXGNJ1/Y5jCpkW7+pNUmCsJP3ME/2E1iS7aiNUDAMlZgu5frzBx4YzlN7
         LGU9QrbJB4CDwX/JJQi4yBuDTXoPz+0pNuVnbBxJS3Y+zSavZNYfRzlE+02u6FSxVCfG
         5AiyrOfkTxftBPH1gDgLAc4621TOLHFN0EDyYtoQh9nuWdC5b80BG3E4rlAu0JFVdD6S
         Ac+AVCNswFwIvFTGkOL2F1V2xffk16MtyAElYxcTnz4eLh5PrNNOOrZ9e4Pi0Z2PEMrd
         fzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504927; x=1795109727;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wY/udgzoTMSU7LblXILhhflOgeGfM9mMJ7q98JCWr+4=;
        b=C798cdv3k9jAPjmjgbu92LXUIZGlRXpM97H5tWCE+ZQf00DUD2QyhbfPzcm57iwulu
         HX3FjGUo1oak8CRl2wNcVgsPhwe3xGRWz5B2x1M6eMItgJkDMWQuvdKAIR7M66SM0NpR
         1eKU3RJrFsiME6sGyjcbFJcPEmx9pKl48pKcaDRzOpiCZLBjKvFRW59xDfqE8AOtyXWs
         3fSMbeLFtzq8nMzwHHk60/RED7ID1z6PJ6lXMdLRifEQea0d4n8jjx8FRAdypp/jTRB2
         n14840EOe+drpCI+yi3Pk1vGCyn7TJ4Tc1HZhyoFuPqUQeDKeiCi4yoTl0lk/wt/0VDS
         ARGw==
X-Forwarded-Encrypted: i=1; AL+hErEuH1FrqVIKfkDsLwpUnYNUNvUt+yA6NpoyKJcdBI+RDTLWUubmxlmdWpS0eyZP8S3fUDnJ3pNAqIz87cc1@vger.kernel.org
X-Gm-Message-State: APuU4Z8APDm4QtxPpR3hbA9AvuEH95Y62qBn8tZolYmjk7VjTkHodlWS
	yCKNv4GL/Gg7qB3ZeSwYznXIlLwPBTXBYEzswDRfyluOxOHHGpRIhUL9J/8CiuRmd1w=
X-Gm-Gg: AYBFou3wCPYB0r84ZbGbQZUQPgnQIKTwtWHMyKkurnUzGDfCXNdaZc9nkPHdi0pcmG1
	G62xT4190x5jR2OnuPgHqhG/2IO0i7FDfJ/89zQ6JfYvjAM0YCLLPx4giIovDFGxgXKoYguxVHk
	gv8A1Fnm81C7GcgHqZTc4I6sD2Fl09MyG7G4tqacb6p7iOxTLQ+mE2kOhgIHJ6ot6BG0+mQFXhi
	D2ZdDWSfMvbSSq2iCLAFTWGMJesoBa2gVjOd50YNKLp6KeAhGGPpMNDxvYI9vewuP8lttZ/0wrV
	2r3qr/EwlKNe642OZpSVse7brNLvuXhWZH/ywPF6tndb/1TtI0gQk+ONmwCGCLvuexc4oSLoZI1
	HSwDamzAhZo0rGSwYJRadF+hu78r9fadM8aHyloCyjkRPM7MlGXrJv7NyDpTnRYFWHTzqpiztrX
	eIEaCyrrWSes5QcYQwqkaoVdo3J3uFVgWaJJowctFfK9grvWzzhmOZWWVITtvLYroIsWPm3/GkZ
	o9W4EQGNMNcyKYt3bu/9IGezZLuLR3DF9JuA49mb50S1f0IbqYtIVnd75dc/rvyDq/OW74LQ9FT
	IoQhg5jR/bHhp/732GUAx/hFqNX2EO+/kDGShF1w7HSCV/aCJDhygwXOU7u0lP5xeby5/SED14X
	GdtnY+GE=
X-Received: by 2002:ac8:5a0f:0:b0:535:a5f9:752c with SMTP id d75a77b69052e-55ac95894d0mr1164321cf.75.1794504927563;
        Thu, 12 Nov 2026 09:35:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d5e579sm847456d6.17.2026.11.12.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:35:25 -0800 (PST)
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
Subject: Re: [PATCH 07/13] mm/migrate_device: look up fault folio after a
 split
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-7-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-7-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:35:23 -0500
Message-Id: <179450492332.482102.8905567682196853763.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> migrate_vma_collect_pmd() looks up the folio of migrate->fault_page once,
> when it is entered, at which point the folio is locked.
> 
> The fault folio is assumed not to change after this, however if
> migrate_vma_split_folio() splits a PTE-mapped large folio which contains
> the fault page, the fault page ends up in a different folio.
> 
> Resolve the issue by looking up fault_folio again after each restart of the
> walk.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: pared down commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Was able to reproduce this, and i think this also reveals (and fixes)
another bug in Nouveau (memory leak).  I think the Nouveau driver still
needs a patch, but this otherwise looks correct.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

