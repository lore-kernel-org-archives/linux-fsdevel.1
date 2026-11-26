Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660487;
	b=yNt8f7r+nE+VNWAsNzMh7i0Qw2Sc7iC4iA2v/+zUlxysG2XWpNHfXXdK55GsfsAAWX+6
	 DTD9xjXuUHYzQWa1Ri2NY4dv5OFwJPMjLcLQgE9kfLM4k9KWlYfioXZ86RjvIYwFRxure
	 lslK+E1BwvSD5axCz5IslDX9g+yZ2rnj68AN4QxjakqLciTi3wRK+RkJQmd3D0ohEDF0B
	 1GuTFcFe1vO7avRbUlMzCI2RUlnilSmPzKPHVa8SYjxsQcM61/UYjBExuf4uPzcRFIWXQ
	 TJ2/Ax/I6nGV097gpRlThW9MTkt3NY3kfiHHxAnKX5L7bO/hKF2uvtwNHaXYSsEYHoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=o8J9LgNaOdUC46WHWDlfzHDnkRTN/ql1qdkuGk8pFsc=;
	b=ZzA0Y6zy9JBAA4B0ZsKIevMH9O3lQ/iEV/fOLUgv2uqLDLqw0CehfCxqXIWtWvLGs5mo
	 jLk4o8UNehcgbo2Gkca0r3MN3kIdCRZ/DY6lBwI9+C4xKcnp0AN5G50FRXvB7Gzlb+hme
	 xg/miM30B3xKfV+ICNDX1Vflmd+3MHoiq1HYR62HorrtAQMsLGPdIgWIWq5VLAaFg5CV+
	 +SBOxKN2vHssZTzufoHR9+OtRg3wTtdOBBUKRDqD1kiBOW8shYFx50+B9iZKv7MBh1sOf
	 8/LBFqLsWw0HfmlcTdJF19I2Sw3gHAizYWWZIbH0xNGcZgeqaArdTIp+gr5+/793brw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DKieMBUw;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41717606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41717606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DKieMBUw
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67dc7eb1442so7254777d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795660486; x=1796265286; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o8J9LgNaOdUC46WHWDlfzHDnkRTN/ql1qdkuGk8pFsc=;
        b=DKieMBUwIXK1Du7nNws3K1cWBDItLe9blorA2CHh+HazEu+PARsK+BsD9aOAlUs9Bn
         s5RYV0OAi/qfVnljTPHwhemFInICn7zykTUXCnOU0Y6d5pFh1qRC8FHhrxT0KBeW+rgK
         y6vrpALNJ+E1cqgUHzbBP9EMA1lDXkBPpsJbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660486; x=1796265286;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8J9LgNaOdUC46WHWDlfzHDnkRTN/ql1qdkuGk8pFsc=;
        b=fZr2W/e1gyicSazyCDxqD6+TI6rD4CLUlYlP2g/a9YIH/gNgjt37xq0Tn7i/D4DjyJ
         Y5bmDy1tmHlZ65jcLfdu1sbq6h6/kYVN+i3qKnvo8c5wpjoXlfpqMY8lmgRHqP276P4m
         q4CUL/bI0Xb1giLryV6A5maQfVXSxhst9xOY23GziVoC5CNrA3Mi1XFG/z/AKyW24IWI
         6j0w4dCR1ZJCt9+6P+CwgLbveMm1nl/YMBmJkeG/nAYs4DtCXZyP7c2TkRrIVSgYHkCE
         HmiCZZQqp0gqt/v4Mgatl0HSD7Rk5dGluiti6AKVygXIUE001seDjVvOn4nZxpQvprRQ
         JTOQ==
X-Forwarded-Encrypted: i=1; AL+hErFCaqHTkuRAgkurOHNYH7+FzQYLNEn7+my7VVnumUHysA074b8latk6XIJQOkPR7VP1/CnTxp6+/Iz9nPiv@vger.kernel.org
X-Gm-Message-State: APuU4Z/jnRZzjF3VBbBUcOCVTIY2pdSJaqFVJRKHtB/wrpoB4Xt4D2WO
	6VXy9PAx45GCy5JWpcxnXH7ORTzfGXQxpvWt9Ak2G5r1viZzQaiGhSotwvJ0DGBl2oc=
X-Gm-Gg: AZFdTZckStweXiKUbT9qveTtwOTjF5Kn3jz/o3vM1FUZ/HmcYrBkdWVPNJNi6X2BzJv
	/1SVwcp1ExDcR3uTf5rzKQFmO/a/WokDsvF4qsKexUQo+GgJZ3Bjv5alZJp1fDkQU+scPcNUpQb
	w18eaku7684DctfSBDbcjPVZikQgPoZqWn6upQZg/tKK5r1rKih+IEXdxW7BY6nSNfTr/cxJBe5
	usPkKh2o2bjj6IHcWATof3jReDGwAtimvVgMoNZfVskNwbNr//+VOO3aSD+43LT5VF9BDMX0ZF5
	kcZIy+4iM/Lx8hGh2ageVDhip2Ea2OTe4HSIwUegE3dhW/m7sJiSlc4tjtgT+Zz0ByuaRkiS4TA
	3FvWmODfQVwMAbX7q5bIZDl1l0P9XElePD5+sMI49v6tE/A1ps/ly00QcHqU45WZm9LKIVQQSZi
	Q5d9XNc8Di78gPbrrlnmgD1fC+JBIYPQAQ3xCehNzhulDjugokopIg2ofHI79S835sufb3lAPcE
	MEo2xqSnZJT1xrH4/YCpWEnqVtG00jp0AQVvHBah699xG3h5NRdLAHRcgBUApJL6YesQWjRI1+h
	UL/FKfcCmaoio3sjdhC0j8fQ4sDfjme4SH3LSYDDxp6+WiNIYMrMJfls/Inrb/hrjm1WOnDhVqN
	nmm0/ze6WBpOT8+pDDbeC0Egdvv2t9HnxGWc5m9/tHxa8F1h3dLGOteos8mJmVz0DY0f0mGJ8fI
	XI4pugP+9YF6ZLx+04fc5lTd4zD7yRjg1yc3Yi6vsci56qBQXQ6OfZFg18WtmhaEq+kam3VL8wC
	AeV3apoBiwkHKmuULqpVPo=
X-Received: by 2002:a05:690e:4188:b0:67d:ba77:6ef8 with SMTP id 956f58d0204a3-67df441dadbmr6760137d50.43.1795660486244;
        Wed, 25 Nov 2026 18:34:46 -0800 (PST)
Received: from [172.20.0.2] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df3354415sm9646045d50.11.2026.11.25.18.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:34:45 -0800 (PST)
Date: Wed, 25 Nov 2026 18:34:42 -0800
From: Chris Down <chris@chrisdown.name>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
	matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
	surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com,
	shakeel.butt@linux.dev, kernel-team@meta.com, baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev
Subject: Re: [PATCH v3 0/5] mm: fixes for THP migration, swap-in and
	device-private smaps
In-Reply-To: <20261123163301.1568240-1-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
Message-ID: <aweawqOejY8Jyrbb@chrisdown.name>
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

Hi Usama,

Thanks, these all look good to me. I reproduced each of the problems on
7.4-rc4 and have verified that the series fixes them.

As such:

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>
