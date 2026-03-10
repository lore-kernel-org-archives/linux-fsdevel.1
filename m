Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84C320A04;
	Tue, 10 Mar 2026 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114608; cv=none; b=lbgA3HO++jF57XmZ7BpHerjPM63kUaa1QcZhScqFLgkjYZ4n8vZSrnh5VJpJKNBkQ2v4ahf6ZQ/GU9opDBKbAP5HLYAwIR+FDWWt8n/3AvqjmJMXUso1b94vpq2tis2pSjpt3qWB8QT2TirxomuJ7hCC3Fz/pdH0qYZNKx9qvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114608; c=relaxed/simple;
	bh=08NZ+Tw3qv920gOa8hGaCxOPb1fEcvIi2et2+XzIvGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgT1wLFGr5HFaroFekNusA1jiLVR48D26uUpqxPrz9WS4eyhy2X/bEwBPoYNOkQ/EMHINvRzLkQfCbdzMK9Jctem+rW10lD4BF7q0O+XjESDuIqsqyPuPAH5pdsaqO5wj3I/sn2EYMVIjNSWX4bVY2c7kVoiov2LVDP1s4awXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1hDsLUSu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1hDsLUSu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KiMjX/yEqsV4wrwCPAl510Spg1vMYOTtNmsnpLdg4mU=; b=1hDsLUSutu3zoCRG/DUtiK9Ql+
	XLoB6gmFb1gcuMOeyypHjgFuNCQZoEdJ4Vnwj1NTFng+xH2IxjlP9M768Lbc+qQyplLf71U5l4O2V
	8a8JERRyRsTm+TPyIwAqppI0wMHZ89J+TMlNd8tcwETugGntIM2OVYf1bYl4MTdpqkq4azpHCQGqd
	0ab0xOSrxPz97SPtPyIP16Asz08ens9INI1Vv5Z4WDevn67t7GRoXg/1oTV2my4ahJBSv03nbV5AO
	0g2OwOFrtshqeUCbab5KAjU/aVcLoCVJdwQ/uiiEgfWbIXqdEW8q/7MzKEyDutqP+eCZiPD4aNThY
	T1hwd4Vw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzo6d-00000008gDM-3QBt;
	Tue, 10 Mar 2026 03:50:03 +0000
Message-ID: <a1c852e6-85a9-4de2-a6ac-9a100e4a169d@infradead.org>
Date: Mon, 9 Mar 2026 20:50:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Mar 9 (ntfs)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
References: <aa8WV_KvEV_TFPPZ@sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aa8WV_KvEV_TFPPZ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/9/26 11:49 AM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20260306:
> 

on ARCH=arm (32-bit):

../fs/ntfs/namei.c: In function 'ntfs_test_inode_attr':
../fs/ntfs/namei.c:813:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  813 |         u64 mft_no = (u64)data;
      |                      ^
../fs/ntfs/namei.c: In function 'ntfs_delete':
../fs/ntfs/namei.c:993:44: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  993 |                                            (void *)ni->mft_no)) != NULL) {
      |    


-- 
~Randy

