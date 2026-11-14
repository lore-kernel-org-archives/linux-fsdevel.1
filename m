Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686201;
	b=G1NRSqmGt1u+2WsawKYXHtMETxNGdsO40iVZUJPXnCAW/FDCZjJr7BF/MO8mDltwH52Q
	 eptvAMHVX+9sWoxuzyewKLxLNJJGjDUP8iqmGeoUGkyjesi/7mFXRDWdNcQ9eI/ydwpNr
	 HngkPiXMr9OkUh0UnC59MGoGBx9doVE93WPF5cI45wSMhrYLIPgvN3qDfoRx8LA8p38B0
	 9Ii9piYCw6OU4g+18xsCGL+etMujmySG7mOA1QGJCCNbtOB5eSSEVmvjC3J7GbtdxD/1S
	 pXN3t/HCpaSujhat+8ZSRDJcP/zuF8c3mC9NFK5w9bLLbG4DBRFT8AOZQvkaZufVm/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=hrbRKPtAWBgGhGonvqRjGeinfUOoIFn0EQDX8I3HUjg=;
	b=2FHMOG2yS8uUn5JgRDKJUtTIEmGB0PXrl3I8Oy27Du9hxETf8ocOig599YDrV+6Psql/
	 idkMhp/5reHBGmfJbELwHYkDLNlCvJGEl7Ud672UU/HuxgcgBOxzDwJTXjTAXLV5P2vyj
	 Rs1L/ntDEtNAQDGzr3BArUp0RdPxfCY0ZPU5eR9V5XfEIp0FaHcwJNuGwd9whi/+tC0np
	 tgsk5coQlsxoqo5lkHTDOzXZGAGPJcpYWyjBngLeo6kRAqLuZN43AqBKIhiZTGPLkUgu9
	 jvUduuStsbHIaTEIe3QMBprndjkfArYFuu7hN/lon643hMHXa0xNfTpNrFyWtM8cE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lpcmlxvR;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C409606A88A
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C409606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lpcmlxvR
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9d7791b00so24791335ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686201; x=1795291001; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrbRKPtAWBgGhGonvqRjGeinfUOoIFn0EQDX8I3HUjg=;
        b=lpcmlxvRCJv6hmodqT+/LEBuEuDWpXdlNC697E3qnM/e+bB7/yFvvagB8D+XlVUznC
         H9Gh+uMyZk6vMTFr9lj5LxMxT7Iqjk1a3TTjFBBxd7fRKm77L5p6ygoG6us+ZOCCcBDF
         xSpNSOo52o3wKLo3xPx0W/LZNB7yUHiEy3S2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686201; x=1795291001;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrbRKPtAWBgGhGonvqRjGeinfUOoIFn0EQDX8I3HUjg=;
        b=UQGmXX2OTBs+GebXxVSWhvbLgPl4WUga6O19Xuh3nNOEgGFHxaddUpsDgUHNoZ6BWb
         0RoqjbKGsxs5RQduCYliWejYqOdixsKmumjtgiaVtWlUFIQGgiVJxGytC9LpV+gTjK7l
         F4862CLxYiPuI3VaXtdvgxAQc2ETajsWDwNI6bJhSv9UKVWcf3BuyCVVLxg4zVUcU54z
         jQfRrCHOqRdNtTeTIvcA4boFD0bHxaYLvDNx7sDqVbb4Exnn9xT3juugl1Rd884VP8Pz
         wOb9J73+ItDuAfowGxFs4sN2NRy5XDNnaE0fdxciUchdrVvpbpT1WKZtICwsTtZWZSFr
         mjRA==
X-Forwarded-Encrypted: i=1; AL+hErFcYmpHkGNL4oAeuacYm+HYkf1ifQ2wY3OnTsM5aIwaqiKBOVkeiHNJ5bLzqpPDOwJoe40+0Bas6O8r5VnZ@vger.kernel.org
X-Gm-Message-State: APuU4Z+zCm5NMDeagjoEm1dZVV3pjlo9vAiajKaa1DFjtNXpR2wx5ydk
	e8zKB7Cd2+mSILkwC7F3HVHJtHKi6+qkYJKVpTT/Mf6O7liKfT+/HtSCOSC7l4W6k2Q=
X-Gm-Gg: AYBFou0RKtGs8UE1YwauvuO0iA0XgBNLnqJGG1Hj95opOu/1sUysXB/tndHaZ4dzB9W
	eu+3PINAvMSZXo6poeX3KiA+G336SmmpIaryc2zQV9ZX2hEglITc/TOJa4HMN7sTxICBHQGyW+u
	rgA/BerwRBrQCyQb8wZyAWTsYTYu6bbtyw6NI6PMYlck0E6+tkmZYFG3XRCuUKqxo4bMT/GP2BN
	wklGqW3PLRuglkoyI0mOLzfkaTCo1bsD0toBzqnm/bTAbp/9t4Nc7OY59BRTg1me7SAg6q08vSU
	LweNeDMjERH+Cez07AJVNLSfr+R/m7/3rBqXNNsWPzHYj/1Gerlkk5WuyWblZfLDngNK1ej+bop
	O+o+NfnAQh0Jqxs3N4iw14R+diLsJtyGVpCT659NfQzSHMT3YOtVUMC08Zb/k0+L6uwJgkWDPhZ
	yAbfCJQie/Ts8c/i4Bl6wyNavvIVKg2yKYC0vGt6LHIiMvWqPK19CVGL9yuLoSsCvRETnHgHeA9
	5PiY8biqPpDlOhQUqlTeZVc4KO+pO9XD7FrmkWiriJ2X+47sy7fuMxIYCWDzqSl2uHrm0W5OKxc
	c7Ja2TKj0VdyhaDOZ1IzouOBGsZvV0QZAqaJHrTmyR7gquElB9LEM0SKsGKOGBGqfrlJNvn/e4G
	53Px2Q8BoelEvocuNOaM8b1ymF8GSZiOI5JWdIbNAg8bncbueta9NC149n0JYnyZX3mVHp8UDec
	P5DneOv5yYSpmpdP47SKLw8i81+JBxNSmfsoAhY8e6byhfBLNWa7CRfPg5
X-Received: by 2002:a17:90b:2e06:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b1b07e1cd4mr5830748a91.6.1794686200819;
        Sat, 14 Nov 2026 11:56:40 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm10008894a91.12.2026.11.14.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:38 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:35 -0800
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
Subject: Re: [PATCH v2 02/13] mm: cachestat: count each page only once
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-2-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-2-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115635.8346206195d50372@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with cachestat() racing against splits and
collapses of a tmpfs file, and the counts no longer come out too high.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
