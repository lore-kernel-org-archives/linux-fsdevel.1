Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83021EF36E;
	Thu, 22 Jan 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093315; cv=none; b=TDwmSTQgoD+XsbCI6/EBgW1FSuJW86D82XSrnltQI1rY/UZKE98g4rourhrLkPvMlLknKaki1ukXFU+NLvcz1j/dlNvOg9HvT4jcaM4Bmml102y1qlCS2FvdruxqeQzqcBj/IUlw19LvteoVdRm8/tUvUr9eiAyWa4Gmw3ESKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093315; c=relaxed/simple;
	bh=mGjFF+8cwoGi115VI3+T86EctLb6NSw0Xv7KJeUUVF4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PAXNeLCDSB32E7OugGx1CNki1HU6R0/wARdN2r/INC36Ga/PN4eW/NTncYjAOI/Z4T80XZmicHsHAIHiizx3MTKYXqpEDntl7uQhyNSzU01h80dqtN3gV7YYOQ2LGUcs4v5Aj+wzqx/c8SMruCRAZFMTWk9Ty4WtC6xansk/AGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SQl+z5hl; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SQl+z5hl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oKhdafUCztgqQ7be+GxGMewazRjtOJp89t4HV5luhIM=;
	b=SQl+z5hlGDlfIpoD9aks61iA7Lj4cFwVWxcbRPiKYY1cU+5iTpUejvYpti0I3F+/93OUsbxAQ
	tLLn7Yc3w6+onEqLumifDXoT+WnI4N5KPh0GQ7QPMjMvzOu+wp29L4IKm12M1rnBHlcWjQyMm0q
	+Vf1MM3Zy4OnWtxjXffRclE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dxkNX6Rlyzcb0S;
	Thu, 22 Jan 2026 22:44:28 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 521C340363;
	Thu, 22 Jan 2026 22:48:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Jan 2026 22:48:27 +0800
Message-ID: <ffdfbf7c-25fc-47ca-8c90-c98301847a1f@huawei.com>
Date: Thu, 22 Jan 2026 22:48:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: Christoph Hellwig <hch@lst.de>
CC: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <5aa7566e-c30c-470a-ab77-8b62a3cdf8c3@huawei.com>
In-Reply-To: <5aa7566e-c30c-470a-ab77-8b62a3cdf8c3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2026/1/20 20:29, Hongbo Li wrote:
> 
> 
> On 2026/1/16 23:46, Christoph Hellwig wrote:
>> I don't really understand the fingerprint idea.  Files with the
>> same content will point to the same physical disk blocks, so that
>> should be a much better indicator than a finger print?  Also how does
>> the fingerprint guarantee uniqueness?  Is it a cryptographically
>> secure hash?  In here it just seems like an opaque blob.
>>
>>> +static inline int erofs_inode_set_aops(struct inode *inode,
>>> +                       struct inode *realinode, bool no_fscache)
>>
>> Factoring this out first would be a nice little prep patch.
>> Also it would probably be much cleaner using IS_ENABLED.
> 
> Ok, Thanks for reviewing. I will refine in next version.

Sorry I overlooked this point. Factoring this out is a good idea, but we 
cannot use IS_ENABLED here, because some aops is not visible  when the 
relevant config macro is not enabled. So I choose to keep this format 
and only to factor this out.

Thanks,
Hongbo

> 
> Thanks,
> Hongbo
> 
>>
>>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>>> *file)
>>> +{
>>> +    struct inode *sharedinode = EROFS_I(inode)->sharedinode;
>>
>> Ok, it looks like this allocates a separate backing file and inode.
>>
