Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439306;
	b=EavkwpdgGD9kxxmfBtDDCZo8YxGfe3Hc4DXaot0nDA1XMGaW7kdru9MTaY4HGvI/uXFH
	 D+4UeZ/xfHHtM0IESyz9MQSgdD4GjFa/XF1lGSVcrFl9+oh20DoOy79rwrNo+X/hBH9LK
	 77XYpOHvNW9y4BZ+MkI9onpU84777FLhajnglKFspGo/hvmB8DJBKo9MLS6KC95ykjRZk
	 dZj6XfkAPTqm8HvU3qVuY3EgyviDaX0Vj6sOvIZEAlZfLTiQs9riks9PZ1g49SNbCJZu4
	 LP5OBsP2AJcCx63/RWkbYq0/fhXyphH5R+F+NEITL479T8UrzJXcZgrpdq30ErMQ/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439306;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E2Z2d4ubA/vBybLDW0A3M/dONekPuI7b74giCSqVh1w=;
	b=iimHgKt16ho0zTttvMlacmKGNLgo0BvDIw4dtYl2e/6OJwFddu0g6fjTcx1FR8pyYdxq
	 jn7BlxC/wE1EwprjD06DZwjlA/994HXqNBbRs9SEsdlrnlnIW4kF1wExWrD04nqMj1RqA
	 Fhfna8ld6oKj/uFvkCG4E+2ThJat34PPbKz1vPj+1YwL9pv65iovi9CrfYO0KvldjpLTi
	 8y7/Ds0b4M+SO10Mu300/ugv1KYoxjm8QE4DdLU24cMtWIkNtB9l3rGrlGxxoENbxW/VQ
	 Z31Ys/gTTK55ENn+ipIXsv5cZvHpz/O70F44XWxCxXaA0IuOLGLd55r2jx4NGLWPdFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=VU36wWCz;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Cd5Tmp8+;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10780606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10780606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=VU36wWCz;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Cd5Tmp8+
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMBrRi1795447
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 18:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=E2Z2
	d4ubA/vBybLDW0A3M/dONekPuI7b74giCSqVh1w=; b=VU36wWCzQDQPCDJskRC8
	GUumOBIPmH3k55QPlp1YNsxNWGQx4zstGDwIkhP9sggGaAtNDOxVNPM+CIQjV7M0
	d76oIXkhjHWJS6/sJD0V7xwxACCKXbEImyr2R53OJ05AYwSPslCjX6JDP1dkJFLt
	ZGLE+lAezMF3v+tbabY1FXS8t+DLmwNBkOOjfe50Y+e8kR16R4byD26CbkJ1engs
	dELYjDkL4R1vzPRAlEtkmGpBtSZPDEYDeCqZDX8LFf2EW4XF+J1pPYC3lE2ZFibP
	e1E7tig8fu3kP6Kh4QBMujICqMTX3AetkkzRw/0wJjtqfoXr5TsZMDAY2ei2x4fR
	0Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvyxkgwq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 18:21:38 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91e98bada22so70407716d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 15:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794439298; x=1795044098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2Z2d4ubA/vBybLDW0A3M/dONekPuI7b74giCSqVh1w=;
        b=Cd5Tmp8+IxlXDjA5tU/GgeRi46Zb3uDPWz+QALmyneKQOujMP94KHDunl7wTrDmO7M
         yicU1Bfn2b1YUNO7g3+boC/Cw7PN7mTm1MTLHiVRNJ4IK/JFRKDqE9NxF0ihrE4hXjCU
         383Oy8N9LtvRkxFAMGOk61eAd6JLxQ6AGCDjS4qtQ0ou6A3kbpDRHHJ00ZkQoEYXOoLN
         0cpw0wPJnYon+Zb2VGLtItmVwo4kBbRFQ8k//L7AlWyfpesHMZ25RCIMLZ5MvOQ/vo2C
         smUr6ARSSboXegQizc/stiEPiVMiYfoaFneA2YQjjCoCAOWufOiMEHsjWUbAv2vTMr1C
         1usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439298; x=1795044098;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2Z2d4ubA/vBybLDW0A3M/dONekPuI7b74giCSqVh1w=;
        b=NjDDwZq36MksUO0hIQ3oiLs/g6nkC6+QRdVn2r9Xu9JDeB63Orbifsw1dttTSyTZZU
         d85J+Prsk2Ff4xw1RuDdkOtVPMLE8Zm2WYbHfniBcQNuKI1I0WT6evQS+DEv2mVfDN/f
         psPy4+WevFJNAn6IPKhujgD6S+ElKHW/r21zZQPsHM9GYOJhzlJNC9bFQy7eH5w+Scia
         vBxbjJaSQFsvU9vstOVNI6uGADxlO0oS5H0XdulSAQospyroxD/nmdvAsRAtyVEJuDst
         79rn0veXfrTgy1DlOMkrE9JC21i0vFyctn/H3EspKQ2gX3ajakBotCHzRi7PJqD1GZN1
         585A==
X-Forwarded-Encrypted: i=1; AL+hErG59JTbUHo9cEqJxOb6i5L5Yv3q/5RHa//vrG+9ZSPGF/vhKD63t4wnWY73mQqqrahP4D2jXsCxgc3UjD8o@vger.kernel.org
X-Gm-Message-State: APuU4Z9ptmPYnBTa1kDiHxKOKnfkvJRzrkVNIXrbzvXXZT+DaND4bX90
	CQL/39wGZId4/nEf3Vp4NA+LjfamyBH8JmgWhrImrH/LvrWpF9PBGwYpPiZw4z1OMK+PNwtsrip
	JjYr7/heDLKMIs7kF5IzS0oJSf8TvGHjSVIZZCld/wu7LfFQqVUzpnqU9UYqOg7I=
X-Gm-Gg: AYBFou32Pq94+kAkcDAHXDnjJo/1eibuJOcIuhV/xbkjfZJdT7Dko1Dq6YIPJbzoeJT
	LCxUMi+rYmg/85T0/uxF7ALDICUtEF5rhLnbcYurDicLq0RGyd+VnTdq4m8BoT4rSU1+BD1Im0b
	IK/m6x4mntUWYuJq0eqQmprGutjsuTVI1drcUK8ghD7v2ZflxSVHVjkVjI1LCfdaCOkku72RNDq
	YLKXgSBHVUJQ9bmFoy1SPZvyYdS69/hT7Tjui5uFlN/4Mlke3easGjzfRlpq9eGqOL2lXIimAVW
	hDN/jJtSGxJI29gNKl2oNVJ7GwDkDvqFD8G451i7KBboBro6yG1gvXXUeY5evnzjWl3eNu7zCbk
	h/I56tRja3OqEDCCDYMxtcNhCHEd/BUpVdaqXigTrHl6PL8yzqic5GiNsZOUhSsOZbQ1mdItfkV
	qKM0FdeNKGHpTYQHnp5UjzHsEoaUk=
X-Received: by 2002:a05:6214:d86:b0:91e:a629:ff92 with SMTP id 6a1803df08f44-91f04196dd4mr71943016d6.42.1794439298036;
        Wed, 11 Nov 2026 15:21:38 -0800 (PST)
X-Received: by 2002:a05:6214:d86:b0:91e:a629:ff92 with SMTP id 6a1803df08f44-91f04196dd4mr71942586d6.42.1794439297418;
        Wed, 11 Nov 2026 15:21:37 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-177-239.net.columbia.edu. [128.59.177.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02fcc4b7sm33094936d6.44.2026.11.11.15.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 15:21:36 -0800 (PST)
Message-ID: <e19f1fff-f1a7-4c2b-8908-2d3ee6a49069@columbia.edu>
Date: Wed, 11 Nov 2026 18:21:35 -0500
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
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
To: Kiryl Shutsemau <kas@kernel.org>,
        "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
 <avTA58zlxJZ69TB8@thinkstation>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avTA58zlxJZ69TB8@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA5MyBTYWx0ZWRfX/dMpe/Wm/sTt
 mhL6to6EFDmb1lGaM9JPupQxMQdZBn544ZlwgIITzI5EYXMEpfvLa1UTQBZ5yRX0jn66Lr0WEOj
 sNUXmVzdx7+C1zzmxfTFF2NMWD4xI0kVwMR7YVsc1tJ8dKwJK7Cf9UeanV5YSq8V6b/VlnFZ1gB
 nJU3k3KztiQkkVRlKQ2pBSLC7D1YkDvQ2lJjwChzlkJRY+j4o06EkEx4c53HXpqKDT1WAVXjU7A
 49aBVjo/q7KaFr9UVvnGFRzzkzrB1Ybt10bfQ5Kln7NupgyNbToBk5mPwTmr/f/vQP25SH8ScTo
 QS9UtrpWbeG9EoU1VxKITbBGngJ5VCENyGE2AsjS0QLzYIGrgxO1ikkTcBb6I4yXd5yNPIjPzod
 2O4Y4mJE+unxVA+zDTJrQL9802shrwdhOOLv73+8Y0iY1yM5lxxn695hyz1ClEtYJIBa6hVqIp1
 UXRmLHUiD+/mz02mrjg==
X-Proofpoint-GUID: J_VCK7wd50LwjmppmvdBw7J8WiyB9ivQ
X-Proofpoint-ORIG-GUID: J_VCK7wd50LwjmppmvdBw7J8WiyB9ivQ
X-Authority-Analysis: v=2.4 cv=L/yI0OT8 c=1 sm=1 tr=0 ts=6af4f882 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=BoHXNMl2GZKy+iVh/K8zVQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=eFDYe-PYqAWV_-s2uwYA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA5MyBTYWx0ZWRfX7UXyvelC7oyt
 FUGA8Tmx+RjkJBh1Xk9+twGt01OKZKVV7e64LZNbeU3urQWMjxXFlPBPMq4B4ENnnA9wHcC+w4x
 uHDVlFExno2eksSwu9WC17J7cmiI8rRnSIR9aMEHWfdSE9t8wKDy
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 clxscore=1015 bulkscore=10 adultscore=0 impostorscore=10
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110093

+ Jose

On 11/11/26 2:25 PM, Kiryl Shutsemau wrote:
> On Wed, Nov 11, 2026 at 12:55:19PM -0500, Tal Zussman wrote:
>> On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
>> the pages. Writes and accesses to the range after the guard is removed
>> are then not reported, and the manager cannot know that it has to
>> protect the range again.
> 
> For RWP this only holds if the range is registered without MISSING.
> 
> The zap frees the pages, so with MISSING the first access after the
> guard is removed is reported as a missing fault. And there is nothing to
> protect again: RWP only covers present PTEs, and a page faulted back in
> shows up as accessed in PAGEMAP_SCAN.
> 
So this makes sense, but I think this gets at the documentation point
raised in the other thread. It seems that to use sync RWP "properly" it
needs to be combined with MINOR for shmem and hugetlb (and MISSING for
holes) and with MISSING for anonymous memory. Is that accurate? If so,
this should be stated much more explicitly in the documentation + man
page. I see that co-registering with MISSING is mentioned, but not the
rest of the points (reclaim, collapse, etc.) The example in
userfaultfd.rst also registers a MAP_SHARED mapping only with RWP and
MISSING, no MINOR, so that should be clarified too. Hopefully this will
make it into Jose's documentation patch.

In any case, this change is also needed for MISSING faults. If a guard
discards the contents of a page registered with MISSING, the manager
isn't told. Once the guard is removed and the page is faulted in again,
the manager may fill it with the old contents, when instead it should
have discarded them and filled it with zeroes. This is similar to
MADV_DONTNEED's handling. I'll update the commit message to emphasize
this point rather than the WP/RWP aspect.

Thanks,
Tal
