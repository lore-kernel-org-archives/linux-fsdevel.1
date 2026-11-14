Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686213;
	b=AYit79ywiyPp/gcubL6AaAJbtpuZ+pd861/Szt2QqiIhZ+uirlyHEjydD+QMLRvlbZNX
	 k2EOwi1fnHG1rkK+hc/NW720DUj4c0ZqziakAuAJe85176H92gdaYlKBjkap+PM8zNJZo
	 sbkpOU8+9UbglChLYf2PybpeZLD+tuiCGCsGM/icE/SqpSa/gNmo0h1NaGDHHdjPV7k0y
	 GhBa+UqKqCiC5iQJ6GdQ8lgftQzJ5O+2GYrXWpVts/RYqxVAk8vsP27MNzsSlKIJomJlJ
	 espUsRZnNsPiUoALxGLNFJKR6/13W08pjHe52Y/gMMU96Ep9wWJyji459AGduko3OaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=jUPvgjj1PBRfdwLGObCdW0ZVMBq40+Tj39RcKsF/1KM=;
	b=cu3l4dr2+tZ3x01wlNLm+ts257xEjyU7ANQBvBCfXL2SbNcKIDp0NHBU6wDlho6RJfYC
	 vH+xeiRk+QZOr2DvtnHO90rlUFzhi+3jhBkuJzhkk4V29aSw0LnEc8A6bbu1Cz/MDdrf9
	 7IbhvI+xf2w1KwLUBn0JtUBFnd4lkA0SgLgNErRWTsBKNai2psdZuy9M6zxQL3q6XeMwA
	 dWSnNPD7H4A6WZWJA0FL8CJF1nfYV5DNcc7WtOQ7WlKhkjWp2hyHbWHIfLgJJUKQTtZpN
	 OiMFgUuZnu0+ETPZeyAAKFNwLv8wIkU8ILLseoF+0tp89ZsgRNeH0VAr2mvmaGdaYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pRiTwZzn;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC134606A895
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC134606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pRiTwZzn
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso2009817a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686212; x=1795291012; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUPvgjj1PBRfdwLGObCdW0ZVMBq40+Tj39RcKsF/1KM=;
        b=pRiTwZznyJjRXEwfZ2Yj6bQhTMfhAND8SF1yLLCDprlMuuVUEfuXxcMAeIcXT4oMCb
         h2mWAMZ9RLugktvlsTqKXyz8lJjoTbqH9YlZA7iLPtiOJs07kKmXDovd5gz/xA3lrkUk
         pSf1nT3EqnybmBBib+Jjaw2cWu4Mh32UD5SfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686212; x=1795291012;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUPvgjj1PBRfdwLGObCdW0ZVMBq40+Tj39RcKsF/1KM=;
        b=VPonRyksSi2Fg7DxuwO1uv3VtpzU/9IvuO96WDYGtjwcvKYb1EhAG612cQc2zsFXzs
         0quL3vJJFr7InP1ju7UTqBEc8EdIQMbimFYDmf8d9sqdbihANnssBSptLpdP8yKvFT8B
         19hVVaeP17e0SswFc1KoIcyIhCd7m4Qc2zHCVXXAhRyOCXLV2Z5BO1+7ITEypPdB+Yvq
         EcE1htiPo0/GtiuJU0P0FLe8u+Tzw7tYIf66JbWIsTF3+DEPKv+4Vpyfd70WEgE2QUw7
         JIUpnEqXbQhDzVtfW3ZVTqQKA0FsYp60YvigwSIlK3L1hJ6OsAM0aFg2tDvSRraogrAI
         CdSw==
X-Forwarded-Encrypted: i=1; AL+hErGWomNqIDjkskPT0QW13f/7OD/Z8PzUObxWBGL6XvcHS4TtZfatPO5l0MiO7IbD+j9g97hemhC1QzD1yFt9@vger.kernel.org
X-Gm-Message-State: APuU4Z9EvRnePfeS9yAJGOPi5lI6Hg18jWV2x0njQGfMRD1t7advMevL
	3ILRdppZVb84vkvRtn/BOJVq7Po4pIZ1v+ri5Qkc9q54TWZvTdkmGO9X1uH+D4szbUI=
X-Gm-Gg: AYBFou0DWZF7XLI0y75BnpFfPn3U6loAM8KH+wQObtD1gThraFUVYQIIXc6wzgo9nLf
	yIBULUBNn4sXKLYX6G/hWal/Xl7PTowKSZTauFbhWu0K0g3y/oDTnplKRC3YDP8h4WOKMqq7u6I
	6sQPrME2gSgm0IuemQ3OFk0rJdHk6DEN0VHkvof3nLqp12LIRjjgiIrqQd5fCi9SWmIXn/AM6wo
	A1sCGXecOjEhUgKAux9u1hYeixvviw6rLxjTEOipoVmPf5/ATmA3E9YEcx8674kOat+xzl4nuMA
	eh1JlKv3YWpzUURP+7FM9o8WalS1LyuhR9nMBR3918YdAQIEsIT3czqn2bLnVCL2we9al78j8Sd
	qfmp7/3SjvLZ/6mx+ri6xigfVh1RAQu50gKfYQhapHOvOc2JeyV1fY7axtgvDhRBBBFXH80B6WV
	qaXKSaP8H5EAM2FayIEVsWgGcxxoM2PHhnNYIFSuh8uIiceR2j3E8Kll2c4Ftf9t5NMqEs9NttY
	1JOfCgVJQo7Nhh4vZ3uErLgRTO706/cPJ+73RBOR2TB4c0pdDQ7m0fAYfOgKHjMc4dXYCKPVbHV
	TanVeQ/Q8IEkyMcKXdVw6Gy3IHyNyKvjK67KpAAET34Kmb6ZU76F/ZqaSvEmhH4eHoEX1iyGzbP
	LIUBX1PpKCX4R1HSAbksL7gP5memHo+NOyKsUWD7Yy+1WCgEoUaR0GLIK8B6sru+L2Pf7DvlB1z
	QcKuJPW2HoElJ3d+j6YXcNAuqi7C3fk/PwLinISddzx/4e2MrcXkWFqrA2
X-Received: by 2002:a17:90b:3551:b0:3b3:8194:9e4c with SMTP id 98e67ed59e1d1-3b381949f14mr141149a91.34.1794686212209;
        Sat, 14 Nov 2026 11:56:52 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm10009272a91.12.2026.11.14.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:51 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:49 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 06/13] mm/migrate_device: don't let go of the fault
	page
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-6-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-6-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115649.cafa06b8b8401e8a@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with the HMM selftests that split the fault
folio, and it works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
