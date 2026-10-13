Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFA542EEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922165; cv=none; b=ZIVYTFzWYmonNepEIzYNz25o/RxejJQbtHE8xfS2Th3o5H3Drhprn8D/QNeHeKE0YErr+D2v9OmefUGmiNabrcTw1hZZcYT171NkVrjJ0rXtIXKw1fHtVOFbkWsyfayfLfq2ph4yn1HU8u4LGC95p7T1j0WX1A5V9wdGr2pZ4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922165; c=relaxed/simple;
	bh=NrenYkyGWgfz/6r9jzkmCjYiJ49/s0j3/93r31ckaP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3lxKAFho/uzpc/FZGPJhvme1Za9tN2I6Nr2CaBf06vvM00PZ8ts4mHemHuzgkvxeJ0fpnCGmBBwZHGiAOsye8877BTtiEFkpk2GOGd0FLg30r47KY0YcwKESCuYwJMyQzJUCmHvlipHZqalMti7wCIH+p9TSVcSeUX6Y8otrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnXe7AuC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnXe7AuC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-487049569b6so2371688f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922161; x=1792526961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=;
        b=LnXe7AuCdnyYnpb6vaGdKk9dNPmYvfuTLMnncmlSHO3bm6LdV5oOFFQ/Hul0fKBMet
         W4nAlbEzoX6HWs6HnCfIDeznmSQmwClyMr+jPICKPEmfXXfo1VXB4SThaFthNtvRHz2l
         HHSAdyzffbMi5JM4yQNKCGSJ756lqg0vmqcnbXSXqkoyzk6PX1CcwWQ8nWsxyFJjO7kh
         zbyj/rZBdtDTsaj8uvPhVRtp1Pj6fs4jAY/Kor3UfAKz9mhj0LOQB7lA3dlzUv0TVBjb
         Q/YthV88wTO4zlFoqnWJRd6MrLdEGTJJklZuxP6/fEkNK1AYgF5rFdACujnJqp1sNibz
         ckCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922161; x=1792526961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=;
        b=o328GImEMPVBVS3G/PEnW/58dRI46+f9bMr4ku2Q7aUNAhPVqtihE44kBlLcN3P4GW
         4uLfUFc8ZK9mH8vAeHF6AKUiQsywlKo6AR6kSuCkbo4B+mXMjCzmf9CbsLXd2vwjcGid
         WLJPnH2SMpao+9OzOeJb9CZSrNYOhkj28UekwsTcDE0/TfzjhC5lxfXOXjxSdlmqcc1Y
         LWKfGqPfhWqPgG53N+xkiknAxzKCm1LDAFjBiW2JZEOwvXASjiV7bJ2q/bsZ/ZX6YtXA
         IT50ccPOs9P9aTabxmosRrxomuEAo8nHE00RxBQ9Vfq7xaQh1LlyVEclKIa52g1tIdvM
         KbTw==
X-Forwarded-Encrypted: i=1; AKwUvBxhVXv7SHpMGmR5Me82oLex2lxeZR4tMdjIRChxhurhxz+KlOj94HZQy8QfY6sCO/MTmdgZCo2ci/+v9pZm@vger.kernel.org
X-Gm-Message-State: AFq9FYLJXBVm/7kB51kBACH7FBmwg1De0hhktGWzYEp4+E5ZisBT3dfb
	Yb18/QYr2aq0ZtefHNMs1Oz9qBlNSkDqMA4VBk1VN21XxwszVg2MxoW5
X-Gm-Gg: AYBFou154swlGaHDzgSTfNkpyIzrhtR2H08aNL4Jm8Q7Mo2WYkvi67h4kB4CHsQdCyg
	Oh4LDW/ADPlrLpfYqTyXzWgW787jQgVvuU9ugrdar0+iE015LoK1FUUljpYF43sTcgk92qN5h2x
	MHYaQM+v6+9kJYuy8MJxQvlmQswnMC/VXXl4/FbUz9HZIVHODR/7hfUmOAiZDJyjWd1xlApKx1l
	Txg4ehzweh+X1npeGnNPJegqWV3QI+t5wU+//RGdYWxD78Wc8mcPYDcv+1xwIxcGC6wPclwUDxV
	sEelolPpyocBOKIzm5xAwLNy95DtgSScfQLsXeqVes4MWG+JnhZL3pEPCNMdDb/wRdcpD+C+Xi2
	Ae+bKs8/N9pT7dGc0Ojz5WuHr/G14PwLiNmlmOnHbNcpxbkuQU4+/dQfuCKMppeQnkigXu/Y9B2
	kYvqoTnW8AK5tYtv+xgv5ZVvmbMwtDh/uGHTFvp8b036LiFoXzMfUiNZqdVaQntlGOSBYEpTZAa
	6F+DqQlNaLtUDoNPVMr66a1McyAh8YxMGEJV3psA6HkgwO/hoErMN2nRAV0HI+3WefS3GFbAki1
	syE+6V+XbjpkMPtYpD/BXI3M/KggdOCVQiqWvvG54nA7oDHk
X-Received: by 2002:a05:6000:310c:b0:487:8b9:526a with SMTP id ffacd0b85a97d-48dbacdaa60mr25864079f8f.36.1791922161609;
        Tue, 13 Oct 2026 13:09:21 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5af7sm7243430f8f.31.2026.10.13.13.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:09:20 -0700 (PDT)
Message-ID: <293d49fb-6488-46da-bd3c-6f8600dd123d@gmail.com>
Date: Tue, 13 Oct 2026 21:09:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Matthew Brost <matthew.brost@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de> <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 20:06, Matthew Brost wrote:
> On Tue, Oct 13, 2026 at 04:10:47PM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>>> I've queued this series up for some testing, in a separate branch. JFYI.
>>
>> More testing it obviously good.  I've been waiting for addressing
>> of the Sashiko comments on the nvme patches before doing more ACKs,
>> and while I can't really judge the code those in the dma-buf code
>> also look somewhat serious.  So it would be useful to get them addressed
>> and the series reposted.  Same for folding in the PI vs dmabuf fix
>> from Anuj, although making the combination work would of course be
>> even better.
>>
> 
> Oops, I forgot to look at Sashiko's feedback when I acked the dma-buf
> patch. I think the two cleanup issues are valid,

I stopped answering to sashiko as it repeats the same from version
to version when false positive. Those two are warning paths, which
should never happen, I'd rather leak than crash on double free or
so.

  but the reclaim-related
> ones are not. 

Thanks for confirming, you already elaborated on one of them in
previous revision, the new one looked to me as the same class of
issue as well.

I'm not sure why Sashiko is confused here.
> 
> I wonder if there are some shrinkers in the tree that incorrectly take
> dma-resv locks in a blocking manner. They should only use trylocks in
> shrinkers and direct reclaim paths.
-- 
Pavel Begunkov

