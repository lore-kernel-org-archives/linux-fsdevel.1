Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922843AB284
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382371; cv=none; b=H5w54OQFQQtaotVTFeLTirs11N8nSzqrSg71PRZ1kDjYI0dSmKxI+Ugt/EqqlWiLR4h5tN/X23kUiJtArsVK+Dl6IjsyET9MB77At64Xl+rfwLUbDP9gCsvkClO6nVVy2O5Dlm5+kaXsHGV1SK7s7tZvwwcnkPJJORnFxhS2QlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382371; c=relaxed/simple;
	bh=/BadFUsA3OstmHGhfK99QbnF/NkulvL8khR/iLpaHno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY1sRI9jpeLaovGSNMtKQMkBolQ605LLz97Kz9zSTxSoDjMHRk2qkJLTRq5KDcKUQiuZQNqRqiQkoKnzgl+qLMZgpl+5t28z2r5OMi8jliwnn9HKKjepz6zwxa5Q/i+funDDPDcz5fPhsCXJY1JU9jE6QZfhiuxCBNdamPDTFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1xFPzzy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1xFPzzy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so2464070b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788382369; x=1788987169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXjufAEosIj1q8FXumUFsTj098OQ/YAIZCUC7EsihNw=;
        b=C1xFPzzyJe6Xcw5H6uguX8gbdFiLTeqdfE9McpcpgiEBn2hdYvKAsXzJL5s+fovqf5
         mozyYL3r+hSAeBLzk4kiCl1wbhoKyeUqD6c3Kv/zvn0IdxSppVDB15XxF1WdAf9rMpr3
         J4RRJh0XZKkLpxWSzPl9qwGSLRgui6DIrPcuIOfELYBimO88NOIEkjNNmFY5dtl8sl8Y
         lESZSUcj8+r8afHpEXPHolYRXgFaPpAq5GIqz0UJ1kfQU1g19gN1XTaHmHIf8LuBT1A/
         bwEDhecpph8l5aVYn19tXLnRTZePi9WpseEUHzvn2M0Te5HvmbpcqgEWEKXmL5pF4xx4
         M6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788382369; x=1788987169;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXjufAEosIj1q8FXumUFsTj098OQ/YAIZCUC7EsihNw=;
        b=PjND3ajjrPWJ/ijcVfSSeXINATrpHjtgYC9ldOm7mn6mbQqD/E3cAbIuiNZKBggm9W
         Qk02xzpbrGh8eByloY/OoQl1XO3hrpxEsJ+FLh3W4GjmxxEzoJyET4qUt96G+gRHXi15
         iMQQwSjaAROAl2vHyciwTWuv/XREWFwsyj480GDGOl2o6OYOyifjrBkLJWMDkKkTFs5N
         UH+86VIe60ynFXZ4u8nZZ9DFFbq1TWapEJ08SMLDpKpocNqbPW1amz1TkmRwa53idvHR
         QPRD2yoNpAABDVlge8q9OeQlWoL1VEVqNvYsu7ZL2jbXosrjWcbz3QFH9FXU+ukIlpBC
         pd2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzuPVIuFHdIygVoR0If19Bj3GdUkuJ3zVeoopTds5IEuGYzBVFo9Zk015H3Hf6RIdb2cuh04FKGPtQc5ssF@vger.kernel.org
X-Gm-Message-State: AFuF++lUJhfxAZ0RgwmFZf3Wg367UcxEgOH61ocSu8L/Mjb4NsQY1J2Q
	DXLppmusoDBXPVejWrpiiVxdKrWHOpixBGssxFFkUXyyiw2ZVt8vHnpJ
X-Gm-Gg: AYBFou19Eaq2R9mnvoEMrQNW5QhZpxTp/0A2mlb3r4lVQCgbIpo8XlGwksMxr1sm7uL
	5cNztz1JWUIqYKnTkn2du1fbFmfWHxutToKR2mnGvBjyoW+oxhYH9ZQOnsIkJQ/pykOb5Dd084O
	WTatahna9cOBqfRv9oq2gkUVtSsHj3z/LgooQ7smNATFJmhAoR7jyoTnkmHaVqhvHxnPvLcamio
	RIYBuvxU4RvzC5DwbUBdVrpaN1i70z2sKSPqo4+shTZk1QNEsC+KSGUQ+yjJja3FjwqsJmYcdk1
	v2DtEArTqzTh3OrfQ0R81O6O3pwE76ZlJsZTJhuVuL7zFPOlqY5/oJK4X2d2XE6JzPJNIEPMLqG
	c3wXY8ys0V55dny/guBylZ2Qb/GmF2Eq9kRz9Ukpj1JZklN1uuCqwayv0i8KpMVVPP+NUoc47ZC
	0J0TtPy7nw6aWLwNjJzmWvd8XSCl3UxziviryI/zYN/PYgsf/G7lj7Mghi9+K8gZEZ
X-Received: by 2002:a05:6a21:6004:b0:3d0:88f5:f813 with SMTP id adf61e73a8af0-3d9b05238admr12663995637.11.1788382368648;
        Wed, 02 Sep 2026 13:52:48 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:4bb2:9d5:1e62:39c6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325592d9c5sm642702eec.11.2026.09.02.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:52:48 -0700 (PDT)
Date: Thu, 3 Sep 2026 02:22:24 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Srikanth Aithal <Srikanth.Aithal@amd.com>,
	Luca Weiss <luca.weiss@fairphone.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] buffer: fix NULL dereference of bh->b_folio in
 __bh_submit()
Message-ID: <apiMiLlwujmqyYLP@user>
References: <20260902013357.2815214-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902013357.2815214-1-joseph.qi@linux.alibaba.com>

On Wed, Sep 02, 2026 at 09:33:57AM +0800, Joseph Qi wrote:
> Commit a2c924c240e7 ("buffer: set BIO_COMPLETE_IN_TASK for dropbehind
> writeback") added an unconditional folio_test_dropbehind(bh->b_folio) in
> __bh_submit().  But jbd2 shadow buffers have a NULL b_folio since commit
> 5febcba29792 ("jbd2: point the shadow buffer at the frozen data
> directly") made them point b_data at the kmalloced frozen data rather
> than a folio.  Submitting such a buffer during journal commit oopses:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:__bh_submit.constprop.0+0x87/0x120
>   Call Trace:
>    jbd2_journal_commit_transaction+0x932/0x1b10
>    kjournald2+0xb2/0x250
> 
> Hit by the ocfs2-testsuite fill_verify_holes test running with
> data=writeback.
> 
> Dropbehind only applies to buffers backed by a folio, so skip the check
> when b_folio is NULL.
>
Hi,

I was working on a fix for this syzbot report [1] and didn't realize that you were
already working on it. I noticed your patch on the mailing list, so i won't
send a duplicate patch.
 
> Fixes: 5febcba29792 ("jbd2: point the shadow buffer at the frozen data directly")

Could you please add the Reported-by: and Closes: tags from the syzbot report
to your patch? This will help syzbot associate the patch with the reported
issue and track the fix.

[1]: https://syzkaller.appspot.com/bug?extid=41453ea05ab61c075f1f

Thank you,
Pavan

> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 427d8a817cd5..f46fa6413032 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
> -	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
> +	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
> +	    op_is_write(opf))
>  		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>  
>  	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> -- 
> 2.39.3
> 
