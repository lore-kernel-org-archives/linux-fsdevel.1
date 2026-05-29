Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885F3451B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087586; cv=none; b=nAU0Wnkd+5illKz4kFECTSURklzN83W/TPzEiu+Cpm3PosDCWF5aCfBiZstaBIIBF3f5zE94YmqKEwdddKH75YV1Kl1OoRcWmyGStE+XiReWS6kJ/VXrxeIfuudBIV+axdj+ZzO34xBbRUF4QdP1vvlondOqJp1OOt16e6O2ZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087586; c=relaxed/simple;
	bh=Dgt9gdgsSTGz25LNKdlg6p96v9ORYzbnwBkkNl+zH0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCkN95nQIA3qOrZw+4eQnUlJKPjRzTgrJwbPpaIs2iZdLJSPZgeYwKV40qWdg2Hg01Gx5vs7rRo4ba/DkuF4RFa5tPafNTjINOiyN/NKxl/C4rHvPBjN4STAnRM5YgLALJdksiEj6G8J7Z66W7//YV2G/m7+TcgN7c0SMQ/VqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fNdL0jd2; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fNdL0jd2"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TKivjA1213287
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 16:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Tu3y
	zxbzT574lf/x8+7GuddK+9mUu+iNaUikqjzhrDc=; b=fNdL0jd2jEZLLdEDzHwo
	hg9oAn2A09Nc/UhTjZBmS2wSISfSJcrx7iHnycx2ggqMsmdYhM48Qp6dn8zJwdYB
	985sLAgkwtmSCT8teAzwTA6OhaIFRxvl6MhKiUIHzXRQSYgRkuDKU0XNg2X2RpBr
	0P7NHA2+A2rGk69mahYeBod1zrBCcJUIzU4maJzE4t8BG1N9Hc/8nKnhiSDo4Nh4
	Ch5XzOjEOBE/jVetXJBtepua7x9ftMeGTiaGWhJ+DI1yELSJMypkbL8bJpLS0OQb
	sCO7ehhxuKMpXZEyP0t++n/X9s8DuU67L6dejzRsJ12iZiflWRTJYEZgsZtHx+T6
	gg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ef6r1n40s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 16:46:18 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50f13da9684so173965441cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087578; x=1780692378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tu3yzxbzT574lf/x8+7GuddK+9mUu+iNaUikqjzhrDc=;
        b=lc4Q76T4ppVCpWn8lM8BNwQmLMVOdN0ifNe5b/FABAwLx09MCWmHmiDUTWCLY+6/ip
         LGvQq+OduF1ufZMMzOG0Pdi5XvpLp+5XXQHkoWHSQevnfB3m+wGw464kIzn7yQqXLmOc
         RttoMTiTrFb8dsx0DK6Miuf1sSuL/US39euDrGH7UL5La+hDDexbqr8yO+yvYGOtNYXF
         W1LzFwAS1BiC7H+REG7Sy4ySU4DnIeFi7mygAvMo5y5CrhmqDeMAoVDep5+Fx78atOrK
         KgI19+jI22YrV6INZFrCwtXoJrX/6W+v/q15xOkt7QxvaAKVVRYlGaL0Prttz+zQYz07
         gDmw==
X-Forwarded-Encrypted: i=1; AFNElJ99okagaU79mUE/lU1iq8yLDHmjEqQ1eS+aYcr2dP2XThFMbfdJexmnbcnkaIDuxlOVHHO0kJ1560sQSQCg@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIdmPgob2PGKcu3WjJolXnGrV1YXhuQBk4nzHDWGFUUisuT8A
	V+wZ3BMYA4WcPSNLnxNRRMpVu73pxl9qUzr39u8DBIksbk2T6BqZwIcl/iv0nTrr//dpoLhGI2i
	Gz9nKtIVpNkD1SvFxoczV36rF3DjEULITwZG+JGhTeKeRIjn5TjbH4A6LGex+crs=
X-Gm-Gg: Acq92OFb5wgEzxpBQEyPtpbWO27VQG7iNcmKiQjvECWyy1KRCwZlvkq7EQvfxMeea46
	DiJ2BhHe3gBosEAe30DlXBK2JwddPqfnd/FYlhQrJxznav5GYAKD6QzdEDdhA10uMvL0C8DW9fQ
	tj0mh5+egNAq2f+rDpyGzkiq1+HzxnLWDahrVbEq8qUTrLBlle4DmX1zT3FOOuoJpjJR/IDGDeB
	hNjlMz0sFKZ24LFYF0EK+vh/f1SLwZcRN3AZkBYFCAPhhd++hXWYxZI8j/yD+Uq8HkZgOwRfWbj
	FDMnsCaJ/v4k8/4T80KT29LJx/zT4piuOntSVFW9T/+++ulLDc+Sb4ZR6J2cgL4g0QgFDgv/H1h
	R6/qD3hl3tVyWAY8/sEe/yRmMhPHH/1W3L5m1ZzETTU8kwuQ+fqVy+SnzJ88d9i2o+QhlW9RHkQ
	ADM+HIphf4GZH7Kk1uLqDzIM3g6w==
X-Received: by 2002:a05:620a:27cf:b0:914:b65f:6afe with SMTP id af79cd13be357-9153d93295cmr223977185a.1.1780087577722;
        Fri, 29 May 2026 13:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:27cf:b0:914:b65f:6afe with SMTP id af79cd13be357-9153d93295cmr223970285a.1.1780087577139;
        Fri, 29 May 2026 13:46:17 -0700 (PDT)
Received: from ?IPV6:2600:4040:974e:fe00:c8bb:325f:9d37:a5f? ([2600:4040:974e:fe00:c8bb:325f:9d37:a5f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324a5502sm300290485a.21.2026.05.29.13.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 13:46:16 -0700 (PDT)
Message-ID: <80cb53f3-e7e5-4f96-bacc-f9fb7661d976@columbia.edu>
Date: Fri, 29 May 2026 16:46:15 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] block: add task-context bio completion
 infrastructure
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-1-782e2fa7477b@columbia.edu>
 <agq2KRd8RkP1TAf5@infradead.org>
 <ea1fa305-3ba2-4cfd-b7cb-86875032a300@columbia.edu>
 <ahPbaSEoNA755Nt3@infradead.org>
 <f1b8eeb6-2397-4f48-a21a-a023eb0c80ab@columbia.edu>
 <rkb5oei6cx2erbyininczz6ukbnquqheexhu7tznn5rslkkdn7@b4kpdyhdwdb6>
 <ahbq0RdUyLIPiItB@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ahbq0RdUyLIPiItB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIwNyBTYWx0ZWRfX9Puk56skxLEA
 jWRF8kOQfAlKWDbDjGPsd1wM5Uv0WBPwXMhrxtm4uU6bocJq/y5eXq9VTe20vKo6j2Zqu2wKM4W
 2Yv7RlFpAhnKTVNoCW+M8x2si/9EFuV0ibocX6g0z1wC5W39DRrZ3v4KgFBp8kIG5NjeOhO6W54
 NRDStix6tmcVJsXt9BVZyH/awczzVrPiwQQqeAM9dRAom/B+9PVjO5C2VEuPxY7jBEpTu7x9yxT
 TUTB+6GK7qTTlCW1S82XsAV7dM1yTnQ9VojgnlGSsKVx5lIJKX1c0VDAsPYVpSPo1RpT6iDlVWT
 r9tidDBNSLbos4tzWSlizxCxiCQ9VEFOMFr8HmD2nK2TKDQVZlvb5cxWwNcfqAnuBFIkgC/ABsG
 DCOkI5gFJ8/79rLNE7ZAinKNsEE+RG5QO37fGORiS3J0iDKyQohWaE6lj2A/IbM7fyneutanaBQ
 xwXQbwNo2vct8DCMflw==
X-Proofpoint-ORIG-GUID: Xws9Z1dlTrLrQRan-yOfSl_79pTTOz1A
X-Authority-Analysis: v=2.4 cv=FI0rAeos c=1 sm=1 tr=0 ts=6a19fb1a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22 a=glsx1xNwX7j2ZVJJCoYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Xws9Z1dlTrLrQRan-yOfSl_79pTTOz1A
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11801
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=10 suspectscore=0 clxscore=1015
 lowpriorityscore=10 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=10 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2605290207

On 5/27/26 9:00 AM, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 11:42:28AM +0200, Jan Kara wrote:
>> > I ran some experiments with fio on both XFS and a raw block device. Five
>> > iterations each for 60s. Results below.
>> > 
>> > TLDR: Removing the delay doesn't significantly decrease user-visible
>> > latency or otherwise improve performance, but does significantly reduce
>> > throughput and increase context switches in some workloads (e.g. C).
>> > I think it makes sense to leave the delay as-is. Thoughts?
>> 
>> Thanks for the test! One question below:
> 
> Thanks from me as well!
> 
>> 
>> > Results:
>> > 
>> > Workloads (all `uncached=1`):
>> >   A: rw=write     bs=128k iodepth=1   ioengine=pvsync2     # XFS
>> >   B: rw=write     bs=128k iodepth=128 ioengine=io_uring    # XFS
>> >   C: rw=randwrite bs=4k   iodepth=32  ioengine=io_uring    # XFS
>> >   D: rw=rw 50/50  bs=64k  iodepth=32  ioengine=io_uring    # XFS
>> >   E: rw=write     bs=128k iodepth=128 ioengine=io_uring    # raw /dev/nvmeXn1
>> >   F: rw=write     bs=128k iodepth=128 numjobs=4
>> >      + vm.dirty_bytes=64MB, vm.dirty_background_bytes=32MB # XFS
>> > 
>> > Mean ± stddev across 5 iterations:
>> > 
>> >     metric                     delay=1           delay=0     delta
>> >     --------------------------------------------------------------
>> > 
>> >   A seq 128k qd1
>> >     BW (MB/s)                4333 ± 27         4374 ± 34     +0.9%
>> >     p99   (us)              36.2 ± 0.8        35.8 ± 0.4     -1.1%
>> >     p999  (us)               3260 ± 75         3228 ± 29     -1.0%
>> >     ctx-switches          184 k ± 59 k     3.68 M ± 65 k    +1903%
>> >     cs / io                0.09 ± 0.03       1.86 ± 0.03    +1888%
>> >     avg bios/run            80.4 ± 0.6         1.1 ± 0.0    -98.7%
>> 
>> So 1 jiffie delay is (with default HZ=1000) 1ms. That means for this load
>> the completion latency should be at least 1000us but your results show p99
>> latency of 36. What am I missing?
> 
> Yes, this looks a bit odd.  Unless there's multiple threads submitting
> and somehow the completions get batched this should complete one
> bio at a time and be the worst case for the delay scheme.

Sorry, I should've clarified - the latency here is the userspace-visible
I/O completion latency (i.e. fio's clat value).

I ran again and traced to get the actual time from __bio_complete_in_task()
to calling ->bi_end_io(). The results match the 1 jiffie delay now:

  metric                  delay=1  delay=0

  A seq 128k qd1
    fio clat p99             38us     36us
    bio cb p50             1.23ms    2.5us
    bio cb p99             4.13ms   1.44ms
    bio cb p999            5.01ms   2.63ms

  B seq 128k qd128
    fio clat p99           8.74ms   8.85ms
    bio cb p50             1.27ms    3.1us
    bio cb p99             4.05ms   2.27ms
    bio cb p999            4.91ms   2.77ms

  C rand 4k qd32
    fio clat p99           8.16ms   8.11ms
    bio cb p50             1.09ms   97.7us
    bio cb p99             3.73ms   2.06ms
    bio cb p999           11.87ms   3.79ms

  D mixed 64k qd32
    fio clat p99            981us   1.03ms
    bio cb p50             1.14ms   39.5us
    bio cb p99             2.83ms    275us
    bio cb p999            3.06ms    595us

  E raw 128k qd128
    fio clat p99          26.97ms  27.34ms
    bio cb p50             1.58ms   41.5us
    bio cb p99             2.98ms    325us
    bio cb p999            3.02ms    575us

  F mem-pressure
    fio clat p99          29.75ms  30.43ms
    bio cb p50             1.32ms    2.5us
    bio cb p99             3.73ms   2.48ms
    bio cb p999            4.62ms   2.83ms

Note that in the above, the C degradation didn't reproduce as much. The
bandwidth does go down from 64.5 MB/s with delay=1 to 54.9 MB/s with delay=0,
but it's a much smaller drop. I ran it several more times and ran into the
degradation ~20% of the time. The lack of batching means the completion
kworker fires for nearly every bio, leading to heavier preemption when a
writer is placed on a CPU that receives many completion IRQs. The degradation
seems to occur when the writers are migrated less often, leading to more
preemption. But I haven't dug into why the scheduler chooses to migrate more
in some runs vs. others. However, when pinning to 16 cores, the difference
between delay=0 and delay=1 goes away.

C specifically also seems to get worse because we're doing random writes to a
sparse file, so each bio goes through the IOMAP_IOEND_UNWRITTEN path and the
completion path is heavier, leading to more CPU stealing from the writing
threads compared to the other workloads.

>> >   C rand 4k qd32
>> >     BW (MB/s)               66.2 ± 0.8        44.6 ± 7.4    -32.7%
>> >     p99   (us)              8002 ± 174      17990 ± 6800   +124.8%
>> >     p999  (us)             11390 ± 554     31890 ± 11076   +180.0%
>> >     ctx-switches         3.67 M ± 45 k    3.59 M ± 106 k     -2.2%
>> >     cs / io                3.78 ± 0.04       5.62 ± 0.83    +48.7%
>> >     avg bios/run            32.3 ± 1.0         3.1 ± 0.3    -90.5%
>> 
>> I'm somewhat surprised how larger is the completion latency is here without
>> the delay. Is that due to a contention on local lock between the IO completion
>> interrupt and the worker? Or why is the completion latency so big here when
>> the case B with more IOs in flight, less bios per run, still had significantly
>> lower latency in the delay=0 case?
> 
> Note that in the past we had major problems with workqueue scheduling
> latency.  At some point these got mitigated a lot, but if they are back
> for this workload that might be one reason.
> 

