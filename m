Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689901;
	b=jzgHO9vr5Zb+nAgqmXH3q1jCfVE4S5mYYlo08NS4kbDNboYk7Olp2sRnW1lw77Vux9zC
	 laRHTjlTDBFKnBdogZyjpy3o/vRruKHWWQRUsa1LiC56Fq04x8sgJoF7NtkYvSBPWHM89
	 uof/a9Fgyi1pjY0EuadlNguLD2+flvHYEPkeDwur3+8ib9wEYchIHA6ARbEOeLitBLm10
	 ns1dEapl+IU0ksYBP5o4209jtOOu+uGmWzlEOY34VvAmT0jZ9BWvsRZ4A9VyNRmhubAG6
	 2ddw+iJL4KYiOXJQ/ME+qb52ojmcBXgwCo+LwRXOMb2Zoodc4H1Ekxozac/CBBATuig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dTzX6/OrqoSYIYFMnL47MVuXS44X2MuyVzOdV4a6oao=;
	b=xK+iAH65wJZG4iiWhMVrhrK5D+SOBpkt7r7Ih02dkAXtBYwArvih2KFPc/1beOnWwYs6
	 FqtJBUO3bpHZJBlNzZ5FefNnBYeJrCi8rQHQ8w9g4pB4DtkAPm4aPjeEKxWorarOzqoh2
	 l4iXyysixyrvf5FVEcdN1fZCtcJQ4XSLDTQwf/70IxGgcB/egew6qlpu9VNDSvQkKMuur
	 JnQQ+Yu+N+yxA7QyuRbZS1r9kJF3WAgendZ8KZ2gW7siVs7kYiBrK0h2p+RSX1fzFcuaG
	 P4MJPIzHitHTO7kbPM0JcWCaWvA+ibFwOX1PbYY453gxAI4TfYy8JaY014e0N6qL38Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tR/VI8cP";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22642606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 10:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22642606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tR/VI8cP
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49a92144733so3411537f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795689899; x=1796294699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTzX6/OrqoSYIYFMnL47MVuXS44X2MuyVzOdV4a6oao=;
        b=tR/VI8cPcpG5hymT+T1jcM5A1W7L8XQdJUT+lNdQZXkVX5/qwTisGBB28S9PUlJsJ3
         07xKsPLkA0fzaUCLNWHD6ptTWhEJyZ/YpopYg50jdi4XQiqSpBJEduMI9nMjK3kLW/dc
         SK2nfH7/vFX/59Ji2uVyc0V1+f2jvFsSc+bR5DsewBYNgIFkASD7O2uYPV2xtYditdqh
         08vGmNfJZQeDPhdI+4ijTOI+LRWnffKfBLoVsVB1lfqZ0iTk02RXZm27biW8v74SGE0Q
         1fUak9psa8IkZFIMAsMVsPq5d0hSKpbhVb4lo3tv0klvXAWVqs1YAK7Xoz0HGESm7LTS
         hhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689899; x=1796294699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dTzX6/OrqoSYIYFMnL47MVuXS44X2MuyVzOdV4a6oao=;
        b=VlkRmZF575zoIrnaJlcXzaQGgss51K+Ar810G4vEok74+pD4AEWluMbjzyYecOHeOI
         7YGoigzTZy9zxzseeZzVfRVa1bRBEy0Rh+FrysGisAJ5iUHJgfPqJsE2aZ9SFajhgy8D
         DR3drAm+f6a02xXJ8yjugod6nDzZv4W+JbPQ+WpSsES2xfJVrecK5NhBjY/+NTyVjhOZ
         oUYVXQzJz+rsy9Xcy6eIL8YR9nwgS9O/JkZZTrju3x4HbN3kmcmZ8rV7fiPi1IKuDif4
         PznmSU4jUJm4Wz+WjyAxdeOp4knWGhdzk6RX0gp1/gIEhjVE8M+UN/gtP6RKxrUoyZHh
         P6+w==
X-Forwarded-Encrypted: i=1; AL+hErFDsyXSrDi2hH3UXzLNAXrsEpgljFgVDnwHydN+RR+iwpYNDxLVvjjwp/309q3YqqrSre8PWZzI8n0xNEJi@vger.kernel.org
X-Gm-Message-State: APuU4Z+oxuE9peYe+pWMjBf76YFVNFpfM4lU03QqL4H9WZefnr7QZc9y
	VKJn72XAemMg9f9lUNfa3YLmjrFwwamf46Ok+SHyLhYW0i0R0Eadh35v
X-Gm-Gg: AZFdTZfyCEQcFP2EYOjJT2nebnyMWhTdLbxrCgdJbT9coM4otM8ex1ewGQMTrEWwONo
	ElnQoBrb+qtJSqlV3lfyCZxWoN1g/AgkmZmHVyItP+97p2ZQ3RmTo9SM74U9kOtStmlv/q8fINc
	CT1uPrwnJERgWV/+iOM1t/uZEMu/YM6rQV3nrKqw20XGj2J4RPXwJw7EsfUegNFFgclWXTMFE7R
	kjnZi0Ut8+XkdMXe5PHS+kG2xMxB/r0d/fdvqSTGCDcoXGZYCETfWeEGz09ZGWCtq9v8HemC+e/
	bPchtzPza3U6bWus3Y+dlCzocAm7NnB3volkw0Xpp4qkgfpNCnQkmIv9yFsx9uL0lxwa7AvlUgn
	xYZSI+pE5sRwXsaR79muo3jKc2omfCJ8oIpFn+ipXLKcoPacC6qsVbwaQncBCDgBrFcErz7l1/k
	AvzFEuRLY/R+SqXwvupdFO0jxFAHYLIql5taVfeyKhbiS/R/kINKaQaehRwBA7RdDBXYhRblYfY
	t9Rt/BO0gyN/dTKIxHEIeEmG06bJlFMbkjDwmDxz3ygIOABXDf8mu9JNbovfuv79LRSXOQW2U3k
	67jf+WIclv2m8OcGW5O0xx7hJggs2qi/pyYwKOPzJSwccBrN0bwCt6v9l9BaZplTe6rVBTkGAAP
	C0qvdZqCz5KDRHxXwUPwb8y0ev6aRSU5q6vq80+66ZKScTrGrA47MuVxgxmy5ZtvQu4b3JOIzGI
	tHrOE=
X-Received: by 2002:a5d:5888:0:b0:490:a481:7ac8 with SMTP id ffacd0b85a97d-4abb532ea79mr37997103f8f.29.1795689899355;
        Thu, 26 Nov 2026 02:44:59 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm40898578f8f.2.2026.11.26.02.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 02:44:58 -0800 (PST)
Message-ID: <0b76171b-7f2e-41d2-8a5c-102dbe4cb85b@gmail.com>
Date: Thu, 26 Nov 2026 10:44:53 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] ext4: Add dma-buf read/write support
To: Mengmeng Zhao <mengmeng.zhao@linux.dev>, Anuj Gupta
 <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Christian Brauner <brauner@kernel.org>
Cc: Anuj Gupta <anuj1072538@gmail.com>, Nitesh Shetty
 <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Li Wang <liwang@kylinos.cn>,
 Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
 <20261120154153.GC28611@lst.de>
 <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
 <CGME20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d@epcas5p3.samsung.com>
 <20261124084025.2101804-1-anuj20.g@samsung.com>
 <3bce3a69-e41c-4683-b1ca-9477dd41a7e0@linux.dev>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <3bce3a69-e41c-4683-b1ca-9477dd41a7e0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/26 01:25, Mengmeng Zhao wrote:
> On 11/24/26 16:40, Anuj Gupta wrote:
>> On Mon, Nov 23, 2026 at 09:51:41AM +0800, Mengmeng Zhao wrote:
>>> Hi Anuj, I'd be happy to help pull our patches together into a single
>>> unified series and send it out for review, if you're okay with that—and
>>> would appreciate your review once it's posted as well. Please let me know how
>>> you'd like to coordinate, or if you have any updates in progress on your
>>> side before I put the series together.
>>
>> Hi Mengmeng,
>>
>> We already have updates in progress on the XFS side.
>>
>> We will consolidate the combined series along with your ext4 work and
>> related patches, keeping your authorship.
>>
>> One more thing that we are looking at combining is the ability to share
>> the registration across files. Pavel had mentioned this earlier in our
>> xfs series [1] and posted a series too [2] which needs some more work.
>>
>> FWIW, we also had ext4 changes, but intentionally started with one
>> filesystem (XFS) so that the common interface could settle first.
>>
>> [1] https://lore.kernel.org/linux-block/4649a20f-aba9-418e-987f-66f21ab24410@gmail.com/
>> [2] https://lore.kernel.org/linux-block/cover.1793751001.git.asml.silence@gmail.com/
> 
> Hi Anuj,
> 
> Sounds good, that makes sense given the ongoing XFS and shared registration
> updates. Thanks for including our ext4 patches and keeping the authorship.
> Feel free to loop me in once you post the combined series—I'd be happy to
> help review and test it.
> 
> I looked at Pavel's patchset as well, and noticed it adds a new f_dma_io_tag
> field to struct file, whereas Christoph and Christian want to avoid bloating
> struct file. Did I miss something, or do you have a different approach in mind
> to avoid adding fields to struct file?

I'll resend it later, how to store the tag is the least interesting
part, it can just move inside the block/ext4/etc code, which would
be uglier, but whatever.

-- 
Pavel Begunkov

