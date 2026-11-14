Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686211;
	b=5ERySSyUFDB5USY8abVPO4TWSpUUitAu0Z/cc+LFvd02RC03h8pCCRC79VU9/9V/8SLl
	 U3z5QMXhVwrHXmw8CbI9ixeyF52UYTnqCzahwyJL5J9yzckJ+fKt+TrAIYE3nMKdHBz8m
	 CwjzwbPcdLmrm0j5lD2BFa4lPUKmTHwAW3r5ay1yDAAaF+6Iml+18JZGa1uMd5404H3/0
	 GajKw7AWDo/0QS018IxZlFWAJb7eKydyVqdot1a3zVc24Rf0wVz/TDpcy4tc0ee3fLbEg
	 bM4VyLG+VCYL5qcdDJaSSh5DsOkHZ54WkicSb4iYJBKb6tji8iSc91lyh/qurlvPOtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=SPhw9hr4e4JeEp2955cZkBVz7k/zkmUYBLZ7LcWCEHrirWaRiHEz5g9uGFjnZR2Dp91b
	 SiRbCMAQmxp+a6EqsfV3JxoBddDVLu3C4Elf9AGLHOAZe27oj/JSj3NA7cXSNsjdf+67F
	 pnY/x5qgrrgskZAN425x82+I7rNHdGzUWHXq+UyMRypATI0LWLWQY5OTwz1/lgGixpSL1
	 THqWyuJtLgS3mtoVo5jFpJGVp7vc6G6crnUg9NngyNZTrp4ifJHSbmA1V4vP5lTW/j9gN
	 bc/6QhhKU/7svYoC7/ohD14hTLkJzcZoB0pu7lSnv8tDAdaJZARerHJdGuD+C/X6Rdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=g9y4Kqb3;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B481606A327
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B481606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=g9y4Kqb3
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso2806753a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686210; x=1795291010; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=g9y4Kqb3xQZI5SfaQLRCJwnELO9McjXi+OC+lVOPwHgkeuPIjg+1PfX+vH0l6xQNu7
         dRhgS0vAAYbAAZpE+kYQ5ut93ePMChHPG6ZsFT+1wdwe1h9GWjXo7R+0ztE7D3hatwi4
         1rEtUZ+u6XMtcwrwmcsaO5RNfFK500Dj4GVhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686210; x=1795291010;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=kWsBe3dZHz0HbFi5rN/RR2DSvFYT574ltErpI7H04NvRehKjmLOWXJP2V9jLw5DcEz
         3+Ui2+EhFKN+Huvhp7U5nsXCGNBHenuLr+ks+CO/E8TlEzSkPMUOxaviNKl7ygt0JCWf
         C5AifJUo7ddBrpK/Jxwo3WW0Z4cPHNTAuPEhZY+oXEdL0oVwz0AG2bTPDTNIv/bAlxgV
         e9WyYnxKbQXPVKsNeMMJgidQRV+Q7TIsfhQ6x8uyrCyaBQQKn5mpHHcz6auQURfip4yE
         6a3er7K4C5Vfhvozt4HDRhfwe1Q3ZHZRHdv1OaR7J9ThwINQ7L1OQOdt9vfN8IfOLTot
         Ivbg==
X-Forwarded-Encrypted: i=1; AL+hErENnE6e6xa0147ZWGeph96MqclAZnXzUkX3T8rPTPSl1Kj9lD3VLGUkZ2G53N5gMStP1g6I+PcOjb8hiKDy@vger.kernel.org
X-Gm-Message-State: APuU4Z9gN9Nny1MGcNwcxE+4k1VnACVB6SZznK2ktL0KEg1uGckSZ4+C
	MG2zhtLln7QxajDqRfeAkwnfFjVmbPPDtJ87Nn7q2wynMmEPXnaWdvaEA58vw/WMugM=
X-Gm-Gg: AYBFou1n96So6NeqQaq8DyMuUFmlEM1dFS7ic0IGiuhbJQByXKHuxYRlvZdujqupbrI
	e44wynFdmWMecfTPMqhiVwB6jBsxN2Nm1F+o5E9GJ2mTvv5M9V/vve/7tlFjf2ddER95xTf/Yl4
	MMZ72zXqL8ES/8Cr1eOIbpzHWal9Alpjjw9Yj6J5Ke2BU2983NHyCLLgnNMX1/i81nt4X4z/cJv
	kRiB4nILVi9KGL4naV1ey39LUMgTvWbn0TZrwLkNsk8CRflp2MZAF19WfB0ERZK0HN5mNHXJ8Ys
	YCPMhhfyZKbZ01c9i6d6SditzOZ0/ZqO9mfeU4xpzIw/ov/hAKhm5u5a3DHkXt2yr2CkT57WBlK
	EgsN1sNO/v3Jf5ARutmTV3TfEGUTseEa9m8WfiaC2MlXL3Ohy2vjUwBHQwhnkOBzvDUfqm1+FVj
	n3CqOmbAmbrSMSECrAjG5MpdI4t84aaOkbu/29svdQy6aeLhhAGvfOcI8UOBqYkg1I88eBEfQde
	vJYkJ9CqYv11jWmc2VXfHMFeuaMBibzHApnLRdbfZA+aeC6mIdG0i01SiY6ZyuJuDGLB+zZO0GV
	lCL2qczb3aOpey8pIaqkFL1Pb2EQHMwQfKr8dj7y3Ep/vFH0X3G02QaPM6P0+vGF9nZROx6T3ui
	P/8l4Dyplz8C5WephpRL3TvEMS9X1CShpCeMWy/KgYiQyIE+k2BH0XnKZc0r7MlUjPfgyonVMeD
	ahEbiUmYEkItrTxuslrU4YYz4XXRYGr8+53Gj8EQ0/AwllPOGMpJyYyEGV
X-Received: by 2002:a17:90b:48c9:b0:3b1:21d9:4c3d with SMTP id 98e67ed59e1d1-3b1b0cc8744mr6495500a91.39.1794686209991;
        Sat, 14 Nov 2026 11:56:49 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm4748452a91.3.2026.11.14.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:49 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:45 -0800
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
Subject: Re: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115645.be49d8916bb1b419@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
