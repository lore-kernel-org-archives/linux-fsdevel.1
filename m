Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659934;
	b=0m8tFHsWbggNtlycwGqbZt7uval08iduIecO4LCpXP4tYZYkRYY76YieWffG5YYQwU65
	 ZXhRIRArPHd1A646hBD3cZM/ImG4R2lUcOuy0BznmVUpvHnajGso+xaNRdCvFpfZrQGZh
	 m9V3TpHkw4n6nkcVCStUMj/ro4OGqiO7f23AeM4QkwWZNfFvUrsk/G/GwO391jYS46Ffv
	 LQV5PKkZzvYCISTctw04JtQVV78egMVR0rhVJVFbv0q6xnabtOBB9dSdNTU8EkvUFJldo
	 JzbmbAWYLjpLBbisRIxagWSF1YIeI4rCpixqaj0r4P0Jum7oovgelg7cdrNZOw/SiWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bq5K8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=;
	b=KmmKSP4NXYGrz+gnHhk6V+koYoVbQf6Q6MHtEVYEAlaoqlfI1rxC9YwnYFqSJ6YpC6VC
	 kBzSc5wmN1IpCj1CrKuFGyq40Vt4LypJ6DoMswHo4YMiRa82TZSO9pmSdmjcJwpUlqys4
	 f3KCiRv35cLtxBBhKuy8+qRB3feLpWNmbZYUWInJ76/blZJrf5+JL2Xv4Dsxq7EP+eH/W
	 upGU8bK6WZRnMqXyvVXpiMnvdnxeR71JO1N6GVM4EQ41BIRJI0xq1Y62Hthbw9lilHS+U
	 c/8PYV88Rn92gVHn7ut3Y67wHD/Rtm6+2cdFdqAxHkf3BElqs43/fFoqRz9YKwn8cww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=azAUGPgc;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Ki+KHe6M;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98538606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98538606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=azAUGPgc;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Ki+KHe6M
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ1Y3u1887073
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 21:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=bq5K
	8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=; b=azAUGPgcRU1jSI5UcEdk
	lX/Oam7hV0qSGuaoRoZ76iTO+yUv1p2TSRxSWqw/GV116U6mifykV1LTK1RDVF4I
	iKOPSY3PSz8vfny7Ha9obUkbMW6zmIsYItSxjLycctsWrDJ2rP2Qa4yaT+QQ9KqU
	+4dz298p9gibceQ5lCgFjd5gQzpe1qreD1yq7bVWWajVHsF3DL8u2w+MyeG6JCax
	6uARcxrpY97cBRd9pD/9MBjtHydvImyxeSEwdpM3USUiXBCQARMKKoJ4GgI1FvmR
	xUwASOZFEFsMGQAO+s7arILwa8QlmuqSFhjk/ZCiUMSZ1ZhwWwfuQrgDVwgAtLqi
	3w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j6a5jrf8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 21:25:22 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2005ce21so1020728785a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795659921; x=1796264721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bq5K8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=;
        b=Ki+KHe6MDEgfProqRIGk0un22f7ITJdGDVR8RFLPbBwg0ny1Bmym8YPhpeZ5n8UlJd
         uG7LtT0XBxXgDmmNj5VuE8pkpIlTsmrOYMww30ypNhH3jQGBmDe/EyrlIGJ7jfYGlEL4
         7qYCGuERLyRh2UNAj2kvUeVApVok7C9JRl8404UQg3FXcsPs+CyLH4KFqOWFLRL3Ll7q
         ARh/AYUGKeJJuaXrpWt34OkALRiyTeYrlsd84E/N4Fe1r6aiLKwda5YULwMZWtlFQtI/
         bCN5U4LkQ4Tf7erCDpoVEO1+B3yiqWYQ7ntypEgKTJuWN2IyZs1VtR/yv8W48b1FM+wm
         eTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795659921; x=1796264721;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bq5K8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=;
        b=b9ZzUZ0cQLbDVG1M30WeXdMjUzp/7ZPsA55s4qpVANSysmeTJtLR0t+vfyzZRp/ePP
         vhPEHZavYO9gg/hhwLszbs/X8mfD9l5ZizoZe7LjEVs6H2G2yAZNs7rFxo+gKSU70n71
         UbCJTjc1nTnBn+ObBTkRzY8TOWcnY8xNLts8EiV9IxCLamcLxgGq4lr5gowtuJ+4Kvi1
         H9nZo0riuFlmrBP7TK5vaGLgmI5lrzqDQNt3GtepZ+vN5TxXTEpUD3MbIE/OGJJ6TUjp
         aykmAokCQKNq0QpmtWN2PJy26MVVbfecOOIYgDdRqA9Ap2Gc+wxOiTc+fXdeMbCrWvGB
         blRQ==
X-Forwarded-Encrypted: i=1; AL+hErHcBdTgt5VjKZS9Rth1Zd9LMqAwYQwgUtkQXvNTbN6opRSLy0PBl0Mhu6PEBYXFNct8uQASC9ydP4Byrzm3@vger.kernel.org
X-Gm-Message-State: APuU4Z9dOPBUqGM8kjsCDJawiWXd0bp+OSjzclW4Mp2BmKi9p2WT3Ngr
	Dfr9L1b8KgAeSXUtX3mDGWtczbEgiYeMax+4H2f8tlGX/JnRBg0+HlQXl+3Wj3k2dmaxh6Dn3RU
	X3eJ13THZIb50XFhU9TOXX3P7Bl3kFrTx0KlknlHYEthgoXJtqT9yzxbAX52EnP4=
X-Gm-Gg: AZFdTZcKVz2KW++8NT4U2+qrLeDMyKTMt6vqgtwLuXxuXM9Agz0pvej1I5TfmNg/MAM
	Y/BbOKFeNWEhCKh9ZXL+sohuYUdUvJWxlcx7tXsEW2uM2dcmmwIkP8+6ceG9Lau0vMgLIhXel0p
	DIFqH4m6wgo/d946HeidmvTIGwqXzVZnElzOU3wDpbc/c4mVxfnEz6iLrMqOhHr/3NqeaWfW7Um
	NdeNJsI6H31Y0bLPak/R5/0OSGKQPX07hqo1Ktu6HQbEsiXM4lFfuPOGL3k0hR3Tr6s2uWWbPV0
	Lig0SPledcnUhywt0NXNFe8k809CR6Wmu5m5b/UEyUUya0jOvKn6zcvxC6HeF0idv8jcbVoiqJt
	mNuRipCmEaumu8TREbIrQd6C6K34OSw71gtyMQV+1A8Sd9W/phDWU5Z+NXREI1bfFIXTVIaqMcx
	5KdRwfYrjn6u9Caj08gcPGXDfc7rYKndc=
X-Received: by 2002:a05:620a:1b8c:b0:949:7920:9d09 with SMTP id af79cd13be357-949ba99fdd3mr3499405685a.35.1795659921403;
        Wed, 25 Nov 2026 18:25:21 -0800 (PST)
X-Received: by 2002:a05:620a:1b8c:b0:949:7920:9d09 with SMTP id af79cd13be357-949ba99fdd3mr3499401185a.35.1795659920987;
        Wed, 25 Nov 2026 18:25:20 -0800 (PST)
Received: from localhost.localdomain (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ae74sm1452063385a.8.2026.11.25.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:25:20 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
        Pedro Falcato <pfalcato@suse.de>, John Hubbard <jhubbard@nvidia.com>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>, Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm: GUP dirty + ->release_folio() fixes
Date: Wed, 25 Nov 2026 21:24:18 -0500
Message-Id: <20261126022418.3620783-1-tz2294@columbia.edu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d088452f-1118-4a06-bc16-1942e523e0fc@kernel.org>
References: <20261119-gup-dirty-what-v1-0-236d69f25c24@suse.de> <4f096d70-6f94-4148-8f47-242b8551e5f9@nvidia.com> <awWNyDZT2SVu2Zp9@pedro-suse.tail5790ac.ts.net> <55114986-0ba1-4a80-8498-bf674d64e01b@kernel.org> <away88BuU8ibcTA5@infradead.org> <d088452f-1118-4a06-bc16-1942e523e0fc@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX54GOZvVSDr/v
 VQDKSzwgdLif35ju0eZhuN4hllSrOUCRpeXPM+mDHOo04ydGx2ypHtEJlIzR9HN8lMCOuFrcEsQ
 34P6l4EhsQ3KDn3f7fC53TSPwPkhICdJ/yBW5p8jvWuDg65syvwE
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6b079892 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=X-ZpGw2H3ZcMOUJhEmsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: wnZ6xB7vs8zh9oxviQui-e-a7BVFpO0n
X-Proofpoint-ORIG-GUID: wnZ6xB7vs8zh9oxviQui-e-a7BVFpO0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX0yvT98JaCQ5+
 Aakxz/xe8+c24PM6dBWAM1lxW7AkppxMUB4deGx1AqXSNnPhVEtr1bHbbARUVw7IWL/wDUJxI/g
 hboWGw5q0d3Ft4VaE8PoCkGiY/r+KVqZygOA10NEy27HTiryxY8MLCvOc7WbE5PUifFC3mxLYFZ
 t4saQIRpKcGG+CwDH7Z3lhRfYVzlg2dwwPJxSiZyc5TA4zfPYPf/AZuIbS2P5o1stQMY6bcqs3n
 eezy9x8iHJnrogRFmu2NXkHxviXvzfBPQ861k3pCwBq8bbm7Emmf3kotxF08OwkaWxy6HbJxxaT
 xS4i9mJKTGewAfC0UXFcNtpBlbhksXg0Y1gZUyzMS5qiP0gbZNY3CRT8qgVuJkBlJo3oA8o5EB6
 lRqsOZMFSVC4hq2cVu6FDFVN0+4A1VTlzxpqfWmB4YT3/kpNXWDc3+kFC2ywXZToWuiKlTYEjqG
 i8ZplliN2fHpkDF5GUg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11977
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=10 impostorscore=10
 malwarescore=0 lowpriorityscore=10 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260008

+CC Miklos

On 11/25/26 5:19 AM, David Hildenbrand (Arm) wrote:
> On 11/25/26 11:05, Christoph Hellwig wrote:
>> On Wed, Nov 25, 2026 at 10:50:42AM +0100, David Hildenbrand (Arm) wrote:
>>> 1) We fix all such cases now where unprivileged users can trigger this,
>>>    converting to FOLL_PIN.
>>
>> We need to, if not for this series then for all the other outstanding
>> issues with GUP writes.
>
> Cool, and I agree (that's why I placed it at 1).
>
> But who is "we"? Because I recall that "we" wanted to do that a while ago.
>
> (I won't be "we" ;) Pedro, can you take a look? I'm afraid the fuse thing might
> be the harder nut to crack)

Coincidentally, I sent out a patch to convert fuse_copy_fill() to use
iov_iter_extract_pages() a few days ago in order to remove its usage of
set_page_dirty_lock() and address a different race. I think it should
address the fuse side of this issue as well.

https://lore.kernel.org/all/20261120-fuse-copy-fill-pin-v1-1-72a0d888f140@columbia.edu/

Thanks,
Tal
