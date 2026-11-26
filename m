Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657936;
	b=EC3Xd/eEDkJDdHYFVAdtiwSPBkNuuvJ5c4CotTUCGVYHZEAC673WotcSwMqfwO0QXIy+
	 iBge3PRPymds1XxhN3iCLIWxC5241L8h9LKcKApZPcfsjCSc/5d552SeEQxkgsaSIR9fB
	 3Eo9Lcpe/Zw9x//NkNASrfSQG7EAeHG02SE9Y+7J+Xp5tbyoVip5s7yv4jkP25qQQxPGA
	 hvWRKRDGcM9/Chz6bcDs2Z7Z+8i5TtLyO1S/Uht0Bm9XgAxUFs0klZUWZNm37dG6097a8
	 TAV6sdtf+CowQCEYaaUX68Idfh2qdgF8W3XLTc/cQED6RfohgjBPgZjIg7altR4XErA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657936;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=InslSophhZR8ptLxuH18WsVK3o/vxwbo+9Lc8i/W61k=;
	b=New86yAfBiXDStXBivC6rrGeqSHsbrbXC9UjGcuWTYP0TIldX3yC4AZUNM8LGb6U0SjT
	 VhUYO0fY6PW7esYEhFXkfJ9TT/2YV7RapdP2fCWJ1O/E5FY9OAGzD7n2XRyxHJrkqJEe5
	 eVaDyKrFhouwBR310pKDh37NV3QutOxhxS2t1friDiinEgsxShNO8YOSAZi8b2OTZrZkO
	 d3YXOEKu3aIgqu5RuCCE+IDN6PAUvxRZQNDbisOCDoKunOXoaYekPBru0XL5QDOAD2JP5
	 ClcmBQvWcxIL7EDlcuzJbswqHoPnPxOiCo0VL6A4uksFLHDZFmeg6giikUJKDmlch6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hFGnDDdL;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D14606A31E;
	Thu, 26 Nov 2026 01:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hFGnDDdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=InslSophhZR8ptLxuH18WsVK3o/vxwbo+9Lc8i/W61k=;
	b=hFGnDDdLUt9A9KsPTLxHoUp8iLp4RHw62Xt0sKKHqdi1EklnCggyFfR44UkMXO
	yL3WVoeoMiU7ptqe/QlsGKpG/V2rHjLV5RnkHY7ClIMsf0r2e7iGoCZbkall7s3A
	KzjinljwqwX/40ig38rrk+OzOSOylqTpeEAlbRCF6xbX8=
Received: from [IPV6:2409:8900:1fda:c14d:483b:2970:cae3:221a] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXf0+rkAdrvRQPKA--.54445S2;
	Thu, 26 Nov 2026 09:51:41 +0800 (CST)
Message-ID: <d2887b0e-a852-490e-bb07-e4b17d979622@163.com>
Date: Thu, 26 Nov 2026 09:51:38 +0800
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
Subject: Re: [PATCH] ntfs: keep i_size of a directory equal to its index root
To: Showta Ishizaki <zakinko@snowrabbit.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261125-ntfs-01-v1@snowrabbit.org>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125-ntfs-01-v1@snowrabbit.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf0+rkAdrvRQPKA--.54445S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWkZF1fAr4kKryUAFyxKrg_yoW5JF15pr
	ZFkr4fK3ykX34UCrna9F98Ga1UurW09rZ0grW5Aw4293s5tw1SgF1jy3y0g3yIvrZ5J34U
	XF4DArW8Xry3Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U24iUUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6g3rtmsHkK3MyAAA3v



在 2026/11/25 22:18, Showta Ishizaki 写道:
> After mkdir, stat() gives a size of 0 for the directory until it is read
> back from disk, where it gives the length of $INDEX_ROOT.
> __ntfs_create() opens the index root but does not set i_size from it.
> 
> When the index root is moved out to an index block,
> ntfs_ir_reparent() updates data_size but not i_size, which keeps the
> length the root had before.
> 
> Set i_size in both, as ntfs_ir_truncate() does.
> 
> Without the patch a new directory was 0 bytes and became 48 after a
> remount, and one with 300 files was 248 and became 56.  With it the sizes
> are the same before and after.
> 
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> ---
>   fs/ntfs/index.c | 3 +++
>   fs/ntfs/namei.c | 7 +++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index fe2a79b..73c8e6f 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1434,6 +1434,8 @@ retry:
>   		icx->idx_ni->data_size = ix_root_size;
>   		icx->idx_ni->initialized_size = ix_root_size;
>   		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
> +		/* As ntfs_ir_truncate() does; i_size kept the old length. */
> +		i_size_write(VFS_I(icx->idx_ni), ix_root_size);
>   	}
>   
>   	ntfs_ir_nill(ir);
> @@ -1455,6 +1457,7 @@ retry:
>   		icx->idx_ni->data_size = ix_root_size;
>   		icx->idx_ni->initialized_size = ix_root_size;
>   		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
> +		i_size_write(VFS_I(icx->idx_ni), ix_root_size);
>   	}
>   	ntfs_ie_set_vcn(ie, new_ib_vcn);
>   	goto err_out;
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 29f1bf5..e4b0fc4 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -611,6 +611,13 @@ static struct ntfs_inode *__ntfs_create(const struct mnt_idmap *idmap, struct in
>   		err = ntfs_attr_open(ni, AT_INDEX_ROOT, I30, 4);
>   		if (err)
>   			goto err_out;
> +		/*
> +		 * ntfs_attr_open() sets data_size to the length of the new
> +		 * $INDEX_ROOT, as ntfs_read_locked_inode() does with i_size
> +		 * too.  i_size stayed at the 0 set above, so stat() gave 0
> +		 * until the directory was read back from disk.
> +		 */
> +		i_size_write(vi, ni->data_size);
>   	} else {
>   		/* Add DATA attribute to inode. */
>   		err = ntfs_attr_add(ni, AT_DATA, AT_UNNAMED, 0, NULL, 0);


Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

