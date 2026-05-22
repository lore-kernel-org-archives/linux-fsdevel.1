Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFD368277
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491840; cv=none; b=GEZ2lzUbn9g3Gl9loFvcTUvYfWXADGtSf+5vyk1xcv3P2Q5iIRGaDw7ZviM2uCT9Rk5cgvODTFEgH27Tr+LDyJdrM9W0iaVCKDDSA3VPG7LhnWo2JxYyyXEJ21z0sMfZkGzHZZnVZ3hMatcWgCo1DWvNMaaKrc7QbiQ5UieuHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491840; c=relaxed/simple;
	bh=4g38+1lKxMMFXNGYi+/tGlmbD39J/6oFSR8yf9ZHHoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWkrPyngq2W6BYPL9cicg7F9Y7cJaerr4OPPz9IRgW3FUeUhh3w69INlqCUazu6nlp/YB5XDX2iecHqd+HaWsd5tyxZG1WGm0Kp3TTTw4yadXnH0bzprgaZSZaUCcuGjOKEuTK0dfgup4+hOutA7JGZaefvypX6FsFCI98GPFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QCzNXMoc; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QCzNXMoc"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MMU1Ro1099552
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=XolI
	xwfsVJBVBpTPhnOybhIeNs+9oP88EwbFpg7C0dI=; b=QCzNXMocAxNFTmwB5r82
	Iqr6KeBeNApgLe1JbrJXqMTH7Hv0Jt/WD3PXKZ/QXCCaHxNZnn7Cil8P0gyKLaZv
	DWa07xsv7CrqPRbXnIU40NAL0kpe5neyU5MB0D0nSvHNPjBZq1at98019jHZbOE3
	9g6gkdgK+gyYrvYu1WCQVHRC1VK7MVRiBOCNXxobfa1CXAaZYTlihRJo2JKZpq8E
	AI1jZOOmEZE6eGOhYGuOC2N/WUrRf67sQd7RyFsswLHPrLlCbfd44HeFHwp6RxpT
	j8T6/BvDioIehEh0yVkyfu3Y4ybyW3Q/KGibGcM/+R8a2gbWyj/1VhE1uhi2jsxH
	Mg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4easg0k6wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:17:17 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516da5a1db4so26207161cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 16:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491837; x=1780096637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XolIxwfsVJBVBpTPhnOybhIeNs+9oP88EwbFpg7C0dI=;
        b=nSwb5cJTIKuCOW7IacsVV6xvvrYZkimlM1t7tjmtswxCh9O3WplNooN+GeCMJBA4d/
         vsdV5cIadA1uwuctU7xj2chxJ5uic5k+eSEqXAFL7qeGePovjU6Y6fHk3DfDlpZavskv
         4mJmnsDBS8TPdDd3DkuChNBWdd3WoLZh1rTwoVhv6jMpa49apEJ1chXZn3u9d4mTyGBB
         C1s07Hl9hxCkPWi3DE859Tg7m4IiIIQPrl9wT/jV26MMSk0KBGWLi8/JRkFwxnVULB89
         bZQhuOcgevQmAj7EZcSmu39h3wnhAaS9kNVoU9feDtjIhaTqLqcZrw1Y54bHb5VLK4M5
         CmQw==
X-Forwarded-Encrypted: i=1; AFNElJ+Q937u6L2Dc4/tRypRRUkqHu83VX7xUrEzKriBwNCONHpnpSvAhuyDMqPLRgoGklRsz61O2xVRT3Mhng6G@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoB7U01ClVy66lghsgeXKzfzbShpswViKAkFKQXrHxt6SkcjO
	eZmnYvJZeKljBt9iXGBDai915ZLzq8DB1Q3/IqPZH0PcwYrl2yqzJNAgUcoT1qHBEpMnJ7l2fGF
	wdwEW25mU2UGdwjzIcsvpzJ+176kJ0DrckvvhIaXBsmfjzO1iqX1Gkr8RqqWWmhI=
X-Gm-Gg: Acq92OGjE595VlxR4Rg7pqjVOXvf32PtLlAWVwBM3ljExwSVP4xyEamZ9qxhInFMOay
	1Vnlb3HHirI22GuUFbJu1vBAuWC16AyKOw+02JTMUPQ2S/E+yIoUtmSZZT9mdp7xJ8X2SV1Yj+m
	QRvaUkgnKkjRL6hfqMrQ3h9cp9mlQxjSmIUjLS7WE3NMVHYDiONSjvQ+Ye+0JHxoMPN3AoVqHph
	DB5XE5SWpXv+UGAKdCTgrdhNyHsmbEfmZnp+X4qA2DQnDSSzKywapoOwCDlBw0UEw2dnZNbdld6
	A0WIrlJ0yzV3B9xHAXN2NwbiV2NcNSiRT1a1W57+d4AneKOFjyCZFGZhfesIKH0VBnWxt5iy7uz
	N5/+SWr/fql6hqrnnLwxHgwnHFzHbt4+EqHpk6EYfYw2PrhqDHwsT0f+uNxj8ESYuLwSYbeOwr/
	o=
X-Received: by 2002:ac8:58cd:0:b0:516:d8c6:3e64 with SMTP id d75a77b69052e-516d8c6436fmr59502401cf.53.1779491837058;
        Fri, 22 May 2026 16:17:17 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:516:d8c6:3e64 with SMTP id d75a77b69052e-516d8c6436fmr59501831cf.53.1779491836515;
        Fri, 22 May 2026 16:17:16 -0700 (PDT)
Received: from [10.207.65.224] (nat-128-59-177-214.net.columbia.edu. [128.59.177.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b0065asm25972531cf.2.2026.05.22.16.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 16:17:16 -0700 (PDT)
Message-ID: <f8d509c7-c0c0-4196-9a82-a6f8ae24ffc2@columbia.edu>
Date: Fri, 22 May 2026 19:17:15 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] block: enable RWF_DONTCACHE for block devices
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzMiBTYWx0ZWRfX6gIC5tOikzNF
 z/8UMMwievXRKnva6HYsMepTQ+cxn+pRBUyZIXbjQa0FMUraJdbLNXataE/igeKI2LPCFyVJt5G
 RnOpQ53h/0FmfCjhxhdM91yvXodLXRyFrW9WqZtkFBi70EaxYgkIAw/xLIpenRv/DA/yKEVzBaI
 ndmUVzYyP3to70TFndVjXwwIhDXGQTxdCbqkdoWUMaUxCfQ2XQLklP6sopEZiRQ/rVG1tPOP5JS
 Al3llh9drcoexKOEsELFUjTL2sG1fHrIBf7MU11srmUhdL+i2CGEGsEw+zuDX4t21IRmQDxoABm
 fLmHrKdCln2IClSfM3bl2Wf1VVR5p6tfCONgRCT7YY3/WSbTjAp7Pxc8NzrI0udpsKcakPZuh5v
 Jac2RtYQ4yBVN2T83oBkCu89zluxH4EQki+Tl9S86yab7SmLC/fRIq2HBp2nxHdeTWd78QnnxDw
 7iLgJWPpTr1lZ7q9sow==
X-Proofpoint-ORIG-GUID: omXzHA2JvBNEZ5HzGqiFUJMBbKB6HcH2
X-Proofpoint-GUID: omXzHA2JvBNEZ5HzGqiFUJMBbKB6HcH2
X-Authority-Analysis: v=2.4 cv=OcKoyBTY c=1 sm=1 tr=0 ts=6a10e3fd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=n4JpGxNP30DHW88kdRRHAg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=c92rfblmAAAA:8 a=7QGR7LCADlPcIrvLOjwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11794
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=10 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220232

On 5/14/26 5:51 PM, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD=y paths, use block_write_begin_iocb() in
> blkdev_write_begin() to thread the kiocb through so that buffer_head
> writeback gets dropbehind support.
> 
> CONFIG_BUFFER_HEAD=n paths are handled by the previously added iomap
> BIO_COMPLETE_IN_TASK support.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Responding to Sashiko review inline:

Link: https://sashiko.dev/#/patchset/20260514-blk-dontcache-v6-0-782e2fa7477b%40columbia.edu

Q: "Could this code path be unreachable during block device writes?
Block device buffered writes use blkdev_write_iter(), which unconditionally
delegates to blkdev_buffered_write() and subsequently
iomap_file_buffered_write(). The iomap infrastructure bypasses the legacy
address_space_operations .write_begin method.
During a write, iomap_write_begin() handles buffer head allocation internally
by calling __block_write_begin_int() directly. This naturally inherits the
FGP_DONTCACHE flag passed down from the kiocb via iomap_get_folio().
If the VFS write paths were actually calling .write_begin for block devices, a
CONFIG_BUFFER_HEAD=n kernel would crash with a NULL pointer dereference since
def_blk_aops does not define .write_begin or .write_end in that configuration."

A: So this actually seems legit... doesn't look like anything actually calls 
blkdev_write_begin() or blkdev_write_end(), unless I'm missing something.
block_write_begin_iocb() usage seems necessary for bh-based filesystems, but
block devices seem to use iomap for writes unconditionally.

> ---
>  block/fops.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index bb6642b45937..31b073181d87 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -504,7 +504,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
>  			      unsigned len, struct folio **foliop,
>  			      void **fsdata)
>  {
> -	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
> +	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
> +				     blkdev_get_block);
>  }
>  
>  static int blkdev_write_end(const struct kiocb *iocb,
> @@ -966,7 +967,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
>  	.uring_cmd	= blkdev_uring_cmd,
> -	.fop_flags	= FOP_BUFFER_RASYNC,
> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>  };
>  
>  static __init int blkdev_init(void)
> 

