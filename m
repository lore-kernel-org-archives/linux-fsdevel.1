Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686197;
	b=tr6bobr2319HbgYQdpZlMzQ+N+QbjeRFH/IMsQ+aOVyYFWuj9D4QhneL6u/CGwerpxvk
	 DYEndB54IxyPu1PR4mZhb+6TuGYY2wP3c1FK3QXw6D28nM1nH/oIk2i2LnNtHNj1KAblj
	 EsPl41PhmeFuf2A5ww/3mPQKSHc09E3x+b8RuijHZLxc3MB+ibiDEMkd6djpmkJL1O2tQ
	 ZJQV+V5mtAuzKsYSEmaV6jm6rXPjnj9mh3TxxKbmtSbmRZNKjJgdu5qauisvER1VPu6XC
	 xREZQYh+d2tkTTfTIVgzUuMuJDWqMaXdx0Qad6JQfu8BFW1w6Ib5/xknBORv+aXR05g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=M5xf74SF1IJB+GwjvbT5WVTIN9Qc9W/2f2algOzAsJI=;
	b=WQpcE5vZoeSvUXkWk0Hzf+HyBm1j0TeYdGWLuagAv1xy/EFIFsxtTGwmnb/CNum8UHRm
	 H4bJhnhSny8EfnXvXlgxL0TKLEOcf9gSj9SUlYYoLvzJ6SsQjLKmIFdo3VfPhjli2suDq
	 KTa0bmevHzy08VTtuCeAZVRNxX2GY8CjiYWgXftUoI2JygTYNf1AFScgnJIuAOylqVay/
	 g1KksdUXwqTQ9ry+8W4tCY9/eCnhEc+8ahVzLkyXVC5za1pAbl6lGWPkKN72HuwihDI3a
	 Mvxy4Lm9l93uswmiltMZgd99uvl03qt0ngDmjNXK/NBqw+dDxqWavhUvYv+UG6/ttFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=frR51aIF;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D0606A32D
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 970D0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=frR51aIF
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b0ae89de91so1325656a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686196; x=1795290996; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M5xf74SF1IJB+GwjvbT5WVTIN9Qc9W/2f2algOzAsJI=;
        b=frR51aIFf5WRfgU3th6pOYCYM8cPJl+KR4SweyAH1sd2oMQtEvVXeAyd+ik6wWZZbM
         18I62ot4lGvwOuXsbafyedHV4rvfyJBzrm0Yichbk1qGZ77ZtF8h+i9uX5pUWNblKneP
         esVU6y26zfavI874j8xW7a93My6Xj+L45Zcj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686196; x=1795290996;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5xf74SF1IJB+GwjvbT5WVTIN9Qc9W/2f2algOzAsJI=;
        b=MG2okGOgDAkaq+wROHsjuFXwZXfNwmwVc6z3lod9fu9SemXkgbrQ+wlgji1wrmkuOa
         WHKyrUFvT5J1TYJV9GY3iwaioD9SGkWMZXAFWnQW+NLBaTP2Yu947FLHvBf6w/kVSSHD
         vYL9LQSIn3AtFLjDe7+WHpvEFn13hJm+LP7MEygJcnkNes/sBdIcoMpeN3qqXj5RloAf
         Tp6E8l9HzIZa18+r8O/XVrbp3fzOzXpwhxHSkr6kOYq/3qsKjtzRREJb+ChUINAe1bPM
         VKs+e+emQPK61E/bzJjANiMepz9401les5pNiG8NNzHBaJ4DRT/NBhSVn23BcVDkHPxA
         cNNw==
X-Forwarded-Encrypted: i=1; AL+hErE+AtxBMLjXpnGkT3xG09p5RmMW143hAZrQUWggQN184GnDg03TAxBeoHhRGjrFB9Z2PvB+in50rUplAPjj@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vp6vrpjeh4lt00yOdd2nV1gMo+DFpV1S/CPqXyKFRao3uASMO
	118JHo9Ejm9kf2OJpC3eJF2CfQrlu8AqndkqFPHCgcZHAu85FMp+EwrILzyJtaPy6mI=
X-Gm-Gg: AYBFou2t5cclilMTFG24NmoXNROiiyWYXfZkOz2kV2WIkstKrE68nbdLmgUVamMMMDa
	ua79elKFdDcIoRznkhGY/kHybJVjj00xM/LGeNnh1H2UiZcD5+IP5TnXgZOg91bHh1QU4h549Ya
	xE7Pbyn8ko8tsCTwR2hEl3kq/ZItL3klqMsJVL3gUj0+quD0SwMfup4FHps0Nbq0a9hJTWaFHd9
	n5suPdgmI72RGcLoNCVPwxv6leGwGWTjQW8tu9uYmkasnJ/dQMkrYCDQht+0o/wOLIhE/Hrq2db
	kPhkReoCGqHGOGNorZcjskoyNQ6ld37f8UkSbxNxwR6k/FUkTSncb03LVHDNpK2J323DZ3IDewC
	4jaFhrrES0VfVy7W/6zp2veNr/XA6OaLwTFxsWgeyMqvm9JTFwglZe1bMuoFJQr6Z/0SW+e3HfO
	Hgs4kv4Mrlf5ShfEWMLpwfb45uVK5jo/6ag7O8bIMKlFuENqznQQbxxYhuxH1H2glB/Dn5k7yGB
	fUDlDIF5pc80q8Fzw+9W+a3SGsdzKL1svQD50TrlrgmnWkW3Rmy5EmicWOR9wdBBDPgNu2ITzgA
	laC4oyGx8glso8t/YLc+RkuYn58kw5XEZ+mxEqqaG1GO3qq/USN2eHvr7FsoKUXb9eLVu9QX87k
	EqsCSOU0/B7haaU7euUE3ZcqXDmM1wD6nyNZ+RNF5kNbD3tKfSeXm3tNAK+UztpiZYsBqX66Vlf
	6cVsurNLzB8y6MmlhhhRkouhULVk4m8Bc9W76JUEQ0dcOey3EIgjqOlKX31Boke1s4xFeNzcDmL
	gCctA==
X-Received: by 2002:a17:90a:b494:b0:3b1:bdc8:c32b with SMTP id 98e67ed59e1d1-3b1bdc8c4bemr3620403a91.53.1794686195875;
        Sat, 14 Nov 2026 11:56:35 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm14940403a91.16.2026.11.14.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:35 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:30 -0800
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
Subject: Re: [PATCH v2 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115630.0b75d0b49869d4fa@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with memcg OOMs where one kill is enough to get
back under the limit, and with it the second kill is gone.

It's probably worth knowing that for a memcg OOM this also needs my
css_task_iter fix [1], which is in mm-hotfixes-unstable. Without it the
memcg task scan stops seeing the victim once its last thread starts to
exit, so oom_evaluate_task() never gets as far as checking MMF_OOM_SKIP
for it.

The test I used for this has a 48M memcg with a 30M task and a 1M task
in it, and then a third task in there faults in 26M, so one kill should
be enough. Out of 300 rounds of that, I got a second kill in 299 with
neither patch, 277 with only this one, 147 with only that one, and none
with both.

[1] https://lore.kernel.org/r/avA1wXhTMs9eY2NF@chrisdown.name

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
