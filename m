Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58763F58F5;
	Mon, 24 Aug 2026 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564721; cv=none; b=TKkWeRkFIgARTnpFBT7TVBZI3C730VNh2nZSK05L3sT/mCczZQf9iScd22oeIICkYSnxfyHhClCmuPcLFhnJzq/LaVvY0h4+QC7Udky1WT969Fyklcv1G4GwlLvejspRyAvLQ8yTL6SIJBLIWubgo1cebcFq1cLXXOvPJr1vVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564721; c=relaxed/simple;
	bh=r8WN6z6fTgXIqOs0URTLBnOzvtzodQOoUFnXpTGjdSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDHg4cFb5/IMdnmtgGKasnGNAWiN7pXdEn7bqBvZuxDRmnvNmZUq+QK8VbBA3SgZ/7vx8kq3kXRjkosY37j9bzn5fv+1qp3zEPTtwCTBIcMmUG7LjrClTY5POqNeooKVa593ba5Zouduw6dwkSCJezDPvVJ+jIa4cXL7LrJUw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Qy90wV4/; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=2a84AeL3; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Qy90wV4/";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="2a84AeL3"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 5893926F768E;
	Mon, 24 Aug 2026 18:45:13 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1787564713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzbQb6I3hfrObyyAh8FLlb1/bPAXNYXLFSU1BgZUND8=;
	b=Qy90wV4/1CdqvQYIZ26WHPt/k1B2pHoi32W0Hy33vwDzx9HdIcBRkyA8/8PrKZSIgqhFSl
	97GiS/SZh+wKy10AouuqcC3GoBN/Cq5U72P8A1foMv9+B2Am0vxCf97SPQzwnZZj1stx/B
	sqy/7uXf1EnmjtnH0Cx8fUb3giUlwCvsi4FIoNeQO4UVwIqtyyTlqGoqseRF7N0j+766l/
	oSetLKKv/WnOgKlr0izO5ro19AgYHIjETevKCgVMcTBjfer4GH4eEhVY16PisEAIQCrwgI
	zyEVytQtu51j/YGzmUsz4x85b0rZhrKt8ozaK2TLcWs9cbAA8xz/CBgoFXgzWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1787564713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzbQb6I3hfrObyyAh8FLlb1/bPAXNYXLFSU1BgZUND8=;
	b=2a84AeL3oMSozXBDEp9ms4fbwhYZMwhbcFGWApXkGy/zL7DTcQiPM99DGyvUP9sO04PgGw
	8+3v72dfjUiLh5Bw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id D7B48E00090;
	Mon, 24 Aug 2026 18:45:12 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id C500422000D2; Mon, 24 Aug 2026 18:45:12 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: David Timber <dxdt@dev.snart.me>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fat: add noflush mount option
In-Reply-To: <20260822173732.10230-1-dxdt@dev.snart.me>
References: <20260822173732.10230-1-dxdt@dev.snart.me>
Date: Mon, 24 Aug 2026 18:45:12 +0900
Message-ID: <871pbn6edz.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> On most distros, udisks manages users' removable volume mount requests.
> Udisks is configured to always mount FAT volumes with the 'flush' mount
> option. This is largely okay for populating directory in small sizes,
> but when a large number of files are involved, the flush behaviour acts
> as a bottleneck point in fat_file_release(). The user may want to
> disable the flush option temporarily before commencing such an intensive
> operation.
>
> To cover this use case, introduce the new 'noflush' mount option. When
> used in the mount options to mount a volume, it overrides the 'flush'
> option previously specified. When used in remount, update it updates the
> flag.
>
> This is a breaking change as traditionally, the mount options other than
> rw and ro are ignored. The patch breaks this tradition by allowing
> reconfiguration of 'flush' and 'noflush' mount options.
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
> ---
>  fs/fat/inode.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 28f78df086ef..850df43ba354 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -813,10 +813,14 @@ int fat_reconfigure(struct fs_context *fc)
>  	bool new_rdonly;
>  	struct super_block *sb = fc->root->d_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	struct fat_mount_options *new_opts = fc->fs_private;
>  	fc->sb_flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
>  
>  	sync_filesystem(sb);
>  
> +	/* allow reconfiguring "flush" or "noflush" */
> +	sbi->options.flush = new_opts->flush;
> +
>  	/* make sure we update state on remount. */
>  	new_rdonly = fc->sb_flags & SB_RDONLY;
>  	if (new_rdonly != sb_rdonly(sb)) {

Maybe, better to set after changed the read-only?

> @@ -1047,7 +1051,7 @@ enum {
>  	Opt_charset, Opt_shortname, Opt_utf8, Opt_utf8_bool,
>  	Opt_uni_xl, Opt_uni_xl_bool, Opt_nonumtail, Opt_nonumtail_bool,
>  	Opt_obsolete, Opt_flush, Opt_tz, Opt_rodir, Opt_errors, Opt_discard,
> -	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy,
> +	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy, Opt_noflush
>  };
>  
>  static const struct constant_table fat_param_check[] = {
> @@ -1110,6 +1114,7 @@ const struct fs_parameter_spec fat_param_spec[] = {
>  	fsparam_flag	("debug",	Opt_debug),
>  	fsparam_flag	("sys_immutable", Opt_immutable),
>  	fsparam_flag	("flush",	Opt_flush),
> +	fsparam_flag	("noflush",	Opt_noflush),

fsparam_flag() is not including the "noflush" too?

>  	fsparam_enum	("tz",		Opt_tz, fat_param_tz),
>  	fsparam_s32	("time_offset",	Opt_time_offset),
>  	fsparam_enum	("errors",	Opt_errors, fat_param_errors),
> @@ -1167,10 +1172,6 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>  	struct fs_parse_result result;
>  	int opt;
>  
> -	/* remount options have traditionally been ignored */
> -	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> -		return 0;
> -
>  	opt = fs_parse(fc, fat_param_spec, param, &result);
>  	/* If option not found in fat_param_spec, try vfat/msdos options */
>  	if (opt == -ENOPARAM) {
> @@ -1183,6 +1184,18 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>  	if (opt < 0)
>  		return opt;
>  
> +	/* remount options have traditionally been ignored */
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		switch (opt) {
> +		/* but there are exceptions */
> +		case Opt_flush:
> +		case Opt_noflush:
> +			break;
> +		default:
> +			return 0;
> +		}
> +	}
> +
>  	switch (opt) {
>  	case Opt_check:
>  		opts->name_check = result.uint_32;
> @@ -1235,6 +1248,9 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>  	case Opt_flush:
>  		opts->flush = 1;
>  		break;
> +	case Opt_noflush:
> +		opts->flush = 0;
> +		break;
>  	case Opt_time_offset:
>  		/*
>  		 * GMT+-12 zones may have DST corrections so at least

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
