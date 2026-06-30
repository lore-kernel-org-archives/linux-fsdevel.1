Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27637C92E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810363; cv=none; b=bpBUP8DvmuKTzYRDKeWRQh8p3pTm1vpaliS948++53UkJZmlTVNH8mPL6OPFiURIHLY9VbNz13Ij7cAA61X1Epo4sNbrI6jcLCnxbm81dk8BMWpOR2eXYHgnHenvRnp62F8F9SDq8yK9nHMXIaHZKXv+n6c8QuONtar8RSSeV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810363; c=relaxed/simple;
	bh=gbMPPQ3n9QEhlGJlpwO/+6Uka55Nk+n8uCxjh4PeC4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4mCpC3/i8/2pZRXTwrYaUQFaNTfVAa3SB5Xo1U/1z7La6jsx/sGRJ+A7oDjYygLF9FuqibfMDWO2RlBtIENI+XCC3weLytIIDggeHQY6/qAm3Zrl5CbLsrMtJlv9OleFE58ZuBBZuFAT23bSkdWyq8Y+/2ASbwOrNh9xkttcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsjhvKDy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsjhvKDy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47362928f65so1636655f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782810361; x=1783415161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfAP5FaVrESGM9X5O0kkbadZqZEiMwMCA2dap+dbsVM=;
        b=KsjhvKDyW18CtbIqijCs1lQbZI4/J5ROs/SZdBwJYuuYxZ1kCznX3vyqhPYy7oE2Sy
         Q0qC/qrCEN1Y8WnN4jSSp7AFqkV/bDv7XTPWlaPtAXygDhCbf9rGLY69N2aTHMGQI7Pe
         bobHAKvrf4TMWmPvnwfHq0uBDocFqQClpwbFUwtuUOe9PvApJ5y0KNUs9Kl1JWVRh4Vh
         sO2mgOMapJJckIixkgYL1oUx54vK2jyRiXxS3+f7EQxCcPA6ef4eyuCZwiZf+V0Y3ydb
         VE1m+KQVGh9ZuHU4dq7b0kn2TBYmgE38M57OHIiledRrVeyxOU/u3xtUYyEx325NTnu3
         qKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782810361; x=1783415161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfAP5FaVrESGM9X5O0kkbadZqZEiMwMCA2dap+dbsVM=;
        b=Xz+Z15LB2rjVMKJSwWTmyJypfCwHof4pTfoYLspWCWGoACO5UVHCmfCPex6yVmzIjB
         bVJybZEz/odN0sw6TIGa1TXj8gHd9wrjVGy85SMuxSh9SW1RYoT27whLVjllyRVibkQq
         5zTfRz7v/759emNQNI6/blVw+7VWjKLy0GwfHlIWuSja5ADqEbTLdo1Czj6mQJGVmXxp
         i6TniRUtsDDUSyVLFF/j5AqgMfTHKbwowLN/I/8NnETfIVNNwdY1PX8dlS/huRTpHBOr
         TDCRv9S5db5Xxpp9hS5mZgTglPnB5428Pvwy3fbHMIHHbRDduJzm2rh0my2V6JfBH2zy
         h3nQ==
X-Forwarded-Encrypted: i=1; AHgh+RrD+cS8nZ2a2if/w9FJxJ59MvJ+noG2HDX4thgYBsiAMignT3GlTkX0/93s6cnQJfA480z30tZCMIRD4pUs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy39t6NNVoSEelQeNQc4EvfN1ArcFg8LLfuFBoEUiMy56spe2O
	UHepcfC5T8Nj2BPzkl6370ga8X4qVy2pDlUmyp04vHeNFy1I7k/o/uJF
X-Gm-Gg: AfdE7cmeErOBt++dxjTeBpd6Eq4oKPRbzUxrQbI69D1WYA2KYAJtnEIEhxRIYb7blH/
	qYRnIkxPyKQtei74W3VDmtYEMpL4V0DhFiCJonxqEVeojTmqNneMvVT2A72Nr5FhKeZg4LR7836
	DVbn4MAcXPOxkLBf41dkSiYMNq48/ugUfJP2LmjEkWdMXau/Ga5DicAghpc4fQbAiQ3zkNSucx3
	RlSpTV4HpdWPfJ2NrbXkb79GN/NCwHIDpMSVdQqYWFbOySArNAoyZJXGorOMG+poNW3yK3uu2Oi
	kM4k145HYLKr7J88ejiQANVgEwa8Ynvu68FkGoO5GGSmDL5H/YGtyPrD9rsmLvxS2LUIKe5J8Bp
	Jlhl1RekDYNvTjdHk4rE1ot0GPGEfEnCQQ7hhV1eJb/MdzylEMwh9rYEskiD5vfMb4dcQ7paJHf
	rfB6PVVU50h+15pgWoUD/BktRFXOKikk2eyMpApStEyaGF9MxXENSB7Po7ImnE
X-Received: by 2002:a05:6000:29c8:b0:472:326c:a4a0 with SMTP id ffacd0b85a97d-47553028a5cmr2459777f8f.23.1782810360640;
        Tue, 30 Jun 2026 02:06:00 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195besm5562998f8f.2.2026.06.30.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:06:00 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:05:50 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, libaokun@linux.alibaba.com, 
	jack@suse.cz, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	yi.zhang@huawei.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	xiaowu.417@qq.com
Subject: Re: [PATCH v11 1/5] fs: add iput_if_not_last() helper
Message-ID: <4k4crl4oobz4xtmvjoqwoefrd6in46xf725z3ewme3smgh5ide@6dmywcnp6o6y>
References: <20260629110848.3085662-1-yun.zhou@windriver.com>
 <20260629110848.3085662-2-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629110848.3085662-2-yun.zhou@windriver.com>

On Mon, Jun 29, 2026 at 07:08:44PM +0800, Yun Zhou wrote:
> Add a helper that drops an inode reference only if the caller does not
> hold the last one.  Returns true if the reference was dropped, false
> otherwise.
> 
> This is useful for filesystems that need to release inode references
> in contexts where triggering final iput (and thus eviction) would be
> unsafe due to lock ordering constraints.  The caller can check the
> return value and defer the final iput to a safe context.
> 
> Unlike iput_not_last() which BUG_ON's if called with the last ref,
> this variant is designed to be called speculatively.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/fs.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d10897b3a1e3..04f0de78fa7a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2413,6 +2413,19 @@ static inline void super_set_sysfs_name_generic(struct super_block *sb, const ch
>  extern void ihold(struct inode * inode);
>  extern void iput(struct inode *);
>  void iput_not_last(struct inode *);
> +
> +/**
> + * iput_if_not_last - drop an inode reference only if it is not the last one
> + * @inode: inode to put
> + *
> + * Returns true if the reference was dropped, false if this was the last
> + * reference and the caller must arrange for final iput() in a safe context.
> + */
> +static inline bool __must_check iput_if_not_last(struct inode *inode)
> +{
> +	return atomic_add_unless(&inode->i_count, -1, 1);
> +}
> +

This still could assert on the count, for example:
	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);

>  int inode_update_time(struct inode *inode, enum fs_update_time type,
>  		unsigned int flags);
>  int generic_update_time(struct inode *inode, enum fs_update_time type,
> -- 
> 2.43.0
> 
