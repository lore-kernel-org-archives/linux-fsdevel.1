Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489879;
	b=dsOSyKyF19MmlHk4J9rDm+3grqQBT+pJXii5/d8i+ZxRGpJE44SkH4ceb3Cg/aXEQ+uA
	 1/lK3rbxuJmfLQODI8HS7/VzdZqM9CcZ0lazIxiCBi2xpeZLAbwNkmqKCnTcrR8p20cZF
	 kaAvd1SEz7gWkUSRrd/zZ92Te576375k6+YAl6lTvjigXlqFgfqBtKl3TopNaoxfC93Or
	 g+fesTpN4oYf/AG3ZO0QtcmnxeVal67Ks5l1toyQ18M/8A+r93aYcP/vvzxQPPC1fJq+X
	 A2q/YK3GWzRdEsz4gjJXwhpIJYJBpQ4v30m9loKunQifN5B6B0/wr8sC8LOZbKeCziQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489879;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=SVD4ZQHZzkomN5H3MR1E2nf4gNfHbhQ1wUkPjw2O63k=;
	b=a2JMUidnUNd5bwMpJPvhZExNI39CvFgKIQoLJ8q762NDmajROqo3EMD2eRZU+BAfyEpm
	 bJeC+GX5Cj94YwpNkONXR2TR0Ig3StemyV8mgJDWrNj7TLNsAIBES9hpDkz+XHinHFbHx
	 gdjX7FlRdYiGptDLz65kVzp3L5tDbaaKvJRkqiP2dueNZa8hWFVZ0GcHGPLGMs6PNhcvG
	 0r+axxkXwtcwpJk9GbqyUK657+QNP4p7MM9aZwLyii6Lxv3CHHWRi+HddmafWZC7Jjd4o
	 e7ZWwSQ91iHF76/PBMk3CD52bKnCkMR00F00oIiVmj79YaF6lw0raG0O87f9G6swMCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=19JYsb+e;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mslJEbfz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u0YYP65g;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=isRxgP5h;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0F606A319;
	Tue, 20 Oct 2026 09:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A0F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=19JYsb+e;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mslJEbfz;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u0YYP65g;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=isRxgP5h
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2322121DC5;
	Tue, 20 Oct 2026 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792489877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVD4ZQHZzkomN5H3MR1E2nf4gNfHbhQ1wUkPjw2O63k=;
	b=19JYsb+eRJeWNQYiCYSDwqH6KcYTkk+mExrkQK3kobqSWoa1/Thd7wgIoXbCbXsBNUIh9z
	PbATJXQY7ZJt/ERxY+f48zEW78+rMvojy3JlqaPHO/fZ7oQ5CbQs/w79pDvGAry4yyBZMH
	ZS10+SpYUGHf16xpb3CIakrfmKqMvoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792489877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVD4ZQHZzkomN5H3MR1E2nf4gNfHbhQ1wUkPjw2O63k=;
	b=mslJEbfzz7HjntSUdiLVYdK+I4nF3utKPZyJJa6P5iRB9Hj/MpU4/BvOknZxBSVHdZEOlS
	jvZbMPWDXDe7C+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792489876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVD4ZQHZzkomN5H3MR1E2nf4gNfHbhQ1wUkPjw2O63k=;
	b=u0YYP65g1mUi11Eh0qKSRgPJqJoLdDhEkgOEBthNtzgiAFzStdjB5olQUnaG4cXr0ymT5O
	zHy7qN2G3xbOU129bJb+DYiLyRaTiIaSlRVM1GxK/jgx8utInQSnmSeCPGMyFkR9iBm9Kc
	Hs20e4/xMz9yAw+LwnYJHByVUO7eUnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792489876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVD4ZQHZzkomN5H3MR1E2nf4gNfHbhQ1wUkPjw2O63k=;
	b=isRxgP5hXruOQgqBAXom9zJtCkfj3kFgIPlLIVcISrkQQa42D9J0VJ8yseITrZQRGjBL9+
	odHGHoJpwKB3ELBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEEED136C6;
	Tue, 20 Oct 2026 09:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v0toMJM512oBFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Oct 2026 09:51:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69A46A13DE; Tue, 20 Oct 2026 11:51:15 +0200 (CEST)
Date: Tue, 20 Oct 2026 11:51:15 +0200
From: Jan Kara <jack@suse.cz>
To: yangguikun <yangguikun19@qq.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] udf: KASAN use-after-free in udf_fill_super on crafted LVID
Message-ID: <ixvlji3lnahqfybiwybclxwdgw5qfnftfwya4zxcwwpwih2l7k@elsnyr6f6qpy>
References: <tencent_A6E5F84C4461A52A7F5B8E203A65989A460A@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A6E5F84C4461A52A7F5B8E203A65989A460A@qq.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,qq.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi!

On Tue 20-10-26 16:28:07, yangguikun wrote:
> Hi Jan,
> 
> Mounting a crafted UDF image gives a KASAN use-after-free in
> udf_fill_super(), before any file operation:
> 
>   BUG: KASAN: use-after-free in udf_fill_super+0x1ce4/0x1e10
>   Read of size 2 at addr ... by task mount
>   Call Trace:
>    udf_fill_super
>    get_tree_bdev_flags
>    path_mount
>    __x64_sys_mount
> 
>   Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> The root cause is that udf_lvid_valid() bounds-checks the start of the
> implementation-use area but not the size of the structure read from it.
> 
>   static bool udf_lvid_valid(struct super_block *sb,
>                              struct logicalVolIntegrityDesc *lvid)
>   {
>           parts = le32_to_cpu(lvid->numOfPartitions);
>           impuselen = le32_to_cpu(lvid->lengthOfImpUse);
>           if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
>               sizeof(struct logicalVolIntegrityDesc) + impuselen +
>               2 * parts * sizeof(u32) > sb->s_blocksize)
>                   return false;
>           return true;
>   }

Yep. Should be fixed by commit a61fb39759d7 ("udf: Make sure there's enough
space for LVID implementation use field") on its way to Linus in this merge
window. Please make sure the problem does reproduce on linux-next before
sending a report & a fix next time. Thanks!

								Honza

>   struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
>   {
>           partnum = le32_to_cpu(lvid->numOfPartitions);
>           offset = partnum * 2 * sizeof(uint32_t);
>           return (void *)(((uint8_t *)(lvid + 1)) + offset);
>   }
> 
> With blocksize = 2048, numOfPartitions = 246 and lengthOfImpUse = 0,
> the check computes 80 + 0 + 1968 = 2048 and passes, while
> udf_sb_lvidiu() returns lvid + 2048, i.e. exactly the end of the
> block. udf_fill_super() then reads lvidiu->minUDFReadRev at +40,
> which is past the buffer. Placing the LVID in the last block of the
> image moves that read past the end of the file.
> 
> Reproducer
> 
> An 80 KiB image. The generator writes:
> 
>   - VRS at offset 32768 (BEA01/NSR02/TEA01)
>   - AVDP, PVD, LVD, USD, IUVD, PD, TD
>   - the LVID as the last block, with numOfPartitions = 246 and
>     lengthOfImpUse = 0
> 
> Mount with:
> 
>   mount -t udf -o loop,ro udf_lvid_oob.img /mnt
> 
> The crash is immediate; no other access is needed.
> 
> The image is included below, base64-encoded gzip. Decode with:
> 
>   base64 -d udf_lvid_oob.b64 | gunzip > udf_lvid_oob.img
>   mount -t udf -o loop,ro udf_lvid_oob.img /mnt
> 
> udf_lvid_oob.b64:
> 
> H4sICKsg12oCA3VkZl9sdmlkX29vYi5pbWcA7d2/btNAHAfwswu9MCD6COZfi8oSsjCwEGiRiqJW
> akIXpi5AJUgZQOI54BGYeAAW3oJHYGFh8YCY+dlNpFYIFRWkhubzOSnWxbZ0/nn43lmWnBIAAAAA
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkO6t97u3CnUAgHmyOdzu9uQ/AMyVkfU/AAAAAAAA
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAHKdIZfoQv++/1blq+wcuPVp7MNjZWPvNablIB61UQgD47yxG
> gj+LHH/7sc6Xo/8v8nypmTiM1oej07mkTrSUVreGo34Vs5jq/v6Ll8/3dsevmp1lsTA9Kl05UofJ
> 3Ge1OWWwU22Mn+wf2l/OyieSY9wrzVgXfbMZgJPLkfi7kXzfH9a5ycOFaQ521AYAzqpzkf+fIvGf
> 9up8te0fvwa+ONgbv35zakM+764BwN+Gadmu+N/F+v/aJFzbmL+5Odzu9n45flaeg0+HceMP5isA
> wFGdyP+VNk3rfF05AGAulNG+RP7feVyl5eaPuylVh7cAwJlzIfK/F/l/+3Odm/fK09LXXJzgufmP
> ybYPAMy8n4I53nYAQAEA
> 
> Fix
> 
> Check the size of the structure that is read afterwards:
> 
>   --- a/fs/udf/super.c
>   +++ b/fs/udf/super.c
>   @@ -1619,7 +1619,8 @@ static bool udf_lvid_valid(struct super_block *sb,
>           impuselen = le32_to_cpu(lvid->lengthOfImpUse);
>           if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
>               sizeof(struct logicalVolIntegrityDesc) + impuselen +
>   -           2 * parts * sizeof(u32) > sb->s_blocksize)
>   +           2 * parts * sizeof(u32) +
>   +           sizeof(struct logicalVolIntegrityDescImpUse) > sb->s_blocksize)
>                   return false;
>           return true;
>   }
> 
> With this applied the same image is rejected and mount fails with
> -EINVAL; no KASAN report.
> 
> Tested on 7.3-rc7. The same image also crashes 7.2-rc5.
> 
> Found by syzkaller-style fuzzing of mounted filesystem images.
> 
> Signed-off-by: yangguikun <yangguikun19@qq.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
