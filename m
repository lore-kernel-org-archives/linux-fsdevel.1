Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B853955EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930024; cv=none; b=TlWA43T72XNd7zYRKoUDNK179TSCWOmvSEQVaVLD9RuVx+OeTUKSblb1XHHeXavvV+qEtyDRch/REI+p3OnUyNy6pG7RidA8EC4dHTKy5rKRC2x7WXNbJoa8NTaQEo8LZOfZ1POkC8kBzzq+EPt7o7mtm/3/0e/hkwCT00OTMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930024; c=relaxed/simple;
	bh=OpY9RkC6P+v0bcPMELNu3X/PnfvXuRHFrc9QfD5R9Uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkG3vI7k3Vbim46x3y1DmVDxCvsxxuaIjrYywTj/2eeLysUW9BFCBmma+fUmfTTUh4Lb6hcp1llAZ6Hegjr+v98j8lIBxKMctlWhs/925bnFyCqcJbzTFIoTPki60bVxDkbsxE8gp/q3jbwrOdtPMLIdyJfZU74Ah3fl/+aZMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoWT3+yn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoWT3+yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4wY4RWP4QXhnzIcRy9eHDGE2HmFl9OBs3bjfxxy2g4=;
	b=BoWT3+ynm0mHUYxRH/KcDBzJXmcxnF+Khxxs6QBOrEviUMz7Y+l/R6EGASjOQCTkh+fB/6
	iTsSkxmhatTCAMdjeQBQi7TC2infVRTnG9oDsRwAUnGqS+yvLBuZd/T3TwMQQlYXNfmUDa
	mQKfT4gSboETeWgD0kFUwRt+jBLjOa4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-jjp8OdHTOKujZDzlc68Ukw-1; Mon,
 13 Jul 2026 04:06:58 -0400
X-MC-Unique: jjp8OdHTOKujZDzlc68Ukw-1
X-Mimecast-MFC-AGG-ID: jjp8OdHTOKujZDzlc68Ukw_1783930017
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E7A1955DDC;
	Mon, 13 Jul 2026 08:06:57 +0000 (UTC)
Received: from localhost (unknown [10.44.33.216])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FFA2180058F;
	Mon, 13 Jul 2026 08:06:55 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-erofs@lists.ozlabs.org,  linux-fsdevel@vger.kernel.org,  Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
In-Reply-To: <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
	(Aleksa Sarai's message of "Mon, 13 Jul 2026 14:52:25 +1000")
References: <20260711071137.4130824-1-gscrivan@redhat.com>
	<2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 13 Jul 2026 10:06:54 +0200
Message-ID: <871pd748kh.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2026-07-11, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 86fa5c6a0c70..3040d4cf9b85 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>  enum {
>>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> +	Opt_source_fd,
>>  };
>>  
>>  static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>  	fsparam_flag_no("directio",	Opt_directio),
>>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>>  	fsparam_flag("inode_share",	Opt_inode_share),
>> +	fsparam_fd("source",		Opt_source_fd),
>>  	{}
>>  };
>>  
>> @@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>  		else
>>  			set_opt(&sbi->opt, INODE_SHARE);
>>  		break;
>> +	case Opt_source_fd:
>> +		if (sbi->dif0.file)
>> +			return -EINVAL;
>> +		sbi->dif0.file = get_file(param->file);
>> +		break;
>
> I don't think this handling is right for a few reasons:
>
>  1. AFAICS this shadows the default "source" handling logic (because
>     -ENOPARAM is not returned for the non-fd case), which means that
>     this regresses existing erofs users -- everyone already uses
>     "source" today. I must really be missing something if this worked
>     when you tested it.
>
>     Additionally, fsparam_fd unfortunately permits strings (where the
>     string is the numerical value of the fd number), meaning that this
>     will call get_file(<garbage>) if someone uses FSCONFIG_SET_STRING.
>     You will need to check param->type at least to avoid that.
>
>     I meant to send a patch for this earlier this year, but a nicer
>     solution would be to have a custom helper similar to fs_lookup_param
>     except that it permits FSCONFIG_SET_FD, FSCONFIG_SET_PATH,
>     FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_STRING. This is sorely
>     missing and people keep accidentally creating unusable interfaces as
>     a result. I mentioned this in an LPC talk last year[1].
>
>     proc_parse_pidns_param was my minimal version that only accepts
>     FSCONFIG_SET_FD and FSCONFIG_SET_STRING, and if you don't want to
>     add dirfd support yet then you should use something more like that.
>
>  2. On a slightly less critical note, fc->source has special handling in
>     the VFS in a few places and AFAICS this is the first example of
>     someone adding an implementation of "source" that does not set
>     fc->source to a proper value, which deserves some additional review.
>
>     (At at quick glance it seems this just means that some stuff in
>     procfs will show as "none" rather than fc->source debugging, but
>     again it probably needs a closer look.)
>
> [1]: https://youtu.be/NX5IzF6JXp0?t=72

sorry, I underestimated the blast of the patch.  I didn't realize it
changes the default handling and that is why I've limited my testing to
the new case only.

Would you be fine if I amend the following fixup?

It addresses both the issues you've reported.  An EROFS image file
mounted via its path still works and shows correctly in mountinfo and
"source" is also populated when mounting from a file descriptor.

# /root/erofs-test/erofs-mount-via-fd /root/erofs.blob /mnt
# grep /mnt /proc/self/mountinfo
671 42 0:83 / /mnt ro,relatime shared:666 - erofs /root/erofs.blob ro,seclabel,user_xattr,acl,cache_strategy=readaround

# mount /root/erofs.blob /mnt/
# grep /mnt /proc/self/mountinfo
671 42 0:83 / /mnt rw,relatime shared:666 - erofs /root/erofs.blob ro,seclabel,user_xattr,acl,cache_strategy=readaround

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3040d4cf9b85..7818872ab1e5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,7 +386,6 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
-	Opt_source_fd,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -414,7 +413,6 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("directio",	Opt_directio),
 	fsparam_u64("fsoffset",		Opt_fsoffset),
 	fsparam_flag("inode_share",	Opt_inode_share),
-	fsparam_fd("source",		Opt_source_fd),
 	{}
 };
 
@@ -447,6 +445,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	struct erofs_device_info *dif;
 	int opt, ret;
 
+	if (strcmp(param->key, "source") == 0 &&
+	    param->type == fs_value_is_file) {
+		if (sbi->dif0.file || fc->source)
+			return -EINVAL;
+		sbi->dif0.file = get_file(param->file);
+		return 0;
+	}
+
 	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
@@ -526,11 +532,6 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
-	case Opt_source_fd:
-		if (sbi->dif0.file)
-			return -EINVAL;
-		sbi->dif0.file = get_file(param->file);
-		break;
 	}
 	return 0;
 }
@@ -779,6 +780,18 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
 	}
+	if (!fc->source) {
+		char *buf, *p;
+
+		buf = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		p = file_path(file, buf, PATH_MAX);
+		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
+		kfree(buf);
+		if (!fc->source)
+			return -ENOMEM;
+	}
 	if (!S_ISREG(file_inode(file)->i_mode) ||
 	    !file->f_mapping->a_ops->read_folio) {
 		errorfc(fc, "source is unsupported");

Regards,
Giuseppe

