Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956957;
	b=QojXBRrFh5P7YO1OfwmZpUJLXCQeqKyQqpP5A87lKNT0hCKqZbSlhTVSULckMl7WYgwJ
	 mTNNz8QXoyYWy71xWtlEZBA4NozFS+02AJX8Z68eVr/pBZBjkr7DdfPpaF/f1SVUxX3OL
	 Wxq+wHCibCZ6KCcA1UzyEWcu0HLVLpqPKzkmmz1hifVkmwd+PfvNY5oEBejPJqFih2/fx
	 vD5+4pUcUXL6GSzET8t/hM8Gv7jE+VBEcDoVk33ESGPmvHTE/VCcUQf1wWoLLS7jnSDkx
	 xN29ChHDU04Dm8XGpn9GaWb6p2YLYrGuOIl+z2Ws9hCU3sUI3T21nqo8ikzz9lO93Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P3xU8z78xh6OIEgL3dWXutqADwQlBsjsEYam6x5iTI8=;
	b=FScJYEUGOe7td3+D57O4XHagnAWFjziWNDK0GtXe3fdwfJYeTZHMqu9sUmHXcqpzakUg
	 xEpJ2Oo6sMX0mjdQcAKmSon3f8R8t1oV0I6VyhbDq/qARWeMa4BdpcI2+jwCjRS4oi0yU
	 +zC39yoTh4nURnWoLOUxF9O5PlV4Akckhwfq2G7LDYw94AKtNQp8Fcsr/HVTd1nC1C0t7
	 envYRK+Sxu/5iI+3jveTvl7yodgly4rkNcv17pXiSvModvdKfoGzk8Zk1JdqW/s8jCu7F
	 GvvprpdfkyK82MEXeMfl5YmREckEqj+kBdlJLHa3A7pbz33Ax1sh+gWMI5G8OA2w3uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhV6xJm4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFF606A334;
	Fri,  6 Nov 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhV6xJm4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC81F008A1;
	Fri,  6 Nov 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956957;
	bh=P3xU8z78xh6OIEgL3dWXutqADwQlBsjsEYam6x5iTI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AhV6xJm4m8V/HpL4pbSiyW5Ok9ttm7VVQoZMqW1QnzDfVokzTh65qBdX7ioOwqTrm
	 9FygTTns73gMX+vasQzybbXc6ozbTWKPYCKsLt33eOkHvRS979++ipnxkQw7D+5Tlw
	 9uaYGJSPFl4QpipmOPrjfBm0GogkuRh6LVmeddokrvNpyWNnLYH7U/61oDYltkXg2s
	 0aDSCP/cK9la7vHaQ2zsp+1xUo1I4prbt8yPi9bmZkIAP8Wu15ZsMnPwFS5nxa+qc0
	 BGIFFUTNJ4Qnnnw/DQmXSV15S3NEmsS61jwHMceqeaqquZiyTrk5wKb29tQpSQjuAd
	 EDk3w/ShCYmMA==
Date: Fri, 6 Nov 2026 10:22:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [Bug report] ufs: fs_cgsize from the superblock indexes struct
 ufs_buffer_head.bh[8] unchecked - UBSAN out-of-bounds on the first
 allocation after remount-rw
Message-ID: <20261106-bedingen-zubringen-spanplatten-80498de14872@brauner>
References: <tencent_EAB5D4A0EF9A112F271AD38CA80E1FA5A807@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_EAB5D4A0EF9A112F271AD38CA80E1FA5A807@qq.com>

On Sat, Oct 31, 2026 at 08:30:00PM +0800, Guikun Yang wrote:
> A natural fix is to validate s_cgsize when the superblock is read:
> reject s_cgsize < s_fsize or (s_cgsize >> s_blocksize_bits) > UFS_MAXFRAG,
> which also covers the zero case. Happy to test a patch.

Please send a patch. ufs has no active maintainer and reports for
orphaned or badly maintained filesystems are low priority. Patches
aren't.

-- 
