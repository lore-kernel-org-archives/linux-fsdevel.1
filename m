Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8333E5EDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938258; cv=none; b=TG+Qp2fOOVGuf/V5EMeHByh9Qpo+yi4UFh5XS4JIdjZoLs+f8sDU/BPj1/Xc1QA3WYm0ngQkmKi7ybCdjYn5CaZXvSxUug5g++DkDgjHJ23kOkuM8SCGEer0hoAP+K/36OGLHyW+QXAkoN2hsfUu+vToweJ0QwlA4xZO53K7ESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938258; c=relaxed/simple;
	bh=FxLM1Q/l5nHmcrqI54hsKjBwOYdVjehwZcbOscUYjjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnrPxmgmAan3Eg8XIqhZuaqdUSHeBg6m5cv8z6Eaa4LDF76NRJTvee7Nav2rjBegLDUVLvTEKcU2huxa+85V+t1JkiF7Chq1R5u0SvgFy6j6AXqV2mhKddiOcDrKLl/fG/qUoxXI+OFIL1gR37R5pf0Zyna6y/jtvKYtc6inNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRpBEOWS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRpBEOWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783938254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/TX7BTpjZY4DlYI5thl0aKFZApPkQRFTRSMk72/cI=;
	b=XRpBEOWSIOr+/OX4C8OhXL11IYbAeaOwBfQoKNUcBYeGahalnUu+M2NE/vC2wusD7u+h9L
	mI/eWtiQv1r1sRvWntjT3ZrIGhNXHh3Tt8RPPFfq9Hn01n3wV4Z4kF29dlbYahCO8w2ElX
	VYibBTsRxuM3G3eVi2pC1TCRiSKHHmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-5HXs3xKSOE-PL7mtLAzyDw-1; Mon,
 13 Jul 2026 06:24:11 -0400
X-MC-Unique: 5HXs3xKSOE-PL7mtLAzyDw-1
X-Mimecast-MFC-AGG-ID: 5HXs3xKSOE-PL7mtLAzyDw_1783938250
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A421955D5E;
	Mon, 13 Jul 2026 10:24:09 +0000 (UTC)
Received: from localhost (unknown [10.44.33.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2863830001A1;
	Mon, 13 Jul 2026 10:24:08 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-erofs@lists.ozlabs.org,  linux-fsdevel@vger.kernel.org,  Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
In-Reply-To: <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
	(Aleksa Sarai's message of "Mon, 13 Jul 2026 18:33:51 +1000")
References: <20260711071137.4130824-1-gscrivan@redhat.com>
	<2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
	<871pd748kh.fsf@redhat.com>
	<2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
Date: Mon, 13 Jul 2026 12:24:07 +0200
Message-ID: <87wluz2nnc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3040d4cf9b85..7818872ab1e5 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,7 +386,6 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>  enum {
>>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> -	Opt_source_fd,
>>  };
>>  
>>  static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -414,7 +413,6 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>  	fsparam_flag_no("directio",	Opt_directio),
>>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>>  	fsparam_flag("inode_share",	Opt_inode_share),
>> -	fsparam_fd("source",		Opt_source_fd),
>>  	{}
>>  };
>>  
>> @@ -447,6 +445,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>  	struct erofs_device_info *dif;
>>  	int opt, ret;
>>  
>> +	if (strcmp(param->key, "source") == 0 &&
>> +	    param->type == fs_value_is_file) {
>> +		if (sbi->dif0.file || fc->source)
>> +			return -EINVAL;
>> +		sbi->dif0.file = get_file(param->file);
>> +		return 0;
>> +	}
>> +
>>  	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
>>  	if (opt < 0)
>>  		return opt;
>
> Shortcutting parsing this way is not really idiomatic, the better way is
> to create a helper -- in this case you can almost certainly just use
> very similar logic to proc_parse_pidns_param() to get something minimal
> working.
>
> Defining your own version of "source" in fs_parameter_spec is fine, you
> just need to make sure you handle FSCONFIG_SET_STRING properly -- there
> are some other examples in the tree you can look at for inspiration
> (mostly remote filesystems AFAICS). You could even return -ENOPARAM to
> fallback to the basic implementation if that makes it easier for you,
> but it would probably be better to handle it all in one place.
>
>> @@ -526,11 +532,6 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>  		else
>>  			set_opt(&sbi->opt, INODE_SHARE);
>>  		break;
>> -	case Opt_source_fd:
>> -		if (sbi->dif0.file)
>> -			return -EINVAL;
>> -		sbi->dif0.file = get_file(param->file);
>> -		break;
>>  	}
>>  	return 0;
>>  }
>> @@ -779,6 +780,18 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>  			return PTR_ERR(file);
>>  		sbi->dif0.file = file;
>>  	}
>> +	if (!fc->source) {
>> +		char *buf, *p;
>> +
>> +		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +		if (!buf)
>> +			return -ENOMEM;
>> +		p = file_path(file, buf, PATH_MAX);
>> +		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
>> +		kfree(buf);
>> +		if (!fc->source)
>> +			return -ENOMEM;
>> +	}
>
> And this would also live in the parser helper.

thanks for the hints.

I'll prepare a v3 if you are fine with the version below:

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..72c85cc53085 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
+	Opt_source,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -402,17 +403,18 @@ static const struct constant_table erofs_dax_param_enums[] = {
 };
 
 static const struct fs_parameter_spec erofs_fs_parameters[] = {
-	fsparam_flag_no("user_xattr",	Opt_user_xattr),
-	fsparam_flag_no("acl",		Opt_acl),
-	fsparam_enum("cache_strategy",	Opt_cache_strategy,
+	fsparam_flag_no("user_xattr",		Opt_user_xattr),
+	fsparam_flag_no("acl",			Opt_acl),
+	fsparam_enum("cache_strategy",		Opt_cache_strategy,
 		     erofs_param_cache_strategy),
-	fsparam_flag("dax",             Opt_dax),
-	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
-	fsparam_string("device",	Opt_device),
-	fsparam_string("domain_id",	Opt_domain_id),
-	fsparam_flag_no("directio",	Opt_directio),
-	fsparam_u64("fsoffset",		Opt_fsoffset),
-	fsparam_flag("inode_share",	Opt_inode_share),
+	fsparam_flag("dax",			Opt_dax),
+	fsparam_enum("dax",			Opt_dax_enum, erofs_dax_param_enums),
+	fsparam_string("device",		Opt_device),
+	fsparam_string("domain_id",		Opt_domain_id),
+	fsparam_flag_no("directio",		Opt_directio),
+	fsparam_u64("fsoffset",			Opt_fsoffset),
+	fsparam_flag("inode_share",		Opt_inode_share),
+	fsparam_file_or_string("source",	Opt_source),
 	{}
 };
 
@@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 	return false;
 }
 
+static int erofs_fc_parse_source(struct fs_context *fc,
+				 struct fs_parameter *param)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (fc->source || sbi->dif0.file)
+		return invalf(fc, "Multiple sources");
+
+	switch (param->type) {
+	case fs_value_is_string:
+		fc->source = param->string;
+		param->string = NULL;
+		return 0;
+	case fs_value_is_file: {
+		char *buf, *p;
+
+		sbi->dif0.file = get_file(param->file);
+		buf = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		p = file_path(param->file, buf, PATH_MAX);
+		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
+		kfree(buf);
+		if (!fc->source)
+			return -ENOMEM;
+		return 0;
+	}
+	default:
+		return invalf(fc, "Invalid source type");
+	}
+}
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
@@ -524,6 +558,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source:
+		return erofs_fc_parse_source(fc, param);
 	}
 	return 0;
 }
@@ -752,14 +788,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	int ret;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+	struct file *file = sbi->dif0.file;
 
-	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
-		struct file *file;
+	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {
+		int ret;
+
+		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+				GET_TREE_BDEV_QUIET_LOOKUP : 0);
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
+		    ret != -ENOTBLK)
+			return ret;
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
@@ -767,12 +807,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
-
-		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	return ret;
+	if (!S_ISREG(file_inode(file)->i_mode) ||
+	    !file->f_mapping->a_ops->read_folio) {
+		errorfc(fc, "source is unsupported");
+		return -EINVAL;
+	}
+	return get_tree_nodev(fc, erofs_fc_fill_super);
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)

Regards,
Giuseppe

