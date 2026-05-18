Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8B1E25F9;
	Mon, 18 May 2026 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068263; cv=none; b=aEAQPvmmAFZHkyFpCr7ot4oOAP4Sj0TkwfTxbwYtGjt6Z/E94Wxsaj2hul0vt8IWNcr3M9jWVJdykXcDn/PdQ3jgKpFRMjDijSYlLpyj2ONJhGuIYVr1Zwd8RpooiN39teRw00ohC55y0hB32Tog4VjzDCHw/eblq2MPNll3eMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068263; c=relaxed/simple;
	bh=e5AbEdxc74VyTtMdQ47+WaR/VFcBZJVsh3vG6A1+wT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1ax7BUg8lOKehjTtmyvr+YkZHKhgXEzWAOqcs/H6g2EAphj5SUs3rop53S6RrtXeXZFXTisavborFKWOFTrg5gLmGv/Xqn10FzYFgJka79Jvw/6EoUwkbBWxI5K9jnvfgd1Aw16YnICHFrZydz1pt7Ve63lUh5SYoPMkFIQUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hL2APeN6; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hL2APeN6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779068258; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G2A8yq+atc45C9TkkOViHo8ROyU1Q4Q+TbyHIReW5Ys=;
	b=hL2APeN61YctbYRkQnzud2mqSAtZZnXBsqe9IL1xhgiFmUmQnQWl2THHK44ioPsNWYZSTmF664KaIa9N0B0Y9gBIky9L4AjNjI5ALOSFmdgKyzjIaBlFKSHh2seXyWiz9dk1pv/7mexperERMvSboswoHi9FN6ooh+udD1+PoSo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X32gD3I_1779068257;
Received: from 30.221.129.172(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X32gD3I_1779068257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 09:37:38 +0800
Message-ID: <ead6ed9a-e198-48aa-bb63-03049a3b08b9@linux.alibaba.com>
Date: Mon, 18 May 2026 09:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ocfs2: reject dinodes whose i_rdev disagrees with the
 file type
To: Michael Bommarito <michael.bommarito@gmail.com>,
 akpm <akpm@linux-foundation.org>
Cc: ZhengYuan Huang <gality369@gmail.com>, ocfs2-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
References: <20260517111015.3187935-1-michael.bommarito@gmail.com>
 <20260517111015.3187935-3-michael.bommarito@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260517111015.3187935-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/17/26 7:10 PM, Michael Bommarito wrote:
> id1.dev1.i_rdev is the device-number arm of the ocfs2_dinode id1
> union and is only meaningful for character and block device
> inodes.  For any other user-visible file type the on-disk value
> must be zero.
> 
> ocfs2_populate_inode() currently runs
> 
>     inode->i_rdev = huge_decode_dev(le64_to_cpu(fe->id1.dev1.i_rdev));
> 
> unconditionally, before the S_IFMT switch decides whether the
> inode is a special file.  As a result, an i_rdev value present on
> a non-device inode is silently published into the in-core inode.
> A subsequent forced re-read or in-core mode mutation (cluster
> peer with raw write access to the shared LUN, on-disk corruption,
> or a separately forged dinode) can then expose the attacker-
> controlled device number to init_special_inode() without ever
> showing an unusual i_mode at validation time.
> 
> System inodes (OCFS2_SYSTEM_FL) legitimately use the bitmap1 and
> journal1 arms of the same union: allocator inodes encode i_used
> / i_total in the bitmap1 arm and the journal encodes ij_flags /
> ij_recovery_generation in the journal1 arm.  Those byte
> sequences are not an i_rdev and a non-zero pattern there is the
> on-disk norm, not an integrity violation.  Restrict the cross-
> check to non-system inodes; that is the full surface where
> i_rdev semantics apply and is also the full surface an
> unprivileged consumer of the volume can see.
> 
> Following the i_mode canonicalisation in patch 1, S_ISCHR /
> S_ISBLK covers the whole device-inode space; this check operates
> correctly on its own, but the canonicalised i_mode makes the
> predicate exhaustive.
> 
> Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/inode.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fb592bf3e5f31..305e22cc9b1d9 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1533,6 +1533,44 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>  		}
>  	}
>  
> +	/*
> +	 * id1.dev1.i_rdev is the device-number arm of the id1 union and
> +	 * is only meaningful for character and block device inodes.  For
> +	 * any other regular user-visible file type the on-disk value
> +	 * must be zero.  ocfs2_populate_inode() currently runs
> +	 *
> +	 *     inode->i_rdev = huge_decode_dev(le64_to_cpu(fe->id1.dev1.i_rdev));
> +	 *
> +	 * unconditionally, before the S_IFMT switch decides whether the
> +	 * inode is a special file.  As a result, an i_rdev value present
> +	 * on a non-device inode is silently published into the in-core
> +	 * inode; a subsequent forced re-read or in-core mode mutation
> +	 * (cluster peer with raw write access to the shared LUN,
> +	 * on-disk corruption, or a separately forged dinode) can then
> +	 * expose the attacker-controlled device number to
> +	 * init_special_inode() without ever showing an unusual i_mode
> +	 * at validation time.
> +	 *
> +	 * System inodes (OCFS2_SYSTEM_FL) legitimately use the bitmap1
> +	 * and journal1 arms of the same union (allocator i_used /
> +	 * i_total counters and the journal ij_flags /
> +	 * ij_recovery_generation pair); those bytes are not an i_rdev
> +	 * and must not be checked here.  Restrict the cross-check to
> +	 * non-system inodes, which is the full attacker-controllable
> +	 * surface.
> +	 */
> +	if (!(le32_to_cpu(di->i_flags) & OCFS2_SYSTEM_FL) &&
> +	    !S_ISCHR(le16_to_cpu(di->i_mode)) &&
> +	    !S_ISBLK(le16_to_cpu(di->i_mode)) &&
> +	    di->id1.dev1.i_rdev != 0) {
> +		rc = ocfs2_error(sb,
> +				 "Invalid dinode #%llu: non-device mode 0%o with i_rdev %llu\n",
> +				 (unsigned long long)bh->b_blocknr,
> +				 le16_to_cpu(di->i_mode),
> +				 (unsigned long long)le64_to_cpu(di->id1.dev1.i_rdev));
> +		goto bail;
> +	}
> +
>  	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
>  		struct ocfs2_inline_data *data = &di->id2.i_data;
>  

