Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968270;
	b=UoIvohlVCbVJhxDBjZ++vKiKKS/hmGgrTHayz+U4VHiHWZlZFYEn41rCq6KhfqfiACal
	 MRYd/C4iKQkHoRrT5ccNcvi8X+ONV9z5MP9c1nKtEi23yjhMa0q4MtO2dP07dY6dstVqk
	 5Nt90xXWwpCvGkPXrzduUVTKif/QmZt/ghr87Ff/n8W6HYsqEw83dVWtsmJTcDfpkKRjO
	 miBrHHy2xiN0VRtfwfJCEY0zkLcP9nVDLzgZxf6X784Hk642NplvqTR5Y7sTvMrpdRfmY
	 lwUTFu74wt5vmgbzP2emehdbxL1fmbVj87pYH2EtwjKK3MbwlOCXXCEeNwt2gJomWIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=za7hVhqCXuZnylgObAS3b8lRUZxmuRElCIY9CGv7ZSI=;
	b=Hp8AlRLQM0aQ3SBwjio3qKnRKvxGlT2CSJaqn0tMfCj0WYwEt6c+WzyjhuvK+Cm9+Zjw
	 mACUe8yvIZDs12zL/hykQ/6VYLdyU1yBSXOPShf3FdNl1NZQlr96//Bo54KT+ZSLl4/0e
	 mua5VA9QLy0OC6XAS+nRvheJSntFzk/8BStgJ64J9aPMZ9bYL+JDVyxfNz2r3uns4xR6C
	 mDroIrIlQdn0WJpUbQDqDelt8uzUaSwuQHBFzht4RcpY+bCjtU+BaGTTkPIG6G8McZQEZ
	 r9k2oVrrMdBSC/8lD9tf/QBzftdxuZ2NOJtPG2xu3qWT629T6+RMMvoj0FspM5vFPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UPbv3cR+;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17661606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 02:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17661606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UPbv3cR+
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a8cc11ac42so713252c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 18:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794968269; x=1795573069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=za7hVhqCXuZnylgObAS3b8lRUZxmuRElCIY9CGv7ZSI=;
        b=UPbv3cR+Ya0LSc709IdS01uNUtZaJppByTyo/zCLDyTAPttY8OMT69q/oU0XZ7DyND
         z0VldnxPQ3FW7vmuDgBCgaq4sD3185+dnx1bLLLT0RkeHWR+UuARHSGtInhv8ux5ueKh
         ypA2xzMl5O9yUmLDHJboINTRIY8tcHfpDt4J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794968269; x=1795573069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=za7hVhqCXuZnylgObAS3b8lRUZxmuRElCIY9CGv7ZSI=;
        b=2Dxhf61MgUANuYdBY8a22ukzzF304bdrAUkXPp6vYY30aGDCNKFsOpKsFw1DXuzFYE
         y/KhPlM3oHWxwLwvZjjrlRbJHGzKNF8T5zIK/+DPKhJuwZAGUY8jd199ILSGN2UUEMpv
         7s6LTnqT60LQVKhD7OrOtsd1u9qojd2tyA16BQOO0gGdhYH9V5NKTPogbNvFYxl+g9cw
         fOg4Zj5IsDGJ4VYbO34JhccYxHp3K50wHLPSUqYhAtbDtLAYC+zi1Wya+/G/vmep9En8
         R6LeEGSstZ27gvuGDg9pGbDKf3DvcLkfBQkelPkcEizdpnOSomioEjOUIYkBpwQn0e3T
         sFVg==
X-Forwarded-Encrypted: i=1; AL+hErF6FRku2uDrgBi4tIN2WWLhLgnVtxIlFtCU5+lyxoYbGPM7yRkffRd7ogDn+JFtFXmJlFED0MaCVuOS6Gbi@vger.kernel.org
X-Gm-Message-State: APuU4Z/fPC90r+5D2ehPr7sZn7IGFpd1YyT6DTWy3RP8c+FYSQ+QWJPm
	BJXRqXkZXO872dlq4msNda6RbH8tiTpMN+UaZTsiXd2qVxyzi3qaCQigyXjUbbd4PQ==
X-Gm-Gg: AYBFou178rkuq0YgP+L5ixFVXho9YnlYE66Q2VdL3jUigW/Vys+jH0XJapoRE0G5rfh
	0QcI0fLPtayrfIiyCN0VItVxaVppErJuZ57p2AL/vr4XfqEB+O6PSY1qjxq+jdYkvzp/Qyu1kj9
	7EnqHlcizwrU8eWY1JIEISpjg05Sl1iozWsybSyIorEXhWWoSQh8q3ZQ/CdLKYDxmSdLvvgt6A3
	pwfYngJB9VICpcwUnL90rTs9cu61BtX7zOnZBm6a1vseG0+zWXuU2QCx5xfP6tM84VQ+3BIEwZf
	39zcnXABn0Idj0qpL/sjO2Jx9m7cjqtq8QpSGWjpWlui5H3+wCVp7kFKrN4dUJIEHoYnHYf/TLJ
	DSdQEyzOkZauHnLuta7aw9C3xM3eiikAUrolrzhg99QcceIBbGfif0Cb04PSrAgtIaPxzpykDUC
	FbjqF6KVgKVXhgDIh0rppB+c7hrs3swdgdY5NMXkUPelP0F3xpWznMObMhkfF1samfyF1PX0yjz
	BlfEVf08lu/UwnR4ld+uUEcv4HGU0Qj+fojZnt3MV2dpPu8jaWfEYXcB2aUoMh4mYthczuM9FvX
	L8sD5y2wKKx9g4j2B8h2woHxsYJtE8dgRjprqzDiQSsAN+UFtrSis9efGKef9pDsrb4bgg==
X-Received: by 2002:a05:701b:2097:10b0:1b5:281e:1702 with SMTP id a92af1059eb24-1b543d270d7mr1285759c88.41.1794968269079;
        Tue, 17 Nov 2026 18:17:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:cdce:1079:e29c:bb93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7eaf3b3sm2155994eec.27.2026.11.17.18.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:17:48 -0800 (PST)
Date: Wed, 18 Nov 2026 11:17:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-new v2 4/5] mm/zsmalloc: remove unused zpdesc_lock()
Message-ID: <av0KlWcq9TgxiSoT@google.com>
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
 <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
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
In-Reply-To: <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>

On (26/11/17 07:16), Shivank Garg wrote:
> It was added in commit c1b3bb73d55e ("mm/zsmalloc: use zpdesc in
> trylock_zspage()/lock_zspage()") but has never had a caller.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
