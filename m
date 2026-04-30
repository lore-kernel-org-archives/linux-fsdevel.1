Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76B47CC84
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574038; cv=none; b=TTfwYTyeyonJmK7rIpsTTd5f6gQHlV41Qp81Z4WCoMf6nEbfiWvDwePNG4h7zvKh1DfFMlIii0eF9pQHYxTvp86A1O+FacjH7zRpoW27pX55zHuDnpvpDJIobccmIjQoe+CQC4EEkUIq+Pco0Eo80VGR1Vym4dIee8WBGUWqoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574038; c=relaxed/simple;
	bh=/jhj+TskCXODG9hKampnDGfknOGVmEGixC/boL6nPuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW8Dip1bPHFThC6u+/vEB2pOAHxyaHB5Nkv3HFPb61R/fVj62iusIZfiwefNLC76X69HdOfWYGmkUUdgRs5uk3AIOrBOtiC7DW8JNF6tFDVO1EYruD65Q9GmfxvJ/Bb4Ymjdn2RstOA1w2pKHES9LMjcae6L1RDu6Aih8/SJrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYNxebG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYNxebG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-445795cf6f1so825304f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777574035; x=1778178835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
        b=IKYNxebG99rJmgJdnK+STw62yP2P2cdaJBZG/cigckDb5MYyuKKqqi+dTFU2d9cFZy
         qhJhEBM2t2gYyYxeD5XqrpJttoMPpfwDkqQGaWge8r5FKsdQAdayH4cS/hC2kxIHEYq6
         tGmHwVFWfDn2FZp49tR0EcsXlAigU9Sqe8yADo0AbxH22Zw75c684dLC6hfRE0EgxQSm
         HB1ngLvlfAIWqWDd9zNtUSfCDyoND4JMJTyGyjU3XxM4J+M97HrqUqLRf+QYygwaj1mC
         Ogr8gZjOmeYK1nNMGlcIaHaGVz3S2JshItziqGxqT+GC883q+Byb/VWR9AJNIaDrVgN5
         mk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574035; x=1778178835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
        b=dxE2TciQJRd9Bv9n3jlaM2JEMB2Sar2Y7I31AIOdUZ2QCyCNNZAjA6D4yHn3T7k30V
         NRFRORsynAzYDKp057sULqq0diPABGcUkJCvVI5MyuYzyt94gEJy4Y5DnV4mtfMuAvsE
         9wdUJoLDENgxUH5kOOj8FqKghcXnFVlgo+x1utSKm1fO8EOugN6wya2Ptx4lznTW9Kby
         ng6mvM+NhXsjYR+MLbjuhf05w+Y9lUYxEUsQahDFYtO0FEQIueMaXNR4pQZ54bdExZWA
         j72p63LV0Y+igxh88dBWbr5X+R083nLNTtEiDwllCyj8lX+GJQFEfX9zW2/m8oNz3hKm
         4E0g==
X-Forwarded-Encrypted: i=1; AFNElJ+SX6oCZuyQaafW70qE6AycTXSQHlq7l9MMPsox+N8lP7/aRpZxbIi505j5HmxzAl71HTsHVOETylKuJqT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpwXbBpOw6lkLRKd2wh34pERPeT3W1JhZIDYqixXkuoQbcDgS
	okareCPgxWFvl7PzIIA0sWASmCruqc4eulpSsEKinCt8jDhnp1h70eUJ
X-Gm-Gg: AeBDietJSfkjhJXP9YlpWWrX01o19YOoDX6uaikm7PRWKbpUltMfKnOiHHTfGbXbGHl
	iIfXi/v5Jub2DDqpLqmEBnfdnamTQZ0APRIqGes5gEBQyd8XctT4I9JDSPbryIUdoPxMHOFA4D3
	/Hc2TPd+eY5tbBzuXk1usJ2pWsYKG4Tc6srX8mnlphyYFU6oQJrqE9IjZ4bgKz5RwuXV1ip9emn
	jP/2ny90+rxabIjewLyJLMrVyf1uRKbPgrLmAyHLn3q5Zxs56tF9gBKjNTe81LOF7JuYqbAIo1o
	8cVo3byZ3+qqKTbMU2RelxggYTf9fr9hKvmrxyLg2ueUxKp9/JXYSuOcxRL2VvByHY+vjCH44gP
	nWUEs5M7JUdU6uIYxmxFx/YZyTU87QvSyjUyldowL9tN/XdUB99+UDyyMmVK21V7rQT3miGo5jk
	hlyI76j0LoHgoLF0JylbINWaD9kLt2I0Zj8vXdxk7maIiyKh7PHWbflm0qgN56aBjo7b0ZUdP0Q
	2sq6Ps46ei//3e2/TJOm22E26cXQAGWjSMNJfJvw63RR3lL5ryhdwWk1V7sJUNbKIIUuIDbGqZa
	ew==
X-Received: by 2002:a05:6000:1a8a:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4493fa01beamr7079438f8f.32.1777574035154;
        Thu, 30 Apr 2026 11:33:55 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it. [2.37.141.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216eecsm13579672f8f.9.2026.04.30.11.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 11:33:54 -0700 (PDT)
Message-ID: <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
Date: Thu, 30 Apr 2026 19:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] file: add callback for creating long-term dmabuf
 maps
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
 <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/30/26 07:03, Christian König wrote:
> On 4/29/26 17:25, Pavel Begunkov wrote:
>> Introduce a new file callback that allows creating long-term dma
>> mapping. All necessary information together with a dmabuf will be passed
>> in the second argument of type struct io_dmabuf_token, which will be
>> defined in following patches.
> 
> Well first of all the naming is probably not the best. Maybe rather call that dma-buf attachment or context or mappping.

"Mapping" or "attachment" would be confusing as maps are created lazily
together with struct io_dmabuf_map. I can name it create_dmabuf_ctx(),
but I decided to use "token" not to collide with dmabuf terminology.
e.g. I wouldn't be surprised to see some dmabuf ctx in the dmabuf
implementation code. Maybe "*io_ctx" would be better.

> Then the patch should probably define the full interface and not just add the callback here and then the structure in a follow up patch.

I strongly prefer splitting patches so that they touch one tree at
a time whenever possible. tbh, I don't see much of a problem it being
not defined as it's just forwarded in first patches, but I can shuffle
it around in the series so that definitions come first.

-- 
Pavel Begunkov

