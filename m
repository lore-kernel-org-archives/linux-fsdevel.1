Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AB395266
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427997; cv=none; b=WpnAj7kXNcDxKmtCraAgzQVjlByC7kNnf9yuxP4w5hP1Nzn4aaV51MPsn3D2e62jwr4nZPujnqkARUMpdde8Esyk7gK2aolW10GyMBPTYNHr5KFFjA5d+s3auOc2dKQwnv4khLZYs7xomQjiycT4kU5WD70ch2MoI7TIxSDSnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427997; c=relaxed/simple;
	bh=v614CFXBfqSzsJ79ahhrgCsmZc7+4+adtxI0ZrlWtWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5xwku5+SIKi1AfJSFnjQHVrjGCJFHbTC4QP4bU3Vj9h2YKYTIUQdfZuhTEZlgw34SEdMuX2iU2uQzVvgQaLlUo0g9TsxOPOpGb49lQIVCey476EJTBswuIZNa9w8FUJyHvYkUm6KfUyAWKH7k1mrEkqtp7Nf7JUhhvXaagiffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQdPCT/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQdPCT/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785427995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqoieD2YmNVSXtZenEKBk8kOT7R3kpMGyQwFIje0FU4=;
	b=bQdPCT/Q4jGPj/pYtt5JeZ7rWgbHJmknGBMT6kSvWgoqTIcCXzsw0EWdjbaSC+mKFNdP8f
	OqLiIbWPL2Abr42VmcaFxqw7qz7q5DxYlHLvgQZ15rouGWmy7wOEb6TeVaXve5soBz5kRu
	WMFJQrk6EfiYPTDrd8Ymqm01quN4mJI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-aGW2d2IIO4ymuwbfuJuHDw-1; Thu,
 30 Jul 2026 12:13:08 -0400
X-MC-Unique: aGW2d2IIO4ymuwbfuJuHDw-1
X-Mimecast-MFC-AGG-ID: aGW2d2IIO4ymuwbfuJuHDw_1785427985
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EA2B180056E;
	Thu, 30 Jul 2026 16:13:05 +0000 (UTC)
Received: from localhost (unknown [10.44.49.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A63130002E9;
	Thu, 30 Jul 2026 16:13:04 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-erofs@lists.ozlabs.org,  xiang@kernel.org,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH] erofs: reuse superblock for file-backed mounts
In-Reply-To: <8733x0k2p1.fsf@redhat.com> (Giuseppe Scrivano's message of "Thu,
	30 Jul 2026 15:49:14 +0200")
References: <20260730124120.1501126-1-gscrivan@redhat.com>
	<amtJX8aTZT5d_sP3@pedro-suse.lan> <8733x0k2p1.fsf@redhat.com>
Date: Thu, 30 Jul 2026 18:13:02 +0200
Message-ID: <87fr10h2wh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> Pedro Falcato <pfalcato@suse.de> writes:
>
>> On Thu, Jul 30, 2026 at 02:41:20PM +0200, Giuseppe Scrivano wrote:
>>> When the same file is mounted multiple times (via path or fd), reuse
>>> the existing superblock instead of creating a new one.  This allows
>>> multiple mounts of the same image to share in-kernel data structures
>>> more efficiently.
>>> 
>>> The backing file is identified by its inode and fsoffset.  If mount
>>> options conflict, a separate superblock is created transparently as
>>> a fallback.
>>> 
>>> Tested by mounting a 177M Fedora EROFS image 20 times with full
>>> traversal:
>>> 
>>> ```
>>> \#!/bin/sh
>>> IMG=${1:-/root/fedora.erofs}
>>> N=20
>>> DIR=$(mktemp -d)
>>> trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT
>>> 
>>> sync; echo 3 > /proc/sys/vm/drop_caches
>>> INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
>>> MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')
>>> 
>>> for i in $(seq 1 $N); do mkdir $DIR/m$i && mount -t erofs "$IMG"
>>> $DIR/m$i && find $DIR/m$i > /dev/null; done
>>> 
>>> echo "Superblocks: $(grep $DIR /proc/self/mountinfo | awk '{print $3}' | sort -u | wc -l)"
>>> echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | awk '{print $2}') - INODES_BEFORE ))"
>>> echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | awk '{print $2}') - MEM_BEFORE )) kB"
>>> ```
>>> 
>>> unpatched kernel:
>>> 
>>> Superblocks: 20
>>> erofs_inode delta: +46368
>>> Slab delta: +39952 kB
>>> 0.08user 0.82system 0:00.98elapsed 93%CPU (0avgtext+0avgdata 4796maxresident)k
>>> 19168inputs+10304outputs (24major+16672minor)pagefaults 0swaps
>>> 
>>> patched kernel:
>>> 
>>> Superblocks: 1
>>> erofs_inode delta: +2044
>>> Slab delta: +1088 kB
>>> 0.07user 0.21system 0:00.31elapsed 91%CPU (0avgtext+0avgdata 4848maxresident)k
>>> 19024inputs+6784outputs (25major+16810minor)pagefaults 0swaps
>>> 
>>> The time difference shows that sharing the superblock also benefits
>>> the page cache and inode cache, as subsequent mounts of the same image
>>> avoid re-reading the backing file.  This is particularly useful for
>>> container hosts running multiple containers from the same base image.
>>
>> Doesn't this approach break-down as soon as you get to change SB flags (through
>> e.g mount -o remount)? It will change superblock flags for all of them, right?
>>
>> (I don't think you can switch off the superblock transparently on a
>> reconfigure?)
>
> This is the same preexisting behavior for block device mounts.  That
> said, I realize this can feel confusing since EROFS is not a block
> device and allowed this so far.
>
> One way to solve this could be an explicit mount option "share_sb" that
> is opt-in and, once set, blocks any remount operations.  Would that
> work?

Would something like the following fixup on top of the previous patch be
acceptable (suggestions for better names are welcome)?

Thanks,
Giuseppe

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 580f8d9f14e7..ac26daf4f78a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -156,6 +156,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
 #define EROFS_MOUNT_DIRECT_IO		0x00000100
 #define EROFS_MOUNT_INODE_SHARE		0x00000200
+#define EROFS_MOUNT_SHARE_SB		0x00000400
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cbd76727f0d3..dd2a351811c8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,7 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
-	Opt_source,
+	Opt_source, Opt_share_sb,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -414,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("directio",		Opt_directio),
 	fsparam_u64("fsoffset",			Opt_fsoffset),
 	fsparam_flag("inode_share",		Opt_inode_share),
+	fsparam_flag("share_sb",		Opt_share_sb),
 	fsparam_file_or_string("source",	Opt_source),
 	{}
 };
@@ -560,6 +561,12 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_share_sb:
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE))
+			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
+		else
+			set_opt(&sbi->opt, SHARE_SB);
+		break;
 	case Opt_source:
 		return erofs_fc_parse_source(fc, param);
 	}
@@ -798,6 +805,8 @@ static int erofs_fc_test_file_super(struct super_block *sb,
 		return 0;
 	if (!sbi->dif0.file || !new_sbi->dif0.file)
 		return 0;
+	if (!test_opt(&new_sbi->opt, SHARE_SB))
+		return 0;
 	return file_inode(sbi->dif0.file) == file_inode(new_sbi->dif0.file) &&
 	       sbi->dif0.fsoff == new_sbi->dif0.fsoff &&
 	       sbi->opt.mount_opt == new_sbi->opt.mount_opt &&
@@ -874,6 +883,9 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 	DBG_BUGON(!sb_rdonly(sb));
 
+	if (test_opt(&sbi->opt, SHARE_SB))
+		return -EBUSY;
+
 	if (new_sbi->domain_id)
 		erofs_info(sb, "ignoring reconfiguration for domain_id.");
 

