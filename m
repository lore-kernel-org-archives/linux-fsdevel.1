Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686237;
	b=WsySHjPyNl6LE8pjSYp+41BqyPvYNbNSenBkxykWxY7n/zbj8YhqIqJFz4siKuhu74E8
	 3H4UHjB2thY/f3JtxX7/CTLmqZQ0XUxzbo4XFw7cNMRLe9VtUixUMxFtdB2YOFyV+8hwd
	 P3ohRCLutt2Eo5ImYBjVbNcZIrwPPNonhKZcDb1OQdKYWNwDZF4Swo5YenVazbm/oRQoh
	 fazklfJS+GtaoMntqgj0EX+3XhUa+q4UrGwYqW8CfEYK7iPVTy06UOhwQxY1nI8PxxF/q
	 jMdvboOA4o2klzCrtm90PROI9JSPjiITACl1dMPGHjcptG/m8fSjP+cIq0PmFpmQ4MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=wELC5IFGTeRAFbePZLvEYw1GXUIEza1yiV125UiskaEO6YmHl3wG30irgq+01BYuNtWa
	 4kKOdOkcTezKN3TOt1axGzyfcq+auA8wFi1b6prRLeqxxG2Xoua0DGbOFUOVXZWKibtrO
	 vgoyRPSfgFL8ZG3mJeNgdn0IZ0+BeV0uKVDlPGOVWGgX+GX6M6S3aJfzE6or5k+NgrBxu
	 CE/9oserGF/UOQRDL0euFaQNeB9Vv8vCmzuLvbFzdJcw9CX+zElJ1PS+8dNDnPAOB/vxQ
	 /GuGHChmLtroX7mG4adPjPuJ3iXqmJogGjXYi0D3IBbTe+aSAMLyesDgd5g+xH9j1QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="R5QF/Lzq";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD560A5BDA
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78AD560A5BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=R5QF/Lzq
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1843949a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686235; x=1795291035; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=R5QF/LzqmNh8H6DW/Tp6D2khmH13F8jS02Au3NAC8yj4TjGWX4bwF6qk5IoNwQrE/3
         Xh1yK0KBPfJuPjRAwYHbzV6XosfNY0tKGMjje9vACiDnt1BKTLgjbIxr9zzZeHHSoySX
         0usB5I5Lay+SCNbYz0Ix38KonSjLyFaPrl1JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686235; x=1795291035;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=KxRsLdhKCSyo48HKnVYgJxmsRei/zsK7px247R/QmLBZsLMnBTsaf58UESOzaAc4vX
         1CBM6vmbvwGog5EJZZSx7AcD/Mzqt/WmO8nTDmGRxpeDDOEbKL7eFQdVJy4TyaYYK0OO
         ptnLTdGQ+LAqVysJP0izvt07cHadwJb2jpsoNgELWv8PWrLC/xG+JzjvYvBJPh9DV2PL
         zCepL4GbUPDQLvIVdFnh9+khHfnNK7IqB9dkqh3amh48Pl8S6JKNX5UV17RRtlaOMLQK
         QHnPDy9WRq/uiHJCAzWAwRzqHK6F1AlZSxNgsOkmRQb2SEwCNty68lO5PkQEOriHKx1V
         Kb9g==
X-Forwarded-Encrypted: i=1; AL+hErFiwAncOSP7sUHZfcaURlkfOfPelJxsTvDbA6r2MX6D5xc0J+ZP0mEx3rfiI0UIlFtd7VwKGiEPb1iL1vUJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/n3Zup5ucRoFMqsXO7CByMi/17HFksLKYDTQ9VXhrCujbS2Opo
	Msf4SefaTmDqkqNNC/c2DolTMfQsob1fJxWoTpzHyzx8J+l+VQ2nqyHuoF0tm6rKOA4=
X-Gm-Gg: AYBFou1/u5DQRaALoD1nI046eK99eg76VGNhwvSMc+gl3H6Y2Ko/hMsP5TZ4Y3IeUnU
	dLzKy2AkCWzo1jjtXKKWCFBtaJ+GhWPWM/yaN38XwNXDaKDj73SkN58F37tqFlpQWjgCGU3LRvM
	pYeeNUy/UFhk+AUkwtrjudGBy4lGEEVJ3VvXkrKCNaGphfaX1OayVX0+wDcBIMzSoI++9WWlbmL
	NUqMMcKxKDgFOeZPYJVWHDwt1pRn5xujWloxXlqQjsHzW2dVVWm6mo7eUJ8shvUuMQIH3DZq6Jx
	V73BJq8cggbk1kVV91lS9gByJtiVhvTPEblaVnyStkCcMoOuXgoT7yIMH1MeLsaIeB4/k3/SA0F
	g6AJ2bpFoqGufPVQzl+RyEk+x7SnnEjllAsiNvBY+JySUu2lwVqx0t7rb7hXul91TgarNbxZ9oo
	wUGsKpwhcrrjUsBk7XCJsTqAcOG9DmKd/nelSFgc89Lc4d45hXqK71LLtjWED6sSa3sdSuxvDo0
	A1gLlU4ZBYNPX3W7oBQNWAWERG588SfRBVltnMSWMO5vbUb0KjX8Md9oOngReydEB6SQR8jrDu2
	UiIQ7lwGVzlwtuZL497HqYCUvvUv7aLbYZbs0vTDp8f+hgiwiJu4xPizsnpXF8oe6tEglyB7oOv
	TWTl4s/TsF4NtsM+KaJVkhCANZDKTsMHPP7T5dMFnB1fZ7sbHMiXW/iIMteS2bbIwhbhxu4Q+9O
	HjdlW2eITQ04HAF98rIpnqOW1KAOiLkP3mwxsLm4B1/noB3pRX1ZOI9g==
X-Received: by 2002:a17:90b:586c:b0:3b0:ab34:afc8 with SMTP id 98e67ed59e1d1-3b1b0b67f13mr5551950a91.20.1794686234917;
        Sat, 14 Nov 2026 11:57:14 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35ac2sm15010379a91.17.2026.11.14.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:14 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:12 -0800
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
Subject: Re: [PATCH v2 12/13] percpu: search the whole reserved chunk
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-12-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-12-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115712.a6d31c964942e1db@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
