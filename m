Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70B31E828
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333777; cv=none; b=BXWvrwcsBE8sz0niVr9Efw8PL1isxdWBDskXlpWutfV8+jVlp+j1o5aLi9fTcZlRo5zEvsfpQW8N5/pxJ9tPih9RZgch7sVFo7SqftusJVUGyCz+wzP7zcLq1vbHWWGKZdadeCtfHIip8ThmoCHVWFh1j+Bk5L/8IRP5XSNxYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333777; c=relaxed/simple;
	bh=IGUqgwZyM66DRTP2saXo2sCLUoGr1kmjqp1NKR3KvXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JivbabZeZHceN875uzZ1CBTutcLT6vBZw138VKwGK5tWEW6hNpUqzETxAOV8S3zgwBvYou7tGggzs6P4GncfosYWewRmP2v0F3iFAKveYDN8A2QWrNnG+wT8h5VVAKj59L5irTpoj6Lht97n/8vMOQgBDSOQkj7P2gezWVFzz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=B3az/KVZ; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="B3az/KVZ"
X-KPN-MessageId: 469300c0-397b-11f1-afda-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 469300c0-397b-11f1-afda-005056994fde;
	Thu, 16 Apr 2026 12:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=JG4gM0jHW5jNdyC0Xi6DedDXP3vyhPOeJlqhB44QDbA=;
	b=B3az/KVZFS2bm/yhKGXtEQ88FobxkkGIZNDVmyc8svu1hZCTtSVs3dG0IAbahRFfvEbI+3qc/DEUb
	 4OjP/LMtVmpA+ce9QmPk4u36QVNkycrBwkdTIQIhjxcX6mG3o5HliQigP4gnYZ4/24ornaBYAgEP8V
	 VcSV5hhSUwmIO2zwBkkPQN4de6nV2Aj4pfH+959gGC8rDVehAdauhoVhqqLZFw8rKfDy3LPQqUEMn+
	 vQtUflYzn/D9Bsrw0Wx00Isw0fWx+chZo8c54S1KP2teFGqaFsDsaw4qo3ZcSxjaSql+C3ye9n2qr9
	 Eydm07KmroUYgQn3CNUXWJnW1BmlGUg==
X-KPN-MID: 33|7tXmQ2EPfFEJ7eoiscPactBx6BGllMPdQcQ8FTDbM2l1ratVEvX4eqWnqTMADpN
 828R+vCXysLphD03l0AYg89iljNvM/gH+KhkOsOtS5qI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2S12EuVbSnmOQRTb4k2ALYupxwwu2PxJihZj4lFTKaLjuChnpO1KyJceXSzNiUK
 BGqz3wfihsEhrKSQyjhsVMQ==
Received: from localhost (unknown [178.226.144.191])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 465c9280-397b-11f1-8d42-00505699b758;
	Thu, 16 Apr 2026 12:01:45 +0200 (CEST)
Date: Thu, 16 Apr 2026 12:01:45 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: greg@kroah.com, linux-fsdevel@vger.kernel.org, security@kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH] jfs: fix missing bounds check in __jfs_setxattr()
Message-ID: <aeCwOoi1gV_sjnQb@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Sebastian Alba Vives <sebasjosue84@gmail.com>, greg@kroah.com, linux-fsdevel@vger.kernel.org, 
	security@kernel.org, linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	jfs-discussion@lists.sourceforge.net
References: <20260413140328.173446-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413140328.173446-1-sebasjosue84@gmail.com>

On Mon, Apr 13, 2026 at 08:03:28AM -0600, Sebastian Alba Vives wrote:
> The loop in __jfs_setxattr() iterates over EA entries without validating
> that NEXT_EA(ea) stays within the ealist buffer. A crafted filesystem
> image with a manipulated EA valuelen field can cause NEXT_EA() to land
> inside the buffer but past the last valid entry, leading to out-of-bounds
> reads in the subsequent memcmp() call.
> 
> Fix this by adding the same bounds check already present in
> __jfs_getxattr() and jfs_listxattr().
> 
> Reported-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  fs/jfs/xattr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index 11d7f74d2..320659bb8 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -688,8 +688,14 @@ int __jfs_setxattr(tid_t tid, struct inode *inode, const char *name,
>  	new_size = sizeof (struct jfs_ea_list);
>  
>  	if (xattr_size) {
> -		for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist);
> +		struct jfs_ea *ealist_end = END_EALIST(ealist);
> +		for (ea = FIRST_EA(ealist); ea < ealist_end;
>  		     ea = NEXT_EA(ea)) {
> +			if (unlikely(ea + 1 > ealist_end) ||

What use is this check? How can ea + 1 > ealist_end immediately after
ea < ealist_end?

> +			    unlikely(NEXT_EA(ea) > ealist_end)) {
> +				rc = -EUCLEAN;
> +				goto release;
> +			}
>  			if ((namelen == ea->namelen) &&
>  			    (memcmp(name, ea->name, namelen) == 0)) {
>  				found = 1;
> -- 
> 2.43.0
> 

You should also know that jfs is not maintained, and there are MANY
of these issues (see syzbot for instance). To my knowledge the community
has decided to deprioritize these kinds of issues, and perhaps
eventually move to FUSE based implementations for legacy filesystems.

Also, you should cc the general list linux-kernel@vger.kernel.org and
the jfs maintainer Dave Kleikamp <shaggy@kernel.org>. Use the
get_maintainer script.

That being said these fixes are still accepted. Thanks for your (first?)
contribution :)

Thanks,
Jori.
