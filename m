Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827434;
	b=14ZRH6JnTMVH9trxIld/1JyqhGK8K5aki6VWhDUk/sMzSq/8eCNsIWhRCzfTkXQbA9jx
	 7ZZ+038ItH88YJxatsPzw6oLdVZwx63Ut1HeF5nkR8Q+zqEhPMoJX6qBExUOb/TPBOBUE
	 sfHdhbWYPpgx/IAnuEdJKO4r8TFVUZ0Av79neXbLuY2HHHMwVfEuQ2FUGnv0t7ctF+Jzy
	 GmQD3R6uxpOTvi0OsXXoqdv5JoKOhY6R9eiJmmF36x4a18GzW+bNZG9ruyPoZJH4v1jAJ
	 onybqflwjPQGEUVCbhUbftHsC7YOR6MJiliiF4zqW4WBigt6W0dH4zihSeTvGWWe9tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=wlqqG4ragrnBG3kIbCybUs0/KOwqWAzi+ZO0z7g/NRY=;
	b=LyDsFlRvd/0o4mzmMPIMcxxm5hfUt0jkUNAiODHRAwKhhapJMdAk3Pm9AcABblAGubOe
	 ZdDC0aoz9u70N6X4I7f+RYHOcz0sYRekJtYs1Tzmh8X5NtHKwYpa8fH0pMJ4ySTrEzYK5
	 nSIpu/7hSiqww1pP/7lT9M6Lro0UhlAYfohH4/3s0ETniinAix431MGevQ4rLUsDQHB5K
	 AxJ1iI1MKovfmboPNwSz5JEtqbfFYbWXU7i4+I0wn31RfDNOId2n3RkCUYtYl716P9jXk
	 R4l2ZwpUNNj3S4fpa13mG7wmXDudJzjFN8zCb7iz3RPBYXZinxjvUaMc9CzHNy1yKVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=C1mkJXCI;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF134606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 00:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF134606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=C1mkJXCI
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b51871c5c4so60519457b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795827433; x=1796432233; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wlqqG4ragrnBG3kIbCybUs0/KOwqWAzi+ZO0z7g/NRY=;
        b=C1mkJXCIpLkt8JNKyS0smGUjMBNpX+eUmxEBhz1pCUi+tcqO8q3OQNR2pwPtR+XeLJ
         0JcHc7OYWkCm8K5+Gz2alY2hfBPzSXfMKabvA4BM6/oxeufS/Y8Nvnp52T9Zh1sVbaw+
         yuRMDZQTZP2E1Ur44LJtAMS3wH5xY9PSrQIUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827433; x=1796432233;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlqqG4ragrnBG3kIbCybUs0/KOwqWAzi+ZO0z7g/NRY=;
        b=AZJdaWWnmY/FdqzmyNXYf6kjc6aewO9+ZEAc0kzRVYsFM8Neqb21m70VcijOL00MZG
         VA3dwUcW+14dTN/oWiZm0h23IWe2tdz8Z1Z415NPOC+LxXHZAv2XPXNyXTE38hbDfMfZ
         i1UIF7XpYfmuCcp92Go8RBVGUAxrKEjLyDWfLFIaBAA14Enon3bgwrjzz9dGm3zElKLD
         u8ELwtgy4U6IfST5v1Dz7hwRu+r9q/Ya9WyWejoNWUauJNI2kQUwfvTDm94YfI+01KMi
         Uwfc/jbeLEjZReLmGj4RpywbPhfBDzku6MzSq81bGdbIGCUt5PTMts1tn3IJRHHP3E/a
         1Cfw==
X-Forwarded-Encrypted: i=1; AL+hErFYNkzj4vVE4evpVVKrLNXn7ucznutewkfw4JZ6TITRkgkfIU684FtqCSTwUbeav6G30Ly/e7Hscc6t7GYN@vger.kernel.org
X-Gm-Message-State: APuU4Z82IpRQhm8t3S89pETyFfllS5Z7/dWzLBjGT0nFrTu5nvGWAfUz
	T36EENEJSHwErhYf7RTwYHdYRc/7Y+jglHqqzot9SiRr4JKfP7iPIHa48v42maM93ag=
X-Gm-Gg: AZFdTZemTavNpzApzEEMeHD8wWDlGbk/Guc8gmnFVhV35Dyv+0WhlhcDhiUp3fbKnah
	d+OHvWdiq3DiCRzHi8ipmgKqcRQ1BXg5GLVYJicgCMVx+AnFNEN1ZsG8iV7BtoiU0MzwtwSNNw8
	jKG5wfiPBal68OlhT1wur5vOqB/b+mP/SvJsEIqhjQMFTfP2xQlbHe/bgqwpH3yYs4FFgMBx9Xc
	rLCHesNie15EEEElopZg8O8ArVXvujHGZhuWyo8wFIX9g6rZzcoKDOQpeccrPfScgFkRxoImEVj
	h+I5GUNh+ll/d3qirWaK1ks3NNPkYAPkMlubQSK5b0Hjtg8BBNYS6yLCtpOOE+FodXzUZgpFp/Y
	4s4OzBxk2o2UwXansgRAvsIrXBM/Nw3q8cXVCiOzV+nwU9JYx10yR2CzVpbiE0TKtp9dQip4ZKs
	HHEzJa6KLYBLQ1OVlWJtmP6rXiyVlYAYSyIoHo9n79v2ZT/JoJX44rRv0Ofhk3wa4GVTeOAnOFz
	DDeJI+BmcUgtbhsRTgRdHIl2w349i9zWTf6Xca2JXHefB2PLQcd11YiUg48Q0sHwLJM09JdUAdQ
	2GzEWDSEuTtSDGCc0VKhKMeqH828dLHIv9wHlCtYAo47KdNysuvmVLAC5pZtoVjrs2aesDbFOoJ
	PM/I3UBroB8ogoZ8k5LqkKiycccgCd2dOarWqRd4VdKXq2Ej+ilOcf7sVvzpPmnIdIOUPxQNwdy
	e7eWmJvd7HXubF1hr27ycb1S3FqVq/QbEwdDAu9oXHWBk7L07CXSLaSfyjlnjpq71xaXxLNq/EC
	yAHY8kqc2t6rIvGxhr3onI=
X-Received: by 2002:a05:690c:c1b:b0:87e:645c:182b with SMTP id 00721157ae682-8b5204dda89mr106486127b3.26.1795827432517;
        Fri, 27 Nov 2026 16:57:12 -0800 (PST)
Received: from [172.20.0.2] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028d628sm99080227b3.8.2026.11.27.16.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 16:57:11 -0800 (PST)
Date: Fri, 27 Nov 2026 16:57:10 -0800
From: Chris Down <chris@chrisdown.name>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Greg Thelen <gthelen@google.com>,
	Greg KH <greg@kroah.com>, Ming Lei <tom.leiming@gmail.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/vmscan: Fix legacy memcg reclaim deadlock
	against filesystem freeze
In-Reply-To: <17d0d1395c0237d201a1abb2473d51f5@kernel.org>
References: <17d0d1395c0237d201a1abb2473d51f5@kernel.org>
Message-ID: <awom5tLa6tNWPZYK@chrisdown.name>
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
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tejun,

Thanks, I've reproduced the deadlock against fsfreeze and have verified
that this patch fixes it.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
