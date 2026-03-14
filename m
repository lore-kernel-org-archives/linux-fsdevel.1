Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCE175D53
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773492473; cv=none; b=gk6bd1s2ejUq6a7cCfh84A5MsjXo/gWBUjKJ0m0GahQLKb5dcu937CXr0nQm2lAQzUDh4PJe8DbIQbwsGx5LbjMEm5gS42KRV1j7UNj0IklFw/iPu7zPy6XspYHfrtF1DGxCI/Csy7yTGoih4lxZrvOvWs4FuL5YDNCTQDUhDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773492473; c=relaxed/simple;
	bh=fA+lyYP+110atZU61RzhzGbte3ZkKDvt1ynoLWRnNes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8OKa7tXtSbuK5IwQbM3t0VWmJT5lKNtrF2Aaq3d7pfG1H/kH9sG8L6XfEAUnaEi8Tnq+MBxgS9os0kRxs7jKJiHemTiqQV4cW08jbJkFPjC1DfY1zrBME5dVbsV76g9X8e1UdP0RHv2zlpwalZ3R1s1UkCw66CdYKR9aGpDhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLrjb/7e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLrjb/7e"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so13787575e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773492470; x=1774097270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaFmVkPTbLRBufh3Qs4dGizBfbZxXt2RQDq/b/ikJHk=;
        b=SLrjb/7ehi9mvnV2lp8cG6GHoo8DoxbKPQA9OfghINpA2cBulLrDFt0cTBop6qCybZ
         Z74tVSY/x1UMCAkrib7HuJvcTIzN7xYqE9UVpD7QR9zFnOL+qAT8tSwBj6FArLhw+luj
         4Tiqt0fBcpROCkc3zTYes+EsNyt39+15GaJuCcJe1dvPSmRlVT1nXxGC2GpPnjal9WDI
         zKcwhYmsjtVhq1yVY3Yl65iSqGFjp7eQ2BIV+XnXSNN4DoPQCCTuwNWvGC4UJ+zpUhO6
         C4aIF2gapzA3Db7q9kstfSnrhu043ksiaU+NBR9xrEacnxH3dLPVsi2tsquwp1R5tuEF
         f72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773492470; x=1774097270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaFmVkPTbLRBufh3Qs4dGizBfbZxXt2RQDq/b/ikJHk=;
        b=K4vzNJstvDD7oPfgqD6Bw01aB7f4TcboiNWNi8pkQTKj8Lw7TmcOwYtzPvNNm7s7cO
         A/IVhsR0n6KYs1CNQTIi+L8KamHhXlacP4zBvEa0tWpqIS6V1TJSet+r/sNjtdX1b9t/
         QLZ5WodhHmsRlq1iUiNrtMi2AOr3TE7r8B++wnxmFGBbYZ82uPQkA6PnaWp5MuDPEmG+
         ZL7meMhENpZ0PV6afSqUVTMwnPj9c/6PLKCmGa4Uf7EeerbK6PpQ9o02RHrBDYEhaI5Z
         5VyrZ+s3btcw/cNmdF8QtcgyoPu/IbUYqTTk2nrhJToy+OISDEaWGcpJRLGCyEKqYpv0
         Grng==
X-Forwarded-Encrypted: i=1; AJvYcCU9CrgyBqudr2UpSbTbXdXQvMXMFEPyj5sJJLbq7HlhJbNKW9+dP2sWi8upU4T/Ma3WBrivuDVZ0Lc07+cI@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYmMg8g4Be8G3Z8BFqubYDC4AtLmaqPLpw4sSNz2HbISD9lDb
	8/uEY0ifzHsdi7cvL6dOaufownONUMiRSLaEMv+KTy10i+NLOyCdyNga
X-Gm-Gg: ATEYQzyzV7T5VieQ711QxLwKj5Y+UibemjubVbI3KUabb4wGlRh6nWPxsR2JYklKFKA
	jS3IjsbLWsPop/wZSTYtL8lHQcJ5BtXbqrLDVX/O8IPfspgCjCIKGAqGGQfpKxscARzNZQi2k55
	kERh7JuC1HLb76vJvrP2toWPWt7PCh+4QNL4C+1puDpN2vChj2WWhAB61j8JPd84kz8BUzhy8op
	/CXFHG31jctoJZPgen7asoKDuOBBO0Fy8v5iXvWl2bcTtO66ufNqPQ8znwFDP/3xj1ezYgqPZrl
	B2x5Mzhvy65XoWAPS9fgv6YzmstlPG6k0+Nc9pK8FY1zDx8yZXUTPKFAn0srmdAZSW4prF5u1vn
	IQxCAxyY7zEWDY69nCfgjZZtZs9ZI6wEj43xEDk1mJK3XzfSgj2mvz+086mA/c6UseO3aql6WTQ
	lkHDEU1aQE9b78/uOSXynA/gkVsZ+4lYoIcn2rzQoLutOI6DvH7wkZIlh2HPTZvr7y
X-Received: by 2002:a05:600c:8b83:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-4855648f5a3mr104574955e9.0.1773492469891;
        Sat, 14 Mar 2026 05:47:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm281121385e9.15.2026.03.14.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 05:47:49 -0700 (PDT)
Date: Sat, 14 Mar 2026 12:47:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, Christian Brauner <brauner@kernel.org>, Mimi Zohar
 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] nilfs2: fix 64-bit division operations in
 nilfs_bmap_find_target_in_group()
Message-ID: <20260314124748.1ccdf93b@pumpkin>
In-Reply-To: <20260313-iino-u64-v2-1-f9abda2464d5@kernel.org>
References: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
	<20260313-iino-u64-v2-1-f9abda2464d5@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 14:45:20 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> With the change to make inode->i_ino a u64, the build started failing on
> 32-bit ARM with:
> 
>     ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!
> 
> Fix this by using the 64-bit division interfaces in
> nilfs_bmap_find_target_in_group().
> 
> Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier conversions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@intel.com/
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nilfs2/bmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..abcf5252578ad24f694bfccf525893674bfcb4bc 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const struct nilfs_bmap *bmap)
>  {
>  	struct inode *dat = nilfs_bmap_get_dat(bmap);
>  	unsigned long entries_per_group = nilfs_palloc_entries_per_group(dat);
> -	unsigned long group = bmap->b_inode->i_ino / entries_per_group;

Are you sure entries_per_group can be more than 32 bits?
It looks like something that will be the same size on 32 and 64bit.

> +	unsigned long group;
> +	u32 index;
> +
> +	group = div_u64(bmap->b_inode->i_ino, entries_per_group);

You don't need the full 64 by 64 divide.
IIRC there are both div_u64_u32() and div_u64_ulong().

> +	div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &index);

NILFD_BMAP_GROUP_DIV is 8 (and probably has to be a power of 2).
So:
	index = bmap->b_inode->i_ino & (NILFS_BMAP_GROUP_DIV - 1);
is the same and likely much faster to calculate.
(The compiler will have done that optimisation before.)

	David


>  
>  	return group * entries_per_group +
> -		(bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
> -		(entries_per_group / NILFS_BMAP_GROUP_DIV);
> +	       index * (entries_per_group / NILFS_BMAP_GROUP_DIV);
>  }
>  
>  static struct lock_class_key nilfs_bmap_dat_lock_key;
> 

