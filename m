Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC003F3263
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053897; cv=none; b=bZJovXh0tPcP7XpszXeNSXTMKg9p6KBNd7TuHaco+dxufTtJo96aKJc42hdicqLAHfMsCUZe8fe6OrTsqsM3qIzIG3bOBiKhSonE4sMbseWSGcPEFzUdisg2t3ZyJNMhjrGiiVyA0Oh3z7JsslX/DQyIHMUG4oE7PuDdgOQI5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053897; c=relaxed/simple;
	bh=y6LW+4EMD/h/HE/Ap7AiqFOjRDXaX850YiMwFVMKzHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeY8iiFp3HIPXzZ7D1l1ZLY/Lh0yzowAieML+a955fBuXKohvHbs0Yut+u3d4c+sK2CwRzt0Z2hDJfDrv0JdVno2/4SiM/osqVv6JUV6iHgD/K66d54nmIQw60uLvcj/KlEVLmnYrLTzwDTx+pr3GWDZpNF2AwOfV/09azYe3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BydgOa4R; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BydgOa4R"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so3341516a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 22:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790053895; x=1790658695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qq9YgbcyezjZVLeoF3eLYnfuwbVIa3eTW8+FxgVEdT8=;
        b=BydgOa4RF/sR111y8M1BWNTJ57eAQeka+Zx5YVWEj5t1lLipKAZ6fNT0iDDYRVI4qs
         BRtAyQnRyrihzubZs3aayIaPHqiW5Sxxyp8VIujD0s9bMQauE9tLQ7vbKo6S/O/jN+Z4
         IqMeiooDW0ecZLBpYumI2OmVbF0PzcAdokbuYnGxOFABRpWyooHqA9sxkVGA8up0ABov
         2GeQq1MQpIrAbSu6lW+zJJReF7rNz83MYaguYgWaVI02VfCPBzU4fmUDjUuBWG7RxKWK
         B0X8VtzRJs2D3EZgBik0zpRDgHkMXULBzpaB9P6atjADvbypVjqr7I5W79iGDUGFjNcR
         Evaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790053895; x=1790658695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qq9YgbcyezjZVLeoF3eLYnfuwbVIa3eTW8+FxgVEdT8=;
        b=h/fCGrQ7usimWaHGlh00J7m165DJLWTEVNpgaS1zzDBCBnJkjlEabuFLVnHYsdr/7A
         6gEC+N8N84DQ2eOLvLgLI0hmNb+laS+kUFQqKyxPiaIb0kl8UgyZL5QiU1UTGNZp9bgg
         +jut2Siphf0eFWqS4BmfcD3ZHIvyjnIJfAWNURXOTUb6uceVtFr4WyUOBJMbkfZow4gp
         Wlxson2e3gMP/r1WAQPEB72AZ3JGIyqDMZDnK+aIaCa5AEpqk1WrSup4Vfj8j9wAxKwx
         9BY2EFoMELf4zO2vhlJN9zBcY6S21n3PoFNwH4infEaqtpdrI1y3vXO+T+Naqf/SUDL9
         DdCA==
X-Forwarded-Encrypted: i=1; AKwUvBx1mpmujLKHmLIW++vBHCWrZTPeeZVqZmi8Odl0DpP7oqp3qASF9nsMrI/oaMFqDrLximH7Rg1T9Mj0apau@vger.kernel.org
X-Gm-Message-State: AFuF++llet4Jo5pI9uD6cM6Nb9kBA8ZpUYOvGo7hiFeLbJ5e0FC8kFLH
	mgJxj6XkaY4gPgpdFKZm6Y79ysgxkjQEZC5FFKG4e3iKRJkM+LLCp/TL
X-Gm-Gg: AYBFou1GhnmgJr0+Li8SUyN0HE+F+HxCIoN/ySzaxp+8hHMIUFjh+zRIF0eF42R+66W
	IBNCSwECPUKYuqe5U5mS+N8LcrvZJZ5eo3UDhbcvd1EJwS1IEJssIreHdAHkpnCTNPddaEK1S2x
	52k21HI3PudzTM5jsjU8ZSwVl8hobZQpHX0BFxnmGgGEJ+R39l+d50t9tWCjH1rDK3vdw7ljHBX
	Xd8co+HXMWMQ7eM6/5xfs5HO8qjGMNmRHt4om4saxIbRiSjvu/fuexR5hnucw7ex38oOmyaAq19
	hW2VnJynsJJDhLey9Zn/AQW8NTTep9YqZu2KH1Xyf5HTxjWR3ZOv3RgRiWDfI/bk92Lbx8loBbR
	/TarJVW3nuin42O7+CQCKX049fbtZ5eNU1+Qjt/RVSRr4IR3hPvpJ047J2HUA27i+MUEgqApI4v
	qD20IOFw3ZdWwwYVr6HCA953rhjk6Ozh+vdecr5IF2ReZuIeePnoIZxT1kl+vIFAGkKSj7CVMj1
	E+d/0SIJ7MM97IwTYjz3j2LJc7CCzX5I3k=
X-Received: by 2002:a17:90b:57c7:b0:3a0:42a8:b357 with SMTP id 98e67ed59e1d1-3a07306ce52mr18290a91.4.1790053895006;
        Mon, 21 Sep 2026 22:11:35 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5cdb48sm1051375a91.17.2026.09.21.22.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:11:34 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: benquike@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minix: validate s_imap_blocks and s_zmap_blocks in minix_check_superblock()
Date: Mon, 21 Sep 2026 22:11:25 -0700
Message-ID: <20260922051125.3727163-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919222621.3796976-1-benquike@gmail.com>
References: <20260919222621.3796976-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 19, 2026 at 22:26:21 +0000, Hui Peng wrote:
> 
> In minix_check_superblock() and minix_fill_super() (fs/minix/inode.c),
> verify that s_imap_blocks and s_zmap_blocks are large enough to cover
> s_ninodes + 1 and s_zones, and check the return value of
> sb_set_blocksize() to prevent out-of-bounds bitmap array reads in
> minix_count_free_inodes() and minix_new_inode().

This issue has already been taken care of with commit fb3e566cafc3,
which changed DIV_ROUND_UP to DIV_ROUND_UP_POW2 to prevent this very
overflow issue. The return value of sb_set_blocksize() isn't actually
checked in this patch, but that's OK because the code was already
checking those return values at both call sites.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

For what it's worth, this is the very first commit to the Linux git
tree. 

> Assisted-by: LLM

Did you review the commit message and patch generated by the LLM? Even
when you use LLM tools to assist with coding tasks, it's important to
make sure their output both makes sense and that it actually does what
it claims.

> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index daf83e4ff25c..b0857dfc1b46 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -185,15 +185,15 @@ static bool minix_check_superblock(struct super_block *sb)
>  		return false;
>  	}
>  
> -	if (sbi->s_ninodes < 1 || sbi->s_firstdatazone <= 4 ||
> -	    sbi->s_firstdatazone >= sbi->s_nzones)
> +	if (sbi->s_ninodes == 0 || sbi->s_ninodes == UINT_MAX ||
> +	    sbi->s_firstdatazone <= 4 || sbi->s_firstdatazone >= sbi->s_nzones)
>  		return false;

This is not the right way to check for an overflow here. s_ninodes is an
unsigned long, not an unsigned int, and I wouldn't want to rely on them
having the same overflow. Also, 'sbi->s_ninodes == UINT_MAX' would never
fire for V1/V2 filesystems, since the underlying types for those
versions are u16 and will never reach UINT_MAX, and it would only match
exactly one value for V3 filesystems (but see below).

>  	/* Apparently minix can create filesystems that allocate more blocks for
>  	 * the bitmaps than needed.  We simply ignore that, but verify it didn't
>  	 * create one with not enough blocks and bail out if so.
>  	 */
> -	block = minix_blocks_needed(sbi->s_ninodes, sb->s_blocksize);
> +	block = minix_blocks_needed((u64)sbi->s_ninodes + 1, sb->s_blocksize);

The u64 cast doesn't add anything. The operands are already unsigned
longs and '(u64)sbi->s_ninodes + 1' would, if sbi->s_ninodes were
UINT_MAX, equal 0x100000000. minix_blocks_needed takes unsigned ints for
its arguments, so that sum would end up being truncated to 0. The
'sbi->s_ninodes == UINT_MAX' guards against this, but the only reason
that guard needs to be there is because of 's_ninodes + 1'.

>  	if (sbi->s_imap_blocks < block) {
>  		printk("MINIX-fs: file system does not have enough "
>  		       "imap blocks allocated. Refusing to mount.\n");
> @@ -201,7 +201,7 @@ static bool minix_check_superblock(struct super_block *sb)
>  	}
>  
>  	block = minix_blocks_needed(
> -			(sbi->s_nzones - sbi->s_firstdatazone + 1),
> +			(u64)sbi->s_nzones - sbi->s_firstdatazone + 1,

As above, the cast adds nothing.

>  			sb->s_blocksize);
>  	if (sbi->s_zmap_blocks < block) {
>  		printk("MINIX-fs: file system does not have enough "

Note that the pre-image in your index line (daf83e4ff25c) is the current
fs/minix/inode.c in mainline, so this patch was made against a tree that
already contains fb3e566cafc3. In other words, the out-of-bounds reads
the commit message describes are already fixed there. Unfortunately,
this patch gets a NAK from me.

Thanks,

-j
