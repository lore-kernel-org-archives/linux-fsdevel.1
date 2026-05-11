Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8D3A7590
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.18.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485763; cv=none; b=QreuZLdHdx35oBM87pnEmYkSo4bmWaMYW25jSbBv4FEgnttvDdb7eMyhf31gU+8q9YTLy9LF+lbh6iRuQSKInk0yHCsTmpJp6L/+VY0/MK6o/eYDuNk/wfyrRKSK8nd4KI+bgaKchQCwH1EDK9RRT7T+MYw9ZODojAZldghtzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485763; c=relaxed/simple;
	bh=RJklagVOb01rdp6xmcQNCN1hMtp3NVfyHk5jSrEWMHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8rkgijDNQEc+Bjnuf+arECVBtrpxGBFg5mTzg5oyxP7BygST+H/ZUX+qVFMkoi2lO04Ap6AAvf2AAf8q/AL6NWfrWcy84J89jGw5uxocIXW1IkgAmyo2nhiKmZK5ZRqydWQrw14lXak9GHmhrNZEf7QpDdJXCVD2dz7Rp7gdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alarsen.net; spf=pass smtp.mailfrom=alarsen.net; dkim=pass (2048-bit key) header.d=alarsen.net header.i=@alarsen.net header.b=Cxe6v7yb; arc=none smtp.client-ip=144.76.18.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alarsen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alarsen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="Cxe6v7yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1778485369; bh=aVWz5H2wKxVX7vJW+AJpzWM7hyjI7IFWMJIAyMyWz+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cxe6v7yb6CvZryvKsQF54hnFqeySE7moiO1FHzfzlThSAjtBKh39fKa47XsB5jcev
	 PgS6+WigEvTY9f1yCo/rWJ85GlkE9chejMve/FwhpoHohkhIx/+DVw46w1nQZfvdtx
	 DbBMalQd2ejdsQ7R9PxgD7f2+2iXz+dkPwH7I5vHsI9wPb/Zp8QP1KD1v2hL+Fj1H5
	 7aE1pziMfU7Ya3z1CZAgSYX2ahErIaNqz4XS3hQpeoQssMeC1FXehcpf1CjBrz9UBC
	 F8zh2CD0rAvXV+xITlc20aZ2/4rPifos/SzApJLxbSdDxDtoa6JkiBdwpLEM2uCIyV
	 UXNkU/oyLHT/w==
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:13c6:f483:161f:2523])
	by joe.alarsen.net (Postfix) with ESMTPS id B0769180593;
	Mon, 11 May 2026 09:42:49 +0200 (CEST)
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTP id A34DE6DA;
	Mon, 11 May 2026 09:42:49 +0200 (CEST)
From: Anders Larsen <al@alarsen.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
 Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 Dave Kleikamp <shaggy@kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>, linux-fsdevel@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/10] qnx4: handle set_blocksize failures
Date: Mon, 11 May 2026 09:42:49 +0200
Message-ID: <12893675.O9o76ZdvQC@oscar>
In-Reply-To: <20260511071701.2456211-4-hch@lst.de>
References:
 <20260511071701.2456211-1-hch@lst.de> <20260511071701.2456211-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On 2026-05-11 09:16 Christoph Hellwig wrote:
> qnx4 uses buffer_heads, which don't handle block size > PAGE_SIZE well.

qnx4fs uses a fixed block size of 512 bytes, so this will never happen.

> -	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
> +	if (!sb_set_blocksize(s, QNX4_BLOCK_SIZE))
> +		return -EINVAL;

QNX4_BLOCK_SIZE is a constant (512)...

Cheers
Anders


