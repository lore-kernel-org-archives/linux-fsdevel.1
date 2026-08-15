Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C1202F71
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832074; cv=none; b=NjG9MvIkBv6htKS6uJCvY93PcXSgqwZiswroad9soB3Ppn0pg/ptgrGImJGrhmqkKejNr3vDWI/jQ3XTMCKfkHe1/hKTJ/xUN7RYU3/Ra4NChWcTBsx0f7BRyXy/cNEFCLgaKJDBLQ5oK/GxS5iPl6iujDV0hBj6vSatK5VkAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832074; c=relaxed/simple;
	bh=oZ4oCwVC/BFzaEM+skmk92FgnswjRK5XhgBLqJzeLcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em2pI8Mx5e8I4GUCiVWkABjNBwvT9ZGpc39Ko8LwwlYsaxdG9fU5qo/AZy/FgkqVs1yNb7eJkzcvskchOk/EPa0GLBpeX/tB1bVDn3mDLIoVpYQFOPGwKrRJqogjvQEBgdo3yuI1kW/bk6R4fMojVlZ0M/HrWK3vYhsd/KMw8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CqGvC0UG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CqGvC0UG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so11286305e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786832072; x=1787436872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AN1qC+lu6UaXd8pXziAeuMVzPx189lShvJn/q+qxOFM=;
        b=CqGvC0UGx8QA8HWWZ0xHJYFYgYMxKpYzjzHxD5JcRo23kXNTTOQw6CihlnTxn5D3zz
         xh0KwndLNVI/uasv3AQecEl7RDI1bSzgmvBsdZQxosjxOuGYb/LxgkmcpY8tVysoPcPq
         tm62c9nj+/JLLdZH5flHuHraZheEJfQVM2jEeQ/Ay7+FgY/lRZiyg+78lAqd8ePNk7D1
         JM5G5gFE2tEI3/9lGh/Hsr/gI9h+NRFniwknf6nN9rcp1nZ2lGezE1Jm+1JXRqR7OdiH
         8KWID9kLZwUFlZ5A2w8G9QGIT9A3hlgJaa2tBtWQraIxQOVo3BVrhAT3hYuibA8QfNMV
         +ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786832072; x=1787436872;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AN1qC+lu6UaXd8pXziAeuMVzPx189lShvJn/q+qxOFM=;
        b=BaYUEoaC9yKhwQ0iNLLasaJL2mLa6rcfcnn9N+LwC8BY0NX2m+IIJ5kHqJwsVU598R
         DKDAYfn7/+pZgwLfLZFWIGnwvhdm/ba2tVMOK2I5HCC2ebXpQPin51+NM6x5x5dWo+0M
         L9Je4toLgzjIqn1AMiiZ32ZsuKeJVbUnlnXKWwNdBxth016FsMLtmkdxwQyqPeg92BUT
         SH42o6CiCG4/KfrG1B5VwtPCwrEDApfmMTTzweM7OPZB9R305CnYDoox5ferIwVgsocy
         P0MU5HPlSuprtXc8bytceLmtDOov/DLjudSyg7/v96vi3cLwTN13N6heopwOVgs3eABY
         2cYg==
X-Forwarded-Encrypted: i=1; AHgh+RoBFJVtGmUnTNEwnccldgLvSXCjIymw8o4bawyDzEUcpX5/JNlGyhDmfEFWctt8UQKMNtY0bDrgWuXnDPR8@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5+e45+S1Pi+EiHwD8BWnPmNJniObjJ1enwmI6RRMnoqVlGfo
	H4192sjbAJac628VcdM6JMJpzxsNz7b8lyf0I4wqNnlQDCHjkgRmkDzbBKHnE39lg0Y=
X-Gm-Gg: AR+sD112kTKdFJonUU6lXMUGheXLE0S/E416cXpQ3klYhLIsyCc+yYxd7jw+NTddPKn
	eCCq3UvvPZCU2QnFYLNtnkUROwWr/OSaJVvDPSPhbmRRTrujncmPWDVWbPT7+IEMYDotD5jjThQ
	rE9QblmsVo7CaeC7279t1wyshNDvzmAw6iK1cAF0DxYOfOAWlBx32mKMH+OhUthMyPvUid07smR
	zoXkAvsgcnMIb4aox0oR7W+T8FAmMKK4vvMFSCHk107K9iql2nVWP+mdFdOobbOc1PYiYCkI43f
	ffm3nhVnlbXnfMtW8cDZnoBnbJ9EsnifaFUFN23lZD1/Zt4bulDgOL4ENAxHDXRHQMRuKdEScH9
	BPQ+HGFqea1s+ETXYsLKpiL1VH6fH26Ivu4Lhs51zpuUA6gPI/ZehMKjtbfydTPozGkFU9qtJuW
	87soCKZ0uQkJIoL25aJcY9T2VEfObjgU1eMwQwzUAV2PE41tOfZCMz4CivxHuEH7dV
X-Received: by 2002:a05:600c:1c21:b0:499:90f3:13b8 with SMTP id 5b1f17b1804b1-49990f315e9mr74686435e9.12.1786832071756;
        Sat, 15 Aug 2026 15:14:31 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm18829339eec.21.2026.08.15.15.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 15:14:30 -0700 (PDT)
Message-ID: <33963533-344c-4f52-8ef7-4c10979f3153@suse.com>
Date: Sun, 16 Aug 2026 07:44:24 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: allow idmapped DEFRAG ioctls
To: Tao Cui <cui.tao@linux.dev>, clm@fb.com, dsterba@suse.com,
 sforshee@kernel.org
Cc: josef@toxicpanda.com, brauner@kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260815132259.3935817-1-cui.tao@linux.dev>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260815132259.3935817-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/15 22:52, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> btrfs_ioctl_defrag() checks MAY_WRITE against nop_mnt_idmap, so on an
> idmapped mount the owner comparison uses the caller's fsuid against the
> raw on-disk uid and the ioctl fails with -EPERM even for the file's
> owner.  Pass the mount idmap down so defrag works on idmapped mounts.
> 
> The check, added in 616d374efa23 ("btrfs: allow defrag on a file opened
> read-only that has rw permissions"), is not a privilege gate.  It only
> tests whether the file could have been opened for writing, and a user
> who owns the file on the idmapped mount can already open it O_RDWR,
> write() to it or fallocate() it.  Defragmenting a regular file only
> rearranges the caller's own extents; there is nothing it can rewrite
> that the caller could not rewrite anyway.  Whole-subvolume defrag on a
> directory keeps its capable(CAP_SYS_ADMIN) requirement, and the
> !capable() guard around this check is left as is.
> 
> FIDEDUPERANGE already works this way for unprivileged callers:
> may_dedupe_file() in fs/remap_range.c compares the inode owner through
> file_mnt_idmap(file) and falls back to inode_permission() with the same
> idmap, and dedupe can rewrite one file's extents from another file's
> contents, which is a stronger operation than defrag.
> 
> On regular mounts file_mnt_idmap() is nop_mnt_idmap and nothing
> changes.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
> v2: rewrite the commit message to explain why defrag is safe for
> idmapped users (Seth Forshee); the code is unchanged.
> ---
>   fs/btrfs/ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 72bc9d4f7708..607329dedd50 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2458,7 +2458,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>   		 * running and allows defrag on files open in read-only mode.
>   		 */
>   		if (!capable(CAP_SYS_ADMIN) &&
> -		    inode_permission(&nop_mnt_idmap, inode, MAY_WRITE)) {
> +		    inode_permission(file_mnt_idmap(file), inode, MAY_WRITE)) {
>   			ret = -EPERM;
>   			goto out;
>   		}

