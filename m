Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245C39F175;
	Mon, 30 Mar 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864217; cv=none; b=UzsJiLm9SY0U1AwduZq+XC38C1QfG12CukSLvgYTGMMW8HAd+DHAr5ImoPKvhg7d4beQFexmzWJYvWYgkUnN3cl8hGLLdQDff+R1HkPaW6n/axirHEDfs601sw6ln/sVgtU8QEmNCRLvnXoWSip+hM1lK1nAq/sc/vrdNFcfvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864217; c=relaxed/simple;
	bh=wwLiFYzrwUgjNNuihTTlkexT57PhD3VdfvzkqfH7Its=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4JIHzW2KzoN/oXooWaA2eVN1Qswrysw8QMnh3Q51A5rAQMptalDBpXsYeiIjLJnACPa+rkkigCO3DTXECQvLbqcaCFwVrbfXWyoYe+arXRIlGsL2ZPMsJac7WRZuK07ePF+XP6GaXcCliN9fltZLTv15FlAZzRglW2jGFyL63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62U9nkGU065070;
	Mon, 30 Mar 2026 18:49:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62U9nkbi065065
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 30 Mar 2026 18:49:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6f43ac51-aeab-4d2f-ba11-432dcf0d88f7@I-love.SAKURA.ne.jp>
Date: Mon, 30 Mar 2026 18:49:46 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hfs: Validate CNIDs in hfs_read_inode
To: George Anthony Vernon <contact@gvernon.com>, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260329205949.701267-1-contact@gvernon.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260329205949.701267-1-contact@gvernon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/03/30 5:59, George Anthony Vernon wrote:
> This patch was regression tested by issuing various system calls on a
> mounted HFS filesystem and validating that file creation, deletion,
> reads and writes all work.

I can't believe that this patch was tested.
Did you build a kernel with this patch applied?

  In file included from ./include/asm-generic/bug.h:31,
                   from ./arch/x86/include/asm/bug.h:193,
                   from ./include/linux/bug.h:5,
                   from ./include/linux/mmdebug.h:5,
                   from ./include/linux/mm.h:7,
                   from ./include/linux/pagemap.h:8,
                   from fs/hfs/inode.c:14:
  fs/hfs/inode.c: In function ‘hfs_read_inode’:
  ./include/linux/kern_levels.h:5:25: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘u32’ {aka ‘unsigned int’} [-Wformat=]
      5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
        |                         ^~~~~~
  ./include/linux/printk.h:483:25: note: in definition of macro ‘printk_index_wrap’
    483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
        |                         ^~~~
  ./include/linux/printk.h:564:9: note: in expansion of macro ‘printk’
    564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
        |         ^~~~~~
  ./include/linux/kern_levels.h:12:25: note: in expansion of macro ‘KERN_SOH’
     12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
        |                         ^~~~~~~~
  ./include/linux/printk.h:564:16: note: in expansion of macro ‘KERN_WARNING’
    564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
        |                ^~~~~~~~~~~~
  fs/hfs/inode.c:435:17: note: in expansion of macro ‘pr_warn’
    435 |                 pr_warn("Invalid inode with cnid %lu\n", cnid);
        |



> Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
> I-love.SAKURA.ne.jp/T/

Please don't break, for this generates a dead link when browsing as HTML.



> I have tested this with syzbot's reproducer and my own reproducer.

Can you share your reproducer, for you said that you can consistently
reproduce that BUG() with my patch applied.



> @@ -348,6 +373,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  	struct hfs_iget_data *idata = data;
>  	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
>  	hfs_cat_rec *rec;
> +	u32 cnid;
>  
>  	HFS_I(inode)->flags = 0;
>  	HFS_I(inode)->rsrc_inode = NULL;
> @@ -369,6 +395,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  	rec = idata->rec;
>  	switch (rec->type) {
>  	case HFS_CDR_FIL:
> +		cnid = be32_to_cpu(rec->file.FlNum);
> +		if (!is_valid_catalog_record(cnid, rec->type))
> +			goto make_bad_inode;
>  		if (!HFS_IS_RSRC(inode)) {
>  			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
>  					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
> @@ -377,7 +406,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  					    rec->file.RPyLen, be16_to_cpu(rec->file.ClpSize));
>  		}
>  
> -		inode->i_ino = be32_to_cpu(rec->file.FlNum);
> +		inode->i_ino = cnid;
>  		inode->i_mode = S_IRUGO | S_IXUGO;
>  		if (!(rec->file.Flags & HFS_FIL_LOCK))
>  			inode->i_mode |= S_IWUGO;
> @@ -390,7 +419,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  		inode->i_mapping->a_ops = &hfs_aops;
>  		break;
>  	case HFS_CDR_DIR:
> -		inode->i_ino = be32_to_cpu(rec->dir.DirID);
> +		cnid = be32_to_cpu(rec->dir.DirID);
> +		if (!is_valid_catalog_record(cnid, rec->type))
> +			goto make_bad_inode;
> +		inode->i_ino = cnid;
>  		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
>  		HFS_I(inode)->fs_blocks = 0;
>  		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
> @@ -399,8 +431,13 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  		inode->i_op = &hfs_dir_inode_operations;
>  		inode->i_fop = &hfs_dir_operations;
>  		break;
> +make_bad_inode:
> +		pr_warn("Invalid inode with cnid %lu\n", cnid);
> +		pr_warn("Volume is probably corrupted, try performing fsck.\n");
> +		fallthrough;
>  	default:
>  		make_bad_inode(inode);
> +		break;
>  	}
>  	return 0;
>  }

I consider that this approach is still buggy. Why do we need to call make_bad_inode()
and preserve the inode on-memory instead of destroying the inode? Why not just return
non-0 value instead of calling make_bad_inode() ?

hfs_read_inode() is called from inode_insert5() from iget5_locked() when
hfs_test_inode() from find_inode() from inode_insert5() from iget5_locked() returned 0.

hfs_test_inode() tries to return 1 based on inode->i_ino, but since you are calling
make_bad_inode() without initializing inode->i_ino, hfs_test_inode() will always
return 0.

  static int hfs_test_inode(struct inode *inode, void *data)
  {
  	struct hfs_iget_data *idata = data;
  	hfs_cat_rec *rec;
  
  	rec = idata->rec;
  	switch (rec->type) {
  	case HFS_CDR_DIR:
  		return inode->i_ino == be32_to_cpu(rec->dir.DirID);
  	case HFS_CDR_FIL:
  		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
  	default:
  		BUG();
  		return 1;
  	}
  }

As a result, a new inode is created until alloc_inode() from iget5_locked() returns
NULL due to exhausiting all kernel memory whenever hfs_iget() is called (i.e. source
of denial of service bug). We should not call make_bad_inode() without initializing
inode->i_ino.

Also, I guess that we should not call make_bad_inode() from hfs_read_inode() when
rec->type is neither HFS_CDR_FIL nor HFS_CDR_DIR, for it will accumulate the inode
in-memory until all kernel memory is exhausited.

Again, why do we want to call make_bad_inode() instead of returning non-0 value
(and release kernel memory) ?

