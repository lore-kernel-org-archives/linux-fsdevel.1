Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124248;
	b=RLVI0v8SQahuAlCgJKOmx6PPjCm5D0SurjCIoBTwfEKzFppW6zpCGJAjbRc8r3QHt9mO
	 JcDMzkdghKF+SjfTqx7Qxah6up6KOy4RM/+hOSBjbOxemWKBeCy3ooIsF+08mhosl0uMv
	 RXpe+/xd9JY0mRaOiq3l6KLga07v3DgY9R421MS/ho9DyJf1f33eIdjYcISQI4QRzX/6v
	 2tgx27u29hDR83K3axxwWv3pLCSs9X54p6luTfsw/c1clI8pZP25GewMmknY+BVVSuagG
	 ztKae+zLUYsP10AGbYAiNKpaPmHjPiK6Mt+VhhuSDcleo2cRHiNe1BGmmOsMosANHvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
	b=GIl9HVHKyz0SOIbbEaiBl6lJGxpGGEhvJlIq91ruz0rQK4ClOBxjTSdiYV2Nv5ZzWUFw
	 i1N4YUiWiDLTByacAUod1hU+0J918KQvzKA+sqhnPJ9t7VjiYBUDsLWqGitOfW3CAwQbn
	 /2XJJiHTAZ+dgzAGGl36fd5KSUEqeW6zPlul7Y0hf8H/cNFhS7fGcetj3LFHBMWbQX413
	 Q6+OVvUF/1PPLknCk2fbLEFxiffkMJ5b9cEmo+TK6PVQwaMVhT5rfB8Ew8eZFVk6BG2Ze
	 nAu9mXwB8bxu97dtzCfLdMITM3CzCcXv5r1LxdzR/UGKHJgShX2ENWfIs0vViwSY0UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E8606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 18:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 654E8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHhC9R1551973
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CbwQ
	ln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=; b=HWMW+LuCz6utW8S/VyIJ
	rHuo4CHhRhfcBnkgT2it5oCdt4YIlLKc6jaoFTG6NBRm9OQx8/Gj8cgBC4Do0iWk
	mAEHeGX4ZEQrgjmx5BHUqwprw2uw/fxZQF3p+JzRElcb76yXcKt4GQvOnFFzOajv
	msygurYhvvDfEXZY1Y1OFRcS/MQ3DzxL1Zn7WjVKu/boL2iCknUIbvotLMEHVOFn
	8z9EcTAubn7A/+OQElkqnT0CU8euYHGKsuMyJovfBE9MpfZ4akkMjYw62aGpHRD7
	9NYu/mzCxLPH6caGTchbWrsAFJNSQvq09+77FlRkr73QTb2lnAcZCq5a3XUaooGA
	UQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hjx1sj4us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7bf2d734so1593996d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793124242; x=1793729042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=MkOva+DPKFBicQaIHSSly2JfoMAicHAbd7jFFZ2jAPfMZSSAxwOfcC3CPShO84ijPq
         ZECGGl73Kz7/09FPj4HtrAatZ8+T45RQt+M4cGZiieC2QJbgruC3B154GGVXb7OAzN+0
         2UhtrH2K//SHtIBzgQwch7+1xSTuSdd3XBXrSOFftUuUdhA49+eAWmetIwHQ/lmQkNU1
         eDgkpiPJIa7m+mdnAJUQCGKhtaBLbGtQoh5/+RjGZf2sev+2X2y5UVI9n1Ip2H0WcVvt
         DLiMDqjdZzodxrWp70M2mYAtjmKnXIkOjZKPebpETepX3BO/HR7B5Mv3SiADMWH9paOp
         KEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124242; x=1793729042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=Hks6Th7coLrutWcPgg87C29W9WVJ6/3sututshB+9mvTm3i+qNB4roycr9q/Uu7Z3k
         xtuz/uw35d6sRAyP5uCPfJHKQfbFAtlqIEIj1fWxL1pBbOKOYWGeomsh4i9q8gvxKFnC
         IQbwzVZAvwnr5VesUc1NNkD4LN7JvmqZv7eZFK5UyE3cO9PBRm9MM+Mtqgkf1WaElGSv
         rFfEDqOGsuDt3014BXsbjVspXYmGUnpQ+TapWARfHxA8EZzUM+hjIPHc3aR91C4CkC3H
         BAkKivg3fXdbh36/vknwGhJyyEjXw+S5m2VofAf4r4cSBOKVqzX+mGezdLMj58NcYm73
         nRhg==
X-Forwarded-Encrypted: i=1; AKwUvBy2UabgI6XxMxFufJP2CTYCdiWNHGdDefpwxwddPJ2xvf9s+qfJjPGy2txnoQ33Jxst4xG3Kn0I3E7z2xgt@vger.kernel.org
X-Gm-Message-State: AFq9FYK/c7yTimCuECg6212ivHgSnjdaybQR9juoYyRlc4Wq8ublgNG6
	ywLniZWhVvAldUyZuFjjtbOrIl98JU997buxZuhBFmlvM8hWMV3VkSbOwOhqtGGwQi1Mq1AuBvO
	0TUW2HAb7JPcU9BZnXgZFMEpNJ02C0fKE969OKDzujkC6UFMsch5Vs/rDAL9XuQU=
X-Gm-Gg: AYBFou3+X4IBFjMDnWQENVx727/hcEMn+nuqcXQ6pfT20ZjjsdgAq8G0iUrJkx+fyad
	DvYkLAmwQzKOizih7DHVlC7MqFbEI+3Ck9pvryXfsPC0BNYQGt1hZ42TslQyjntyaEj50l7fzZa
	Hk45pcuzbFkFxXeAnGWRm4qFbLkjHxa3GZK0ZLZSj3S3pKAzGClafyEOVUU53nVtRn2y8fEmNLP
	yuo+ZxWAjLTdVhfXSecwNXBc/MimajqGkzm7B+O6LSN1GoWn/1t0dSEo45Ude53wR0nnTequ882
	FlX8XrGXRbvCDnaoTr3AtMZHl4N4WIbl99ejo9QIeujvz40sWBlN5viUIKb9tvDIDFmmbQT+9E/
	uHndtg7wNSqZxGTFdf8YBqfXEv6pRDQmADDWw8wcW1NB+AyOAMrZMKMwaXPUdnD8llaM40rsCqf
	oOEYScxJvdIBZIhWO8fXSnRYeWk4yzzyWPqSRoWucmY3B8zoK4M/CzvrZc2Axpb0Oy9MCpBe0SS
	mhSX7S4X6Ntiwc=
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547501085a.82.1793124242423;
        Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547486985a.82.1793124241704;
        Tue, 27 Oct 2026 11:04:01 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a94a5csm1037624685a.41.2026.10.27.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:04:00 -0700 (PDT)
Message-ID: <208738b1-35df-458c-9955-e2e5318fd2c7@columbia.edu>
Date: Tue, 27 Oct 2026 14:03:58 -0400
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
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-cxl@vger.kernel.org, stable@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
 <auCw2-_yjh1_RjiO@cmpxchg.org>
 <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX2LJ0nvxkc9s2
 Ve09+euF9pn98dOCxrRxFvqR/M/qrKh5h1+9eTTCygR2Omd8B4eUog9K9Me++9Qu1hP5/JFJddi
 3AZxmoUXWElY1wnX7tLxMns8u9uu2tJsAScIrggI3eycX8+7GKn6
X-Authority-Analysis: v=2.4 cv=AM1GsprT c=1 sm=1 tr=0 ts=6ae0e793 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=pJWPUViXIfCbsMganCcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX7K5Qz/U1wg4R
 kV9aQAfnK+3T4Rh3ai9SXamfNk8iqhLyRIPUWUapq6BbYjc+o6vuwpNx7B+/6RywfPKlCjA6jNR
 Y9rCaJlxP+3OHYFragAUJKpwkx4Zncbe+BtZMbyMuADgrsn7L8JL7ZNsM/qjUDeE33G5etj242q
 nSZ09c6QYRLX+i1mIG2O4qo8GSF8CFZ7HdLHQ14dGsH3ntOiGMucaJ5Tzog9oGvhoUgYFkPZjAC
 MJbHFkZ2TtTjYDCEza4KXCsDUNQcRsFaKlZuBFYIAPUe3lqwcJjTrbiMaR2HswQ/pRSfT9vRDUY
 6QebFMVr1SK+ll+1prnUscipfBl4i2MQqC9Caetq28RX3eh7rm6KH/gBfCZxL/ebTU/DyLIpq6g
 Zc8GoYnxQnHBfL2ery7TdfV+d5OSd2qEG50jsXG1RK08rZKcs+5Pa2FLz3QUpK7FXK36XcePXn0
 5mbHuL9KMP06y9bIvCQ==
X-Proofpoint-ORIG-GUID: nGreWo0w7I720DLq4CArXscPtNT5AVn1
X-Proofpoint-GUID: nGreWo0w7I720DLq4CArXscPtNT5AVn1
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 adultscore=0 lowpriorityscore=10 suspectscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 spamscore=0 phishscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270071



On 10/27/26 11:15 AM, David Hildenbrand (Arm) wrote:
> While I have your attention: This variant works, a different proposal used
> 
> list_del_init_careful()
> 
> instead. However, that is documented to require list_empty_careful().
> 
> Do you think it's worth looking into?
> 
> 
> https://lore.kernel.org/all/20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu/

In this case the careful variant is fine without
list_empty_careful() since it writes ->prev first
and then ->next with smp_store_release(), and
__list_lru_add() only writes to the entry after it
sees -> next == entry so it can't race with the ->prev
write anymore.

But your version also covers the PG_partially_mapped
race your comment mentions, which mine doesn't, so
it's the more complete fix anyway.

Thanks,
Mani

