Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686239;
	b=fAJt8ToSUgH+acv1llZC056hRK2JLET1qxQfWTW8L55Qu4FeBniDN/Vk4mdD0ctrZrQs
	 raQpIT26I16qqK9r2tp6H9Um/eH6zQr4O3bxUmNBavogjrMKliulwVxqtPoGZ2Bj6YCh3
	 f0wQ2sPPUFmpA6RecpsMPFqc8IqKIdXjnp9MLLpxVtLPK63IzsucWDzFtmQA3xtZvG2mr
	 WG5w9SjC1iAafERqsnfDbzUMdYY6gKI691SgyMavIb+btapqKnfnILtVWvuqy6vv9kB+9
	 IipB+bNX68C5TEK4NMqFdLX8VE6M3MLeuWccP4fiKOOygMCxaqFT/jPElsBxyHx/SvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=JIJ74zgHsGqKLtFFY6055Tyb0J7Mw29Smu9tDh45Q3Z9LvR9o0fRNWiqG52fwSDKutDv
	 ddLJ1jM2kBgdQGWBOEjytjPrORYFYIyjY8cv7WxiNjA96gQcVe44gqjhNs9am2AhnalsD
	 DJal2AmZKpain1ddd0/AYoDNKTnL2qEzElRbQAALxnljXwU5NlAQ+rhe/h6sgrTWCglL2
	 ++ajkzF56Cz8Cuc4oKZbZ78dSnpHofoxqC072SwnuGRPJ+ZUPFulYc/QzBwEX1iZSeZJF
	 UpbRtAvEfXgIxEdDVHV+dVM0QiX9Rh6NoiopJXgg+eSf1XxqkHXf0HwaZuunkCFzYIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvPSjOzG;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DF60A2618
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D7DF60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvPSjOzG
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1096954a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686239; x=1795291039; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=IvPSjOzG0y3haCxrNaMvn66q5rF9E/Bw91sbLQXdLaKWqKJc7Sd2PP5Dm4+PqJ7A6W
         UpJ65HjvOIocRyPQMVZZDk9U1UUOoSobj9gm/OK4vM+I86boyFVThJ9Q30QOpUZ262cE
         0aRefoB+Q7ls8w4pYS0VwMyqJrdKOojp5krQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686239; x=1795291039;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=k/ngXTANVfgWVBaZ9moI8+gg6ATl3GgTHZawW7WESbw6hO2dBCTjn8t4IydSPn67hM
         1S3x3R8RFNG6va5mmu6zTkoqXJr4tPVlU86h6h01ZHeNRBi2CFww8mUsH7cawqQNSutc
         xXXzSXdXlmTcC9r5K2ChKumBCviheboEpd4uz9jlGuXqgA+ZmeYdqe01tqKwxr7CjE25
         KZGNrpNJR5+dnKaR/5z9IRluCkwTIYYwh8YwFHbGqBKK9enJ67vekpVDiCOOkJHrZS9/
         Vj0pVuLcP5RY+EeX7bdM/PE+MyU0ZEDVdVDoyPEz81ntPfBUzKM0oQcl9bKyzWDFRZIY
         er1Q==
X-Forwarded-Encrypted: i=1; AL+hErHlfhFzggPcrQkn7TxHtCp59zl+Ea6AHI8k6slSl0MB5XrWOCRccjXE9dwL3biC+0efxujBcEUgnfpmTXZ9@vger.kernel.org
X-Gm-Message-State: APuU4Z9YzCL9oRzyhcBT4JpNInEc3dz0+3YZ28l0fgMwhcmOhCpyWqUa
	KKXmTqiEai4KdnH4WslpYyKRvrxQkodEZxuyLTR4ngTI0lpdXY60pTKR1m34+76fWwc=
X-Gm-Gg: AYBFou3i0nToVKEKo3daFBFX5iOyDnXIde0V0jJCT03en903AcSE3OrqBzCPi3GNXhp
	fmC3t6WaJFE9iihQuVQwMjR6Ms/ZDQNaqUh+PQoJLpKKx/juJ3ESbjBkz2hkapweTs2Nhg71zzO
	1Ac7ie/NBbPBZq+OcMBdkJUh7ibPeW9w+AcsJCmufsZYRbJckQTsPEYJ/x67nstXMUb/V+ccAW+
	1SNxZTH/wtmtIYYV1lQztUZuprsWx5TFaRhuO46UhvCazt74cDaVKO5BrdLGnGFahL/Swzipnfj
	+OR/tjHrujv3qbYCbbNnS0PyU69zAVo7jf6fb+qTvUXiiwdOTwwSuj5Kf2QyKlIyQlYOkbMCgu5
	BJAKowWnVPB/Vxbvt9JqVHqiEN2D+dG5LnWCwQnSpLRTONMJYKNSnVSAJX/IInV36k+lbZRRilw
	7x+NDUvhSuV2bIeyr3O6JxDhJk8r+WHaphLXIOjZjW9PeMaFISz3qpsWr5jrLMZByiwPebzTPAG
	tUlz1gQnckB4TDp3BIvY2y7f4njxhvrIgpmkBOto92P+iGdpzoLLaung63UCr0EhUp+ClMcpS8V
	y/iFRAxGvDqXsa3cENwM/UkELoCmI8kd4u2oaps7wOV4KeJka6wyJEi59evafCmbgOwp8oX3yEI
	9TTbjUs3MN4MYwWQ/vt855fV1GcN02+jOT9yEaWe8BU65ppi6BhR5ZVYGSMXhjwXd4Fj96MykaP
	c7+u9gBag87gOdhJ5RE7Dy+ooxNXnIExXFoEYkk+nmI+AIKCuKvzZu6A==
X-Received: by 2002:a17:90b:2e47:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b1b07e9b25mr4925477a91.1.1794686238731;
        Sat, 14 Nov 2026 11:57:18 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3a903sm10737441a91.8.2026.11.14.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:17 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:14 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 13/13] percpu: queue the balance work on an unbound
	workqueue
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-13-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-13-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115714.04d384f992f7a635@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
