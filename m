Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F44EC650
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672683; cv=none; b=dsIJ27elSDw0XymCSXXtPUgmZgDCRyPAvV2KF4UIP8nASLGPnBeBI1cQSYa+a6lM8TmqcWpkRjvrDhcb+D/eI819vyylNcDtOC+u5cBrDXIG9Dq2Pggq21q2HkhwR+laWughbE1rQv7LbdnXEGlCWyDXBc39m0r3FF88RB1PVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672683; c=relaxed/simple;
	bh=qIkpliZGABu/1DsQ9lqxJf6xulmYU8xgQLf18jeRo/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2KNJyQS4uL9RAWG6R2G+QQlgViREaYlL5AgoG06JdJ4RwoHUY7qKjTlbjpHzfpSt+peqqZRvf1Sq7PQ0IiGByoDUDYD7tFCBfYQE6Go8auKpJkGgxzZX64A58zPln/JBLqKoEkXWbg4+MhwxtWro5yv5ZO39GabhdEcMOENTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Cvw+v+7g; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CncbDnl6; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Cvw+v+7g";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CncbDnl6"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T8YNfp1577787
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 04:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Nhw8
	v53Ku7yoHr9osqQh1xifI8ymi7aYlLItUVuMPgU=; b=Cvw+v+7gR9f6uZsw52F0
	MXPD0qPAq9Q+gdETTR50hu6HwIZyql1BqQ3hngAWoZ7hl1s8zJNa7ENhtX8qRMO1
	d6KwAcEU5x4qHip70NKL1Lezj+cZokgT4qnL1JdgCQ8xpGy83Ui3/sofCsgfB9oG
	dUvHuciNrM+Py803HDSfzYIvJepGceM7aogzK11x7D8ZJDUaVMOYnx7Z7/Ft8vcA
	8Pe0WcyhxnBwiMfSmRXhVk/cDdJeh9z4MMgMyjQqU0IiHBDTp3fEI5yoje1PBuQZ
	tR5V09oftFknpJBxo2xlBxs60tiJnAJ/mOoXMLygEXtEJNmkhg4KndL1MLVdhFZF
	+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gyx2auyu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 04:47:45 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c444b438aso849290385a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790671664; x=1791276464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nhw8v53Ku7yoHr9osqQh1xifI8ymi7aYlLItUVuMPgU=;
        b=CncbDnl68wrk+LwE/fGS2yfT9w5F+q5j4wX5pEJqePFRYUHqnQrC7w3oflSW9pwJP4
         lT/S2RN6v6C+rEKkSff+ZhkfhlvX6Nz2L1eN16lrLxXtU9kJWAwNEbli+3s+XknpfgnB
         kEHn+RB8pKQsQvNi6G7ybN19eh/y1n04xQKcX2zqr2nm6lNGwN7O98oL44lodjd7i4ft
         4t2T0Ts0oN9dyt5N1Y/8FEuEZRh7bn7GLzX5liXZhxxsjYt+Ryx52sbClqFaql0s9kJ3
         YAHEPUsy2IMYgD2Jivzza1L20BJzV9zdGgX+Et/l+AFJ5B5yStTSKK6OAngCYXdUCJQH
         wjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671664; x=1791276464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nhw8v53Ku7yoHr9osqQh1xifI8ymi7aYlLItUVuMPgU=;
        b=rap2Z/aPKShpBo4X0U22DKbc8hyl+ZEAUOGKeZ32wvbI6esRloQUEsnSvT3GwN8A15
         Cto86GUQe6HDpanb75EvJhH+aNUG95yHG+F66ty5D1GzGQydL0nhbjP48GU6wfceAeon
         XqocvcKiG8nJOimLlgGSiW6hfzxrLfUPQVRFIGebafAtzlzIom8NVpgHVvd2Rtp7xEtB
         JkOjcUP5puyr9bX0C5Dc3JeVmi0YBXBYp0DaqpnjGtQy/S4ZAfa6yclq0PAKSpuprIMU
         oBzc9Ftg6Ak9yxzLv+j8b30Xl7y1PTUp5xHk47UfYMmcrYKkvvrbFJi+BFasJ0faFhdS
         2NFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuxP1WzFPrflq1zSpMqDECVFdtHg3pkRuLD7JVsEbpX77w0sp/KOnoMV2m9XBIGaWTR7HmMC3UYQNowWfs@vger.kernel.org
X-Gm-Message-State: AFuF++lucDv+4j3HYcpJh3phWbwRP50eTpQyCw+c0PzswqwsPvBNvq0j
	7G6ENdd12xW7STX8ylGSarNG/7Kq0zVXDXer+IkarD5AnubHqQ36NJKEXO/mQKnqSOQgtaMSYfj
	o0aUyh+Y/jAnIzU9hbJk7U6n4WnYW58yZcSxb4O66Muf8nIPK2WGPL4QOWsASoXY=
X-Gm-Gg: AYBFou0GRszA7CqKXvFrN+/s/aYIDNDNoZaRJUPzSzWYnBvYSW/zUA8cH4xoGx6m8p+
	fh//74xRHl29V+IK6gwJYWcDIIswsgq5djSVlxZ1ekAD8KTz20oe0jOthlDexx1M8EYcaYy52u5
	sjZWnS0L2P9/Pt214zdV7r0Ev80chKY/OgrAeZbnej3PSI5cGlTpomF4T9bea5HiPXVsIxqRop3
	prtBKs16bgPm1xbBEoVsgxmrJYSAjvKnQya3CRJEExi+s35fRBO/WdKSYSd0P8z4K3e/4QOtKgO
	jsoOhe4VTFL4em0Qn35RaBXEZsqM1BuW0cTOqFN1/427/6lWXHRWcLGva03ybtadvKBjT5GCcqz
	LRD/NKmGsq9TP
X-Received: by 2002:a05:620a:4446:b0:93b:6113:218 with SMTP id af79cd13be357-93c43b80eb8mr2546611385a.12.1790671664175;
        Tue, 29 Sep 2026 01:47:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4446:b0:93b:6113:218 with SMTP id af79cd13be357-93c43b80eb8mr2546608385a.12.1790671663703;
        Tue, 29 Sep 2026 01:47:43 -0700 (PDT)
Received: from [10.192.23.156] ([82.142.85.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af508cedfsm2418391f8f.30.2026.09.29.01.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:47:42 -0700 (PDT)
Message-ID: <bb13358b-24f2-4462-92ef-0e538ab314a2@columbia.edu>
Date: Tue, 29 Sep 2026 10:47:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
 <20260923-blkdev-fixes-v5-5-89e60d66eb38@columbia.edu>
 <69579dae-285d-472c-ba69-4279e5170502@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <69579dae-285d-472c-ba69-4279e5170502@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e9iT2qp/ c=1 sm=1 tr=0 ts=6abb7b31 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xSnE1pX28jTrkUJPvDlzhA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=5vhaLU_8k3ht0VnDKtMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: GPwni_3o-x6oYQ97eC5UgrcFzWRchfNk
X-Proofpoint-ORIG-GUID: GPwni_3o-x6oYQ97eC5UgrcFzWRchfNk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfX3WBjCNdUvC/c
 QnjVK8KBtNOC2oMXSlE3cv5GsIP1yjn5LkfQhx0CqewSJR3Njcr58HznmzZYccnWZ8NzbP7uLd5
 3sgb9AaFpjr2s7+WMcK9OpGDA+bG+8sWwxFRK5HHOds+6HwmDR4ACDvUd56JrTQgtQZFQceRYl6
 8eda9aPle8noiWvC7ni77y95Tzfq8VmVIjvi91HMBh/tkucplHKLca9jWSf/RKjLPmIY4oqVZej
 ss6GaT8eI9qFbejIA7Uh0sJuH+Efidn9vYCsOKGwjZa6tBFASgbZX+uTrY+/Ms7JJgZJn17QgZQ
 TAn5b3NxyhPKAqzzMray26Pg+JydnkmlcW8fXtZ1GSrYb7PY4KpbfvfVZDr4kY1wCdIZWmGC40L
 Z+LflSNEvNPN/aqKtadQAFeE+2XFTxTmxr43ZPAcIipeaY6A/BadjPdBdJt73h47S9UhsyDPxCo
 oHQcSKnAQZ6FfodunAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfX4LMPp9gArOU1
 t8kOvfz+nvgyGzqL0364pgk3HQKptKLqH1YHaWWiQXJUAueVgKcV9pMIXDO/Yf/znpmGP/Agtjc
 k6Na9uEEzp9/LOD1oEN33aLvz17gVLB02W6M4n8yxa+weJcc0uuc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11919
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=10 phishscore=0
 priorityscore=1501 impostorscore=10 clxscore=1015 bulkscore=10 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290033

On 9/25/26 9:37 AM, John Garry wrote:
> On 9/24/26 00:56, Tal Zussman wrote:
>> On a partial page pin, __blkdev_direct_IO_simple() and
>> __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC set
>> and leave the rest to the buffered fallback, tearing an IOCB_ATOMIC
>> write.
>> 
>> This can be triggered deterministically. A 16K pwritev2(RWF_ATOMIC)
>> whose last page is PROT_NONE, on a scsi_debug device with atomic_wr=1,
>> completes short with only three of the four pages written, violating
>> RWF_ATOMIC semantics.
> 
> I don't mean to load more work, but a blktests case for this would be
> great. I am consider doing it if you are too busy.
> 
> Thanks!
> 

No problem, I already have a reproducer so it's easy enough. I'll send
it in the next couple of days.

