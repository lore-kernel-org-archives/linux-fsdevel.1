Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192731;
	b=5L5Blq/c2cEZVIyvK2ODnJOkkYYeeN+rxL0D64bU0us9haBassUHRmvU3MCj21ApXTmG
	 z+jT7ThXTfhDkXQyNJhTGnSPzN6ApNbqPMzzhQJ0lK9UjgmyYfrgx2EA/JVKhUxqKBkwF
	 0sv1gO/kiZ1msfnfFRvSidVqSy0JzKtXXRgqClZQnNtu3x2zNyjoZGQn3bwC1c1P8Yzoz
	 hQ/jD3n38gioM22tZ4j+VeSFmqiGBwW3TptP8OYlHTYkaiy9YJ07gZ+G+TlljatrlYGSy
	 qbQeiIFPXOKHvbNMbNOwWIjMmeeqki32VMQbXRgm6g55MVb67B/L6rtA12i2IIeGNnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192731;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nWqWiduDQX/+eDY/lBNMvXq4xgQ2WR9If/niokbocYQ=;
	b=QEeJeSZahYzr3xPzZbyu52GusPbX6zZF/IArGuAhwJ/CwmfJ8WDudjQgayTL2QXQdZHH
	 sQcldx++QdoYPQ9j6dyhb2C45Y6S7y45ZEkBXIJNtPZc8wFYYDWETB1kCjrTTderhpKzt
	 N9Ms4SqBhLr4+O9FmckfPYo+KgJgzNVjj7+kfrhdGRw82xjxy4Lbly2n1q4w/Mih5FlD6
	 qKgn/Al/CY65T/7yWt2ZscAmXHxURhDHX6UL1W4KrlHPzCbk46IoDRr00jgdYW6+zVR/5
	 CFJKeaAJj0Q+pCNgqPZe9Dl1UBb+G2GOamTRapH2ngggNBMqsKAO6j5nJ/tlW+HVzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED1606A320
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 02:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84ED1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1zQrA1miKQ/sO3U4FLD9eN7ND1EAn4eFHq58nFmS/2c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794192722; v=1; x=1794797522;
 b=pKqbz5+1nAKvoDjratDGIzCVYLRnYWqr1KkI/51AbwTsIOLh1H3KSkwjZnitIUapDrfX3moK
 iBDOjWlEa0LcAglhZ0IIVJXQpa10JvLhgoeorLL1bBrmrzYqTSk7F/F73Ux8tJumFsmES18Q1nY
 WVU2IQ4+YlREcEp/U62zWKW0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f8a5242679d67f97;
	Mon, 09 Nov 2026 02:52:02 +0000
X-Mizu-Trace-ID: f8a5242679d67f97
X-Migadu-Flow: FLOW_OUT
Message-ID: <3f45a5f9-9c87-420d-b6a5-6145c834c0d1@linux.dev>
Date: Mon, 9 Nov 2026 10:51:46 +0800
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
Subject: Re: [RFC 1/6] block: refuse a dma-buf bio that carries a crypto
 context
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, asml.silence@gmail.com,
 Anuj Gupta <anuj1072538@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, Li Wang <liwang@kylinos.cn>
References: <20261105065847.196540-1-mengmeng.zhao@linux.dev>
 <20261105065847.196540-2-mengmeng.zhao@linux.dev>
 <20261106104119.GA5668@lst.de>
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
In-Reply-To: <20261106104119.GA5668@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 18:41, Christoph Hellwig wrote:
> On Thu, Nov 05, 2026 at 02:58:42PM +0800, Mengmeng Zhao wrote:
>> +	/* a dma-buf bio has no pages for integrity work or contents crypto */
>>  	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
>> -		bdev_has_integrity_csum(bio->bi_bdev))) {
>> +	    (bdev_has_integrity_csum(bio->bi_bdev) ||
>> +	     bio_has_crypt_ctx(bio)))) {
> 
> This could really use a factored helper explaining all the refusals.
> And maybe we should use the chance to sit back and think what else
> would blow up and add it there as well.
> 
Hi Christoph, thanks for the review. I will extract a helper in V2 soon. 
There are several buffered io fallbacks, it's really necessary to discuss
how to avoid these. Glad to join it.
